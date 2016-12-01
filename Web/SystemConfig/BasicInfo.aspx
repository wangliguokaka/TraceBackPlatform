<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master" CodeFile="BasicInfo.aspx.cs" Inherits="SystemConfig_BasicInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function ()
        {
            GetDataList();

           

            var EditJson = $.parseJSON('<%=EditJson%>');
            $("#corp").val(EditJson["corp"]);
            $("#Ecorp").val(EditJson["Ecorp"]);
            $("#Address").val(EditJson["Address"]);
            $("#netname").val(EditJson["netname"]);
            $("#Email").val(EditJson["Email"]);
            $("#LinkMan").val(EditJson["LinkMan"]);
            $("#phone").val(EditJson["phone"]);
            $("#fax").val(EditJson["fax"]);
            $("#ServerIP").val(EditJson["ServerIP"]);
            if (EditJson["ProductID"] != null) {
               
                $.each(EditJson["ProductID"].split(','), function (n, value) {
                    $("#" + value).attr("checked", "checked");
                });
            }
            
            $("#RoleA").html($("#template").html())
            $("#RoleB").html($("#template").html())
            $("#RoleC").html($("#template").html())
            $("#RoleD").html($("#template").html())

            $("#SettingModal input[type=checkbox]").on("click", function () {
                $(this).attr("checked") == "checked" ? $("#" + $(this).parents("div").attr("id") + " input[name*=" + $(this).val() + "]").attr("checked", "checked") : $("#" + $(this).parents("div").attr("id") + " input[name*=" + $(this).val() + "]").removeAttr("checked");
         
                if ($(this).parents("div").eq(0).find("input[class=" + $(this).attr("class") + "]").length <= $(this).parents("div").eq(0).find("input[class=" + $(this).attr("class") + "]:checked").length + 1)
                {
                  
                   $(this).parents("div").find("." + $(this).attr("class")).eq(0).attr("checked", "checked");
                }                
                if ($(this).parents("div").eq(0).find("input[class=" + $(this).attr("class") + "]").eq(0).attr("checked") == "checked" && $(this).parents("div").eq(0).find("input[class=" + $(this).attr("class") + "]").length > $(this).parents("div").eq(0).find("input[class=" + $(this).attr("class") + "]:checked").length) {
                   // alert($(this).parents("div").eq(0).find("input[class=" + $(this).attr("class") + "]:checked").length)
                    $(this).parents("div").find("." + $(this).attr("class")).eq(0).removeAttr("checked");
                }

            })

            if (EditJson["RoleA"] != null) {

                $.each(EditJson["RoleA"].split(':'), function (n, value) {
                    $("#RoleA input[value=" + value+"]").attr("checked", "checked");
                });
            }

            if (EditJson["RoleB"] != null) {

                $.each(EditJson["RoleB"].split(':'), function (n, value) {
                    $("#RoleB input[value=" + value + "]").attr("checked", "checked");
                });
            }

            if (EditJson["RoleC"] != null) {

                $.each(EditJson["RoleC"].split(':'), function (n, value) {
                    $("#RoleC input[value=" + value + "]").attr("checked", "checked");
                });
            }

            if (EditJson["RoleD"] != null) {

                $.each(EditJson["RoleD"].split(':'), function (n, value) {
                    $("#RoleD input[value=" + value + "]").attr("checked", "checked");
                });
            }
            
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
            productId = productId.substr(1,productId.length)

           
            var AcheckID = "";
            $("#RoleA input[type=checkbox]:checked").each(function () {
                AcheckID = AcheckID + ":" + $(this).val()
            })
            var BcheckID = "";
            $("#RoleB input[type=checkbox]:checked").each(function () {
                BcheckID = BcheckID + ":" + $(this).val()
            })
            var CcheckID = "";
            $("#RoleC input[type=checkbox]:checked").each(function () {
                CcheckID = CcheckID + ":" + $(this).val()
            })
            var DcheckID = "";
            $("#RoleD input[type=checkbox]:checked").each(function () {
                DcheckID = DcheckID + ":" + $(this).val()
            })

            $.ajax({
                type: "post",
                url: "BasicInfo.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "SaveBase", corp: $("#corp").val(), Ecorp: $("#Ecorp").val(), Address: $("#Address").val(), netname: $("#netname").val()
                , Email: $("#Email").val(), fax: $("#fax").val(), LinkMan: $("#LinkMan").val(), phone: $("#phone").val(), ServerIP: $("#ServerIP").val(),
                ProductID: productId, "RoleA": AcheckID, "RoleB": BcheckID, "RoleC": CcheckID, "RoleD": DcheckID
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
       
        var deleteDialogIndex = 0;
        function DeleteHistory()
        {
            layer.open({
                  title:"历史数据删除",
                  type: 1,
                  skin: 'layui-layer-rim', //加上边框
                  area: ['360px', '200px'], //宽高
                  content: '<div style="width:80%;margin:auto;"><div style="margin:15px;"><button type="button" class="ui-button" onclick="DeleteHisData()">删除</button></div>'
                      + '<div style="margin:15px;">开始日期：<input type="text"  id="StartDate" readonly="readonly" style="width:160px;"  class="detepickers pro_input1 required" /> </div>'
                      + '<div style="margin:15px;">结束日期：<input type="text" id="EndDate"  readonly="readonly"  style="width:160px;" class="detepickers pro_input1 required" /></div></div>'
            });

            deleteDialogIndex = layer.index ;

        }

        function DeleteHisData()
        {
            var startDate = $("#StartDate").val();
            var endDate = $("#EndDate").val();
            if (startDate == "")
            {
                layer.msg("开始日期不能为空");
                return;
            }

            if (endDate == "") {
                layer.msg("结束日期不能为空");
                return;
            }

            $.ajax({
                type: "post",
                url: "BasicInfo.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "DeleteHisData", "startDate": startDate, "endDate": endDate
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                    if (data == "0") {
                        layer.msg("删除失败！");
                    }
                    else {
                        layer.msg("删除成功！");
                        layer.close(deleteDialogIndex);
                    }
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
              
            </td>
          </tr>
           
            <tr>
                <td class="pro_tableTd" colspan="6">
                    <hr style="margin:10px 0px;" />
                    <button type="button" class="ui-button cd-popup-product">产品设置</button>
                    <button type="button" class="ui-button" data-toggle="modal" data-target="#SettingModal">权限设置</button>
                    <button type="button" class="ui-button" onclick="DeleteHistory();">删除历史</button>
                </td>
            </tr>
          <tr>
            <td class="pro_tableTd">公司名称<span class="red" >*</span></td>
            <td colspan="5"><input type="text" id="corp" maxlength="50" class="pro_input required" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">公司英文名称</td>
            <td colspan="5"><input type="text" id="Ecorp" maxlength="50"  class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">公司地址</td>
            <td colspan="5"><input type="text" id="Address" maxlength="50"  class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">官方网站</td>
            <td colspan="5"><input type="text" id="netname" maxlength="50"  class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">电子邮箱</td>
            <td colspan="5"><input type="text" id="Email" maxlength="50"  class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">传真</td>
            <td colspan="5"><input type="text" id="fax" maxlength="50"  class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">联系人</td>
            <td colspan="5"><input type="text" id="LinkMan" maxlength="50"  class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">联系电话</td>
            <td colspan="5"><input type="text" id="phone" maxlength="50"  class="pro_input" /></td>
          </tr>
          <tr>
            <td class="pro_tableTd">服务器内网IP地址</td>
            <td colspan="5"><input type="text" id="ServerIP" maxlength="50"  class="pro_input" /></td>
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
    
    
    <div class="modal fade" id="SettingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">权限设置</h4>
                </div>
                <div class="modal-body">
                    <ul id="myTab" class="nav nav-tabs">
	                    <li class="active"><a href="#RoleA" data-toggle="tab">经销商</a></li>
	                    <li><a href="#RoleB" data-toggle="tab">加工厂</a></li>
	                    <li><a href="#RoleC" data-toggle="tab">本公司员工</a></li>
                        <li><a href="#RoleD" data-toggle="tab">本公司文员</a></li>
                    </ul>
                    <div id="myTabContent" class="tab-content">
	                    <div class="tab-pane  in active" id="RoleA">
	                    </div>
	                    <div class="tab-pane " id="RoleB">		 
	                    </div>
	                    <div class="tab-pane " id="RoleC">
	                    </div>
	                    <div class="tab-pane " id="RoleD">
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="template" style="display:none;">
         <table  style="width:80%; margin-left:100px;">
                <tr style="height:30px;"><td style="width:30px;"><input type="checkbox" name="SaleManage"class="Sales"   value="SaleManage" /><span class="folder-open"></span>订单管理</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="Sales"  name="SaleManageProductSales" value="ProductSales" /><span class="folder-open"></span>产品销售</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="Sales"  name="SaleManageProductSaleList" value="ProductSalesList" /><span class="folder-open"></span>产品销售查询</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="Sales"  name="SaleManageProductFactoryOrder" value="FactoryOrder" /><span class="folder-open"></span>加工厂订单查询</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="Sales"  name="SaleManageFactoryExportExcel" value="FactoryExportExcel" /><span class="folder-open"></span>数据导入</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="Sales"  name="SaleManageProductRelatedOrder" value="RelatedOrder" /><span class="folder-open"></span>订单关联查询</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="Sales"  name="SaleManageUserTrace" value="UserTrace" /><span class="folder-open"></span>患者查询跟踪</td></tr>

                <tr style="height:30px;"><td style="width:30px;"><input type="checkbox" class="System"   value="SystemSetting" name="SystemSetting" /><span class="folder-open"></span>系统设置</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="System"  name="SystemSettingDictManagement" value="DictManagement"/><span class="folder-open"></span>数据字段</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="System"  name="SystemSettingSpecManage" value="SpecManage"/><span class="folder-open"></span>规格型号维护</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="System"  name="SystemSettingCustomerManage" value="CustomerManage"/><span class="folder-open"></span>客户管理</td></tr>
                <tr style="height:30px;"><td style="width:30px;"><span class="folder-line"></span><input type="checkbox" class="System"  name="SystemSettingBasicInfo" value="BasicInfo"/><span class="folder-open"></span>基础信息</td></tr>
            </table>
    </div>
    <!--box  end-->
</asp:Content>
