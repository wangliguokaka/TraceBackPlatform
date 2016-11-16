<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/MasterPage.master" CodeFile="GenerateContract.aspx.cs" Inherits="SalesManage_GenerateContract" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
         input ,.ContactInput {
            border-top-style:none;
            border-left-style:none;
            border-right-style:none;
            border-bottom-style:solid;
            border-width:1px;
            width:90%;
            height:25px;
            vertical-align:middle;
        }

        td .Split {
            border-right-style:solid;
            border-right-width:1px;
        }

        tr 
        {
            height:26px;
        }
    </style>
    <style media="print" type="text/css">
        .Noprint{display:none;}

　　      .PageNext{page-break-after: always;}

    </style>
    <script type="text/javascript">
        $(function () {
        
            if ('<%=strAction%>' == "exportContact")
            {
                //var j;
                //j=  setInterval(function clicks() {
                //    try {
                //        console.log(1)
                //        $(".reportView a[title='Word']").click();
                //        clearInterval(j);
                //    }
                //    catch (Err) {
                //        //console.log(-1)
                //    }
                //}, 2000);
            }
            else if ('<%=strAction%>' == "exportGoodsTicket")
            {
                //var k;
                //k = setInterval(function clicks() {
                //    try {
                //        console.log(1)
                //        $(".reportExcelView a[title='Excel']").click();
                //        clearInterval(k);
                //    }
                //    catch (Err) {
                //        //console.log(-1)
                //    }
                //}, 2000);
            }
            else
            {
                var nowDate = new Date().Format("yyyy-MM-dd");
                $(".detepickers").val(nowDate)
            }
            
            if ('<%=Request["SignDatetime"]%>' != '')
            {
                $(".detepickers").val('<%=Request["SignDatetime"]%>' )
            }

            
        })

        function printDirent()
        {
            if (isIe())
            {
                try{
                    document.all.WebBrowser.ExecWB(7, 1);
                }               
                catch(Err)
                {
                    window.print();
                }
            }
            else
            { 
                window.print();
            }
        }
        function isIe() {
            return ("ActiveXObject" in window);
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="box" style="margin:10px auto; border:none; " >
        <div style="margin-left:80px;" class="Noprint">
            <asp:Button ID="ExportContact" runat="server"  Width="80" CssClass="ui-button" Text="导出" OnClick="ExportContact_Click" />
             <asp:Button ID="ExportGoods" runat="server"  Width="120" CssClass="ui-button" Text="导出发货单" OnClick="ExportGoods_Click"  />
            <button type="button" class="ui-button" onclick="printDirent()">打印</button>
           <object id="WebBrowser" width="0" height="0"  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>
        </div>
        
      <table style="width:90%;margin:10px auto; ">
         
          <tr>
              <td colspan="4" style="text-align:center; font-size:20px; border-width:1px; border-bottom-style:solid;">买卖合同
              </td>
          </tr>
           <tr>
              <td>卖方：</td>
              <td><asp:TextBox ID="Seller" CssClass="ContactInput"  Text="山东新华医疗器械股份有限公司" runat="server"></asp:TextBox></td>
              <td>合同编号：</td>
              <td><asp:TextBox ID="ContactBH" CssClass="ContactInput" Text="KQ"  runat="server"></asp:TextBox></td>
          </tr>
           <tr >
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>签订地点：</td>
              <td><asp:TextBox ID="SignAddr" CssClass="ContactInput" Text="山东淄博"  runat="server"></asp:TextBox></td>
          </tr>
           <tr >
              <td>买方：</td>
              <td><asp:TextBox ID="Buyer" CssClass="ContactInput"   runat="server"></asp:TextBox></td>
              <td>签订时间：</td>
              <td><input type="text" id="SignDatetime" name="SignDatetime" class="ContactInput detepickers" readonly="readonly" /></td>
          </tr>
          <tr style="height:30px; vertical-align:bottom;">
              <td colspan="4">第一条：标的、数量、金额</td>
          </tr>
          <tr>
              <td colspan="4" style="width:100%;">
                  <table border ="1" style="width:100%;">
                      <tr><td>标的名称</td><td>规格型号</td><td>订货号</td><td>单位</td><td>数量</td><td>单价</td><td>金额（元）</td> </tr>
                        <%foreach (System.Data.DataRow row in OrderDetail.Rows)
                          { %>
                      <tr style="height:30px; vertical-align:bottom;">
                          <td><%=row["ProductName"] %></td>
                          <td><%=row["Spec"] %></td>
                          <td><%=row["OrderNo"] %></td>
                          <td>&nbsp;</td>
                          <td><%=row["Qty"] %></td>
                          <td></td>
                          <td></td>
                      </tr>
                      <%} %>
                      <tr style="height:30px; vertical-align:bottom;">
                          <td>合计：</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                       <tr style="height:30px; vertical-align:bottom;">
                          <td>合计大写：</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                  </table>
              </td>
          </tr>
          <tr>
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:150px;">第二条：质量标准：</td>
                          <td><asp:TextBox ID="Quantity" CssClass="ContactInput"  runat="server" Text="企标"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr>
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:300px;">第三条：交（提）货方式、地点：</td>
                          <td><asp:TextBox ID="ProvideGoods" CssClass="ContactInput"  runat="server" Text=""></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr>
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:380px;">第四条：运输方式及到达站（港）和费用负担：</td>
                          <td><asp:TextBox ID="FeeCharge" CssClass="ContactInput"  Text="卖方负担运费。" runat="server"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr>
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:300px;">第五条：检验标准、方法、地点及期限：</td>
                          <td><asp:TextBox ID="CheckStandard" CssClass="ContactInput"  runat="server"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr >
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:260px">第六条：结算方式、时间及地点：</td>
                          <td><asp:TextBox ID="Statements" CssClass="ContactInput"  runat="server"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr>
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:180px;">第七条：违约责任：</td>
                          <td><asp:TextBox ID="Contact" CssClass="ContactInput"  Text="《合同法》。" runat="server"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr>
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:230px;">第八条：合同争议的解决方式：</td>
                          <td><asp:TextBox ID="Solve" CssClass="ContactInput" Text="友好 协商。"  runat="server"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr >
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:200px;">第九条：本合同自</td>
                          <td><asp:TextBox ID="SignMethod" CssClass="ContactInput"  runat="server" Text="签章"></asp:TextBox></td>
                          <td style="width:100px;">起生效。</td>
                      </tr> 
                    </table>
                </td>                
          </tr>
            <tr >
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:200px;">第十条：其他约定事项：</td>
                          <td><asp:TextBox ID="AppointedItem" CssClass="ContactInput" Text="1、增值税票（√），普票（    ）。请将收货信息、开票信息、汇款信息回传至"  runat="server"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
           <tr >
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:200px;">&nbsp;</td>
                          <td><asp:TextBox ID="AppointedItem1" CssClass="ContactInput" Text="0533-3588673  。" Width="400"  runat="server"></asp:TextBox>发票类型不选视为开普票 。</td>
                      </tr> 
                    </table>
                </td>                
          </tr>
           <tr >
              <td colspan="4">
                  <table style="width:100%;">
                      <tr>
                          <td style="width:150px;">第十一条: 染色液:</td>
                          <td><asp:TextBox ID="Liquor" CssClass="ContactInput"  runat="server"></asp:TextBox></td>
                          <td style="width:60px;">,分类：</td>
                          <td><asp:TextBox ID="Classify" CssClass="ContactInput"  runat="server"></asp:TextBox></td>
                      </tr> 
                    </table>
                </td>                
          </tr>
          <tr>
              <td colspan="4">&nbsp;</td>
          </tr>
          <tr>
              <td colspan="4">
                  <table style="width:100%;border-style:solid;border-width:1px;">
                      <tr>
                          <td class="Split" colspan="2" style="width:50%;text-align:center;">卖    方</td>
                          
                          <td colspan="2" style="text-align:center;">买   方</td>
                      </tr>
                      <tr>
                          <td style="width:140px">卖方：</td><td class="Split" style="width:260px"><asp:TextBox ID="SellerBottom" CssClass="ContactInput" Text="山东新华医疗器械股份有限公司"  runat="server"></asp:TextBox></td>
                          <td style="width:140px">买方：</td><td style="width:260px"><asp:TextBox ID="BuyerBottom" CssClass="ContactInput" Text="山东新华医疗"  runat="server"></asp:TextBox></td>
                      </tr>
                       <tr>
                          <td >住所：</td><td class="Split"><asp:TextBox ID="SellerAddr" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                          <td>住所：</td><td><asp:TextBox ID="BuyerAddr" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                      </tr>
                      <tr>
                          <td >经办人：</td><td class="Split"><asp:TextBox ID="SellerOperator" CssClass="ContactInput" Text="颉宏勇"  runat="server"></asp:TextBox></td>
                          <td>经办人：</td><td><asp:TextBox ID="BuyerOperator" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                      </tr>
                      <tr>
                          <td >电话：</td><td class="Split"><asp:TextBox ID="SellerTel" CssClass="ContactInput"   Text="0533-3581573"  runat="server"></asp:TextBox></td>
                          <td>电话：</td><td><asp:TextBox ID="BuyerTel" CssClass="ContactInput"  Text=""  runat="server"></asp:TextBox></td>
                      </tr>
                      <tr>
                          <td >传真：</td><td class="Split"><asp:TextBox ID="SellerFax" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                          <td>传真：</td><td><asp:TextBox ID="BuyerFax" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                      </tr>
                     <%--  <tr>
                           <td colspan="4">
                               <table style="width:100%;">
                                   <tr>
                                        <td style="width:10%;">电话：</td>
                                       <td style="width:15%;"><asp:TextBox ID="SellerTel" CssClass="ContactInput"   Text="0533-3581573"  runat="server"></asp:TextBox></td>
                                       <td style="width:5%;">&nbsp;传真：</td>
                                       <td style="width:20%;" class="Split"><asp:TextBox ID="SellerFax" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                                       <td style="width:10%;">电话：</td>
                                       <td><asp:TextBox ID="BuyerTel" CssClass="ContactInput"  Text=""  runat="server"></asp:TextBox></td>
                                       <td style="width:10%;">&nbsp;传真：</td>
                                       <td><asp:TextBox ID="BuyerFax" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                                   </tr>
                                   
                               </table>
                           </td>
                      </tr>--%>
                       <tr>
                          <td >开户银行：</td><td class="Split"><asp:TextBox ID="SellerBank" CssClass="ContactInput" Text="中国银行淄博人民公园支行"  runat="server"></asp:TextBox></td>
                          <td>开户银行：</td><td><asp:TextBox ID="BuyerBank" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                      </tr>
                       <tr>
                          <td >账号：</td><td class="Split"><asp:TextBox ID="SellerAccount" CssClass="ContactInput" Text="244211260465"  runat="server"></asp:TextBox></td>
                          <td>账号：</td><td><asp:TextBox ID="BuyerAccount" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                      </tr>
                        <tr>
                          <td >邮政编码：</td><td class="Split"><asp:TextBox ID="SellerPostcodes" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox> </td>
                          <td>邮政编码：</td><td><asp:TextBox ID="BuyerPostcodes" CssClass="ContactInput" Text=""  runat="server"></asp:TextBox></td>
                      </tr>
                     
                  </table>
              </td>
          </tr>
      </table>
      <!--divWidth  end-->
      <div class="clear" style="display:none;">
           <rsweb:ReportViewer ID="SalesContactViewer"  runat="server" Font-Names="Verdana" Font-Size="8pt" Width="1200"  CssClass="reportView"  Height="75%"  WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                <LocalReport ReportPath="SalesManage\Rdlc\GenerateContract.rdlc"></LocalReport>
            </rsweb:ReportViewer>
           <rsweb:ReportViewer ID="ReportViewerExcel" ClientIDMode="Static"  runat="server" Font-Names="Verdana" Font-Size="8pt" Width="1200" CssClass="reportExcelView"  Height="75%"  WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                <LocalReport ReportPath="SalesManage\Rdlc\GoodsTicket.rdlc"></LocalReport>               
            </rsweb:ReportViewer>
          <asp:ScriptManager ID="ScriptManager1"  runat="server"></asp:ScriptManager> 
        </div>
    </div>

</asp:Content>
