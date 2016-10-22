<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DBTableManagement.aspx.cs" Inherits="DBTableManagement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>查询界面</title>
    <link type="text/css" rel="Stylesheet" href="Css/select.css" />
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <!--搜索框开始-->
    <div class="search">
        <div class="searchcontent">
            <asp:Label ID="SelectNameLabel" runat="server" Text="姓名："></asp:Label>
            <asp:TextBox ID="SelectName" runat="server"></asp:TextBox>
        </div>
        <asp:Button ID="SelectButton" runat="server" Text="查询" CssClass="searchbutton" OnClick="SelectButton_Click" />

        <asp:Button ID="Add" runat="server" Text="新增客户" CssClass="searchbutton" OnClick="AddButton_Click" />
    </div>
    <!--搜索框结束-->
    <!--列表开始-->
    <div>
        <asp:GridView ID="UserSelectGridView" runat="server" CssClass="gridView" AutoGenerateColumns="False"
            BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
            CellPadding="15" EnableModelValidation="True" GridLines="Horizontal" AllowPaging="true" PageSize="4" AllowSorting="true" >
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <pagersettings mode="Numeric" position="Bottom" pagebuttoncount="10"/>                     
            <pagerstyle backcolor="LightBlue" height="30px" verticalalign="Bottom" horizontalalign="Center"/>

            <Columns>
                <asp:TemplateField HeaderText="类型" HeaderStyle-HorizontalAlign="Center" SortExpression="Name">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("class")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="序号" HeaderStyle-HorizontalAlign="Center" SortExpression="Sex">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("Serial")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="客户" HeaderStyle-HorizontalAlign="Center" SortExpression="Permission">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("Client")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="手机号码" HeaderStyle-HorizontalAlign="Center" SortExpression="Telephone">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("Tel")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="固定号码" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("Tel2")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="国家" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("Country")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="省份" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("province")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="城市" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("city")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="地址" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("addr")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("Email")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="用户名" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("UserName")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="密码" HeaderStyle-HorizontalAlign="Center" SortExpression="Email">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <%#Eval("Passwd")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="操作">
                    <ItemTemplate>
                        <asp:HiddenField ID="selectclientid" runat="server" Value='<%#Eval("Id")%>' />
                        <asp:Button ID="UpdateButton" runat="server" Text="修改" OnClick="UpdateButton_Click" ></asp:Button>
                        <asp:LinkButton ID="DeleteLinkButton" runat="server" OnClick="DeleteButton_Click" OnClientClick='javascript:return confirm("确定删除嘛？")'>删除信息</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        </asp:GridView>
    </div>
    <!--列表开始-->
    </form>
</body>
</html>

