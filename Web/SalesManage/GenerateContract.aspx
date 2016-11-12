<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/MasterPage.master" CodeFile="GenerateContract.aspx.cs" Inherits="SalesManage_GenerateContract" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        input {
            border-top-style:none;
            border-left-style:none;
            border-right-style:none;
            border-bottom-style:solid;
            border-width:1px;
            width:70%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="box" style="margin:10px auto; " >
      <table style="width:90%;margin:10px auto; ">
          <tr>
              <td colspan="4" style="text-align:center; font-size:20px; border-width:1px; border-bottom-style:solid;">买卖合同</td>
          </tr>
           <tr style="height:30px; vertical-align:bottom;">
              <td>卖方：</td>
              <td><input type="text" /></td>
              <td>合同编号：</td>
              <td><input type="text" /></td>
          </tr>
           <tr style="height:30px; vertical-align:bottom;">
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>签订地点：</td>
              <td><input type="text" /></td>
          </tr>
           <tr style="height:30px; vertical-align:bottom;">
              <td>买方：</td>
              <td><input type="text" /></td>
              <td>签订时间：</td>
              <td><input type="text" /></td>
          </tr>
      </table>
      <!--divWidth  end-->
      <div class="clear" >
           <rsweb:ReportViewer ID="FinanceReportViewer" runat="server" Font-Names="Verdana" Font-Size="8pt" CssClass="reportView"  Height="75%"  WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                <LocalReport ReportPath="SalesManage\Rdlc\DailyReport.rdlc"></LocalReport>
    </rsweb:ReportViewer>
          <asp:ScriptManager ID="ScriptManager1"  runat="server"></asp:ScriptManager> 
        </div>
    </div>
   
</asp:Content>
