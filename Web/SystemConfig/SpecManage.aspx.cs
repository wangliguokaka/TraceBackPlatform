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

public partial class SystemConfig_SpecManage : PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    IList<ModelSpec> listObj;
    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (actiontype == "GetSpecManageList")
        {
            
            string Bh = Request["Bh"];
            if (!String.IsNullOrEmpty(Bh))
            {
                ccwhere.AddComponent("Bh", "%" + Bh + "%", SearchComponent.Like, SearchPad.And);
            }
            string Class = Request["Class"];
            if (!String.IsNullOrEmpty(Class))
            {
                ccwhere.AddComponent("Class", "%" + Class + "%", SearchComponent.Like, SearchPad.And);
            }
            string OrderNo = Request["OrderNo"];
            if (!String.IsNullOrEmpty(OrderNo))
            {
                ccwhere.AddComponent("OrderNo", "%" + OrderNo + "%", SearchComponent.Like, SearchPad.And);
            }

          

            int iPageCount = 0;
            int iPageIndex = int.Parse(Request["PageIndex"]) + 1;
            servComm.strOrderString = "Id desc";
            listObj = servComm.GetList<ModelSpec>("Spec", "*", "Id", 10, iPageIndex, iPageCount, ccwhere);
            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
            Response.Write("[{\"RowCount\":" + servComm.RowCount + ",\"JsonData\":" + responseJson + "}]");
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
            listObj = servComm.GetListTop<ModelSpec>(0, "[Id],[SaleDate],[seller],[Salesperson],[BillDate],[BillNo],[BillClass],[Reg],[RegTime]", "Sale", ccwhere);
            string shortName = DateTime.Now.ToString("yyyyMMddHHmmsshhh") + ".xlsx";
            string fileName = Request.PhysicalApplicationPath + "UploadFile\\" + shortName;
            using (NPOIHelper excelHelper = new NPOIHelper(fileName, Request.PhysicalApplicationPath + "UploadFile\\"))
            {
                DataTable dtTable = listObj.ToDataTable();
                dtTable.Columns.Remove("IsDel");
                int count = excelHelper.DataTableToExcel(dtTable, "订单信息", true);
            }
            Response.Write("http://" + Request.Url.Authority + "//UploadFile//" + shortName);
            Response.End();
        }
        else if (Request["actiontype"] == "SaveSpec")
        {
            int identityID = 0;
            try
            {
                ModelSpec ModelSpec = new ModelSpec();
                if (String.IsNullOrEmpty(Request["Id"]))
                {
                    ModelSpec.Class = Request["Class"];
                    ModelSpec.Bh = Request["Bh"];
                    ModelSpec.ProductName = Request["ProductName"];
                    ModelSpec.Spec = Request["Spec"];
                    ModelSpec.OrderNo = Request["OrderNo"];
                    ModelSpec.Size = Request["Size"];
                    ModelSpec.exterior = Request["exterior"];
                    ModelSpec.Color = Request["Color"];
                    ModelSpec.Remark = Request["Remark"];                  
                    identityID = servComm.Add(ModelSpec);
                }
                else
                {

                    if (String.IsNullOrEmpty(Request["Bh"]))
                    {
                        identityID = servComm.ExecuteSql(" delete from Spec where ID in (" + Request["Id"] + ");");

                    }
                    else
                    {
                        identityID = int.Parse(Request["Id"]);
                        ModelSpec.Class = Request["Class"];
                        ModelSpec.Bh = Request["Bh"];
                        ModelSpec.ProductName = Request["ProductName"];
                        ModelSpec.Spec = Request["Spec"];
                        ModelSpec.OrderNo = Request["OrderNo"];
                        ModelSpec.Size = Request["Size"];
                        ModelSpec.exterior = Request["exterior"];
                        ModelSpec.Color = Request["Color"];
                        ModelSpec.Remark = Request["Remark"];
                        ModelSpec.ID = identityID;
                        int result = servComm.Update(ModelSpec);
                    }
                }

            }
            catch (Exception ex)
            {
                Response.Write(0);
                Response.End();
            }

            Response.Write(identityID);
            Response.End();

        }

    }
}