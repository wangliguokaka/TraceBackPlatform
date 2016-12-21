<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master" CodeFile="FactoryExportExcel.aspx.cs" Inherits="SalesManage_FactoryExportExcel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function () {

           
        });

        function printDirent() {
            if (isIe()) {
                try {
                    document.all.WebBrowser.ExecWB(7, 1);
                }
                catch (Err) {
                    window.print();
                }
            }
            else {
                window.print();
            }
        }

        function isIe() {
            return ("ActiveXObject" in window);
        }

        function CheckFie()
        {
            if ($("#fileExport").val() == "")
            {
                layer.msg("请上传附件！")
                return false;
            }
        }
</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="box" >
      <div class="title" >模板下载</div>
        
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>
              <td rowspan="3" style="width:150px;"><a href="../Template/上传模板表.xlsx" title="点击下载模板"><img src="../Css/images/Excel.png" alt="点击下载" /></a></td>
              <td class="pro_tableTd">1.请点击左侧图标下载数据上传模板</td>
          </tr>
          <tr>             
              <td class="pro_tableTd">2.填写数据请注意数据的真实合理性,例如年龄,数量要求是数字类型,日期类型要符合日期格式</td>
          </tr>
          <tr>             
              <td class="pro_tableTd">3.防伪卡号,工厂编码，订单号不能为空,以上字段为空时将不会被上传至服务器</td>
          </tr>
        </table>   
      </div>
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>
    <div class="box" >
      <div class="title" >数据上传</div>
        
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr style="height:40px;">
            <td  class="pro_tableTd" style="width:420px;"><asp:FileUpload runat="server" Width="600px" Height="30px"   ClientIDMode="Static"   class="pro_input required" ID="fileExport" /></td>
              <td class="pro_tableTd"><asp:button runat="server"  class="ui-button" Text="上传" ID="btnFile" OnClientClick="return CheckFie()" OnClick="btnFile_Click" /></td>
          </tr>
        </table>   
      </div>
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>
    <div class="box" >
      <div class="title" >数据上传状态</div>
        <div class="divWidth" style="margin:15px;" >
            <asp:TextBox TextMode="MultiLine" Rows="10" Width="800" BorderStyle="None" ReadOnly="true" ID="UploadResult" runat="server"></asp:TextBox>
        </div>
      
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>
    <!--box  end-->
    
 
    <!--divWidth1  end-->
    
</asp:Content>

