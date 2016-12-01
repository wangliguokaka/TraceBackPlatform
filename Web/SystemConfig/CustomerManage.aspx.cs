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

public partial class SystemConfig_CustomerManage : PageBase
{
    ServiceCommon servComm = new ServiceCommon();
    ConditionComponent ccwhere = new ConditionComponent();
    IList<ModelClient> listObj;
    protected void Page_Load(object sender, EventArgs e)
    {
        string actiontype = Request["actiontype"];
        if (actiontype == "GetCustomerManageList")
        {
            string Serial = Request["Serial"];
            if (!String.IsNullOrEmpty(Serial))
            {
                ccwhere.AddComponent("Serial", "%" + Serial + "%", SearchComponent.Like, SearchPad.And);
            }
            string Class = Request["Class"];
            if (!String.IsNullOrEmpty(Class))
            {
                ccwhere.AddComponent("Class", "%" + Class + "%", SearchComponent.Like, SearchPad.And);
            }

            string linkman = Request["linkman"];
            if (!String.IsNullOrEmpty(linkman))
            {
                ccwhere.AddComponent("linkman", "%" + linkman + "%", SearchComponent.Like, SearchPad.And);
            }

            int iPageCount = 0;
            int iPageIndex = int.Parse(Request["PageIndex"]) + 1;
            servComm.strOrderString = "Id";
            listObj = servComm.GetList<ModelClient>("Client", "*", "Id", 10, iPageIndex, iPageCount, ccwhere);
            var timeConvert = new IsoDateTimeConverter();
            //timeConvert.DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
            timeConvert.DateTimeFormat = "yyyy-MM-dd";
            string responseJson = JsonConvert.SerializeObject(listObj, Formatting.Indented, timeConvert);
            Response.Write("[{\"RowCount\":" + servComm.RowCount + ",\"JsonData\":" + responseJson + "}]");
            Response.End();

        }
        else if (actiontype == "ExportExcel")
        {
            string BillNo = Request["BillNo"];
            if (!String.IsNullOrEmpty(BillNo))
            {
                ccwhere.AddComponent("BillNo", "%" + BillNo + "%", SearchComponent.Like, SearchPad.And);
            }
            string Salesperson = Request["Salesperson"];
            if (!String.IsNullOrEmpty(Salesperson))
            {
                ccwhere.AddComponent("Salesperson", "%" + Salesperson + "%", SearchComponent.Like, SearchPad.And);
            }
            string IsDel = Request["IsDel"];
            if (!String.IsNullOrEmpty(IsDel))
            {
                ccwhere.AddComponent("IsDel", "1", SearchComponent.Equals, SearchPad.And);
            }
            else
            {
                ccwhere.AddComponent("Isnull(IsDel,0)", "1", SearchComponent.UnEquals, SearchPad.And);
            }

            servComm.strOrderString = "Id";
            listObj = servComm.GetListTop<ModelClient>(0, "[Id],[SaleDate],[seller],[Salesperson],[BillDate],[BillNo],[BillClass],[Reg],[RegTime]", "Sale", ccwhere);
            string shortName = DateTime.Now.ToString("yyyyMMddHHmmsshhh") + ".xlsx";
            string fileName = Request.PhysicalApplicationPath + "UploadFile\\" + shortName;
            using (NPOIHelper excelHelper = new NPOIHelper(fileName, Request.PhysicalApplicationPath + "UploadFile\\"))
            {
                DataTable dtTable = listObj.ToDataTable();
                dtTable.Columns.Remove("IsDel");
                int count = excelHelper.DataTableToExcel(dtTable, "订单信息", true);
            }
            Response.Write("http://" + Request.Url.Authority + "//UploadFile//" + shortName);
            Response.End();
        }
        else if (Request["actiontype"] == "SaveCustomer")
        {
            int identityID = 0;
            try
            {
                ModelClient modelClient = new ModelClient();
                if (String.IsNullOrEmpty(Request["Id"]))
                {
                    modelClient.Class = Request["Class"];
                    modelClient.Serial = Request["Serial"];
                    modelClient.Client = Request["Client"];
                    modelClient.linkman = Request["linkman"];
                    modelClient.Tel = Request["Tel"];
                    modelClient.Tel2 = Request["Tel2"];
                    modelClient.Country = Request["Country"];
                    modelClient.Province = Request["Province"];
                    modelClient.City = Request["City"];
                    modelClient.Email = Request["Email"];
                    modelClient.Addr = Request["Addr"];
                    modelClient.UserName = Request["UserName"];
                    string password = Request["Passwd"];
                    if (!String.IsNullOrEmpty(password))
                    {
                        password = CryptoHelper.StaticEncrypt(password, "pass");
                    }
                    modelClient.Passwd = password;
                    identityID = servComm.Add(modelClient);
                }
                else
                {
                   
                    if (String.IsNullOrEmpty(Request["Class"]))
                    {
                        identityID = servComm.ExecuteSql(" delete from Client where ID in (" + Request["Id"] + ");");
                        
                    }
                    else
                    {
                        identityID = int.Parse(Request["Id"]);
                        modelClient.Class = Request["Class"];
                        modelClient.Serial = Request["Serial"];
                        modelClient.Client = Request["Client"];
                        modelClient.linkman = Request["linkman"];
                        modelClient.Tel = Request["Tel"];
                        modelClient.Tel2 = Request["Tel2"];
                        modelClient.Country = Request["Country"];
                        modelClient.Province = Request["Province"];
                        modelClient.City = Request["City"];
                        modelClient.Email = Request["Email"];
                        modelClient.Addr = Request["Addr"];
                        modelClient.UserName = Request["UserName"];
                        string password = Request["Passwd"];
                        if (!String.IsNullOrEmpty(password))
                        {
                            password = CryptoHelper.StaticEncrypt(password);
                        }
                        modelClient.Passwd = password;
                        modelClient.ID = identityID;
                        int result = servComm.Update(modelClient);
                    }
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

    }
}