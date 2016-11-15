using D2012.Common;
using D2012.Common.DbCommon;
using D2012.Domain.Services;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SalesManage_GenerateContract : System.Web.UI.Page
{
    protected string strAction = "0";
    protected DataTable OrderDetail = new DataTable() ;
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    protected void Page_Load(object sender, EventArgs e)
    {
        string orderid = Request["orderid"];
        ccwhere.AddComponent("Id", orderid, SearchComponent.Equals, SearchPad.NULL);
        OrderDetail = servComm.GetListTop(0, "ViewSalesDetail", ccwhere);
        if (!IsPostBack)
        {
            string file = Request.PhysicalApplicationPath + "UploadFile\\"+"KQ201677.xlsx";
            TestExcelWrite(file);

        }
        else {
            strAction = "exportContact";
        }
    }

    static void TestExcelWrite(string file)
    {
        try
        {
            using (NPOIHelper excelHelper = new NPOIHelper(file))
            {
                DataTable data = new DataTable();
                for (int i = 0; i < 5; ++i)
                {
                    data.Columns.Add("Columns_" + i.ToString(), typeof(string));
                }

                for (int i = 0; i < 10; ++i)
                {
                    DataRow row = data.NewRow();
                    row["Columns_0"] = "item0_" + i.ToString();
                    row["Columns_1"] = "item1_" + i.ToString();
                    row["Columns_2"] = "item2_" + i.ToString();
                    row["Columns_3"] = "item3_" + i.ToString();
                    row["Columns_4"] = "item4_" + i.ToString();
                    data.Rows.Add(row);
                }
                int count = excelHelper.DataTableToExcel(data, "发货单", true);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Exception: " + ex.Message);
        }
    }


    protected void ExportContact_Click(object sender, EventArgs e)
    {
        this.SalesContactViewer.LocalReport.DataSources.Clear();
        DataTable dtContact  = (new SalesDataSet()).Tables["ContactDataTable"];
        //dtContact.Columns.Add("Seller");
        //dtContact.Columns.Add("ContactBH");
        //dtContact.Columns.Add("SignAddr");
        //dtContact.Columns.Add("Buyer");
        //dtContact.Columns.Add("SignDatetime");
        dtContact.Rows.Add(dtContact.NewRow());
        dtContact.Rows[0]["Seller"] = this.Seller.Text;
        dtContact.Rows[0]["ContactBH"] = this.ContactBH.Text;
        dtContact.Rows[0]["SignAddr"] = this.SignAddr.Text;
        dtContact.Rows[0]["Buyer"] = this.Buyer.Text;
        dtContact.Rows[0]["SignDatetime"] = Request["SignDatetime"];

        dtContact.Rows[0]["Quantity"] = this.Quantity.Text;
        dtContact.Rows[0]["ProvideGoods"] = this.ProvideGoods.Text;
        dtContact.Rows[0]["FeeCharge"] = this.FeeCharge.Text;
        dtContact.Rows[0]["CheckStandard"] = this.CheckStandard.Text;
        dtContact.Rows[0]["Statements"] = this.Statements.Text;
        dtContact.Rows[0]["Contact"] = this.Contact.Text;
        dtContact.Rows[0]["Solve"] = this.Solve.Text;
        dtContact.Rows[0]["SignMethod"] = this.SignMethod.Text;
        dtContact.Rows[0]["AppointedItem"] = this.AppointedItem.Text;
        dtContact.Rows[0]["AppointedItem1"] = this.AppointedItem1.Text;
        dtContact.Rows[0]["Liquor"] = this.Liquor.Text;
        dtContact.Rows[0]["Classify"] = this.Classify.Text;

        dtContact.Rows[0]["SellerBottom"] = this.SellerBottom.Text;
        dtContact.Rows[0]["BuyerBottom"] = this.BuyerBottom.Text;
        dtContact.Rows[0]["SellerAddr"] = this.SellerAddr.Text;
        dtContact.Rows[0]["BuyerAddr"] = this.BuyerAddr.Text;
        dtContact.Rows[0]["SellerOperator"] = this.SellerOperator.Text;
        dtContact.Rows[0]["BuyerOperator"] = this.BuyerOperator.Text;
        dtContact.Rows[0]["SellerTel"] = this.SellerTel.Text;
        dtContact.Rows[0]["BuyerTel"] = this.BuyerTel.Text;
        dtContact.Rows[0]["SellerFax"] = this.SellerFax.Text;
        dtContact.Rows[0]["BuyerFax"] = this.BuyerFax.Text;
        dtContact.Rows[0]["SellerBank"] = this.SellerBank.Text;
        dtContact.Rows[0]["BuyerBank"] = this.BuyerBank.Text;
        dtContact.Rows[0]["BuyerBank"] = this.BuyerBank.Text;
        dtContact.Rows[0]["SellerAccount"] = this.SellerAccount.Text;
        dtContact.Rows[0]["BuyerAccount"] = this.BuyerAccount.Text;
        dtContact.Rows[0]["SellerPostcodes"] = this.SellerPostcodes.Text;
        dtContact.Rows[0]["BuyerPostcodes"] = this.BuyerPostcodes.Text;



        DataTable dtSetail = new DataTable();
        dtSetail.Columns.Add("ProductName");
        dtSetail.Columns.Add("Spec");
        dtSetail.Columns.Add("OrderNo");
        dtSetail.Columns.Add("Unit");
        dtSetail.Columns.Add("Qty");
        dtSetail.Columns.Add("Price");
        dtSetail.Columns.Add("Amount");
        for (int i = 0;i< OrderDetail.Rows.Count;i++)
        {
            dtSetail.Rows.Add(dtSetail.NewRow());
            dtSetail.Rows[i]["ProductName"] = OrderDetail.Rows[i]["ProductName"];
            dtSetail.Rows[i]["Spec"] = OrderDetail.Rows[i]["Spec"];
            dtSetail.Rows[i]["OrderNo"] = OrderDetail.Rows[i]["OrderNo"];
            //dtSetail.Rows[i]["Unit"] = OrderDetail.Rows[i]["Unit"];
            dtSetail.Rows[i]["Qty"] = OrderDetail.Rows[i]["Qty"];
            //dtSetail.Rows[i]["Price"] = OrderDetail.Rows[i]["Price"];
            //dtSetail.Rows[i]["Amount"] = OrderDetail.Rows[i]["Amount"];
        }

        
        //dtGoodsTicket.Rows[1][2] = "部门：";
        //dtGoodsTicket.Rows[1][3] = "口腔技术分厂";
        //dtGoodsTicket.Rows[1][4] = "打印日期：";
        //dtGoodsTicket.Rows[1][5] = DateTime.Now.ToString("yyyy/MM/dd");

        this.SalesContactViewer.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dtContact));
        this.SalesContactViewer.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dtSetail));
   
        this.SalesContactViewer.DataBind();
        this.SalesContactViewer.LocalReport.Refresh();

    }

    protected void ExportGoods_Click(object sender, EventArgs e)
    {
        strAction = "exportGoodsTicket";
        this.SalesContactViewer.LocalReport.DataSources.Clear();
        DataTable dtGoodsTicket = (new SalesDataSet()).Tables["GoodsTicketDataTable"];
        dtGoodsTicket.Rows.Add(dtGoodsTicket.NewRow());
        dtGoodsTicket.Rows[0][0] = "单据号：";
        dtGoodsTicket.Rows[0][1] = this.ContactBH.Text;
        dtGoodsTicket.Rows[0][2] = "部门：";
        dtGoodsTicket.Rows[0][3] = "口腔技术分厂";
        dtGoodsTicket.Rows[0][4] = "打印日期：";
        dtGoodsTicket.Rows[0][5] = DateTime.Now.ToString("yyyy/MM/dd");

        dtGoodsTicket.Rows.Add(dtGoodsTicket.NewRow());
        dtGoodsTicket.Rows[1][0] = "客户名称：";
        dtGoodsTicket.Rows[1][1] = "吉星";

        dtGoodsTicket.Rows.Add(dtGoodsTicket.NewRow());
        dtGoodsTicket.Rows[2][0] = "收货地址：";
        dtGoodsTicket.Rows[2][1] = "淄博高新区北辛路99号";

        this.ReportViewerExcel.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dtGoodsTicket));
        this.ReportViewerExcel.DataBind();
        this.ReportViewerExcel.LocalReport.Refresh();
    }
}