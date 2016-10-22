using D2012.DBUtility.Data.Core.SQLCore;
using D2012.Domain.Dal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Addpage_AddClient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    #region   提交按钮
    protected void Submit_Click(object sender, EventArgs e)
    {
        ClientDal dal = new ClientDal();
        string classname ="";
        string serial ="";
        string client ="";
        string tel ="";
        string tel2 ="";
        string country ="";
        string province="";
        string city ="";
        string addr ="";
        string email ="";
        string userName ="";
        string passwd ="";
        if(string.IsNullOrEmpty(this.Class.Text)){
             classname = "null";
        }else{
             classname = this.Class.Text;
        }

         if(string.IsNullOrEmpty(this.Serial.Text)){
             serial = "null";
        }else{
             serial = this.Serial.Text;
        }

         if(string.IsNullOrEmpty(this.Client.Text)){
             client = "null";
        }else{
             client = this.Client.Text;
        }

         if(string.IsNullOrEmpty(this.Tel.Text)){
            tel = "null";
        }else{
            tel = this.Tel.Text;      
        }

         if(string.IsNullOrEmpty(this.Tel2.Text)){
            tel2 = "null";
        }else{
            tel2 = this.Tel2.Text;
        }

         if(string.IsNullOrEmpty(this.Country.Text)){
            country = "null";
        }else{
             country = this.Country.Text;        
        }

         if(string.IsNullOrEmpty(this.Province.Text)){
            province = "null";
        }else{
            province = this.Province.Text;
        }

         if(string.IsNullOrEmpty(this.City.Text)){
            city = "null";
        }else{
            city = this.City.Text;
        }
       
        if(string.IsNullOrEmpty(this.Addr.Text)){
            addr = "null";
        }else{
            addr = this.Addr.Text;     
        }

         if(string.IsNullOrEmpty(this.Email.Text)){
            email = "null";
        }else{
            email = this.Email.Text;
        }

         if(string.IsNullOrEmpty(this.UserName.Text)){
            userName = "null";
        }else{
            userName = this.UserName.Text;
        }

        if(string.IsNullOrEmpty(this.Passwd.Text)){
            passwd = "null";
        }else{
             passwd = this.Passwd.Text;
        }

        dal.AddClient(classname,serial,client,tel,tel2,country,province,city,addr,email,userName,passwd);


        //if (a > 0)
        //{
           Response.Redirect("DBTableManagement.aspx");
           Response.End();
        // }
        // else
        //{
        //        System.Threading.Thread.Sleep(2000);
        //        Response.Redirect("AddClient.aspx");
        //        Response.End();
        // }
        //}
    }
    #endregion   提交按钮

    #region 重置按钮
    protected void Reset_Click(object sender, EventArgs e)
    {
        this.FindButton(this);
    }
    private void FindButton(Control c)
    {
        if (c.Controls != null)
        {

            foreach (Control x in c.Controls)
            {
                if (x is System.Web.UI.WebControls.TextBox)
                {
                    ((System.Web.UI.WebControls.TextBox)x).Text = "";
                }
                FindButton(x);
            }
        }
    }
    #endregion 重置按钮
}