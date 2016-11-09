<%@ Page Language="C#" MasterPageFile="~/App_Master/Master.master" AutoEventWireup="true" CodeFile="ProductSales.aspx.cs" Inherits="SalesManage_ProductSales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" lang="zh-cn">
        var json = $.parseJSON("[]");// 定义一个json对象
        var arr =
         {
             "Id": "",
             "Serial": "",
             "Bh": "",
             "orderid": "",
             "Qty": "",
             "OClass": "",
             "ObatchNo": "",
             "BatchNo": "",
             "ProdDate": "",
             "TestDate": "",
             "BtQty": "",
             "SRate": "",
             "Valid": "",
             "Addr": "",
             "Receiver": "",
             "Tel": "",
             "Distri": "",
             "DistriNo": "",
             "NoStart": "",
             "NoEnd": "",
             "NoQty": ""
         }
        arr.Id = 1;

        json.push($.extend(true, {}, arr))

        arr.Id = 2;
        json.push($.extend(true, {}, arr))

        var values = $.map(json, function (value) {
            return value.Id == 2 ? value : null;//isNaN:is Not a Number的缩写 
        }
        );
        values[0].Id = 3

       
        json.splice(1, 1);
       
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="right" >
    <div class="save" ><button class="ui-button">保存</button></div>
    <div class="" >
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
        <tr>
          <td class="pro_tableTd">经销商<span class="red" >*</span></td>
          <td><input type="text" class="pro_input" ></td>
          <td class="pro_tableTd">业务员</td>
          <td><input type="text" class="pro_input" ></td>
          <td class="pro_tableTd">发货日期<span class="red" >*</span></td>
          <td><input type="text" class="pro_input" ></td>
        </tr>
        <tr>
          <td class="pro_tableTd">发票号</td>
          <td><input type="text" class="pro_input" ></td>
          <td class="pro_tableTd">字典表维护发票类型</td>
          <td><input type="text" class="pro_input" ></td>
          <td class="pro_tableTd">发票日期</td>
          <td><input type="text" class="pro_input" ></td>
        </tr>
        <tr>
          <td colspan="6" style="text-align:right;">
            <button class="ui-button">新增订单</button>
            <button class="ui-button">编辑订单</button>
            <button class="ui-button">删除订单</button>
          </td>
        </tr>
      </table>   
    </div>
    <div class="" >
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
    <div class="clear" ></div>
  </div>
</asp:Content>
