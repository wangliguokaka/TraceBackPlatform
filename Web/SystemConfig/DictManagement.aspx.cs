using D2012.Common;
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

public partial class SystemConfig_DictManagement :PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccWhere = new ConditionComponent();
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
                if (Request["DelMainClass"] != null && Request["DelClassID"] != null)
                {
                    servComm.ExecuteSql(" delete from Dict where MainClass = '" + Request["DelMainClass"] + "' and ClassID = '" + Request["DelClassID"] + "'");
                    servComm.ExecuteSql(" delete from DictDetail where ClassID = '" + Request["DelClassID"] + "'");
                }
                else
                {
                    string MainClass = Request["MainClass"];
                    string ClassID = Request["ClassID"];
                    string ClassName = Request["ClassName"];
                    string Sortno = Request["Sortno"];
                    try
                    {
                        if (!String.IsNullOrEmpty(ClassID))
                        {
                            ModelDict modelDict = new ModelDict();
                            modelDict.MainClass = MainClass;
                            modelDict.ClassID = ClassID;
                            modelDict.ClassName = ClassName;
                            modelDict.Sortno = int.Parse(Sortno);
                            modelDict.UpdateTime = DateTime.Now;
                            modelDict.UpdateUser = LoginUser.UserName;
                            if (servComm.ExecuteSqlDatatable("select ClassID from Dict where MainClass = '" + MainClass + "' and ClassID = '" + ClassID + "'").Rows.Count > 0)
                            {
                                ccWhere.AddComponent("MainClass", MainClass, SearchComponent.Equals, SearchPad.NULL);
                                ccWhere.AddComponent("ClassID", ClassID, SearchComponent.Equals, SearchPad.And);
                                servComm.Update(modelDict, ccWhere);
                            }
                            else
                            {
                                servComm.Add(modelDict);
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("-1");
                        Response.End();
                    }
                   
                }
                servComm.strOrderString = "MainClass,Sortno";
                List<ModelDict> listObj = servComm.GetListTop<ModelDict>(0, "*", "Dict", null).ToList<ModelDict>();
                var timeConvert = new IsoDateTimeConverter();
                timeConvert.DateTimeFormat = "yyyy-MM-dd";
                string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
                Response.Write(responseJson);
                Response.End();


            }
            else if (type == "GetMainClass")
            {
                servComm.strOrderString = "Sortno";
                List<ModelDict> listObj = servComm.GetListTop<ModelDict>(0, "*", "Dict", null).ToList<ModelDict>();
                var timeConvert = new IsoDateTimeConverter();
                timeConvert.DateTimeFormat = "yyyy-MM-dd";
                string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
                Response.Write(responseJson);
                Response.End();
            }
            else if (type == "GetDetail")
            {
                servComm.strOrderString = "Sortno";
                ConditionComponent ccwhere = new ConditionComponent();
                ccwhere.AddComponent("ClassID", Request["selectMainClass"], SearchComponent.Equals, SearchPad.NULL);
                List<ModelDictDetail> listObj = servComm.GetListTop<ModelDictDetail>(0, "*", "DictDetail", ccwhere).ToList<ModelDictDetail>();
                var timeConvert = new IsoDateTimeConverter();
                timeConvert.DateTimeFormat = "yyyy-MM-dd";
                string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
                Response.Write(responseJson);
                Response.End();
            }
            else if (type == "SaveClass")
            {
                string jsonResult = Request["data"];
                List<ModelDictDetail> listModel = Utility.ConvertJsonToEntity<ModelDictDetail>(jsonResult.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries));
                string SelectClassID = Request["selectMainClass"];
                servComm.ExecuteSql(" delete from DictDetail where ClassID = '" + SelectClassID + "'");
                foreach (ModelDictDetail model in listModel)
                {
                    if (!String.IsNullOrEmpty(model.Code))
                    {
                        model.ClassID = SelectClassID;
                        model.OperTime = DateTime.Now;
                        model.oper = LoginUser.UserName;
                        servComm.Add(model);
                    }
                }

                DataCache.dict = servComm.GetListTop<ModelDictDetail>(0, null).ToList();
                Response.Write("DictDetail");
                Response.End();
            }
        }
    }
}