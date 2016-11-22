<%@ WebHandler Language="C#" Class="BaseOpetation" Debug="true" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using D2012.Domain.Services;
using D2012.Common.DbCommon;
using D2012.Domain.Entities;

/// <summary>
/// Summary description for GetWorkFlowHandler
/// </summary>
public class BaseOpetation : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccWhere = new ConditionComponent();
    public string ConnectionString = "";
    public void ProcessRequest(HttpContext context)
    {

        // actiontype: "ModifyPass", "OldPass": OldPass, "NewPass": NewPass, "ConfirmPass": ConfirmPass
        string returnValue = "";
        string actiontype = context.Request["actiontype"];


        if (actiontype == "ModifyPass")
        {
            string OldPass = context.Request["OldPass"];
            string NewPass = context.Request["NewPass"];
            string ConfirmPass = context.Request["ConfirmPass"];

            try
            {
                servComm.ExecuteSql("update Client set Passwd ='" + ConfirmPass + "' where UserName = 88 and Passwd = '"+OldPass+"'");
            }
            catch (Exception ex)
            {
                context.Response.Write("0");
                context.Response.End();
            }


            //   context.Response.ContentType = "application/json";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.Write("1");
            context.Response.End();
        }



    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}



