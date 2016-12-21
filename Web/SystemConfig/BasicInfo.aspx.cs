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

public partial class SystemConfig_BasicInfo : PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccWhere = new ConditionComponent();
    protected string EditJson = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ModelBase modelSale = servComm.GetEntity<ModelBase>("1");
            var timeConvert = new IsoDateTimeConverter();
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string modelJson = JsonConvert.SerializeObject(modelSale, Formatting.Indented, timeConvert);

            EditJson = modelJson.Replace("\r\n", "");
        }
        string actiontype = Request["actiontype"];
        if (actiontype == "GetProductList")
        {
            servComm.strOrderString = "itemname collate Chinese_PRC_CS_AS_KS_WS";
           // ccWhere.AddComponent("Serial", LoginUser.Serial, SearchComponent.Equals, SearchPad.NULL);
            DataTable dtProduct = servComm.GetListTop(0, "products", ccWhere);
            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(dtProduct, Formatting.Indented, timeConvert);
            Response.Write("[{\"RowCount\":" + servComm.RowCount + ",\"JsonData\":" + responseJson + "}]");
            Response.End();

        }
        else if (actiontype == "SaveBase")
        {
            int identityID = 1;
            try
            {
                ModelBase modelBase = new ModelBase();

                modelBase.ID = 1;
                modelBase.corp = Request["corp"].ToString();
                modelBase.Ecorp = Request["Ecorp"].ToString();
                modelBase.Address = Request["Address"];
                modelBase.Email = Request["Email"];
                modelBase.fax = Request["fax"];
                modelBase.LinkMan = Request["LinkMan"];
                modelBase.netname = Request["netname"];
                modelBase.phone = Request["phone"];
                modelBase.ServerIP = Request["ServerIP"];
                modelBase.ProductID = Request["ProductID"];
                modelBase.RoleA = Request["RoleA"].Trim(':');
                modelBase.RoleB = Request["RoleB"].Trim(':');
                modelBase.RoleC = Request["RoleC"].Trim(':');
                modelBase.RoleD = Request["RoleD"].Trim(':');
                servComm.Delete<ModelBase>("1", true);

                servComm.Add(modelBase);
            }
            catch (Exception ex)
            {
                Response.Write(0);
                Response.End();
            }

            Response.Write(identityID);
            Response.End();
        }
        else if (actiontype == "DeleteHisData")
        {
            try
            {
                string factoryEndDate = Request["factoryEndDate"];
                string salesEndDate = Request["salesEndDate"];
                servComm.ExecuteSql("exec SP_DeleteHistory '" + factoryEndDate + "','" + salesEndDate + "'");
            }
            catch (Exception ex)
            {
                Response.Write(0);
                Response.End();
            }

            Response.Write("1");
            Response.End();
        }
    }
}