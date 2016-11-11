using D2012.Common.DbCommon;
using D2012.DBUtility.Data.Core.SQLCore;
using D2012.Domain.Dal;
using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DBTableManagement : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    ClientDal dal = new ClientDal();
    protected void Page_Load(object sender, EventArgs e)
    {
        ModelSpec modelSpec = new ModelSpec();
        modelSpec.Class = "A";
        modelSpec.Color = "Black";
        modelSpec.exterior = "exterior";
        modelSpec.Size = "Size";
        modelSpec.OrderNo = "OrderNo";
        modelSpec.Remark = "Remark";
        servComm.Add(modelSpec);

          #region  页面加载
        if (!IsPostBack)
            {
                DataSet ds = dal.SelectAll();
                this.UserSelectGridView.DataSource = ds;
                UserSelectGridView.DataBind();
            }
        }
        #endregion  页面加载

        #region   查询按钮
        protected void SelectButton_Click(object sender, EventArgs e)
        {
            string client = this.SelectName.Text;

            DataSet ds = dal.SelectByClient(client);
            this.UserSelectGridView.DataSource = ds;
            UserSelectGridView.DataBind();
        }
        #endregion   查询按钮

        #region   新增按钮
        protected void AddButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddPage/AddClient.aspx");
        }
        #endregion   查询按钮

        #region      更新数据
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            //获得当前更新按钮点击的行序列
            int index = ((sender as Button).NamingContainer as GridViewRow).RowIndex;
            //通过隐藏域获取当前查到的id
            HiddenField hiddenClientid = this.UserSelectGridView.Rows[index].FindControl("selectclientid") as HiddenField;
            dal.UpdateClient(hiddenClientid.Value);
            Response.Redirect("UpdatePage/UpdateClient.aspx?selectclientid=" + hiddenClientid.Value);
        }
        #endregion   更新数据

        #region  删除数据
        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            LinkButton btn = sender as LinkButton;
            //获得当前删除按钮点击的行序列
            int index = ((sender as LinkButton).NamingContainer as GridViewRow).RowIndex;
            //通过隐藏域获取当前查到的id
            HiddenField hiddenClientid = this.UserSelectGridView.Rows[index].FindControl("selectclientid") as HiddenField;
            dal.DeleteClient(hiddenClientid.Value);

            Response.Redirect("DBTableManagement.aspx");
            
        }
        #endregion   删除数据
}