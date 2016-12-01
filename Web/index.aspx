<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master"  CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function ()
        {
            if ($("#main-nav ul li a").length > 0)
            {
       
                var href = "../SalesManage/ProductSalesList.aspx";
                $("#main-nav ul li ").each(function ()
                {
                    if ($(this).css("display") == "block")
                    {
                        href = $(this).find("a").eq(0).attr("href");
                        return false;
                        
                    }
                  
                })
                window.location.href = href;
            }
          
        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
</asp:Content>