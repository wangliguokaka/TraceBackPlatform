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

public partial class SystemConfig_BasicInfo : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (actiontype == "GetProductList")
        {
            servComm.strOrderString = "itemname collate Chinese_PRC_CS_AS_KS_WS";
            DataTable dtProduct = servComm.GetListTop(0, "products", null);
            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(dtProduct, Formatting.Indented, timeConvert);
            Response.Write("[{\"RowCount\":" + servComm.RowCount + ",\"JsonData\":" + responseJson + "}]");
            Response.End();

        }
        else if (actiontype == "SaveBase")
        {
            int identityID = 0;
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
                servComm.Delete<ModelBase>("1", true);

                identityID = servComm.Add(modelBase);
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