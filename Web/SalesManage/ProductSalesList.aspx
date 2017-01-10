<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master"  CodeFile="ProductSalesList.aspx.cs" Inherits="SalesManage_ProductSalesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function () {

            GetDataList(0);
            createPage(10, 10, allRowCount);
            $(".pagination .page.active a").eq(0).click();

            ControlButton();
            
           
        });

        function SearchList()
        {
            GetDataList(0);
            createPage(10, 10, allRowCount);
            ControlButton();
        }

        function ControlButton()
        {
            if ($("#IsDel").attr("checked") == "checked") {
                $("#ReuseOrder").show();
                $("#DisableOrder").hide();
            }
            else {
                $("#DisableOrder").show();
                $("#ReuseOrder").hide();
            }
            $("#selectAllCheck").removeAttr("checked");
            var userClass = "<%=LoginUser.Class%>"
            if (userClass == "S" || userClass == "C") {
                $("#DisableOrder").show();
                $("#ReuseOrder").show();
            }
            else {
                $("#DisableOrder").hide();
                $("#ReuseOrder").hide();
            }
        }

        function CheckDetail(obj, SerialIndex) {
            arrayCheck = new Array();
            $("#SalesDetail tbody input[type='checkbox']:checked").each(function () {

                arrayCheck.push($(this).val());
            })

        }

        function DisableDetailOrder()
        {
            if (arrayCheck.length == 0) {
                layer.msg("请选择要操作记录");
                return false;
            }
            else {
                $.ajax({
                    type: "post",
                    url: "ProductSalesList.aspx",
                    cache: false,
                    async: false,
                    data: {
                        "actiontype": "DisableOrderAction", "CheckOrder": arrayCheck.toString()
                    },
                    dataType: "text",
                    success: function (data)
                    {
                        if (data == "0") {
                            layer.msg("操作失败");
                        }
                        else {
                            SearchList();
                            layer.msg("操作完成");
                        }
                    }
                });
            }
        }

        function ReuseDetailOrder() {
            if (arrayCheck.length == 0) {
                layer.msg("请选择要操作记录");
                return false;
            }
            else {
                $.ajax({
                    type: "post",
                    url: "ProductSalesList.aspx",
                    cache: false,
                    async: false,
                    data: {
                        "actiontype": "ReuseOrderAction", "CheckOrder": arrayCheck.toString()
                    },
                    dataType: "text",
                    success: function (data) {
                        if (data == "0") {
                            layer.msg("操作失败");
                        }
                        else {
                            SearchList();
                            layer.msg("操作完成");
                        }
                    }
                });
            }
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
        var arrayCheck = new Array();
        function SelectAll(obj) {
            $("#SalesDetail tbody input[type='checkbox']").each(function () {

                $(obj).attr("checked") == "checked" ? $(this).attr("checked", "checked") : $(this).removeAttr("checked");
            })

            CheckDetail();
        }

        function CheckDetail() {
            arrayCheck = new Array();
            $("#SalesDetail tbody input[type='checkbox']:checked").each(function () {

                arrayCheck.push($(this).val());
            })
        }

        function ExportSale()
        {
            // window.open("ExportToExcel.aspx?BillNo="+ $("#BillNo").val()+"&Salesperson="+$("#Salesperson").val()+"&IsDel"+ $("#IsDel").attr("checked"))
            
           
            $.ajax({
                type: "post",
                url: "ProductSalesList.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "ExportExcel", "BillNo": $("#BillNo").val(), "Salesperson": $("#Salesperson").val(), "IsDel": $("#IsDel").attr("checked")
                },
                dataType: "text",
                success: function (data) {
                    window.open(data);
                    //用到这个方法的地方需要重写这个success方法
                    //$("#downloadpath").attr("href",data);
                    ////$("#downloadpath").click();
                    //$("#downloadpath").mousedown();
                    //$("#downloadpath").mouseup();
                    //$("#downloadpath").trigger("click");
                }
            });
            //    $('.cd-popup-contact').addClass('is-visible');
           // window.open("GenerateContract.aspx?orderid=<%="42" %>");

        }

        var allRowCount = 0;
        function GetDataList(PageIndex)
        {
            
            $.ajax({
                type: "post",
                url: "ProductSalesList.aspx",
                cache: false,
                async: false,
                data: {
                    "actiontype": "GetSaleList", "PageIndex": PageIndex, "BillNo": $("#BillNo").val(), "Salesperson": $("#Salesperson").val(), "IsDel": $("#IsDel").attr("checked")
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                   
                    var returnData = $.parseJSON(data);
                    allRowCount = returnData[0].RowCount
                    var json = returnData[0].JsonData;
                    $("#SalesDetail tbody").empty();
                    arrayCheck = new Array();
                    //遍历行结果
                    for (var i = 0; i < json.length; i++) {
                        //var trnum = $("#" + gridId + " tbody").find("tr").slice(0).length - 1;
                        //if (i > trnum) {


                        //遍历行中每一列的key 
                        if (json[i]["IsDel"] == "1") {
                            var trHtml = "<tr><td><input type=\"checkbox\" class=\"pro_checkbox\" onclick=\"CheckDetail()\"  value=\"" + json[i]["Id"] + "\" /></td><td>" + json[i]["Id"] + "</td><td>" + json[i]["Seller"].substring(0, 20) + "</td><td>" + json[i]["Salesperson"].substring(0, 20) + "</td><td>" + json[i]["BillNo"].substring(0, 20) + "</td><td>" + json[i]["SaleDate"] + "</td><td>" + (json[i]["BillDate"] == null ? "" : json[i]["BillDate"]) + "</td><td>" + json[i]["RegTime"] + "</td></tr>";

                        }
                        else {
                            var trHtml = "<tr><td><input type=\"checkbox\" class=\"pro_checkbox\" onclick=\"CheckDetail()\"  value=\"" + json[i]["Id"] + "\" /></td><td><a href=\"ProductSales.aspx?Id=" + json[i]["Id"] + "\">" + json[i]["Id"] + "</a></td><td>" + json[i]["Seller"].substring(0, 20) + "</td><td>" + json[i]["Salesperson"].substring(0, 20) + "</td><td>" + json[i]["BillNo"].substring(0, 20) + "</td><td>" + json[i]["SaleDate"] + "</td><td>" + (json[i]["BillDate"] == null ? "" : json[i]["BillDate"]) + "</td><td>" + json[i]["RegTime"] + "</td></tr>";

                        }

                        $("#SalesDetail tbody").append(trHtml);
                    }

                   
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="box" >
      <div class="title" >查询条件</div>
        
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>
            <td width="6%" class="pro_tableTd">发票号</td>
            <td width="20%"><input type="text" id="BillNo" class="pro_input" /></td>
            <td width="6%" class="pro_tableTd">业务员</td>
            <td width="20%"><input type="text" id="Salesperson" class="pro_input" /></td>
            <td width="6%" style="text-align:right;"><input type="checkbox" id="IsDel"  class="pro_checkbox" /></td>
            <td class="pro_tableTd">废止</td>
          </tr>
          <tr>
            <td colspan="6" style="text-align:right;">
              <button class="ui-button" type="button" onclick="SearchList()">查询</button>
              <button class="ui-button" id="DisableOrder" type="button" style="display:none;" onclick="DisableDetailOrder()">废止</button>
              <button class="ui-button"  id="ReuseOrder" type="button" style="display:none;" onclick="ReuseDetailOrder()">恢复</button>
              <button class="ui-button" type="button" onclick="ExportSale()">导出</button>
              <button class="ui-button" type="button"  onclick="printDirent()">打印</button>
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
                <th><input type="checkbox" id="selectAllCheck" class="pro_checkbox" onclick="SelectAll(this)" /></th>
                <th>编码</th>
                <th>经销商</th>
                <th>业务员</th>
                <th>发票号</th>
                <th style="display:none;">发票类型</th>
                <th>发货日期</th>
                <th>开票日期</th>
                <th>订单日期</th>
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
    <a href="#" id="downloadpath" ></a>
    <!--divWidth1  end-->
    
</asp:Content>