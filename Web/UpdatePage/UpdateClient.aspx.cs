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
    //类型
    public string classname
    {
        get
        {
            if (Request["class"] != null)
            {
                return Request["class"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }
    //序号
    public string serial
    {
        get
        {
            if (Request["serial"] != null)
            {
                return Request["serial"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }
    //string classname = "";
    //string serial = "";

    //string client = "";
    //string tel = "";
    //string tel2 = "";
    //string country = "";
    //string province = "";
    //string city = "";
    //string addr = "";
    //string email = "";
    //string userName = "";
    //string passwd = "";

    //客户
    public string client
    {
        get
        {
            if (Request["client"] != null)
            {
                return Request["client"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }

    //手机
    public string tel
    {
        get
        {
            if (Request["tel"] != null)
            {
                return Request["tel"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }
    //固定电话
    public string tel2
    {
        get
        {
            if (Request["tel2"] != null)
            {
                return Request["tel2"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }
    //国家


    public string country
    {
        get
        {
            if (Request["country"] != null)
            {
                return Request["country"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }

    //省份
    public string province
    {
        get
        {
            if (Request["province"] != null)
            {
                return Request["province"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }

    //城市
    public string city
    {
        get
        {
            if (Request["city"] != null)
            {
                return Request["city"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }


     //地址

    public string addr
    {
        get
        {
            if (Request["addr"] != null)
            {
                return Request["addr"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }

    //邮箱
    //string  = "";
    //string passwd = "";
    public string email
    {
        get
        {
            if (Request["email"] != null)
            {
                return Request["email"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }
    //用户名
    public string userName
    {
        get
        {
            if (Request["userName"] != null)
            {
                return Request["userName"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }
    //密码
    public string passwd
    {
        get
        {
            if (Request["passwd"] != null)
            {
                return Request["passwd"].ToString();
            }
            else
            {
                return String.Empty;
            }
        }
    }
   

    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.QueryString["selectclientid"];
        ClientDal dal = new ClientDal();
        DataSet ds = dal.SelectById(id);
        DataTable dt = ds.Tables[0];
        Class.Text = dt.Rows[0][1].ToString();
        Serial.Text = dt.Rows[0][2].ToString();
        Client.Text = dt.Rows[0][3].ToString();
        Tel.Text = dt.Rows[0][4].ToString();
        Tel2.Text = dt.Rows[0][5].ToString();
        Country.Text = dt.Rows[0][6].ToString();
        Province.Text = dt.Rows[0][7].ToString();
        City.Text = dt.Rows[0][8].ToString();
        Addr.Text = dt.Rows[0][9].ToString();
        Email.Text = dt.Rows[0][10].ToString();
        UserName.Text = dt.Rows[0][11].ToString();
        Passwd.Text = dt.Rows[0][12].ToString();

    }

    #region   提交按钮
    protected void Submit_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["selectclientid"];
        ClientDal dal = new ClientDal();
       
        //if (string.IsNullOrEmpty(this.Class.Text))
        //{
        //    classname = "";
        //}
        //else
        //{
        //    classname = this.Class.Text;
        //}

        //if (string.IsNullOrEmpty(this.Serial.Text))
        //{
        //    serial = "";
        //}
        //else
        //{
        //    serial = this.Serial.Text;
        //}

        //if (string.IsNullOrEmpty(this.Client.Text))
        //{
        //    client = "";
        //}
        //else
        //{
        //    client = this.Client.Text;
        //}

        //if (string.IsNullOrEmpty(this.Tel.Text))
        //{
        //    tel = "";
        //}
        //else
        //{
        //    tel = this.Tel.Text;
        //}

        //if (string.IsNullOrEmpty(this.Tel2.Text))
        //{
        //    tel2 = "";
        //}
        //else
        //{
        //    tel2 = this.Tel2.Text;
        //}

        //if (string.IsNullOrEmpty(this.Country.Text))
        //{
        //    country = "";
        //}
        //else
        //{
        //    country = this.Country.Text;
        //}

        //if (string.IsNullOrEmpty(this.Province.Text))
        //{
        //    province = "";
        //}
        //else
        //{
        //    province = this.Province.Text;
        //}

        //if (string.IsNullOrEmpty(this.City.Text))
        //{
        //    city = "";
        //}
        //else
        //{
        //    city = this.City.Text;
        //}

        //if (string.IsNullOrEmpty(this.Addr.Text))
        //{
        //    addr = "";
        //}
        //else
        //{
        //    addr = this.Addr.Text;
        //}

        //if (string.IsNullOrEmpty(this.Email.Text))
        //{
        //    email = "";
        //}
        //else
        //{
        //    email = this.Email.Text;
        //}

        //if (string.IsNullOrEmpty(this.UserName.Text))
        //{
        //    userName = "";
        //}
        //else
        //{
        //    userName = this.UserName.Text;
        //}

        //if (string.IsNullOrEmpty(this.Passwd.Text))
        //{
        //    passwd = "";
        //}
        //else
        //{
        //    passwd = this.Passwd.Text;
        //}

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