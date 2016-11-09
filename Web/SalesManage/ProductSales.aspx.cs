using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SalesManage_ProductSales : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request["actiontype"] == "SaveSales")
        {
            int identityID = 0;
            try
            {
                ModelSale modelSale = new ModelSale();

                DateTime? TimeNull = null;
                modelSale.SaleDate = String.IsNullOrEmpty(Request["SaleDate"]) ? TimeNull : DateTime.Parse(Request["SaleDate"].ToString());
                modelSale.Seller = Request["Seller"];
                modelSale.Salesperson = Request["Salesperson"];
                modelSale.BillDate = String.IsNullOrEmpty(Request["BillDate"]) ? TimeNull : DateTime.Parse(Request["BillDate"].ToString()); ;
                modelSale.BillNo = Request["BillNo"];
                modelSale.BillClass = Request["BillClass"];
                modelSale.Reg = "User1";
                modelSale.RegTime = DateTime.Now;
                identityID = servComm.Add(modelSale);
                Response.Write(identityID);
                Response.End();
            }
            catch (Exception ex)
            {
                Response.Write(identityID);
                Response.End();
            }          
           
        }
       
        //if (modelSale.ExecuteSqlDatatable("select ClassID from Dict where ClassID = '" + ClassID + "'").Rows.Count > 0)
        //{
        //    servComm.Update(modelDict);
        //}
        //else
        //{
            
        //}
    }
}