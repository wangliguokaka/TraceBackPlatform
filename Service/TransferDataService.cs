using Cjwdev.WindowsApi;
using System;
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
            timer.Interval = int.Parse(Interval);
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
                Log.LogInfo("Upload");
               
                string con = ConfigurationManager.AppSettings["ConnectString"];
                SqlConnection sqlConn = new SqlConnection(con);
                SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConn);
                bulkCopy.DestinationTableName = "orders";
               
                bulkCopy.BulkCopyTimeout = 60;
                try
                {
                    string faccon = ConfigurationManager.AppSettings["FactoryConnectString"];
                    SqlConnection sqlFacConn = new SqlConnection(faccon);
                    sqlFacConn.Open();
                    string strSql = "SELECT [CardNo],'JJ2011' as [Serial],a.[Order_ID],[hospital],[doctor],[patient],[age],[sex],[OutDate],c.itemname as[Itemname], "
                        + "b.Qty as [Qty],b.a_teeth as [a_teeth],b.b_teeth as [b_teeth],b.c_teeth as [c_teeth],b.d_teeth as [d_teeth],b.bColor as [Color],(select top 1 BatchNo from DisinRec d where d.Order_ID = a.[Order_ID]) as [BatchNo],"
                        + "b.Valid as[Valid] FROM [orders] a inner join OrdersDetail b on a.[Order_ID] = b.[Order_ID] inner join products c on b.ProductId = c.id";

                    SqlDataAdapter adapter = new SqlDataAdapter(strSql, sqlFacConn);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    sqlFacConn.Close();

                    strSql = "SELECT id,itemclass,SmallClass,itemname from products";
                    adapter = new SqlDataAdapter(strSql, sqlFacConn);
                    DataTable dtProducts = new DataTable();
                    adapter.Fill(dtProducts);
                    sqlFacConn.Close();


                    bulkCopy.BatchSize = dt.Rows.Count;

                    sqlConn.Open();
                    SqlCommand sqlCom = new SqlCommand("delete from orders", sqlConn);
                    sqlCom.ExecuteNonQuery();
                    sqlCom.CommandText = "delete from products";
                    sqlCom.ExecuteNonQuery();
                    // new SqlCommand("delete from Patran_Model where [ModelID] = '" + modelID.ToString() + "'", sqlConn).ExecuteNonQuery();
                    if (dt != null && dt.Rows.Count != 0)
                        bulkCopy.WriteToServer(dt);

                    bulkCopy.DestinationTableName = "products";
                    bulkCopy.BatchSize = dtProducts.Rows.Count;
                    if (dtProducts != null && dtProducts.Rows.Count != 0)
                        bulkCopy.WriteToServer(dtProducts);
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
