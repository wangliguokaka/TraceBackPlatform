﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Net.NetworkInformation;
using System.Runtime.InteropServices;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using D2012.Common;
using System.Data.SqlClient;

namespace DD2012.Service
{
    public partial class TransferDataService : ServiceBase
    {
        System.Timers.Timer timer = new System.Timers.Timer();
        public TransferDataService()
        {
            InitializeComponent();
        }
        string Interval = ConfigurationManager.AppSettings.Get("Interval");
        string serviceName = ConfigurationManager.AppSettings.Get("ServiceName");
        static string networkName = ConfigurationManager.AppSettings.Get("networkName");
        protected override void OnStart(string[] args)
        {
            timer.Enabled = true;
            timer.Interval = 1000;
            timer.Elapsed += new System.Timers.ElapsedEventHandler(timer_Elapsed);
            
            
            //timer.Start();
        }

        protected override void OnStop()
        {
        }

       
       
        private void timer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
           
            try
            {
                timer.Stop();
               
                Log.LogInfo("Upload");
               
                string con = ConfigurationManager.AppSettings["ConnectString"];
                con = CryptoHelper.StaticDecrypt(con);
                Log.LogInfo("远程数据库连接:" + con);
                string facBM = ConfigurationManager.AppSettings["FactoryBM"];
                string passWord = ConfigurationManager.AppSettings["Password"];
                SqlConnection sqlConn = new SqlConnection(con);
                SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConn);
              
               
                bulkCopy.BulkCopyTimeout = 0;
                try
                {
                    sqlConn.Open();
                    string xhSql = "select convert(varchar,isnull(max(regtime),'1900-01-01'),121) ,1 as sno from orders union select ProductID,2 as sno from Client where Serial = '"+ facBM + "' and Passwd = '"+ CryptoHelper.StaticEncrypt(passWord) + "'  order by sno";
                    SqlDataAdapter adapter = new SqlDataAdapter(xhSql, sqlConn);
                    DataTable dtConfig = new DataTable();
                    adapter.Fill(dtConfig);
                    if (dtConfig.Rows.Count >= 2)
                    {
                        string ProductID = dtConfig.Rows[1][0].ToString();
                        string MaxRegTime = dtConfig.Rows[0][0].ToString();
                        Log.LogInfo("ProductID:"+ ProductID+ ";MaxRegTime:"+MaxRegTime);

                        string faccon = ConfigurationManager.AppSettings["FactoryConnectString"];
                        SqlConnection sqlFacConn = new SqlConnection(faccon);
                        sqlFacConn.Open();
                        if (ProductID == "")
                        {
                            ProductID = "''";
                        }
                        string strSql = "SELECT a.[CardNo],'" + facBM + "' as [Serial],a.[Order_ID],a.[hospital],a.[doctor],a.[patient],a.[age],a.[sex],a.[OutDate],a.regtime"
                            + " FROM [orders] a  where EXISTS(select Order_ID from OrdersDetail b where  a.[Order_ID] = b.[Order_ID] and a.Serial = b.Serial and b.ProductId in(" + ProductID + ") and a.Regtime > '" + MaxRegTime + "')";


                        //strSql = "SELECT a.[CardNo],'" + facBM + "' as [Serial],b.subId,c.itemname as[Itemname], "
                        //    + "b.Qty as [Qty],b.a_teeth as [a_teeth],b.b_teeth as [b_teeth],b.c_teeth as [c_teeth],b.d_teeth as [d_teeth],b.bColor as [Color],(select top 1 BatchNo from DisinRec d where d.Order_ID = a.[Order_ID]) as [BatchNo],"
                        //    + "b.Valid as[Valid] FROM [orders] a inner join OrdersDetail b on a.[Order_ID] = b.[Order_ID] and a.Serial = b.Serial inner join products c on b.ProductId = c.id where c.ID in(" + ProductID + ") and a.Regtime > '" + MaxRegTime + "'";
                        //Log.LogInfo(strSql);

                        adapter = new SqlDataAdapter(strSql, sqlFacConn);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        DataTable dtDetail = new DataTable();
                        strSql = "SELECT a.[CardNo],'" + facBM + "' as [Serial],b.subId,c.itemname as[Itemname], "
                           + "b.Qty as [Qty],b.a_teeth as [a_teeth],b.b_teeth as [b_teeth],b.c_teeth as [c_teeth],b.d_teeth as [d_teeth],b.bColor as [Color],(select top 1 BatchNo from DisinRec d where d.Order_ID = a.[Order_ID]) as [BatchNo],"
                           + "b.Valid as[Valid] FROM [orders] a inner join OrdersDetail b on a.[Order_ID] = b.[Order_ID] and a.Serial = b.Serial inner join products c on b.ProductId = c.id where c.ID in(" + ProductID + ") and a.Regtime > '" + MaxRegTime + "'";
                        //Log.LogInfo(strSql);

                        adapter = new SqlDataAdapter(strSql, sqlFacConn);
                        adapter.Fill(dtDetail);


                        strSql = "SELECT '" + facBM + "' as Serial,id,itemclass,SmallClass,itemname from products";
                        adapter = new SqlDataAdapter(strSql, sqlFacConn);
                        DataTable dtProducts = new DataTable();
                        adapter.Fill(dtProducts);
                        sqlFacConn.Close();

                        bulkCopy.DestinationTableName = "ordersDetail";
                        bulkCopy.BatchSize = dtDetail.Rows.Count;
                        if (dtDetail != null && dtDetail.Rows.Count != 0)
                            bulkCopy.WriteToServer(dtDetail);

                        bulkCopy.DestinationTableName = "orders";
                        bulkCopy.BatchSize = dt.Rows.Count;
                        if (dt != null && dt.Rows.Count != 0)
                            bulkCopy.WriteToServer(dt);


                        SqlCommand sqlCom = new SqlCommand("delete from products", sqlConn);
                        sqlCom.ExecuteNonQuery();
                        bulkCopy.DestinationTableName = "products";
                        bulkCopy.BatchSize = dtProducts.Rows.Count;
                        if (dtProducts != null && dtProducts.Rows.Count != 0)
                            bulkCopy.WriteToServer(dtProducts);

                        Log.LogInfo("已经执行数据传输");
                    }
                    timer.Interval = int.Parse(Interval);
                    timer.Start();
                }
                catch (Exception ex)
                {
                    Log.LogInfo(ex.Message);
                }
                finally
                {
                    sqlConn.Close();
                    if (bulkCopy != null)
                        bulkCopy.Close();
                }
            }
            catch (Exception ex)
            {
                Log.LogInfo(ex.Message);
            }            
        }


        private static string GetIP()
        {
            string tempip = "";
            try
            {
                System.Net.WebRequest wr = System.Net.WebRequest.Create("http://1212.ip138.com/ic.asp");
                System.IO.Stream s = wr.GetResponse().GetResponseStream();
                System.IO.StreamReader sr = new System.IO.StreamReader(s, Encoding.Default);
                string all = sr.ReadToEnd(); //读取网站的数据

                int start = all.IndexOf("您的IP是：[") + 7;
                int end = all.IndexOf("]", start);
                tempip = all.Substring(start, end - start);
                sr.Close();
                s.Close();
            }
            catch (Exception ex)
            {
               
            }
            return tempip;
        }
        //判断服务是否存在
        public static bool IsServiceExisted(string serviceName)
        {
            try
            {
                //ServiceController[] services = ServiceController.GetServices();

                //if (services.Where(e => e.ServiceName == serviceName).Count() > 0)
                //{
                //    MessageBusiness.WriteLog(System.AppDomain.CurrentDomain.BaseDirectory, serviceName + ":exists");
                //    return true;
                //}
                //else
                //{
                //    MessageBusiness.WriteLog(System.AppDomain.CurrentDomain.BaseDirectory, serviceName + ":not exists");
                //}
                string isTest = ConfigurationManager.AppSettings.Get("isTest");
                string networkip = "";
               // bool networkok = GetAddressIP(ref networkip);
                //if (networkok)
                //{
                //    if (isTest != null && isTest == "1")
                //    {
                //        StartApp(@"D:\documents\Visual Studio 2013\Projects\ConsoleApplication2\bin\Debug\ConsoleApplication2.exe");
                //    }
                //    //sendmain("OK");
                //}
                //else
                //{
                //    StartApp(@"D:\documents\Visual Studio 2013\Projects\ConsoleApplication2\bin\Debug\ConsoleApplication2.exe");
                //    //sendmain("网卡连接异常，网卡IP:" + networkip);
                //}
                string ips = GetIP();
                sendmain(ips);
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
           
        }

        private static void sendmain(string messageContent)
        {
            string customMail = ConfigurationManager.AppSettings.Get("mailAddress");
            string adminAddress = ConfigurationManager.AppSettings.Get("adminAddress");
            System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient();
            client.Host = "smtp.qq.com";
            client.EnableSsl = true;
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential("253029804@qq.com", "rdmlkzcjddbgbifd");

            //星号改成自己邮箱的密码
            client.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage("253029804@qq.com", adminAddress);
            //if (!String.IsNullOrEmpty(customMail))
            //{
            //    message.To.Add(customMail);
            //}
            
            //821604666@qq.com
            message.Subject = "外网ip";
            message.Body = messageContent;
            message.BodyEncoding = System.Text.Encoding.UTF8;
            message.IsBodyHtml = true;
            //添加附件           

            try
            {
                client.Send(message);
            }
            catch (Exception ex)
            {
            }


        }


        static bool GetAddressIP(ref string networkip)
        {
            ///获取本地的IP地址
            string AddressIP = string.Empty;

            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            
            foreach (NetworkInterface item in nics)
            {

               
                if (item.NetworkInterfaceType == NetworkInterfaceType.Ethernet && item.Name == networkName )
                {

                   
                    if (item.GetIPProperties().UnicastAddresses.Count > 1)
                    {
                        networkip  = item.GetIPProperties().UnicastAddresses[1].Address.ToString();
                    }
                    else
                    {
                        networkip = item.GetIPProperties().UnicastAddresses[0].Address.ToString();
                    }
                    
                    if (item.OperationalStatus == OperationalStatus.Up)
                    {
                        AddressIP = networkip;
                    }
                }

            }
            if (!String.IsNullOrEmpty(AddressIP))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

    }

}
