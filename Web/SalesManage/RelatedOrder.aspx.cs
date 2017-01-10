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
    IList<ModelClient> listSeler = new List<ModelClient>();
    protected string BindingJson = "[]";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ccwhere.Clear();
            ccwhere.AddComponent("Class", "B", SearchComponent.Equals, SearchPad.NULL);
            listSeler = servComm.GetListTop<ModelClient>(0, "*", "Client", ccwhere);
            BindingJson = JsonConvert.SerializeObject(listSeler, Formatting.Indented, new IsoDateTimeConverter());

            BindingJson = BindingJson.Replace("\r\n", "").Replace("Client", "NodeName");
        }
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
                dt.Columns.Add("BillNo");
                dt.Columns.Add("BillClass");
                dt.Columns.Add("Qty");
                dt.Columns.Add("Bh");
                dt.Columns.Add("ProductName");
                dt.Columns.Add("orderid");
                dt.Columns.Add("BatchNo");
                dt.Columns.Add("OClass");
                dt.Columns.Add("ObatchNo");
                dt.Columns.Add("ProdDate");
                dt.Columns.Add("BtQty");
                dt.Columns.Add("SRate");
                dt.Columns.Add("Valid");
                dt.Columns.Add("receiver");
                dt.Columns.Add("Addr");
                dt.Columns.Add("Tel");
                dt.Columns.Add("distri");
                dt.Columns.Add("distriNo");
                dt.Columns.Add("NoStart");
                dt.Columns.Add("NoEnd");
                dt.Columns.Add("NoQty");
                dt.Columns.Add("factoryBM");
                dt.Columns.Add("Order_ID");
                dt.Columns.Add("hospital");
                dt.Columns.Add("doctor");
                dt.Columns.Add("patient");
                dt.Columns.Add("OutDate");
                dt.Columns.Add("Itemname");
                dt.Columns.Add("factoryValid");
                dt.Columns.Add("a_teeth");
                dt.Columns.Add("b_teeth");
                dt.Columns.Add("c_teeth");
                dt.Columns.Add("d_teeth");

                string templateName = "订单关联信息.xlsx";
                if (LoginUser.Class == "A")
                {
                    templateName = "订单关联信息A.xlsx";
                    dt.Columns.Remove("SaleDate");
                    dt.Columns.Remove("Salesperson");
                    dt.Columns.Remove("BillDate");
                    dt.Columns.Remove("BillNo");
                    dt.Columns.Remove("BillClass");
                    dt.Columns.Remove("Bh");
                    dt.Columns.Remove("OClass");
                    dt.Columns.Remove("ObatchNo");
                    dt.Columns.Remove("BtQty");
                    dt.Columns.Remove("distri");
                    dt.Columns.Remove("NoStart");
                    dt.Columns.Remove("NoEnd");          

                    dt.Columns.Remove("factoryBM");
                    dt.Columns.Remove("Order_ID");
                    dt.Columns.Remove("hospital");
                    dt.Columns.Remove("doctor");
                    dt.Columns.Remove("patient");
                    dt.Columns.Remove("OutDate");
                    dt.Columns.Remove("Itemname");
                    dt.Columns.Remove("factoryValid");
                    dt.Columns.Remove("a_teeth");
                    dt.Columns.Remove("b_teeth");
                    dt.Columns.Remove("c_teeth");
                    dt.Columns.Remove("d_teeth");
                }
                else if (LoginUser.Class == "B")
                {
                    templateName = "订单关联信息B.xlsx";
                    dt.Columns.Remove("SaleDate");
                    dt.Columns.Remove("Salesperson");
                    dt.Columns.Remove("BillDate");
                    dt.Columns.Remove("BillNo");
                    dt.Columns.Remove("BillClass");
                    dt.Columns.Remove("Bh");
                    dt.Columns.Remove("OClass");
                    dt.Columns.Remove("ObatchNo");
                    dt.Columns.Remove("BtQty");
                    dt.Columns.Remove("distri");
                    dt.Columns.Remove("NoStart");
                    dt.Columns.Remove("NoEnd");
                }

                DataTable dtTable = listObj.ToDataTable(dt);                
                int count = excelHelper.DataTableToExcel(dtTable, "订单关联信息", true, templateName);
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
            ccwhere.AddComponent("CardNo", CardNoStart, SearchComponent.GreaterOrEquals, SearchPad.And);
        }
        string CardNoEnd = Request["CardNoEnd"];
        if (!String.IsNullOrEmpty(CardNoEnd))
        {
            ccwhere.AddComponent("CardNo", CardNoEnd, SearchComponent.LessOrEquals, SearchPad.And);
        }

        string FilterSerial = Request["FilterSerial"];
        if (!String.IsNullOrEmpty(FilterSerial))
        {
            ccwhere.AddComponent("factoryBM", '%'+FilterSerial+'%', SearchComponent.Like, SearchPad.And);
        }

        string FilterSalesperson = Request["FilterSalesperson"];
        if (!String.IsNullOrEmpty(FilterSalesperson))
        {
            ccwhere.AddComponent("Salesperson", '%' + FilterSalesperson + '%', SearchComponent.Like, SearchPad.And);
        }

        string FilterSeller = Request["FilterSeller"];
        if (!String.IsNullOrEmpty(FilterSeller))
        {
            ccwhere.AddComponent("seller", '%' + FilterSeller + '%', SearchComponent.Like, SearchPad.And);
        }

        if (LoginUser.Class == "B")
        {
            ccwhere.AddComponent("Serial", LoginUser.Serial, SearchComponent.Equals, SearchPad.And);
        }

        if (LoginUser.Class == "A")
        {
            ccwhere.AddComponent("seller", LoginUser.Serial, SearchComponent.Equals, SearchPad.And);
        }

        string FilterSalesDateStart = Request["FilterSalesDateStart"];
        if (!String.IsNullOrEmpty(FilterSalesDateStart))
        {
            ccwhere.AddComponent("SaleDate", FilterSalesDateStart, SearchComponent.GreaterOrEquals, SearchPad.And);
        }
        string FilterSalesDateEnd = Request["FilterSalesDateEnd"];
        if (!String.IsNullOrEmpty(FilterSalesDateEnd))
        {
            ccwhere.AddComponent("SaleDate", DateTime.Parse(FilterSalesDateEnd).AddDays(1).ToString(), SearchComponent.Less, SearchPad.And);
        }
    }
}