using D2012.Common;
using D2012.Common.DbCommon;
using D2012.Domain.Entities;
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
using TraceBackPlatform.AppCode;

public partial class SalesManage_UserTrace : PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    IList<ModelOrders> listObj;
    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (actiontype == "GetSaleList")
        {
            ConstructionCondition();

            int iPageCount = 0;
            int iPageIndex = int.Parse(Request["PageIndex"]) + 1;
            servComm.strOrderString = "CardNo";
            listObj = servComm.GetList<ModelOrders>("orders", "*", "CardNo", 10, iPageIndex, iPageCount, ccwhere);
            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
            Response.Write("[{\"RowCount\":" + servComm.RowCount + ",\"JsonData\":" + responseJson + "}]");
            Response.End();

        }
        else if (actiontype == "ExportExcel")
        {
            ConstructionCondition();

            servComm.strOrderString = "CardNo";
            listObj = servComm.GetListTop<ModelOrders>(0, "*", "orders", ccwhere);
            string shortName = DateTime.Now.ToString("yyyyMMddHHmmsshhh") + ".xlsx";
            string fileName = Request.PhysicalApplicationPath + "UploadFile\\" + shortName;
            using (NPOIHelper excelHelper = new NPOIHelper(fileName, Request.PhysicalApplicationPath + "UploadFile\\"))
            {
                DataTable dtTable = listObj.ToDataTable();                
                int count = excelHelper.DataTableToExcel(dtTable, "工厂订单信息", true, "工厂订单信息.xlsx");
            }
            Response.Write("http://" + Request.Url.Authority + "//UploadFile//" + shortName);
            Response.End();
        }
    }

    private void ConstructionCondition()
    {
        string CardNoStart = Request["CardNoStart"];
        if (!String.IsNullOrEmpty(CardNoStart))
        {
            ccwhere.AddComponent("CardNoStart", CardNoStart, SearchComponent.GreaterOrEquals, SearchPad.And);
        }
        string CardNoEnd = Request["CardNoEnd"];
        if (!String.IsNullOrEmpty(CardNoEnd))
        {
            ccwhere.AddComponent("CardNoEnd", CardNoEnd, SearchComponent.LessOrEquals, SearchPad.And);
        }
        string Salesperson = Request["Salesperson"];
        if (!String.IsNullOrEmpty(Salesperson))
        {
            ccwhere.AddComponent("Salesperson", "%" + Salesperson + "%", SearchComponent.Like, SearchPad.And);
        }
    }
}