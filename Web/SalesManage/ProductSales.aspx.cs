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

public partial class SalesManage_ProductSales :PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccWhere = new ConditionComponent();
    protected List<ModelDictDetail> listDictType = new List<ModelDictDetail>();
    protected string EditJson;
    protected string OrderJson="[]";
    protected IList<ModelClient> listSeler = new List<ModelClient>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            servComm.strOrderString = "Client";
            ccWhere.Clear();
            ccWhere.AddComponent("Class", "A", SearchComponent.Equals, SearchPad.NULL);
            listSeler = servComm.GetListTop<ModelClient>(0, ccWhere);
            listDictType = DataCache.findAllDict().Where(model => model.ClassID == "BillType").ToList();
            listDictType.Insert(0, new ModelDictDetail() { });
            servComm.strOrderString = " OrderNo ";
            ccWhere.Clear();
            ccWhere.AddComponent("OrderNo", null, SearchComponent.ISNOT, SearchPad.NULL);
            ccWhere.AddComponent("Bh", null, SearchComponent.ISNOT, SearchPad.And);
            IList<ModelSpec> listSaleDetail = servComm.GetListTop<ModelSpec>(0, "OrderNo,Bh", "Spec", ccWhere);
            string SpecJson = JsonConvert.SerializeObject(listSaleDetail, Formatting.Indented, new IsoDateTimeConverter());

            OrderJson = SpecJson.Replace("\r\n", "");
        }

        string Id = Request["Id"];
        if (!String.IsNullOrEmpty(Id))
        {
            servComm.strOrderString = "Id";
            ModelSale modelSale = servComm.GetEntity<ModelSale>(Request["Id"]);
            var timeConvert = new IsoDateTimeConverter();
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string modelJson = JsonConvert.SerializeObject(modelSale, Formatting.Indented, timeConvert);
            ccWhere.Clear();
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
                modelSale.IsDel = "0";
                modelSale.Reg = LoginUser.UserName;
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

                servComm.ExecuteSql(" delete from SaleDetail where ID = '" + identityID + "';");
                int serialIndex = 0;
                foreach (ModelSaleDetail modelDetail in listModel)
                {
                    serialIndex = serialIndex + 1;
                    modelDetail.Serial = serialIndex;
                    servComm.Add(modelDetail);
                }

                if (String.IsNullOrEmpty(Request["Id"]))
                {
                    servComm.ExecuteSql("exec AutoDetectionNoCard " + identityID + "," + LoginUser.UserName);
                }
                else
                {
                    servComm.ExecuteSql("exec AutoDetectionNoCard " + identityID + "," + identityID);
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
        else if (Request["actionType"] == "GetMaxCardNo")
        {
            DataTable dtCardNo = servComm.ExecuteSqlDatatable("select max(NoEnd) as MaxNo from CardNoMaintenance");
            if (dtCardNo.Rows.Count == 0)
            {
                Response.Write("00000000");
                Response.End();
            }
            else
            {
                string maxNo = dtCardNo.Rows[0][0].ToString();
                maxNo =  (int.Parse(maxNo) + 1).ToString().PadLeft(8,'0');
                Response.Write(maxNo);
                Response.End();
            }
        }
        else if (Request["actionType"] == "DeleteCardNo")
        {
            string NoStart = Request["NoStart"];
            string NoEnd = Request["NoEnd"];
            if (!String.IsNullOrEmpty(NoStart) && !String.IsNullOrEmpty(NoEnd))
            {
                servComm.ExecuteSql("update CardNoMaintenance set IsSave = 2 where  NoEnd ='" + NoEnd + "' and NoStart = '" + NoStart + "'");
            }
        }
        else if (Request["actiontype"] == "ValidCardNo")
        {
            string NoStart = Request["NoStart"];
            string NoEnd = Request["NoEnd"];
            string Serial = Request["Serial"];
            ccWhere.Clear();
            string condition = "";
            if (Serial != null && Serial == "-1")
            {
                Serial = Request["DetailCount"];
            }
            else if (Serial != null && Serial != "-1" && !String.IsNullOrEmpty(Id))
            {
                condition = condition + " and (ID !='" + Id + "' or  ID ='" + Id + "' and Serial != " + Serial + ")";
                //ccWhere.AddComponent("Id", Id, SearchComponent.Equals, SearchPad.NULL);
                //ccWhere.AddComponent("Serial", Serial, SearchComponent.UnEquals, SearchPad.And);
            }    
            else
            {
                condition = condition + " and (ID !='" + LoginUser.UserName + "' or  ID ='" + LoginUser.UserName + "' and Serial != " + Serial + ")";
            }
            int count = servComm.ExecuteSqlDatatable("select Id from CardNoMaintenance where (NoStart<='" + NoStart + "' and NoEnd>='" + NoStart +
                "' or NoStart<='" + NoEnd + "' and NoEnd>='" + NoEnd +
                "' or NoStart>='" + NoStart + "' and NoEnd<='" + NoEnd + "')" + condition).Rows.Count;
            if (count == 0)
            {
                if (String.IsNullOrEmpty(Id))
                {
                    servComm.ExecuteSql("delete from CardNoMaintenance where  ID ='" + LoginUser.UserName + "' and Serial = " + Serial + ";  insert into CardNoMaintenance values('" + LoginUser.UserName + "','" + Serial + "','" + NoStart + "','" + NoEnd + "',GetDate(),0)");
                }
                else
                {
                    servComm.ExecuteSql("delete from CardNoMaintenance where  ID ='" + Id + "' and Serial = " + Serial + ";insert into CardNoMaintenance values('" + Id + "','" + Serial + "','" + NoStart + "','" + NoEnd + "',GetDate(),0)");
                }

                Response.Write(count);
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