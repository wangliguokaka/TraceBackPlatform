using D2012.Common.DbCommon;
using D2012.Domain.Entities;
using D2012.Domain.Services;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SalesManage_ProductSalesList : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (actiontype == "GetSaleList")
        {
            string BillNo = Request["BillNo"];
            if (!String.IsNullOrEmpty(BillNo))
            {
                ccwhere.AddComponent("BillNo", "%"+BillNo+"%", SearchComponent.Like, SearchPad.And);
            }
            string Salesperson = Request["Salesperson"];
            if (!String.IsNullOrEmpty(Salesperson))
            {
                ccwhere.AddComponent("Salesperson", "%"+Salesperson+"%", SearchComponent.Like, SearchPad.And);
            }
            string IsDel = Request["IsDel"];
            if (!String.IsNullOrEmpty(IsDel))
            {
                ccwhere.AddComponent("IsDel", "1", SearchComponent.Equals, SearchPad.And);
            }
            else
            {
                ccwhere.AddComponent("Isnull(IsDel,0)", "1", SearchComponent.UnEquals, SearchPad.And);
            }
            int iPageCount = 0;
            int iPageIndex = int.Parse(Request["PageIndex"])+1;
            servComm.strOrderString = "Id";
            IList<ModelSale> listObj = servComm.GetList<ModelSale>("Sale", "*", "Id", 10, iPageIndex, iPageCount, ccwhere);
            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
            Response.Write("[{\"RowCount\":"+servComm.RowCount + ",\"JsonData\":"+ responseJson+"}]");
            Response.End();

        }
        else if(actiontype == "DisableOrderAction")
        {
            string Ids = Request["CheckOrder"];
            string result = "0";
            try
            {
                servComm.ExecuteSql("update Sale set IsDel = 1 where Id in (" + Ids + ")");
                result = "1";
            }
            catch (Exception ex)
            {
                result = "0";
            }
            Response.Write(result);
            Response.End();
        }
        else if (actiontype == "ReuseOrderAction")
        {
            string Ids = Request["CheckOrder"];
            string result = "0";
            try
            {
                servComm.ExecuteSql("update Sale set IsDel = 0 where Id in (" + Ids + ")");
                result = "1";
            }
            catch (Exception ex)
            {
                result = "0";
            }
            Response.Write(result);
            Response.End();
        }
    }
}