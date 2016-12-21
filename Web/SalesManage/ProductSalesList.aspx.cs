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

public partial class SalesManage_ProductSalesList : PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    IList<ModelSale> listObj;
    protected IList<ModelClient> listSeler = new List<ModelClient>();

    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (!IsPostBack)
        {
            servComm.strOrderString = "Client";
            ccwhere.Clear();
            ccwhere.AddComponent("Class", "A", SearchComponent.Equals, SearchPad.NULL);
            listSeler = servComm.GetListTop<ModelClient>(0, ccwhere);
        }
        if (actiontype == "GetSaleList")
        {
            string BillNo = Request["BillNo"];
            ccwhere.Clear();
            if (!String.IsNullOrEmpty(BillNo))
            {
                ccwhere.AddComponent("BillNo", "%"+BillNo.Trim() + "%", SearchComponent.Like, SearchPad.And);
            }
            string Salesperson = Request["Salesperson"];
            if (!String.IsNullOrEmpty(Salesperson))
            {
                ccwhere.AddComponent("Salesperson", "%"+Salesperson.Trim()+"%", SearchComponent.Like, SearchPad.And);
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
            servComm.strOrderString = "Id desc";
            listObj = servComm.GetList<ModelSale>("Sale", "*", "Id", 10, iPageIndex, iPageCount, ccwhere);
            listObj.ToList().ForEach(eo => eo.Seller = (listSeler.Where(le => le.Serial == eo.Seller).Count() > 0 ? listSeler.Where(le => le.Serial == eo.Seller).FirstOrDefault().Client : ""));


            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
            responseJson = responseJson.Replace(": null", ": \"\"");
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
        else if (actiontype == "ExportExcel")
        {
            string BillNo = Request["BillNo"];
            if (!String.IsNullOrEmpty(BillNo))
            {
                ccwhere.AddComponent("BillNo", "%" + BillNo + "%", SearchComponent.Like, SearchPad.And);
            }
            string Salesperson = Request["Salesperson"];
            if (!String.IsNullOrEmpty(Salesperson))
            {
                ccwhere.AddComponent("Salesperson", "%" + Salesperson + "%", SearchComponent.Like, SearchPad.And);
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

            servComm.strOrderString = "Id";
            string fieldShow = "[Id],[SaleDate],[seller],[Salesperson],[BillDate],[BillNo],[BillClass],[Reg],[RegTime]";
            listObj = servComm.GetListTop<ModelSale>(0, fieldShow, "Sale", ccwhere);
            string shortName = DateTime.Now.ToString("yyyyMMddHHmmsshhh") + ".xlsx";
            string fileName = Request.PhysicalApplicationPath + "UploadFile\\" + shortName;
            using (NPOIHelper excelHelper = new NPOIHelper(fileName, Request.PhysicalApplicationPath + "UploadFile\\"))
            {
                DataTable dt = new DataTable();
                string[] splitField = fieldShow.Split(',');
                for (int i = 0; i < splitField.Length; i++)
                {
                    dt.Columns.Add(splitField[i].Trim('[').Trim(']'));
                }                
              
                DataTable dtTable = listObj.ToDataTable(dt);
                //dtTable.Columns.Remove("IsDel");
                int count = excelHelper.DataTableToExcel(dtTable, "订单信息", true);
            }
            Response.Write("http://"+ Request.Url.Authority+"//UploadFile//"+ shortName);
            Response.End();
        }
        
    }
}