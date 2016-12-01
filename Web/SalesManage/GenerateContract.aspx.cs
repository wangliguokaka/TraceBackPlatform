using D2012.Common;
using D2012.Common.DbCommon;
using D2012.Domain.Services;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;
using TraceBackPlatform.AppCode;

public partial class SalesManage_GenerateContract : PageBase
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
            try
            {
                foreach (Control cp in Page.Controls)
                {
                    foreach (Control ct in cp.Controls)
                    {
                        if (ct is HtmlForm)
                        {
                            foreach (Control con in ct.Controls)
                            {
                                foreach (Control ctr in con.Controls)
                                {
                                    if (ctr is TextBox)
                                    {
                                        if (ConfigurationManager.AppSettings.Get(ctr.ID) != null)
                                        {
                                            ((TextBox)ctr).Text = ConfigurationManager.AppSettings.Get(ctr.ID);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception excrt)
            {
            }           
           
        }
        else
        {
            strAction = "exportContact";
        }
    }



    protected void ExportContact_Click(object sender, EventArgs e)
    {
        this.SalesContactViewer.LocalReport.DataSources.Clear();
        DataTable dtContact = (new SalesDataSet()).Tables["ContactDataTable"];
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
        for (int i = 0; i < OrderDetail.Rows.Count; i++)
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
        dtSetail.Rows.Add(dtSetail.NewRow());
        dtSetail.Rows[OrderDetail.Rows.Count]["ProductName"] = "合计";
        dtSetail.Rows.Add(dtSetail.NewRow());
        dtSetail.Rows[OrderDetail.Rows.Count+1]["ProductName"] = "合计大写：";
        


        this.SalesContactViewer.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dtContact));
        this.SalesContactViewer.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dtSetail));

        this.SalesContactViewer.DataBind();
        this.SalesContactViewer.LocalReport.Refresh();

        Warning[] warnings;
        string[] streamids;
        string mimeType;
        string encoding;
        string extension;
        string filename;

        byte[] bytes = SalesContactViewer.LocalReport.Render(
           "WORDOPENXML", null, out mimeType, out encoding,
            out extension,
           out streamids, out warnings);

        filename = string.Format("{0}.{1}", this.ContactBH.Text, "docx");
        Response.ClearHeaders();
        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment;filename=" + filename);
        Response.ContentType = mimeType;
        Response.BinaryWrite(bytes);
        Response.Flush();
        Response.End();


    }

    protected void ExportGoods_Click(object sender, EventArgs e)
    {
       
        strAction = "exportGoodsTicket";
        this.ReportViewerExcel.LocalReport.DataSources.Clear();
        DataTable dtGoodsTicket = (new SalesDataSet()).Tables["GoodsTicketDataTable"];
        for (int i = 0; i < OrderDetail.Rows.Count; i++)
        {
            dtGoodsTicket.Rows.Add(dtGoodsTicket.NewRow());
            dtGoodsTicket.Rows[i][0] = (i+1).ToString();
            dtGoodsTicket.Rows[i][1] = OrderDetail.Rows[i]["ProductName"]; 
            dtGoodsTicket.Rows[i][2] = OrderDetail.Rows[i]["Spec"];            
            dtGoodsTicket.Rows[i][4] = OrderDetail.Rows[i]["Qty"];
        }
            

        DataTable oneRowData = (new SalesDataSet()).Tables["OnerowDataTable"];
        oneRowData.Rows.Add(oneRowData.NewRow());
        this.ReportViewerExcel.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dtGoodsTicket));
        this.ReportViewerExcel.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", oneRowData));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("ContactNo", this.ContactBH.Text));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("Department", "口腔技术分厂"));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("PrintDate", DateTime.Now.ToString("yyyy/MM/dd")));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("Customer", "吉星"));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("RecieveAddr", "淄博高新区北辛路99号"));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("Receiver", "张总"));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("Telephone", "18669803591"));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("Operator", "颉宏勇"));
        this.ReportViewerExcel.LocalReport.SetParameters(new ReportParameter("Maker", "颉宏勇"));
        this.ReportViewerExcel.DataBind();
        this.ReportViewerExcel.LocalReport.Refresh();

        //XmlDocument sourceDoc = new XmlDocument();
        //sourceDoc.Load(Request.PhysicalApplicationPath + this.ReportViewerExcel.LocalReport.ReportPath);
      

        //string path = Request.PhysicalApplicationPath + "UploadFile\\" + DateTime.Now.ToString("MM月dd号")+"发货.rdlc";
        //sourceDoc.Save(path);

        //ReportViewerExcel.LocalReport.ReportPath = path;
        //this.ReportViewerExcel.LocalReport.Refresh();

        

        Warning[] warnings;
        string[] streamids;
        string mimeType;
        string encoding;
        string extension;
        string filename;


        //EXCELOPENXML
        byte[] bytes = ReportViewerExcel.LocalReport.Render(
           "EXCEL", null, out mimeType, out encoding,
            out extension,
           out streamids, out warnings);
        //File.Delete(path);
        filename = string.Format("{0}.{1}", this.ContactBH.Text, "xls");
        Response.ClearHeaders();
        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment;filename=" + filename);
        Response.ContentType = mimeType;
        Response.BinaryWrite(bytes);
        Response.Flush();
        Response.End();
    }


}