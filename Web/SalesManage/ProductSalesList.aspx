<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master"  CodeFile="ProductSalesList.aspx.cs" Inherits="SalesManage_ProductSalesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function () {

            $.ajax({
                type: "post",
                url: "ProductSalesList.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "GetSaleList"
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                    var json = $.parseJSON(data);
                    $("#SalesGrid tbody").empty();
                    //遍历行结果
                    for (var i = 0; i < json.length; i++) {
                        //var trnum = $("#" + gridId + " tbody").find("tr").slice(0).length - 1;
                        //if (i > trnum) {


                        //遍历行中每一列的key 

                        var trHtml = "<tr><td><input type=\"checkbox\" class=\"pro_checkbox\" onclick=\"EditDetail(this," + json[i]["Id"] + ")\" value=\"" + json[i]["Id"] + "\" /></td><td>" + json[i]["Id"] + "</td><td>" + json[i]["Seller"] + "</td><td>" + json[i]["Salesperson"] + "</td><td>" + json[i]["BillNo"] + "</td><td>" + json[i]["BillClass"] + "</td><td>" + json[i]["SaleDate"] + "</td><td>" + json[i]["BillDate"] + "</td></tr>";

                        $("#SalesGrid tbody").append(trHtml);
                    }
                }
            });

            createPage(10, 10, 150);

            function createPage(pageSize, buttons, total) {
                $(".pagination").jBootstrapPage({
                    pageSize: pageSize,
                    total: total,
                    maxPageButton: buttons,
                    onPageClicked: function (obj, pageIndex) {
                        alert(pageIndex)
                        $('#pageIndex').html('您选择了第<font color=red>' + (pageIndex + 1) + '</font>页');
                    }
                });
            }

            //$('#btn1').click(function () {
            //    createPage(10, 10, 200);
            //});

            //$('#btn2').click(function () {
            //    createPage(10, 15, 200);
            //});

            //$('#btn3').click(function () {
            //    createPage(5, 12, 200);
            //});

        });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="box" >
      <div class="title" >查询条件</div>
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>
            <td width="6%" class="pro_tableTd">发票号<span class="red" >*</span></td>
            <td width="20%"><input type="text" class="pro_input" ></td>
            <td width="6%" class="pro_tableTd">业务员</td>
            <td width="20%"><input type="text" class="pro_input" ></td>
            <td width="6%" style="text-align:right;"><input type="checkbox" class="pro_checkbox" ></td>
            <td class="pro_tableTd">废止</td>
          </tr>
          <tr>
            <td colspan="6" style="text-align:right;">
              <button class="ui-button">查询</button>
              <button class="ui-button">废止</button>
              <button class="ui-button">恢复</button>
              <button class="ui-button">导出</button>
              <button class="ui-button">打印</button>
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
        <table border="0" style="width:100% "  id="SalesGrid" cellspacing="0" cellpadding="0" class="pro_table1">
          <thead>
            <tr>
                <th><input type="checkbox" class="pro_checkbox" /></th>
                <th>编码</th>
                <th>经销商</th>
                <th>业务员</th>
                <th>发票号</th>
                <th>发票类型</th>
                <th>发货日期</th>
                <th>开票日期</th>
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
    <!--divWidth1  end-->
    
</asp:Content>