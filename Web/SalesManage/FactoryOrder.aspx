﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master"  CodeFile="FactoryOrder.aspx.cs" Inherits="SalesManage_FactoryOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function () {
            GetProductList();
            GetDataList(0);
            createPage(10, 10, allRowCount);
            $(".pagination .page.active a").eq(0).click();
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


            //打开窗口
            $('.cd-popup-product').on('click', function (event) {
                event.preventDefault();
                $('.cd-popup-contact').addClass('is-visible');
            });

            //关闭窗口
            $('.cd-popup-contact').on('click', function (event) {
                if ($(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup-add')) {
                    event.preventDefault();
                    $(this).removeClass('is-visible');
                }
            });

            $('.cd-popup-contact').on('click', function (event) {
                if ($(event.target).is('.cd-popup-save')) {
                    event.preventDefault();
                    var productId = "";
                    $("#productTable [type=checkbox]:checked").each(function () {
                        productId = productId + "," + $(this).attr("id");
                    })
                    productId = productId.substr(1, productId.length)
                    $.ajax({
                        type: "post",
                        url: "FactoryOrder.aspx",
                        cache: false,
                        async: false,
                        data: {
                            actiontype: "SaveProduct", ProductID: productId
                        },
                        dataType: "text",
                        success: function (data) {
                            //用到这个方法的地方需要重写这个success方法
                            if (data == "0") {
                                layer.msg("保存失败！");
                            }
                            else {
                                layer.msg("保存成功！");
                            }
                        }
                    });
                    $(this).removeClass('is-visible');
                }
            });

            //ESC关闭
            $(document).keyup(function (event) {
                if (event.which == '27') {
                    $('.cd-popup-contact').removeClass('is-visible');
                }
            });

            var userClass = "<%=LoginUser.Class%>"
            if (userClass == "B") {
                $(".cd-popup-product").show();
                 var ProductID = '<%=LoginUser.ProductID%>'
                if (ProductID != '') {

                    $.each(ProductID.split(','), function (n, value) {
                        $("#" + value).attr("checked", "checked");
                    });
                }
            }
            else {
                $(".cd-popup-product").hide();

            }
            

            $(".cd-popup-container").draggable();

            $("#gridLayer input").attr("disabled", "disabled")

            old_value = $("#FilterSerial").val();
            var test_list = $.parseJSON('<%=BindingJson%>');
            BindCommonAutoCompleteEvent("FilterSerial", "auto_div", test_list)

        });


        function GetProductList() {

            $.ajax({
                type: "post",
                url: "FactoryOrder.aspx",
                cache: false,
                async: false,
                data: {
                    "actiontype": "GetProductList"
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法

                    var returnData = $.parseJSON(data);
                    allRowCount = returnData[0].RowCount
                    json = returnData[0].JsonData;
                    $("#productTable tbody").empty();
                    //遍历行结果
                    var line = parseInt(json.length / 6);
                    for (var i = 0; i < line; i++) {

                        //遍历行中每一列的key 

                        var trHtml = "<tr><td><input type=\"checkbox\" id =\"" + json[i * 6]["id"] + "\">" + json[i * 6]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i * 6 + 1]["id"] + "\">" + json[i * 6 + 1]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i * 6 + 2]["id"] + "\">" + json[i * 6 + 2]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i * 6 + 3]["id"] + "\">" + json[i * 6 + 3]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i * 6 + 4]["id"] + "\">" + json[i * 6 + 4]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i * 6 + 5]["id"] + "\">" + json[i * 6 + 5]["itemname"] + "</td></tr>"

                        $("#productTable tbody").append(trHtml);
                    }
                    var trHtml = "<tr>";
                    for (var i = 0; i < json.length % 6; i++) {
                        trHtml = trHtml + "<td><input type=\"checkbox\" id =\"" + json[line * 6 + i]["id"] + "\">" + json[line * 6 + i]["itemname"] + "</></td>";
                    }
                    trHtml = trHtml + "</tr>";
                    $("#productTable tbody").append(trHtml);
                }
            });
        }

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
                    "actiontype": "GetSaleList", "PageIndex": PageIndex, "CardNoStart": $("#CardNoStart").val(), "CardNoEnd": $("#CardNoEnd").val(), "FilterSerial": $("#FilterSerial").val()
                    , "FilterOrder_ID": $("#FilterOrder_ID").val(), "FilterOutDateStart": $("#FilterOutDateStart").val(), "FilterOutDateEnd": $("#FilterOutDateEnd").val()
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

            $.ajax({
                type: "post",
                url: "FactoryOrder.aspx",
                cache: false,
                async: false,
                data: {
                    "actiontype": "GetOrderDetail", "CardNo": CardNo
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法

                    var detailJson = $.parseJSON(data);
                    $(".detailTR").remove();
                    var OrdersDetail = "<tr class=\"detailTR\"><td colspan=\"6\"><b>订单详细：</b></td></tr>"
                    //遍历行结果
                    for (var i = 0; i < detailJson.length; i++) {
                        OrdersDetail = OrdersDetail + "<tr class=\"detailTR\"><td class=\"pro_tableTd\">产品名称</td><td>" + detailJson[i]["Itemname"] + "</td><td class=\"pro_tableTd\" style=\"border-bottom-style:solid;border-bottom-width:1px;\">牙位A（上右位）</td><td style=\"border-bottom-style:solid;border-right-style:solid;border-bottom-width:1px;border-right-width:1px;\">" + detailJson[i]["a_teeth"] + "</td><td class=\"pro_tableTd\">牙位B（上左位）</td><td>" + detailJson[i]["b_teeth"] + "</td></tr>";
                        OrdersDetail = OrdersDetail + "<tr class=\"detailTR\" style=\"border-bottom-style:dotted;border-bottom-width:1px;\"><td class=\"pro_tableTd\">产品数量</td><td>" + detailJson[i]["Qty"] + "</td><td class=\"pro_tableTd\">牙位C（下右位）</td><td>" + detailJson[i]["c_teeth"] + "</td><td class=\"pro_tableTd\" style=\"border-top-style:solid;border-left-style:solid;border-top-width:1px;border-left-width:1px;\">牙位D（下左位）</td><td style=\"border-top-style:solid;border-top-width:1px;\">" + detailJson[i]["d_teeth"] + "</td></tr>";
                      
                    }
                  
                    $("#gridLayer").append(OrdersDetail);
                }
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
    <style type="text/css">
        #gridLayer input 
        {
            border-style:none;
            background-color:white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="box" >
      <div class="title" >查询条件</div>
        
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>
            <td width="10%" class="pro_tableTd">防伪卡号开始</td>
            <td width="15%"><input type="text" id="CardNoStart" class="pro_input CardNoStart" /></td>
            <td width="10%" class="pro_tableTd">防伪卡号结束</td>
            <td width="15%"><input type="text" id="CardNoEnd" value="99999999" class="pro_input CardNoEnd" /></td>            
           <td width="10%" class="pro_tableTd">订单号</td>
            <td width="15%"><input type="text" id="FilterOrder_ID" class="pro_input" /></td>
          </tr>
            <tr>
             <td width="10%" class="pro_tableTd">客户</td>
            <td width="15%"><div class="search"><input type="text" id="FilterSerial" maxlength="50"  class="pro_input" /><div id="auto_div" class="auto_div"></div></div></td>
            
            <td width="10%" class="pro_tableTd">出货开始日期</td>
            <td width="15%"><input type="text" id="FilterOutDateStart" class="pro_input detepickers" /></td>
            <td width="10%"  class="pro_tableTd">出货结束日期</td>
            <td><input type="text"  id="FilterOutDateEnd" class="pro_input detepickers" /></td>           
          </tr>
          <tr>
            <td colspan="6" style="text-align:right;">
              <button class="ui-button" type="button" onclick="SearchList()">查询</button>
              <button class="ui-button" type="button" onclick="ExportSale()">导出</button>
              <button class="ui-button" type="button"  onclick="printDirent()">打印</button>
                <button type="button" class="ui-button cd-popup-product">产品设置</button>
                <object id="WebBrowser" width="0" height="0"  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>
            </td>
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
                <th>客户</th>
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
     <div class="cd-popup-contact">
         <div class="cd-popup-container" >
            <div class="box" >
              <div class="title" >新华医疗产品设置</div>
              <div class="divWidth"  style=" overflow:auto !important;height:240px;" >
               <table id="productTable" class="pro_table" >
                        <tbody>

                        </tbody>
                    </table>
              </div>
              <!--divWidth  end-->
              <div class="clear" ></div>
            </div>
            <!--box  end-->
             <a href="#0" class="cd-popup-save">保存</a>
            <a href="#0" class="cd-popup-close">关闭</a>
        </div>
    </div>
    <div class="cd-popup-add">
    <div class="cd-popup-container" style="overflow:auto !important; height:240px;">
        <div class="box" >
          <div class="title" >客户订单详细</div>
          <div class="divWidth" style="overflow:auto !important; height:190px;">
            <table width="100%" id="gridLayer" border="0" cellspacing="0" cellpadding="0" class="pro_table">
              <tr>
                <td class="pro_tableTd">防伪卡号</td>
                <td><input type="text" id="CardNo" maxlength="50"  class="pro_input required" /></td>
                <td class="pro_tableTd">客户编码</td>
                <td><input type="text" id="Serial" value="" maxlength="50"   class="pro_input required" /></td>
                <td class="pro_tableTd">订单条码</td>
                <td><input type="text" id="Order_ID" maxlength="10" class="pro_input required number" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">医疗机构</td>
                <td><input type="text" id="Hospital" maxlength="10"  class="pro_input required number" /></td>
                <td class="pro_tableTd">医生</td>
                <td><input type="text" id="Doctor" maxlength="50"  class="pro_input required number" /></td>
                  <td class="pro_tableTd">患者</td>
                <td><input type="text" id="Patient" maxlength="50"  class="pro_input required number" /></td>
                
              </tr>
              <tr>
                <td class="pro_tableTd">患者年龄</td>
                <td><input type="text" id="Age" maxlength="10"  class="pro_input" /></td>
                <td class="pro_tableTd">患者性别</td>
                <td><input type="text" id="Sex" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">出货日期</td>
                <td><input type="text" id="OutDate" maxlength="50"  class="pro_input required" /></td>
               
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
