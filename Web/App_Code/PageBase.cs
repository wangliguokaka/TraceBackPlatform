using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Text.RegularExpressions;

using D2012.Domain.Entities;
using D2012.Common;
using D2012.Domain.Services;
using D2012.Common.DbCommon;
using System.Globalization;
using System.Threading;
using System.Text;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Security.Cryptography;

/// <summary>
///AdminPageBase 的摘要说明



/// </summary>
public class PageBase : System.Web.UI.Page
{
    protected string SaveFilePath
    {
        get 
        {
            return "/uploadedFiles/" + LoginUser.BelongFactory + "/" + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString()+"/";
        }
    }


    //获取微信凭证access_token的接口
    public static string getAccessTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={0}&secret={1}";
    #region 获取微信凭证
    public string GetAccessToken(string appid,string APPSECRET)
    {
        string accessToken = "";
        //获取配置信息Datatable



        string respText = "";
        //获取appid和appsercret

        //获取josn数据
        string url = string.Format(getAccessTokenUrl, appid, APPSECRET);

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();

        using (Stream resStream = response.GetResponseStream())
        {
            StreamReader reader = new StreamReader(resStream, Encoding.Default);
            respText = reader.ReadToEnd();
            resStream.Close();
        }
        JavaScriptSerializer Jss = new JavaScriptSerializer();
        Dictionary<string, object> respDic = (Dictionary<string, object>)Jss.DeserializeObject(respText);
        //通过键access_token获取值
        try
        {
            accessToken = respDic["access_token"].ToString();
        }
        catch (Exception ex)
        {
        }


        return accessToken;
    }

    #endregion 获取微信凭证

   

    public int CurrentUserID
    {
       
        get {
            return int.Parse(HttpContext.Current.Session["USERID"].ToString());
        }
    }

    public bool IsCN
    {
        get
        {
            return Session["Language"] == "zh-cn";
        }
    }

    private CultureInfo cultureInfo = null;

    public CultureInfo GetCurrentCulture
    {
        get
        {
            
            if (cultureInfo == null)
            {
                if (Request["languageType"] == "1")
                {
                    Session["Language"] = "en";

                }
                else if (Request["languageType"] == "0")
                {
                    Session["Language"] = "zh-cn";
                }
                else if (Session["Language"] == null && Request["Language"] == null)
                {
                    Session["Language"] = "zh-cn";
                }
                else if (Request["Language"]!= null && Request["Language"].ToString() == "zhcn")
                {
                    Session["Language"] = "zh-cn";
                   
                }
                else if (Request["Language"] != null && Request["Language"].ToString() == "en")
                {
                    Session["Language"] = "en";
                }

                return new CultureInfo(Session["Language"] == null ? "zh-cn" : Session["Language"].ToString());
            }
            return cultureInfo;
        }
    }

    protected override void InitializeCulture()
    {
        Thread.CurrentThread.CurrentUICulture = GetCurrentCulture;
    }

    public WUSERS LoginUser
    {
        get {
            return (WUSERS)(Session["objUser"]);
        }
    }

    public string IDRule
    {
        get{
            return Session["IDRule"].ToString();
        }
    }
    /// <summary>
    /// doAjax
    /// </summary>
    protected virtual void doAjax()
    {
        Response.End();
    }

    //protected override void Render(HtmlTextWriter writer)
    //{
    //    if (Request.Params["_xml"] == null)
    //    {
    //        base.Render(writer);
    //    }
        
    //}

    protected static string FormatName()
    {
        int RanNum = 0;
        string TempStr = "";
        Random Rnd = new Random();
        RanNum = Rnd.Next(100000, 900000);
        //TempStr = Year(now) & Month(now) & Day(now) & RanNum & "." & FileExt 
        TempStr = DateTime.Now.ToString("MMddHHmm") + RanNum;
        return TempStr;
    }
    protected string factoryConnectionString
    {
        get{
            return Session["factoryConnectionString"].ToString();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (Request.RawUrl.Contains("Weixinclient"))
        {
            Session["FromWeixin"] = "1";
        }
        if (Session["UserName"] == null && !Request.RawUrl.Contains("WXLogin.aspx") && Request.RawUrl.Contains("GeestarWeixinclient"))
        {
            Response.Write("<script>top.location='/Weixinclient/WXLogin.aspx'</script>");
            Response.End();
        }
        else if (Session["UserName"] == null && !Request.RawUrl.Contains("WXLogin.aspx") && Request.RawUrl.Contains("Weixinclient"))
        {           
            Response.Write("<script>top.location='/Weixinclient/WXLogin.aspx'</script>");
            Response.End();           
        }

        if (Session["UserName"] == null && !Request.RawUrl.Contains("login.aspx") && Session["FromWeixin"] == null && !Request.RawUrl.Contains("Weixinclient"))
        {
            //HttpContext.Current.Response.Redirect("/login.aspx");
            Response.Write("<script>top.location='/login.aspx'</script>");
            Response.End();
        }
        else
        {
           
        }
    }

    protected string UserName {
        get {
            return Session["USERNAME"].ToString();
        }
    }

    protected string TrimWithNull(object strValue)
    {
        if(strValue == null)
        {
            return "";
        }
        else{
            return strValue.ToString().Trim();
        }
    }

    protected Hashtable GetOrganization
    {
        get
        {
            return (Hashtable)(Session["Organization"]);
        }
    }

    protected void GetFilterByKind(ref ConditionComponent paraWhere,string inDataBase = "")
    {
        if (paraWhere != null)
        {
            string dataFilterByKind = inDataBase==""?" BelongFactory = '"+LoginUser.BelongFactory+"'":" 1=1 ";
            if (LoginUser.Kind == "B")
            {
                dataFilterByKind += " and sellerid =" + LoginUser.AssocNo;
            }
            else if (LoginUser.Kind == "C")
            {
                dataFilterByKind += " and HospitalID =" + LoginUser.AssocNo;
            }
            else if (LoginUser.Kind == "D" && inDataBase =="")
            {
                dataFilterByKind += " and DoctorID =" + LoginUser.AssocNo;
            }
            else if (LoginUser.Kind == "D" && inDataBase != "")
            {
                dataFilterByKind += " and doctor = (select top 1 doctor from doctor where id = " + LoginUser.AssocNo + ")";
            }

            if (dataFilterByKind != "")
            {
                if (paraWhere.sbComponent.Length == 0)
                {
                    paraWhere.sbComponent.Append(dataFilterByKind);
                }
                else
                {
                    paraWhere.sbComponent.Append(" and " + dataFilterByKind);
                }
            }
           
        }
    }

    /// <summary>
    /// 绑定分类
    /// </summary>
    protected DataTable BindDictClass(ServiceCommon facComm,ConditionComponent ccWhere, string ClassID)
    {
        ccWhere.Clear();
        ccWhere.AddComponent("ClassID", ClassID, SearchComponent.Equals, SearchPad.NULL);
        return facComm.GetListTop(0, " Code,DictName ", "DictDetail", ccWhere);

    }

    /// </summary>
    /// <param name="strName">名称</param>
    /// <param name="strValue">值</param>
    public static void WriteCookie(string strName, string strValue)
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[strName];
        if (cookie == null)
        {
            cookie = new HttpCookie(strName);
            HttpContext.Current.Response.AppendCookie(cookie);
            cookie.Expires = DateTime.Now.AddDays(30);
            cookie.Value = strValue;
        }
        else
        {
            cookie.Expires = DateTime.Now.AddDays(30); 
            cookie.Value = strValue;
        }

        HttpContext.Current.Response.AppendCookie(cookie);
    }

    public static string GetCookie(string strName)
    {
        if (HttpContext.Current.Request.Cookies != null && HttpContext.Current.Request.Cookies[strName] != null)
            return HttpContext.Current.Request.Cookies[strName].Value.ToString();

        return "";
    }

    protected string ConvertShortDate(string paraDate)
    {
        if (paraDate.Trim() == "")
        {
            return "";
        }
       // return " CONVERT(varchar(8),cast('" + paraDate + "' as datetime),11)";
        return paraDate.Substring(2,8).Replace("-","/");
    }

    public static string GetRandom()
    {
        string num = "";
        Random raninit = new Random(DateTime.Now.Millisecond);
        for (int i = 0; i < 6; i++)
        {
            Random ran = new Random(raninit.Next(i, int.MaxValue));
            num = num + ran.Next(1, int.MaxValue).ToString().Substring(1, 1);
        }
        return num;
    }

    protected static string LimitStringLength(String str, int limitLength)
    {
        if (str.Length > limitLength)
        {
            return str.Substring(0, limitLength);
        }
        else
        {
            return str;
        }
    }
}
