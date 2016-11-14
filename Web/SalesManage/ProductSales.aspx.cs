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
using TraceBackPlatform.AppCode;

public partial class SalesManage_ProductSales :PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccWhere = new ConditionComponent();
    protected List<ModelDictDetail> listDictType = new List<ModelDictDetail>();
    protected string EditJson;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            listDictType = DataCache.findAllDict().Where(model => model.ClassID == "MaterialType").ToList();
        }

        string Id = Request["Id"];
        if (!String.IsNullOrEmpty(Id))
        {
            servComm.strOrderString = "Id";
            ModelSale modelSale = servComm.GetEntity<ModelSale>(Request["Id"]);
            var timeConvert = new IsoDateTimeConverter();
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string modelJson = JsonConvert.SerializeObject(modelSale, Formatting.Indented, timeConvert);

            ccWhere.AddComponent("Id",Id, SearchComponent.Equals, SearchPad.NULL);
            IList<ModelSaleDetail> listSaleDetail = servComm.GetListTop<ModelSaleDetail>(0,"*","SaleDetail", ccWhere);

            string listJson = JsonConvert.SerializeObject(listSaleDetail, Formatting.Indented, timeConvert);

            EditJson = modelJson.Replace("}", ",\"DetailJson\":") + listJson + "}";
            EditJson = EditJson.Replace("\r\n", "");
            //"[{\"RowCount\":"+servComm.RowCount + ",\"JsonData\":"+ responseJson+"}]"
        }

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
                if (String.IsNullOrEmpty(Request["Id"]))
                {
                    identityID = servComm.Add(modelSale);
                }
                else
                {
                    identityID = int.Parse(Request["Id"]);
                    modelSale.Id = identityID;
                    int result = servComm.Update(modelSale);
                    
                }
                string jsonResult = Request["SalesDetail"];
                jsonResult = jsonResult.Replace("[", "").Replace("]", "").Replace("},{", "}|{").Replace("\"Id\":\"\"", "\"Id\":" + identityID.ToString());
                List<ModelSaleDetail> listModel = Utility.ConvertJsonToEntity<ModelSaleDetail>(jsonResult.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries));

                servComm.ExecuteSql(" delete from SaleDetail where ID = '" + identityID + "'");
                int serialIndex = 0;
                foreach (ModelSaleDetail modelDetail in listModel)
                {
                    serialIndex = serialIndex+1;
                    modelDetail.Serial = serialIndex;
                    servComm.Add(modelDetail);
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
       
        //if (modelSale.ExecuteSqlDatatable("select ClassID from Dict where ClassID = '" + ClassID + "'").Rows.Count > 0)
        //{
        //    servComm.Update(modelDict);
        //}
        //else
        //{
            
        //}
    }
}