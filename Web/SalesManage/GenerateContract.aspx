<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/MasterPage.master" CodeFile="GenerateContract.aspx.cs" Inherits="SalesManage_GenerateContract" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="box" >
      <div class="title" >查询条件</div>
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>
            <td class="pro_tableTd">公司类别</td>
            <td><select class="pro_select" ><option >经销商</option><option >加工厂</option><option >本厂</option></select></td>
            <td class="pro_tableTd">公司编码</td>
            <td><input type="text" class="pro_input" ></td>
            <td class="pro_tableTd">公司名称</td>
            <td><input type="text" class="pro_input" ></td>
          </tr>
          <tr>
            <td class="pro_tableTd">联系人</td>
            <td><input type="text" class="pro_input" ></td>
            <td class="pro_tableTd">手机</td>
            <td><input type="text" class="pro_input" ></td>
            <td class="pro_tableTd">电话</td>
            <td><input type="text" class="pro_input" ></td>
          </tr>
          <tr>
            <td class="pro_tableTd">国家</td>
            <td><select class="pro_select" ><option >国家</option></select></td>
            <td class="pro_tableTd">省</td>
            <td><select class="pro_select" ><option >省</option></select></td>
            <td class="pro_tableTd">市</td>
            <td><select class="pro_select" ><option >市</option></select></td>
          </tr>
          <tr>
            <td class="pro_tableTd">E_mail</td>
            <td><input type="text" class="pro_input" ></td>
            <td colspan="4"></td>
          </tr>
          <tr>
            <td class="pro_tableTd">详细地址</td>
            <td><input type="text" class="pro_input" ></td>
            <td colspan="4"></td>
          </tr>
          <tr>
            <td class="pro_tableTd">收货单位地址</td>
            <td colspan="5"><input type="text" class="pro_input" ></td>
          </tr>
          <tr>
            <td class="pro_tableTd">账号</td>
            <td><input type="text" class="pro_input" ></td>
            <td class="pro_tableTd">密码</td>
            <td><input type="text" class="pro_input" ></td>
            <td colspan="2"></td>
          </tr>
          <tr>
            <td colspan="6" style="text-align:right;">
              <button class="ui-button">保存</button>
            </td>
          </tr>
        </table>   
      </div>
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>
</asp:Content>
