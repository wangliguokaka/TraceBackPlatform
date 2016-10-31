<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddClient.aspx.cs" Inherits="Addpage_AddClient" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <link type="text/css" rel="Stylesheet" href="../Css/add.css" />
</head>
<body>
<form id="form1" runat="server">
    <!--整体开始-->
    <div id="all">
        <!--left开始-->
        <div id="left">
        </div>
        <!--left结束-->
        <!--middle开始-->
        <div id="middle">
            <!--middle top开始-->
            <div id="top">
            </div>
            <!--middle top结束-->
            <!--middle content开始-->
            <div id="content">
                <!--middle content username开始-->
                <div id="textleft">
                </div>
                <div id="texttop">
                </div>
                <div class="textcontent">
                    <asp:Label ID="ClassLabel" runat="server" Text="类型:"></asp:Label>
                    <asp:TextBox ID="Class" runat="server"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="SerialLabel" runat="server" Text="序号:"></asp:Label>
                    <asp:TextBox ID="Serial" runat="server" > </asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="ClientLabel" runat="server" Text="客户:"></asp:Label>
                    <asp:TextBox ID="Client" runat="server"> </asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="TelLabel" runat="server" Text="手机号码:"></asp:Label>
                    <asp:TextBox ID="Tel" runat="server"> </asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="Tel2Label" runat="server" Text="固定号码:"></asp:Label>
                    <asp:TextBox ID="Tel2" runat="server"> </asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="CountryLabel" runat="server" Text="国家:"></asp:Label>
                    <asp:TextBox ID="Country" runat="server"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="ProvinceLabel" runat="server" Text="省份:"></asp:Label>
                    <asp:TextBox ID="Province" runat="server"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="CityLabel" runat="server" Text="城市:"></asp:Label>
                    <asp:TextBox ID="City" runat="server"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="AddrLabel" runat="server" Text="地址:"></asp:Label>
                    <asp:TextBox ID="Addr" runat="server"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="EmailLabel" runat="server" Text="Email:"></asp:Label>
                    <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="UserNameLabel" runat="server" Text="用户名:"></asp:Label>
                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Label ID="PasswdLabel" runat="server" Text="密码:"></asp:Label>
                    <asp:TextBox ID="Passwd" runat="server"  TextMode="Password"></asp:TextBox>
                </div>
                <div class="textcontent">
                    <asp:Button ID="Submit" runat="server" Text="提交" OnClick="Submit_Click" />
                    <asp:Button ID="Reset" runat="server" Text="重 置" OnClick="Reset_Click" />
                </div>
            </div>
            <!--middle content结束-->
            <!--middle footer开始-->
            <div id="footer">
            </div>
            <!--middle footer结束-->
        </div>
        <!--middle结束-->
        <!--right开始-->
        <div id="right">
        </div>
        <!--right结束-->
    <!--整体结束-->
     </div>
    </form>
</body>
</html>
