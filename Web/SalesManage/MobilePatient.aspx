<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MobilePatient.aspx.cs" Inherits="SalesManage_MobilePatient" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="format-detection" content="telephone=no" />
<meta name="format-detection" content="email=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link type="text/css" rel="stylesheet" href="../Css/patientstyle.css" >
    <link href="../Css/layer.css" rel="stylesheet" />
<script type="text/javascript" src="../Jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/layer.js"></script>
<title></title>
    <style type="text/css">
        /*.layui-layer-demo {background:black; color:#fff; border: none;}*/
    </style>
    <script type="text/javascript">
        var openIndex = 0;
        $(function ()
        {
            openIndex = layer.open({
                title: "防伪卡号验证",
                type: 1,
                shade: [1, '#393D49'],
                closeBtn: 0, //不显示关闭按钮
                skin: 'layui-layer-demo', //加上边框
                area: ['300px', '300px'], //宽高
                content: '<div class="logo">'
                    + '<div class="logo-div" style="margin-top:10px;"><input type="text" class="logo-input logo-code" value="15681820" id="CardNo" placeholder="防伪卡号" ></div>'
                     + '<div class="logo-div" style="margin-top:10px;"><input type="text" class="logo-input logo-code" value="张三" id="PatientName" placeholder="患者姓名" ></div>'
                    + '<div class="logo-div1 logo-div1-margin" ><input type="button" onclick="CheckCardNo()" class="logo-btn" value="验证" ></div>'
                    + '</div>'
            });
        })

        function CheckCardNo()
        {
            $.ajax({
                type: "post",
                url: "MobilePatient.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "ValidCardNo", CardNo: $("#CardNo").val(), PatientName: $("#PatientName").val()
                },
                dataType: "text",
                success: function (data) {
                    var returnData = $.parseJSON(data);
                    var allRowCount = returnData[0].RowCount
                    var json = returnData[0].JsonData;
                    var detailJson = returnData[0].JsonDetail;

                    if (allRowCount == 0) {
                        layer.msg("防伪卡号验证失败");
                    }
                    else if (allRowCount > 1) {
                        layer.msg("防伪卡号被重复使用");
                    }
                    else {
                        $("#Serial").html(json[0].Serial)
                        $("#Order_ID").html(json[0].Order_ID)
                        $("#hospital").html(json[0].hospital)
                        $("#doctor").html(json[0].doctor)
                        $("#patient").html(json[0].patient) 
                        $("#OutDate").html(json[0].OutDate)

                        var OrdersDetail = "<tr class=\"detailTR\"><td colspan=\"4\"><b>订单详细：</b></td></tr>"
                        //遍历行结果
                        for (var i = 0; i < detailJson.length; i++) {
                            OrdersDetail = OrdersDetail + "<tr><td>种类:</td><td><span class=\"details-text-color details-text-solid\" >&nbsp;" + detailJson[i]["Itemname"] + "</span></td><td>保修期:</td><td><span class=\"details-text-color\" >" + detailJson[i]["Valid"] + "</span></td></tr>";
                            OrdersDetail = OrdersDetail + "<tr><td>上右牙位:</td><td><span class=\"details-text-color details-text-solid\" >&nbsp;" + detailJson[i]["a_teeth"] + "</span></td><td>上左牙位:</td><td><span class=\"details-text-color\" >" + detailJson[i]["b_teeth"] + "</span></td></tr>";
                            OrdersDetail = OrdersDetail + "<tr><td>下右牙位:</td><td><span class=\"details-text-color details-text-solid\" >&nbsp;" + detailJson[i]["c_teeth"] + "</span></td><td>下左牙位:</td><td><span class=\"details-text-color\" >" + detailJson[i]["d_teeth"] + "</span></td></tr>";
                        }

                        $(".details-text").append(OrdersDetail);

                        layer.close(openIndex);
                    }
                }
            });
           
        }
    </script>
</head>

<body>
<div class="viewport" >
 
  <!--header   end-->
  <section >
    <div class="details" >
      <div class="details_img" ><img src="../Css/images/img.jpg" alt="" ></div>
      <h3 class="details-title" >患者信息</h3>
      <table border="0" cellspacing="0" cellpadding="0" style="width:100%;" class="details-text">
        <tr>
          <td style="width:24%;">加工厂:</td>
          <td style="width:26%;"><span class="details-text-color details-text-solid" id="Serial"></span></td>
            <td style="width:24%;">订单号:</td>
          <td style="width:26%;"><span class="details-text-color" id="Order_ID"></span></td>
        </tr>      
         <tr>
          <td style="width:24%;">医疗机构:</td>
          <td style="width:26%;"><span class="details-text-color details-text-solid" id="hospital" ></span></td>
          <td style="width:24%;">医生:</td>
          <td style="width:26%;"><span class="details-text-color"  id="doctor" ></span></td>
        </tr>
        <tr>
          <td >患者:</td>
          <td><span class="details-text-color details-text-solid" id="patient" ></span></td>
             <td>生产日期:</td>
          <td><span class="details-text-color details-text-solid" id="OutDate" ></span></td>          
        </tr>
        
         
        
      </table>
  </section>
  <!--section   end-->
  <div class="clear" ></div>
</div>
<!--viewport   end-->

</body>
</html>