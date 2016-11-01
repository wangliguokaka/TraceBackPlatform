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
                string ClassID = Request["ClassID"];
                string ClassName = Request["ClassName"];
                string Sortno = Request["Sortno"];

                ModelDict modelDict = new ModelDict();
                modelDict.ClassID = ClassID;
                modelDict.ClassName = ClassName;
                modelDict.Sortno = int.Parse(Sortno);
                modelDict.UpdateTime = DateTime.Now;
                modelDict.UpdateUser = "User1";
                
                servComm.Add(modelDict);

                List<ModelDict> listObj = servComm.GetListTop<ModelDict>(0,"*","Dict", null).ToList<ModelDict>();
                var timeConvert = new IsoDateTimeConverter();
                timeConvert.DateTimeFormat = "yyyy-MM-dd";

                Response.Write(JsonConvert.SerializeObject(modelDict, Formatting.Indented, timeConvert));
                Response.End();
            }
        }
    }
}