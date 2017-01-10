using D2012.Common.DbCommon;
using D2012.Domain.Services;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SalesManage_MobilePatient : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (actiontype == "ValidCardNo")
        {
            string CardNo = Request["CardNo"];
            string PatientName = Request["PatientName"];
            ccwhere.Clear(); 
            ccwhere.AddComponent("CardNo", CardNo, SearchComponent.Equals, SearchPad.NULL);
            ccwhere.AddComponent("patient", PatientName, SearchComponent.Equals, SearchPad.And);
            DataTable dtOrders = servComm.GetListTop(0, "(select a.*,b.Client from orders a left join Client b on a.Serial = b.Serial) c", ccwhere);
            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(dtOrders, Formatting.Indented, timeConvert);

            ccwhere.Clear();
            ccwhere.AddComponent("CardNo", CardNo, SearchComponent.Equals, SearchPad.NULL);
            DataTable dtOrdersDetail = servComm.GetListTop(0, "ordersdetail", ccwhere);
            string detailJson = JsonConvert.SerializeObject(dtOrdersDetail, Formatting.Indented, timeConvert);
            if (dtOrders.Rows.Count > 0)
            {
                servComm.ExecuteSql("insert into Visitor values ( getdate())");
            }
            Response.Write("[{\"RowCount\":" + dtOrders.Rows.Count + ",\"JsonData\":" + responseJson + ",\"JsonDetail\":" + detailJson + "}]");
            Response.End();
        }
            
    }
}