using D2012.Common;
using D2012.Common.DbCommon;
using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SalesManage_ExportToExcel : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    protected void Page_Load(object sender, EventArgs e)
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
        DataTable dtSales = servComm.GetListTop(0, "[Id],[SaleDate],[seller],[Salesperson],[BillDate],[BillNo],[BillClass],[Reg],[RegTime]","Sale", ccwhere);
        string fileName = Request.PhysicalApplicationPath + "UploadFile\\" + DateTime.Now.ToString("yyyyMMddHHmmsshhh") + ".xlsx";
        using (NPOIHelper excelHelper = new NPOIHelper(fileName, Request.PhysicalApplicationPath + "UploadFile\\"))
        {
            
            int count = excelHelper.DataTableToExcel(dtSales, "订单信息", true);
        }
    }
}