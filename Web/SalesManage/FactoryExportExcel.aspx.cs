using D2012.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SalesManage_FactoryExportExcel : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void btnFile_Click(object sender, EventArgs e)
    {
        try
        {
            string shortName = LoginUser.UserName == null ? "" : LoginUser.UserName + DateTime.Now.ToString("yyyyMMddHHmmsshhh") + ".xlsx";
            string fileName = Request.PhysicalApplicationPath + "UploadFile\\" + shortName;
            fileExport.SaveAs(fileName);


            ExcelToDataTable(fileName, null);
        }
        catch (Exception ex)
        {
            UploadResult.Text = "数据上传失败，请检查附件中的数据。";
        }
    }

    public DataTable ExcelToDataTable(string pathName, string sheetName)
    {
        
        DataTable tbContainer = new DataTable();
        string strConn = string.Empty;
        if (string.IsNullOrEmpty(sheetName)) { sheetName = "Sheet1"; }
        FileInfo file = new FileInfo(pathName);
        if (!file.Exists)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "sucess", "layer.msg('文件不存在');", true);
            return null;
        }
        string extension = file.Extension;
        switch (extension)
        {
            case ".xls":
                strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathName + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1;'";
                break;
            case ".xlsx":
                strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + pathName + ";Extended Properties='Excel 12.0;HDR=Yes;IMEX=1;'";
                break;
            default:
                strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathName + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1;'";
                break;
        }
        //链接Excel
        OleDbConnection cnnxls = new OleDbConnection(strConn);
        //读取Excel里面有 表Sheet1
        OleDbDataAdapter oda = new OleDbDataAdapter(string.Format(" select [防伪卡号] from (select [防伪卡号],Max([加工厂编码]) as [Max加工厂编码] ,Min([加工厂编码]) as [Min加工厂编码] , Max([订单号]) as [Max订单号],Min([订单号]) as [Min订单号] from [{0}$] group by [防伪卡号]) t where [Max加工厂编码] <> [Min加工厂编码] or [Max订单号] <> [Min订单号] ", sheetName), cnnxls);
        DataSet ds = new DataSet();
        //将Excel里面有表内容装载到内存表中！
        oda.Fill(tbContainer);

        if (tbContainer.Rows.Count > 0)
        {
           
            UploadResult.Text = "防伪卡号关联订单有错误，防伪卡号与订单号需要一一对应,请检查上传文件";
            return null;
        }
        else
        {
            SqlTransaction uploadTran = null;
            try
            {
                DataTable dtOrders = new DataTable();
                oda = new OleDbDataAdapter(string.Format("select distinct [防伪卡号],[加工厂编码],[订单号],[医疗机构],[医生],[患者],[患者年龄],[患者性别],[出货日期],Now() as [RegTime]  from [{0}$] where {1} ", sheetName, " [防伪卡号] <>'' and [加工厂编码] <> '' and [订单号] <>'' and Len([防伪卡号]) = 8 "), cnnxls);
                oda.Fill(dtOrders);

                if (dtOrders.Rows.Count == 0)
                {
                    file.Delete();
                    UploadResult.Text = "没有任何数据被上传，如果“防伪卡号,工厂编码，订单号”,为空或者防伪卡号位数不足8位将视为无效记录。";
                    return null;
                }

                DataTable dtOrdersDetail = new DataTable();
                oda = new OleDbDataAdapter(string.Format("select [防伪卡号],[加工厂编码],null as [subNo],[产品名称],[产品数量],[上右位],[上左位],[下右位],[下左位],[颜色],[材料批号],[加工厂保修期] from [{0}$] where {1}", sheetName, "  [防伪卡号] <>'' and [加工厂编码] <> '' and [订单号] <>'' and Len([防伪卡号]) = 8 "), cnnxls);
                oda.Fill(dtOrdersDetail);

                string con = ConfigurationManager.AppSettings["ConnectString"];
                SqlConnection sqlConn = new SqlConnection(con);
                sqlConn.Open();
                //创建一个事务 
                uploadTran = sqlConn.BeginTransaction();
                string cardNos = "''";
                foreach (DataRow dr in dtOrders.Rows)
                {
                    cardNos = cardNos + ",'" + dr["防伪卡号"] + "'";
                }
                cardNos = "(" + cardNos.Trim(',') + ")";
                SqlCommand sqlCom = new SqlCommand("delete from orders where CardNo in " + cardNos + ";delete from ordersdetail where CardNo in " + cardNos, sqlConn, uploadTran);
                sqlCom.ExecuteNonQuery();
                SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConn, SqlBulkCopyOptions.Default, uploadTran);


                bulkCopy.BulkCopyTimeout = 0;
                bulkCopy.DestinationTableName = "orders";
                bulkCopy.BatchSize = dtOrders.Rows.Count;
                if (dtOrders != null && dtOrders.Rows.Count != 0)
                    bulkCopy.WriteToServer(dtOrders);

                bulkCopy.BulkCopyTimeout = 0;
                bulkCopy.DestinationTableName = "ordersDetail";
                bulkCopy.BatchSize = dtOrdersDetail.Rows.Count;
                if (dtOrdersDetail != null && dtOrdersDetail.Rows.Count != 0)
                    bulkCopy.WriteToServer(dtOrdersDetail);
                uploadTran.Commit();
                Page.ClientScript.RegisterStartupScript(GetType(), "sucess", "layer.msg('上传完成')", true);
                UploadResult.Text = "数据已上传完成。\r\n共上传" + bulkCopy.BatchSize + "条数据。";
            }
            catch (Exception ex)
            {
               
                if (uploadTran != null)
                {
                    uploadTran.Rollback();
                }


                if (ex.Message.IndexOf("标准表达式中数据类型不匹配") > -1)
                {
                    UploadResult.Text = "数据上传出现错误\r\n错误信息：标准表达式中数据类型不匹配,请确认是否使用标准模板进行上传。\r\n如果无法解决,请联系管理员。";
                }
                else if (ex.Message.IndexOf("来自数据源的 String 类型的给定值不能转换为指定目标列的类型") > -1)
                {
                    UploadResult.Text = "数据上传出现错误\r\n错误信息：上传数据的类型不匹配或者是数据长度过长,请再次确认上传数据是否合理。\r\n如果无法解决,请联系管理员。";
                }
                else
                {
                    UploadResult.Text = "数据上传出现错误\r\n错误信息：" + ex.Message + "\r\n如果无法解决,请联系管理员。";
                }
                // Page.ClientScript.RegisterStartupScript(GetType(), "sucess", "layer.msg('"+ ex.Message+ "')", true);
                return null;
            }
            finally
            {
                if (file.Exists)
                {
                    file.Delete();
                }
            }
        }

        return tbContainer;
    }

}