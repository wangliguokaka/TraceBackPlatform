<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master" CodeFile="BasicInfo.aspx.cs" Inherits="SystemConfig_BasicInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function ()
        {
            GetDataList();

            //打开窗口
            $('.cd-popup-product').on('click', function (event) {
                $("#Serial").val(-1);
                event.preventDefault();
                $('.cd-popup-add').addClass('is-visible');
            });

            //关闭窗口
            $('.cd-popup-add').on('click', function (event) {
                if ($(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup-add')) {
                    event.preventDefault();
                    $(this).removeClass('is-visible');
                }
            });
            //ESC关闭
            $(document).keyup(function (event) {
                if (event.which == '27') {
                    $('.cd-popup-add').removeClass('is-visible');
                }
            });
        })

        function validateRow(tableID, sliceIndex) {
            var ispass = $.fn.tables.validateRow(tableID, sliceIndex);

            if (!ispass) {
                layer.alert("还有必填项未填写！请继续完善后再保存!");
            }

            return ispass;

        }

        function SaveBase() {
            if (validateRow('girdBase', 0) == false)
            {
                return false;
            }
            var productId = "";
            $("#productTable [type=checkbox]:checked").each(function ()
            {
                productId = productId + ","+$(this).attr("id");
            })
            productId = productId.substr(1,productId.len)
            alert(productId)
            $.ajax({
                type: "post",
                url: "BasicInfo.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "SaveBase", corp: $("#corp").val(), Ecorp: $("#Ecorp").val(), Address: $("#Address").val(), netname: $("#netname").val()
                , Email: $("#Email").val(), fax: $("#fax").val(), LinkMan: $("#LinkMan").val(), phone: $("#phone").val(), ServerIP: $("#ServerIP").val(),
                ProductID: productId
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                    if (data == "0") {
                        layer.msg("保存失败！");
                    }
                    else {
                        $("#Id").val(data);
                        $("#MakeContact").show();
                        layer.msg("保存成功！");
                    }
                }
            });

        }


        function GetDataList() {

            $.ajax({
                type: "post",
                url: "BasicInfo.aspx",
                cache: false,
                async: false,
                data: {
                    "actiontype": "GetProductList"
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法

                    var returnData = $.parseJSON(data);
                    allRowCount = returnData[0].RowCount
                    json = returnData[0].JsonData;
                    $("#productTable tbody").empty();
                    //遍历行结果
                    var line = parseInt(json.length/6);
                    for (var i = 0; i < line; i++) {

                        //遍历行中每一列的key 

                        var trHtml = "<tr><td><input type=\"checkbox\" id =\"" + json[i*6]["id"] + "\">" + json[i*6]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i*6 + 1]["id"] + "\">" + json[i*6 + 1]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i*6 + 2]["id"] + "\">" + json[i*6 + 2]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i*6 + 3]["id"] + "\">" + json[i*6 + 3]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i*6 + 4]["id"] + "\">" + json[i*6 + 4]["itemname"] + "</td>"
                            + "<td><input type=\"checkbox\" id =\"" + json[i*6 + 5]["id"] + "\">" + json[i*6 + 5]["itemname"] + "</td></tr>"

                        $("#productTable tbody").append(trHtml);
                    }
                    var trHtml = "<tr>";
                    for (var i = 0; i < json.length % 6; i++)
                    {
                        trHtml = trHtml + "<td><input type=\"checkbox\" id =\"" + json[line * 6 + i]["id"] + "\">" + json[line * 6 + i]["itemname"] + "</></td>";
                    }
                    trHtml = trHtml+"</tr>";
                    $("#productTable tbody").append(trHtml);
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="box" >
      <div class="title" >基础信息设置</div>
      <div class="divWidth" >
        <table width="100%" id="girdBase" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>
            <td colspan="6" style="text-align:right;">
               <button type="button" class="ui-button" onclick="SaveBase()">保存</button>
              <button type="button" class="ui-button cd-popup-product">产品设置</button>
            </td>
          </tr>
          <tr>
            <td class="pro_tableTd">公司名称</td>
            <td colspan="5"><input type="text" id="corp" class="pro_input required" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">公司英文名称</td>
            <td colspan="5"><input type="text" id="Ecorp" class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">公司地址</td>
            <td colspan="5"><input type="text" id="Address" class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">官方网站</td>
            <td colspan="5"><input type="text" id="netname" class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">电子邮箱</td>
            <td colspan="5"><input type="text" id="Email" class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">传真</td>
            <td colspan="5"><input type="text" id="fax" class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">联系人</td>
            <td colspan="5"><input type="text" id="LinkMan" class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">联系电话</td>
            <td colspan="5"><input type="text" id="phone" class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">服务器内网IP地址</td>
            <td colspan="5"><input type="text" id="ServerIP" class="pro_input" /></td>
          </tr>
         
          <tr>
            <td class="pro_tableTd">简介</td>
            <td colspan="5"><textarea class="pro_textarea"></textarea></td>
          </tr>
          
        </table>   
      </div>
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>
    <div class="cd-popup-add">
    <div class="cd-popup-container"  style=" overflow:auto;height:390px;">
        <div class="box" >
          <div class="title" >新华医疗产品设置</div>
          <div class="divWidth" >
           <table id="productTable" class="pro_table" >
                    <tbody>

                    </tbody>
                </table>
          </div>
          <!--divWidth  end-->
          <div class="clear" ></div>
        </div>
        <!--box  end-->
        <a href="#0" class="cd-popup-close">关闭</a>
    </div>
</div>
    <!--box  end-->
</asp:Content>
