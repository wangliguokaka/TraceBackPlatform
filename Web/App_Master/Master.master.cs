using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class App_Master_Master : System.Web.UI.MasterPage
{
    ServiceCommon servComm = new ServiceCommon();
    protected ModelBase modelBase = new ModelBase();
    protected void Page_Load(object sender, EventArgs e)
    {
        modelBase = servComm.GetEntity<ModelBase>("1");
    }

    protected void logout_Click(object sender, EventArgs e)
    {
        Session["objUser"] = null;
        Session["UserName"] = null;
        Session["AccessMenu"] = "";
        HttpContext.Current.Response.Redirect("/login.aspx");
    }
}
