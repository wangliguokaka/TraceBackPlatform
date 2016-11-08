<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductSales.aspx.cs" Inherits="SalesManage_ProductSales" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
 <script type="text/javascript" src="../Scripts/jquery-1.7.1.min.js"></script>
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
        return value.Id == 2 ? value :null ;//isNaN:is Not a Number的缩写 
        }
    );
    values[0].Id = 3

    alert(json.length)
    json.splice(1, 1);
    alert(json.length)
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
    </div>
    </form>
</body>
</html>
