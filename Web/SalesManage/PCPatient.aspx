<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PCPatient.aspx.cs" Inherits="SalesManage_PCPatient" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://www.shinva.net/favicon.ico" rel="shortcut icon" />
<link type="text/css" rel="stylesheet" href="../Css/patientstyle.css" >
    <link href="../Css/layer.css" rel="stylesheet" />
<script type="text/javascript" src="../Jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/layer.js"></script>
<title></title>
    
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
                area: ['400px', '300px'], //宽高
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
                url: "PCPatient.aspx",
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
    <style type="text/css">
        /*.layui-layer-demo {background:black; color:#fff; border: none;}*/
        header .inner 
        {
            height:100px;
        }

        header .top 
        {
            width:1120px;
            height:80px;
            margin:0 auto;
            position:relative;
        }
        .logoxinhua {
            padding-top:40px;
            width:265px;
            height:30px;
            float:left;
            overflow:hidden;
        }
        .inner 
        {
            width:1120px;
            margin:0 auto;
            position:relative;
        }

        .clear {
            clear:both;
        }

        .foot-text 
        {
            text-align:center;
            line-height:30px;
            margin-left:0px;
        }
        header 
        {
            background: #fff url(http://www.shinva.net/templates/default/images/header_bg.jpg) 0px 0px repeat-x;
            zoom:1;
            z-index:10;
            position:relative;
            border-bottom:1px solid #ddd;
        }

        .hright 
        {
            float:left;
            width:460px;
            height:100px;
            font-size:12px;
    
            margin-left:300px;
        }

        .telxinhua
        {
            font-weight:bold;
            color:darkturquoise;
            float:left;
            width:300px;
            height:25px;
           
            margin-top:15px;
            margin-left:-13px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            font-size:25px;
            color: rgb(0,118,194);
            letter-spacing: 0;
            text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135
        }


    </style>
</head>

<body>
<div  >
    <header>
        <div class="inner clear">
            
			  <div class="top">
                  <div class="logoxinhua">
				    <a href="http://www.shinva.net/" title="新华医疗" id="web_logo">
					    <img src="http://www.shinva.net/templates/default/images/logo.png" alt="新华医疗" title="新华医疗"/>
				    </a> 
                  </div>
                  
                  <div class="hright">
                      <div style="float:right;margin-top:15px; width:300px; padding-left:230px;"></div>
                      <div class="telxinhua">患  者  信  息  查  询</div>
                  </div>
            </div>
        </div>
    </header>
  <!--header   end-->
  <section >
    <div class="details"  >
      <div class="details_img" ><img src="../Css/images/xinhuaimg.jpg"  alt="" ></div>
      <h3 class="details-title" style="background-color:cornflowerblue;" >患者信息</h3>
      <table border="0" cellspacing="0" cellpadding="0" style="width:80%; margin:15px auto;" class="details-text">
        <tr>
          <td >加工厂:</td>
          <td ><span class="details-text-color details-text-solid" id="Serial"></span></td>
            <td >订单号:</td>
          <td ><span class="details-text-color" id="Order_ID"></span></td>
        </tr>      
         <tr>
          <td style="width:24%;">医疗机构:</td>
          <td style="width:26%;"><span class="details-text-color details-text-solid" id="hospital" ></span></td>
          <td style="width:24%;">医生:</td>
          <td style="width:26%;"><span class="details-text-color"  id="doctor" ></span></td>
        </tr>
        <tr>
          <td style="width:24%;">患者:</td>
          <td style="width:26%;"><span class="details-text-color details-text-solid" id="patient" ></span></td>
             <td>生产日期:</td>
          <td><span class="details-text-color details-text-solid" id="OutDate" ></span></td>          
        </tr>
        
         
        
      </table>
  </section>
    <footer style="color:#eeeced;background:#706E6F;">
	<div class="inner">
		<div class="foot-text">
			版权所有：山东新华医疗器械股份有限公司　　ICP备案号：鲁ICP备07005707号-1　互联网药品信息服务资格证书编号：（鲁）-非经营性-2016-0001
		</div>
	<div class="clear"></div>
	</div>
</footer>

  <!--section   end-->
  <div class="clear" ></div>
</div>
<!--viewport   end-->

</body>
</html>