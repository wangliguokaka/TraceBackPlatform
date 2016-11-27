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

public partial class SalesManage_RelatedOrder : PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    IList<ModeRelatedOrderView> listObj;
    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (actiontype == "GetSaleList")
        {
            ConstructionCondition();

            int iPageCount = 0;
            int iPageIndex = int.Parse(Request["PageIndex"]) + 1;
            servComm.strOrderString = "CardNo";
            listObj = servComm.GetList<ModeRelatedOrderView>("ViewRelatedOrder", "*", "CardNo", 10, iPageIndex, iPageCount, ccwhere);
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
            listObj = servComm.GetListTop<ModeRelatedOrderView>(0, "[CardNo],[factoryBM],[Order_ID],[hospital],[doctor],[patient],[OutDate],[factoryValid],[a_teeth],[b_teeth],[c_teeth],[d_teeth],[Itemname],[Id],[Serial],[Bh],[orderid],[Qty],[OClass],[ObatchNo],[BatchNo],[ProdDate],[TestDate],[BtQty],[SRate],[Valid],[Addr],[receiver],[Tel],[distri],[distriNo],[NoStart],[NoEnd],[NoQty],[BillClass],[seller],[Salesperson]", "ViewRelatedOrder", ccwhere);
            string shortName = DateTime.Now.ToString("yyyyMMddHHmmsshhh") + ".xlsx";
            string fileName = Request.PhysicalApplicationPath + "UploadFile\\" + shortName;
            using (NPOIHelper excelHelper = new NPOIHelper(fileName, Request.PhysicalApplicationPath + "UploadFile\\"))
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("SaleDate");
                dt.Columns.Add("seller");
                dt.Columns.Add("Salesperson");
                dt.Columns.Add("BillDate");
                dt.Columns.Add("Qty");

                DataTable dtTable = listObj.ToDataTable(dt);                
                int count = excelHelper.DataTableToExcel(dtTable, "订单关联信息", true, "订单关联信息.xlsx");
            }
            Response.Write("http://" + Request.Url.Authority + "//UploadFile//" + shortName);
            Response.End();
        }
    }

    private void ConstructionCondition()
    {
        ccwhere.Clear();
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
       
    }
}