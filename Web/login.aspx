<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>新华医疗登录页面</title>
<link type="text/css" rel="stylesheet" href="css/style.css" >
<link href="/Css/layer.css" rel="stylesheet" />
<script src="jQuery/jquery-1.10.2.js" type="text/javascript"></script>
<script type="text/javascript" src="/Scripts/layer.js"></script>


<style >
html,body{
	background:#dfe1e0 ;
	height:100%;
    margin:0px;
	}
</style>
    <script type="text/javascript">
        function refreshcode() {
            document.getElementById("validCode").src = "Handler/ValidateCode.ashx?k=" + Math.random();
        }

        $(function () {
            refreshcode();
        })
        function CheckLogin()
        {
            if ($("#username").val() == "")
            {
                layer.msg("用户名不能为空", { time: 800 });
                return false;
            }

            if ($("#password").val() == "") {
                layer.msg("密码不能为空", { time: 800 });
                return false;
            }

            if ($("#txtimgcode").val() == "") {
                layer.msg("验证码不能为空", { time: 800 });
                return false;
            }
        var ischecked = false;
            $.ajax({
                
                url: "login.aspx?action=checkcode&checkcode=" + encodeURIComponent($("#txtimgcode").val()) + "&k=" + Math.random(),
                async: false,
                success: function (data) {
                    if (data == "1") {
                        ischecked = true;
                    }
                    else {
                       layer.msg("验证码输入有误", { time: 800 });
                        ischecked = false;
                    }
                }
            
            })
            return ischecked;
            
        }

        if (document.addEventListener) {   
            document.addEventListener("keypress", fireFoxHandler, true);

        } else {
            document.attachEvent("onkeypress", ieHandler);
        }

        function fireFoxHandler(evt) {
            if (evt.keyCode == 13) {
                $("#loginBtn").click();
            }
        }

        function ieHandler(evt) {
            if (evt.keyCode == 13) {

                $("#loginBtn").click();

            }
        }
    </script>
</head>

<body>
 <form runat="server">
<div class="login" >
  <div class="login_title" >用户登录</div>
  <ul class="login_ul" >
    <li class="login_li" ><span class="login_name" >用户名：</span><input type="text" name="username" id="username" class="login_input" ></li>
    <li class="login_li" ><span class="login_name" >密码：</span><input type="password" name="password" id="password" class="login_input" ></li>
    <li class="login_li login_li1" ><span class="login_name" >验证码：</span><input type="text" id="txtimgcode" class="login_input" ><img  id="validCode" alt="" ><a href="javascript:void(0);" onclick="refreshcode();" >换一张</a></li>
    <li class="login_li2" >  <asp:Button ID="loginBtn" runat="server" OnClientClick="return CheckLogin()"  CssClass="login_btn" Text="登录" OnClick="loginBtn_Click" /></li>
  </ul>
  <div class="clear" ></div>
</div>
<div class="footer" style="background-color:rgb(1,138,218)">
    <div style="text-align:center; vertical-align:middle; margin-top:15px;">
            版权所有：山东新华医疗器械股份有限公司　　ICP备案号：鲁ICP备07005707号-1　互联网药品信息服务资格证书编号：（鲁）-非经营性-2016-0001
    </div>
</div>
  </form>
</body>
</html>
