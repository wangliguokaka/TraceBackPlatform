using D2012.Common.DbCommon;
using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
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
        ccWhere.AddComponent("Passwd", password, SearchComponent.Equals, SearchPad.And);
        ModelClient objUser = servComm.GetEntity<ModelClient>(null, ccWhere);
        if (objUser != null && objUser.ID > 0)
        {
            Session["UserName"] = username;
            Session["objUser"] = objUser;
            Response.Redirect("SalesManage/ProductSales.aspx");
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "sucess", "layer.msg('用户名或密码错误');", true);
        }
    }
}