using D2012.Domain.Services;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SalesManage_LineUserShow : PageBase
{
    protected string categories = "";
    protected string serials = "";
    ServiceCommon servComm = new ServiceCommon();
    protected DataTable dtYear = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string actiontype = Request["actiontype"];
        string SelectYear = Request["SelectYear"];
        string SelectMonth = Request["SelectMonth"];
        if (actiontype == "GetAccessDate")
        {
            try
            {
                string ShowBy = "";
                string DimensionValue = "";
                if (!String.IsNullOrEmpty(SelectYear) && !String.IsNullOrEmpty(SelectMonth))
                {
                    ShowBy = "month";
                    DimensionValue = SelectYear + SelectMonth.PadLeft(2, '0');
                }
                else if (!String.IsNullOrEmpty(SelectYear) && String.IsNullOrEmpty(SelectMonth))
                {
                    ShowBy = "year";
                    DimensionValue = SelectYear;
                }
                DataTable dtAccess = servComm.ExecuteSqlDatatable("exec SP_GetAccessTime '" + ShowBy + "','" + DimensionValue + "'");
                DataTable dtX = new DataTable();
                dtX.Columns.Add("name");
                dtX.Columns.Add("data");
                string data = "[";
                string data1 = "[";
                for (int i = 0; i < dtAccess.Rows.Count; i++)
                {
                    categories = categories + "," + dtAccess.Rows[i][0];
                    data = data + dtAccess.Rows[i][1] + ",";
                }
                data = data.Trim(',') + "]";
                //data1 = data1.Trim(',') + "]";
                categories = categories.Trim(',');

                dtX.Rows.Add("患者访问量", data);
                //dtX.Rows.Add("User2", data1);

                //dtX.co
                serials = JsonConvert.SerializeObject(dtX, Formatting.Indented, new IsoDateTimeConverter());
                serials = serials.Replace("\r\n", "").Replace("\"[", "[").Replace("]\"", "]");
            }
            catch (Exception ex)
            {
                Response.Write("0");
                Response.End();
            }
            Response.Write(categories + "|" + serials);
            Response.End();
        }
        else
        {
             dtYear = servComm.ExecuteSqlDatatable("select distinct year(AccessTime) as year from Visitor order by  year(AccessTime)");
        }
    }
}