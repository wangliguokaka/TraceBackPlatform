using D2012.Common;
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

public partial class SystemConfig_DictManagement : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
        string type = Request["actiontype"];
        if (type != null)
        {
            if (type == "SaveMainClass")
            {
                if (Request["deleteKey"] != null)
                {
                    servComm.Delete<ModelDict>(Request["deleteKey"], true);
                }
                else
                {
                    string ClassID = Request["ClassID"];
                    string ClassName = Request["ClassName"];
                    string Sortno = Request["Sortno"];
                    if (!String.IsNullOrEmpty(ClassID))
                    {
                        ModelDict modelDict = new ModelDict();
                        modelDict.ClassID = ClassID;
                        modelDict.ClassName = ClassName;
                        modelDict.Sortno = int.Parse(Sortno);
                        modelDict.UpdateTime = DateTime.Now;
                        modelDict.UpdateUser = "User1";

                        servComm.AddOrUpdate(modelDict);
                    }
                }
                

                servComm.strOrderString = "Sortno";
                List<ModelDict> listObj = servComm.GetListTop<ModelDict>(0,"*","Dict", null).ToList<ModelDict>();
                var timeConvert = new IsoDateTimeConverter();
                timeConvert.DateTimeFormat = "yyyy-MM-dd";
                string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
                Response.Write(responseJson);
                Response.End();
            }
            else if (type == "SaveClass")
            {
                string jsonResult = Request["data"];
                List<ModelDict> listModel = Utility.ConvertJsonToEntity<ModelDict>(jsonResult.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries));
                Response.Write("");
                Response.End();
            }
        }
    }
}