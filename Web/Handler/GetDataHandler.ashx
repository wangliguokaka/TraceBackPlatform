<%@ WebHandler Language="C#" Class="GetDataHandler" Debug="true" %>

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
public class GetDataHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccWhere = new ConditionComponent();
    public string ConnectionString = "";
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string returnValue = "";
            string strType = context.Request["ddlType"];
            string strParaValue = context.Request["ddlId"];

            string IsCN = context.Request["IsCN"];
            DataTable dtResult = null;
            servComm.strOrderString = "";

            ccWhere.Clear();
            if (String.IsNullOrEmpty(strParaValue) || strParaValue=="-1")
            {
                ccWhere.AddComponent("1", "2", SearchComponent.Equals, SearchPad.NULL);
            }
            else
            {
                ccWhere.AddComponent("parentid", strParaValue, SearchComponent.Equals, SearchPad.NULL);
            }

            if (strType == "Group")
            {

                dtResult = servComm.GetListTop(0, " codeid as id,areaName as NameCN,areaName as NameEN ", "DictArea", null);
            }
            else if (strType == "Process")
            {
                dtResult = servComm.GetListTop(0, " codeid as id,areaName as NameCN ,areaName as NameEN", "DictArea", ccWhere);
            }
            else
            {


                dtResult = servComm.GetListTop(0, " codeid as ID,areaName as NameCN,areaName as NameEN ", "DictArea", ccWhere);
            }


            StringBuilder strClass = new StringBuilder();
            if (dtResult != null && dtResult.Rows.Count >0)
            {
                strClass.Append("[");
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    strClass.Append("{");
                    strClass.Append("\"ID\":\"" + dtResult.Rows[i]["ID"].ToString() + "\",");

                    strClass.Append("\"Cname\":\"" + (IsCN == "False" ? dtResult.Rows[i]["NameEN"].ToString() : dtResult.Rows[i]["NameCN"].ToString()) + "\"");

                    if (i != dtResult.Rows.Count - 1)
                    {
                        strClass.Append("},");
                    }
                }

                strClass.Append("}");
                strClass.Append("]");
                returnValue = strClass.ToString();
            }
            else
            {
               returnValue = "[]";
            }

            context.Response.ContentType = "application/json";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.Write(returnValue);
            context.Response.End();



        }
        catch(Exception ex)
        {

        }
        finally
        {
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



