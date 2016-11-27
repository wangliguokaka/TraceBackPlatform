<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master" CodeFile="FactoryExportExcel.aspx.cs" Inherits="SalesManage_FactoryExportExcel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function () {

            GetDataList(0);
            createPage(10, 10, allRowCount);

            //关闭窗口
            $('.cd-popup-add').on('click', function (event) {
                if ($(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup-edit')) {
                    event.preventDefault();
                    $(this).removeClass('is-visible');
                }
            });
            //ESC关闭
            $(document).keyup(function (event) {
                if (event.which == '27') {
                    $('.cd-popup-add').removeClass('is-visible');
                }
            });
        });

        function SearchList()
        {
            GetDataList(0);
            createPage(10, 10, allRowCount);
        }
        function createPage(pageSize, buttons, total) {
            $(".pagination").jBootstrapPage({
                pageSize: pageSize,
                total: total,
                maxPageButton: buttons,
                onPageClicked: function (obj, pageIndex) {
                    GetDataList(pageIndex)
                   // $('#pageIndex').html('您选择了第<font color=red>' + (pageIndex + 1) + '</font>页');
                }
            });
        }


        function ExportSale()
        {
            $.ajax({
                type: "post",
                url: "FactoryOrder.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "ExportExcel", "BillNo": $("#BillNo").val(), "Salesperson": $("#Salesperson").val(), "IsDel": $("#IsDel").attr("checked")
                },
                dataType: "text",
                success: function (data) {
                    window.open(data);
                }
            });
        }
        var json = $.parseJSON("[]");// 定义一个json对象
        var allRowCount = 0;
        function GetDataList(PageIndex)
        {
            
            $.ajax({
                type: "post",
                url: "FactoryOrder.aspx",
                cache: false,
                async: false,
                data: {
                    "actiontype": "GetSaleList", "PageIndex": PageIndex, "CardNoStart": $("#CardNoStart").val(), "CardNoEnd": $("#CardNoEnd").val(), "Salesperson": $("#Salesperson").val()
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                   
                    var returnData = $.parseJSON(data);
                    allRowCount = returnData[0].RowCount
                    json = returnData[0].JsonData;
                    $("#SalesDetail tbody").empty();
                    //遍历行结果
                    for (var i = 0; i < json.length; i++) {
                        //var trnum = $("#" + gridId + " tbody").find("tr").slice(0).length - 1;
                        //if (i > trnum) {


                        //遍历行中每一列的key 

                        var trHtml = "<tr><td><a href=\"javascript:OpenDetail("+json[i]["CardNo"] + ")\">" + json[i]["CardNo"] + "</a></td><td>" + json[i]["Serial"] + "</td><td>" + json[i]["Order_ID"] + "</td><td>" + json[i]["Hospital"] + "</td><td>" + json[i]["Doctor"] + "</td><td>" + json[i]["Patient"] + "</td></tr>";

                        $("#SalesDetail tbody").append(trHtml);
                    }

                   
                }
            });
        }

        function OpenDetail(CardNo)
        {
            $('.cd-popup-add').addClass('is-visible');

            var arrSelect = $.map(json, function (value) {
                return value.CardNo == CardNo ? value : null;//isNaN:is Not a Number的缩写 
            }
               );
            $.each(arrSelect[0], function (i, n) {
                $("#" + i).val(arrSelect[0][i]);
            });
        }

       

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
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="box" >
      <div class="title" >数据上传</div>
        
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr style="height:40px;">
            <td  class="pro_tableTd" style="width:420px;"><asp:FileUpload runat="server" Width="400px" Height="30px"  class="pro_input required" ID="fileExport" /></td>
              <td class="pro_tableTd"><asp:button runat="server"  class="ui-button" Text="上传" ID="btnFile" /></td>
          </tr>
        </table>   
      </div>
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>
    <!--box  end-->
    <div class="divWidth1" >
      <div class="divTable" style="height:300px; overflow:auto;" >
        <table border="0" style="width:100% "  id="SalesDetail" cellspacing="0" cellpadding="0" class="pro_table1">
          <thead>
            <tr>
                <th>防伪卡号</th>
                <th>加工厂编码</th>
                <th>订单条码</th>
                <th>医疗机构</th>
                <th>医生</th>
                <th>患者</th>
              </tr>        
          </thead>
            <tbody>

            </tbody>
        </table>
      </div>
     
      <!--pager  end-->
    </div>
     <div  >
        <ul class="pagination"></ul>
      </div>
    <div class="cd-popup-add">
    <div class="cd-popup-container">
        <div class="box" >
          <div class="title" >工厂订单详细</div>
          <div class="divWidth" >
            <table width="100%" id="gridLayer" border="0" cellspacing="0" cellpadding="0" class="pro_table">
              <tr>
                <td class="pro_tableTd">防伪卡号<span class="red" >*</span></td>
                <td><div class="search"><input type="text" id="CardNo" maxlength="50"  class="pro_input required" /><div id="auto_div"></div></div></td>
                <td class="pro_tableTd">加工厂编码<span class="red" >*</span></td>
                <td><input type="text" id="Serial" value="" maxlength="50"   class="pro_input required" /></td>
                <td class="pro_tableTd">订单条码<span class="red" >*</span></td>
                <td><input type="text" id="Order_ID" maxlength="10" class="pro_input required number" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">医疗机构<span class="red" >*</span></td>
                <td><input type="text" id="Hospital" maxlength="10"  class="pro_input required number" /></td>
                <td class="pro_tableTd">医生<span class="red" >*</span></td>
                <td><input type="text" id="Doctor" maxlength="50"  class="pro_input required number" /></td>
                  <td class="pro_tableTd">患者<span class="red" >*</span></td>
                <td><input type="text" id="Patient" maxlength="50"  class="pro_input required number" /></td>
                
              </tr>
              <tr>
                <td class="pro_tableTd">患者年龄</td>
                <td><input type="text" id="Age" maxlength="10"  class="pro_input" /></td>
                <td class="pro_tableTd">患者性别</td>
                <td><input type="text" id="Sex" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">出货日期<span class="red" >*</span></td>
                <td><input type="text" id="OutDate" maxlength="50"  class="pro_input required" /></td>
               
              </tr>
              <tr>
                 <td class="pro_tableTd">产品名称<span class="red" >*</span></td>
                <td><input type="text" id="Itemname" class="detepickers pro_input required" /></td>
                <td class="pro_tableTd">产品数量</td>
                <td><input type="text" id="Qty" class="detepickers pro_input" /></td>
                <td class="pro_tableTd">牙位A（上右位）</td>
                <td><input type="text" id="a_teeth" maxlength="10"  class="pro_input number" /></td>
               
              </tr>
              <tr>
                <td class="pro_tableTd">牙位B（上左位）</td>
                <td><input type="text" id="b_teeth" maxlength="10"  class="pro_input" /></td>
                <td class="pro_tableTd">牙位C（下右位）</td>
                <td><input type="text" id="c_teeth" class="pro_input" /></td>
                 <td class="pro_tableTd">牙位D（下左位）</td>
                <td><input type="text" id="d_teeth" maxlength="50"  class="pro_input" /></td>
              </tr>
             
              <tr>
                <td class="pro_tableTd">颜色</td>
                <td><input type="text" id="Color" maxlength="20"  class="pro_input" /></td>
                <td class="pro_tableTd">材料批号</td>
                <td><input type="text" id="BatchNo" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">加工厂保修期</td>
                <td><input type="text" id="Valid" maxlength="100"  class="pro_input" /></td>
              </tr>
              
            </table>   
          </div>
          <!--divWidth  end-->
          <div class="clear" ></div>
        </div>
        <!--box  end-->
        <a href="#0" class="cd-popup-close">关闭</a>
    </div>
</div>
    <!--divWidth1  end-->
    
</asp:Content>

