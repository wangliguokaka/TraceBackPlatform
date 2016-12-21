using D2012.Common;
using D2012.Common.DbCommon;
using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccWhere = new ConditionComponent();

    protected void Page_Load(object sender, EventArgs e)
    {
       
        string action = Request["action"];
        if (action == "checkcode")
        {
            string checkcode = Request["checkcode"];
            if (checkcode.ToLower() == Session["CheckCode"].ToString().ToLower())
            {
                Response.Write("1");
            }
            else
            {
                Response.Write("0");
            }
            Response.End();
        }
    }

    protected void loginBtn_Click(object sender, EventArgs e)
    {
        string username = Request["username"];
        string password = Request["password"];
        ccWhere.Clear();
        //condComponent.AddComponent("UPPER(Alias)", strUserName.ToUpper(), SearchComponent.Equals, SearchPad.Ex);
        ccWhere.AddComponent("UPPER(UserName)", username.ToUpper(), SearchComponent.Equals, SearchPad.NULL);
        ccWhere.AddComponent("Passwd", CryptoHelper.StaticEncrypt(password), SearchComponent.Equals, SearchPad.And);
        ModelClient objUser = servComm.GetEntity<ModelClient>(null, ccWhere);
        if (objUser != null && objUser.ID > 0)
        {
            Session["UserName"] = username;
            Session["objUser"] = objUser;
            Session["UserName"] = objUser.Client;


            //servComm.ExecuteSql("insert into Visitor values ( getdate())");

            if (objUser.Class == "S")
            {
                Session["AccessMenu"] = "S";
            }
            else
            {
                DataTable dtRole = servComm.ExecuteSqlDatatable("select Role" + objUser.Class + " from base");
                if (dtRole.Rows.Count > 0)
                {
                    Session["AccessMenu"] = dtRole.Rows[0][0].ToString();
                }
                if (Session["AccessMenu"] == null)
                {
                    Session["AccessMenu"] = "";
                }
            }
           

            Response.Redirect("index.aspx");
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "sucess", "layer.msg('用户名或密码错误');", true);
        }
    }
}