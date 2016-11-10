<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master"  CodeFile="ProductSalesList.aspx.cs" Inherits="SalesManage_ProductSalesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function () {
            createPage(10, 13, 150);

            function createPage(pageSize, buttons, total) {
                $(".pagination").jBootstrapPage({
                    pageSize: pageSize,
                    total: total,
                    maxPageButton: buttons,
                    onPageClicked: function (obj, pageIndex) {
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
    <div class="save" ><button class="ui-button">查询</button></div>
    <div class="divWidth1" >
      <div class="divTable" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table1">
          <tr>
            <th><input type="checkbox" class="pro_checkbox" ></th>
            <th>存货编码</th>
            <th>订货号</th>
            <th>销售数量</th>
            <th>材料类型</th>
            <th>生产批号</th>
            <th>生产日期</th>
          </tr>
          <tr>
            <td><input type="checkbox" class="pro_checkbox" ></td>
            <td>BM001</td>
            <td>DD001</td>
            <td>5</td>
            <td>类型1</td>
            <td>SCPH0001</td>
            <td>2016/12/30</td>
          </tr>
          <tr>
            <td><input type="checkbox" class="pro_checkbox" ></td>
            <td>BM001</td>
            <td>DD001</td>
            <td>5</td>
            <td>类型1</td>
            <td>SCPH0001</td>
            <td>2016/12/30</td>
          </tr>
          <tr>
            <td><input type="checkbox" class="pro_checkbox" ></td>
            <td>BM001</td>
            <td>DD001</td>
            <td>5</td>
            <td>类型1</td>
            <td>SCPH0001</td>
            <td>2016/12/30</td>
          </tr>
        </table>
      </div>
     
      <!--pager  end-->
    </div>
     <div  >
        <ul class="pagination"></ul>
      </div>
    <!--divWidth1  end-->
    
</asp:Content>