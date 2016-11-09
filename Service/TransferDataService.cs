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
            }
            catch (Exception ex)
            {
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
