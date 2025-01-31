﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExportToExcel.aspx.cs" Inherits="SalesManage_ExportToExcel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <link href="../Css/bootstrap.min.css" rel="stylesheet"/>
    <link href="../Css/jquery-ui-1.10.4.custom.css" rel="stylesheet" />
    <link href="../Css/layer.css" rel="stylesheet" />
    <link href="../Css/style.css" rel="stylesheet" />
   


    <script type="text/javascript" src="../Scripts/jquery-1.7.1.min.js"></script>
    <script type="text/javascript"  src="../Scripts/jquery-ui-1.8.20.min.js"></script>
    <script type="text/javascript"  src="../Scripts/jBootstrapPage.js"></script>
    <script type="text/javascript"  src="../Scripts/jquery-ui-tables.js"></script>
    <script type="text/javascript" src="../Scripts/common.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Scripts/layer.js"></script>


    <script type="text/javascript">

        $(window).resize(function () {
            $(".col-md-10").css("height", $(window).height() - 100);
        });


        $(function () {
            $(".col-md-10").css("height",$(window).height() - 100);
            //$("#SalesMenu").click();
            //$("#SalesMenu").parent().attr("class", "active");
           
            if (location.href.indexOf("ProductSales.aspx") > -1)
            {
                $("#ProductSales").attr("class", "active");
                $("#ProductSales").parent().parent().find("a").eq(0).click();
                $("#ProductSales").parent().parent().find("a span").eq(0).css("color","white");
                $("#ProductSales").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("ProductSalesList.aspx") > -1) {
                $("#ProductSalesList").attr("class", "active");
                $("#ProductSalesList").parent().parent().find("a").eq(0).click();
                $("#ProductSalesList").parent().parent().find("a span").eq(0).css("color","white");
                $("#ProductSalesList").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("RelatedOrder.aspx") > -1) {
                alert($("#UserTrace").parent().parent().find("a").eq(0).html())
                $("#RelatedOrder").attr("class", "active");
                $("#RelatedOrder").parent().parent().find("a").eq(0).click();
                $("#RelatedOrder").parent().parent().find("a span").eq(0).css("color", "white");
                $("#RelatedOrder").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("UserTrace.aspx") > -1) {
               
                $("#UserTrace").attr("class", "active");
                $("#UserTrace").parent().parent().find("a").eq(0).click();
                $("#UserTrace").parent().parent().find("a span").eq(0).css("color", "white");
                $("#UserTrace").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("DictManagement.aspx") > -1) {
                $("#DictManagement").attr("class", "active");
                $("#DictManagement").parent().parent().find("a").eq(0).click();
                $("#DictManagement").parent().parent().find("a span").eq(0).css("color", "white");
                $("#DictManagement").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("CustomerManage.aspx") > -1) {
                $("#CustomerManage").attr("class", "active");
                $("#CustomerManage").parent().parent().find("a").eq(0).click();
                $("#CustomerManage").parent().parent().find("a span").eq(0).css("color", "white");
                $("#CustomerManage").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("FactoryOrder.aspx") > -1) {
                $("#FactoryOrder").attr("class", "active");
                $("#FactoryOrder").parent().parent().find("a").eq(0).click();
                $("#FactoryOrder").parent().parent().find("a span").eq(0).css("color", "white");
                $("#FactoryOrder").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("BasicInfo.aspx") > -1) {
                $("#BasicInfo").attr("class", "active");
                $("#BasicInfo").parent().parent().find("a").eq(0).click();
                $("#BasicInfo").parent().parent().find("a span").eq(0).css("color", "white");
                $("#BasicInfo").parent().parent().attr("class", "active");
            }
            else if (location.href.indexOf("SpecManage.aspx") > -1) {
                $("#SpecManage").attr("class", "active");
                $("#SpecManage").parent().parent().find("a").eq(0).click();
                $("#SpecManage").parent().parent().find("a span").eq(0).css("color", "white");
                $("#SpecManage").parent().parent().attr("class", "active");
            }
            else {
                $("#ProductSalesList").attr("class", "active");
                $("#ProductSalesList").parent().parent().find("a").eq(0).click();
                $("#ProductSalesList").parent().parent().find("a span").eq(0).css("color","white");
                $("#ProductSalesList").parent().parent().attr("class", "active");
            }
           
            $(".nav-header").each(function () {

                $(this).bind("click", function ()
                    {
                         $("ul").removeClass("in");
                        })
                    }
                );
        })
        
        var updateIndex = 0;
        function ModifyPassword() {
            layer.open({
                title: "密码修改",
                type: 1,
                skin: 'layui-layer-rim', //加上边框
                area: ['360px', '240px'], //宽高
                content: '<div style="width:80%;margin:auto;"><div style="margin:15px;"><button type="button" class="ui-button" onclick="ModifyPass()">修改</button></div>'
                    + '<div style="margin:15px;">旧密码&nbsp;&nbsp;&nbsp;：<input type="password"  id="OldPass" style="width:160px;"  class=" pro_input1 required" /> </div>'
                    + '<div style="margin:15px;">新密码&nbsp;&nbsp;&nbsp;：<input type="password" id="NewPass"   style="width:160px;" class=" pro_input1 required" /></div>'
                    + '<div style="margin:15px;">确认密码：<input type="password" id="ConfirmPass"   style="width:160px;" class=" pro_input1 required" /></div></div>'
            });

            updateIndex = layer.index;

        }

        function ModifyPass()
        {
            var OldPass = $("#OldPass").val();
            var NewPass = $("#NewPass").val();
            var ConfirmPass = $("#ConfirmPass").val();
            if (OldPass == "") {
                layer.msg("旧密码不能为空");
                return;
            }

            if (NewPass == "") {
                layer.msg("新密码不能为空");
                return;
            }

            if (ConfirmPass == "") {
                layer.msg("确认密码不能为空");
                return;
            }

            if (NewPass != ConfirmPass) {
                layer.msg("两次密码输入不一致");
                return;
            }

            $.ajax({
                type: "post",
                url: "../Handler/BaseOpetation.ashx",
                cache: false,
                async: false,
                data: {
                    actiontype: "ModifyPass", "OldPass": OldPass, "NewPass": NewPass, "ConfirmPass": ConfirmPass
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                    if (data == "0") {
                        layer.msg("修改失败！");
                    }
                    else {
                        layer.msg("修改成功！");
                        layer.close(updateIndex);
                    }
                }
            });
        }

        function Logout()
        {
            layer.confirm('确认注销吗？', {

            }, function (index) {

                $("#logout").click();
                layer.close(index);
            }, function () {

            });

        }

    </script>
     <style media="print" type="text/css">
        .Noprint{display:none;}

　　      .PageNext{page-break-after: always;}

    </style>
    <style>
        html {
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        body {
            font-family: 'Microsoft Yahei', '微软雅黑', '宋体', \5b8b\4f53, Tahoma, Arial, Helvetica, STHeiti;
            margin: 0;
        }

        .main-nav {
            margin-left: 1px;
        }

            .main-nav.nav-tabs.nav-stacked > li {
            }

                .main-nav.nav-tabs.nav-stacked > li > a {
                    padding: 10px 8px;
                    font-size: 12px;
                    font-weight: 600;
                    color: #4A515B;
                    background: #E9E9E9;
                    background: -moz-linear-gradient(top, #FAFAFA 0%, #E9E9E9 100%);
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FAFAFA), color-stop(100%,#E9E9E9));
                    background: -webkit-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    background: -o-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    background: -ms-linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    background: linear-gradient(top, #FAFAFA 0%,#E9E9E9 100%);
                    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9');
                    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9')";
                    border: 1px solid #D5D5D5;
                    border-radius: 4px;
                }

                    .main-nav.nav-tabs.nav-stacked > li > a > span {
                        color: #4A515B;
                    }

                .main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover {
                    color: #FFF;
                    background: #3C4049;
                    background: -moz-linear-gradient(top, #4A515B 0%, #3C4049 100%);
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#4A515B), color-stop(100%,#3C4049));
                    background: -webkit-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: -o-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: -ms-linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    background: linear-gradient(top, #4A515B 0%,#3C4049 100%);
                    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049');
                    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049')";
                    border-color: #2B2E33;
                }

                    #main-nav.nav-tabs.nav-stacked > li.active > a, #main-nav.nav-tabs.nav-stacked > li > a:hover > span {
                        color: #FFF;
                    }

            .main-nav.nav-tabs.nav-stacked > li {
                margin-bottom: 4px;
            }

        .nav-header.collapsed > span.glyphicon-chevron-toggle:before {
            content: "\e114";
        }

        .nav-header > span.glyphicon-chevron-toggle:before {
            content: "\e113";
        }

        footer.duomi-page-footer {
            background-color: white;
        }

            footer.duomi-page-footer .beta-message {
                color: #a4a4a4;
            }

                footer.duomi-page-footer .beta-message a {
                    color: #53a2e4;
                }

            footer.duomi-page-footer .list-inline a, footer.authenticated-footer .list-inline li {
                color: #a4a4a4;
                padding-bottom: 30px;
            }




        footer.duomi-page-footer {
            background-color: white;
        }

            footer.duomi-page-footer .beta-message {
                color: #a4a4a4;
            }

                footer.duomi-page-footer .beta-message a {
                    color: #53a2e4;
                }

            footer.duomi-page-footer .list-inline a, footer.authenticated-footer .list-inline li {
                color: #a4a4a4;
                padding-bottom: 30px;
            }

        /*********************************************自定义部分*********************************************/
        .secondmenu a {
            font-size: 12px;
            color: #4A515B;
            text-align: center;
            border-radius: 4px;
        }

        .secondmenu > li > a:hover {
            background-color: #6f7782;
            border-color: #428bca;
            color: #fff;
        }

        .secondmenu li.active {
            background-color: #6f7782;
            border-color: #428bca;
            border-radius: 4px;
        }

            .secondmenu li.active > a {
                color: #ffffff;
            }

        .navbar-static-top {
            background-color: #212121;
            margin-bottom: 5px;
        }

        .navbar-brand {
           
            display: inline-block;
            vertical-align: middle;
            padding-left: 50px;
            color: #fff;
        }

            .navbar-brand:hover {
                color: #fff;
            }


        .collapse.glyphicon-chevron-toggle, .glyphicon-chevron-toggle:before {
            content: "\e113";
        }

        .collapsed.glyphicon-chevron-toggle:before {
            content: "\e114";
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <a href="#"></a>
          <div class="col-md-2 Noprint">
              <ul id="main-nav" class="main-nav nav nav-tabs nav-stacked" style="max-width:300px;">
                  <li >
                        <a href="#SalesManage" class="nav-header collapsed  " data-toggle="collapse">
                            <i class="glyphicon glyphicon-cog"></i>
                            订单管理
                            
                            <span class="pull-right glyphicon glyphicon-chevron-toggle"></span>
                        </a>
                        <ul id="SalesManage" class="nav nav-list secondmenu collapse" style="height: 0px;">
                            <li id="ProductSales"><a href="../SalesManage/ProductSales.aspx"><i class="glyphicon glyphicon-user"></i>&nbsp;产品销售</a></li>
                            <li id="ProductSalesQuery"><a href="../SalesManage/ProductSalesList.aspx"><i class="glyphicon glyphicon-th-list"></i>&nbsp;产品销售查询</a></li>
                            <li id="FactoryOrder"><a href="../SalesManage/FactoryOrder.aspx"><i class="glyphicon glyphicon-tasks"></i>&nbsp;客户订单查询</a></li>
                            <li id="RelatedOrder"><a href="../SalesManage/RelatedOrder.aspx"><i class="glyphicon glyphicon-edit"></i>&nbsp;关联查询</a></li>
                            <li id="UserTrace"><a href="../SalesManage/UserTrace.aspx"><i class="glyphicon glyphicon-eye-open"></i>&nbsp;用户追踪</a></li>
                        </ul>
                    </li>
                  </ul>
              </div>
    <div style="width:800px; height:400px">
    <iframe src="LineUserShow.aspx" style="border:none;width:100%;height:100%"></iframe>
    </div>
    </form>
</body>
</html>
