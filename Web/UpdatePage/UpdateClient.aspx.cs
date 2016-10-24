using D2012.Domain.Dal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UpdatePage_UpdateClient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.QueryString["selectclientid"];
        ClientDal dal = new ClientDal();
        DataSet ds = dal.SelectById(id);
        DataTable dt = ds.Tables[0];
        this.Class.Text = dt.Columns[1].ToString();
        this.Serial.Text = dt.Columns[2].ToString();
        this.Client.Text = dt.Columns[3].ToString();
        this.Tel.Text =  dt.Columns[4].ToString();
        this.Tel2.Text =  dt.Columns[5].ToString();
        this.Country.Text = dt.Columns[6].ToString();
        this.Province.Text =  dt.Columns[7].ToString();
        this.City.Text =  dt.Columns[8].ToString();
        this.Addr.Text =  dt.Columns[9].ToString();
        this.Email.Text = dt.Columns[10].ToString();
        this.UserName.Text =  dt.Columns[11].ToString();
        this.Passwd.Text = dt.Columns[12].ToString();
        //this.Class.Text = ds.Tables[0].Columns[1].ToString();
        //this.Serial.Text = ds.Tables[0].Columns[2].ToString();
        //this.Client.Text = ds.Tables[0].Columns[3].ToString();
        //this.Tel.Text = ds.Tables[0].Columns[4].ToString();
        //this.Tel2.Text = ds.Tables[0].Columns[5].ToString();
        //this.Country.Text = ds.Tables[0].Columns[6].ToString();
        //this.Province.Text = ds.Tables[0].Columns[7].ToString();
        //this.City.Text = ds.Tables[0].Columns[8].ToString();
        //this.Addr.Text = ds.Tables[0].Columns[9].ToString();
        //this.Email.Text = ds.Tables[0].Columns[10].ToString();
        //this.UserName.Text = ds.Tables[0].Columns[11].ToString();
        //this.Passwd.Text = ds.Tables[0].Columns[12].ToString();
        //this.Class.Text = ds.Tables[0].Columns[1][0];
        //this.Serial.Text = ds.Tables[0].Columns[2][0];
        //this.Client.Text = ds.Tables[0].Columns[3][0];
        //this.Tel.Text = ds.Tables[0].Columns[4][0];
        //this.Tel2.Text = ds.Tables[0].Columns[5][0];
        //this.Country.Text = ds.Tables[0].Columns[6][0];
        //this.Province.Text = ds.Tables[0].Columns[7][0];
        //this.City.Text = ds.Tables[0].Columns[8][0];
        //this.Addr.Text = ds.Tables[0].Columns[9][0];
        //this.Email.Text = ds.Tables[0].Columns[10][0];
        //this.UserName.Text = ds.Tables[0].Columns[11][0];
        //this.Passwd.Text = ds.Tables[0].Columns[12][0];

    }

    #region   提交按钮
    protected void Submit_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["selectclientid"];
        ClientDal dal = new ClientDal();
        string classname = "";
        string serial = "";
        string client = "";
        string tel = "";
        string tel2 = "";
        string country = "";
        string province = "";
        string city = "";
        string addr = "";
        string email = "";
        string userName = "";
        string passwd = "";
        if (string.IsNullOrEmpty(this.Class.Text))
        {
            classname = "";
        }
        else
        {
            classname = this.Class.Text;
        }

        if (string.IsNullOrEmpty(this.Serial.Text))
        {
            serial = "";
        }
        else
        {
            serial = this.Serial.Text;
        }

        if (string.IsNullOrEmpty(this.Client.Text))
        {
            client = "";
        }
        else
        {
            client = this.Client.Text;
        }

        if (string.IsNullOrEmpty(this.Tel.Text))
        {
            tel = "";
        }
        else
        {
            tel = this.Tel.Text;
        }

        if (string.IsNullOrEmpty(this.Tel2.Text))
        {
            tel2 = "";
        }
        else
        {
            tel2 = this.Tel2.Text;
        }

        if (string.IsNullOrEmpty(this.Country.Text))
        {
            country = "";
        }
        else
        {
            country = this.Country.Text;
        }

        if (string.IsNullOrEmpty(this.Province.Text))
        {
            province = "";
        }
        else
        {
            province = this.Province.Text;
        }

        if (string.IsNullOrEmpty(this.City.Text))
        {
            city = "";
        }
        else
        {
            city = this.City.Text;
        }

        if (string.IsNullOrEmpty(this.Addr.Text))
        {
            addr = "";
        }
        else
        {
            addr = this.Addr.Text;
        }

        if (string.IsNullOrEmpty(this.Email.Text))
        {
            email = "";
        }
        else
        {
            email = this.Email.Text;
        }

        if (string.IsNullOrEmpty(this.UserName.Text))
        {
            userName = "";
        }
        else
        {
            userName = this.UserName.Text;
        }

        if (string.IsNullOrEmpty(this.Passwd.Text))
        {
            passwd = "";
        }
        else
        {
            passwd = this.Passwd.Text;
        }

        dal.UpdateClientById(classname, serial, client, tel, tel2, country, province, city, addr, email, userName, passwd,id);


        //if (a > 0)
        //{
        Response.Redirect("../DBTableManagement.aspx");
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