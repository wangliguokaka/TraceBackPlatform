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
            int iPageCount = 0;
            IList<ModelSale> listObj = servComm.GetList<ModelSale>("Sale", "*", "Id",10,0, iPageCount, ccwhere);
            var timeConvert = new IsoDateTimeConverter();
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
            Response.Write(responseJson);
            Response.End();

        }
    }
}