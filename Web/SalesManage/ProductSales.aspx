﻿<%@ Page Language="C#" MasterPageFile="~/App_Master/Master.master" AutoEventWireup="true" CodeFile="ProductSales.aspx.cs" Inherits="SalesManage_ProductSales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
        var detailCount = 0;

        var arrayCheck = new Array();

        function CheckDetail(obj,SerialIndex)
        {
            arrayCheck = new Array();
            $("#gridDetail tbody input[type='checkbox']:checked").each(function ()
            {
              
                arrayCheck.push($(this).val());
            })
           
            if ($(obj).attr("checked") == "checked")
            {
                $("#Serial").val(SerialIndex);
                arrSelect = $.map(json, function (value) {
                    return value.Serial == SerialIndex ? value : null;//isNaN:is Not a Number的缩写 
                }
                );
                $.each(arrSelect[0], function (i, n) {
                    $("#" + i).val(arrSelect[0][i]);
                });
            }          

        }
        var arrSelect = null;
        function SelectAll(obj)
        {
            $("#gridDetail tbody input[type='checkbox']").each(function () {

                $(obj).attr("checked") == "checked"?$(this).attr("checked", "checked"):$(this).removeAttr("checked");
            })

            arrayCheck = new Array();
            $("#gridDetail tbody input[type='checkbox']:checked").each(function () {

                arrayCheck.push($(this).val());
                CheckDetail(obj, $(this).val());
            })
        }

        function DeleteDetail()
        {
            if (arrayCheck.length == 0)
            {
                layer.msg("请选择要删除的记录");
                return false;
            }
            $(arrayCheck).each(function (i, n) {
                var index = json.map(function (d) { return d['Serial']; }).indexOf(n);
                json.splice(index, 1);
                $.ajax({
                    type: "post",
                    url: "ProductSales.aspx",
                    cache: false,
                    async: false,
                    data: {
                        actiontype: "DeleteCardNo", NoStart: $("#NoStart").val(), NoEnd: $("#NoEnd").val()
                    },
                    dataType: "text",
                    success: function (data) {
                    }
                });
            })
            
            BindGrid();
        }

        function SaveOrderDetail()
        {
           
            if (CompareCardNo() == false) {
                return false;
            }
            if (validateRow('gridLayer', 0) == false) {
                return false;
            }

            var CardPass = true;
            $.ajax({
                type: "post",
                url: "ProductSales.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "ValidCardNo", NoStart: $("#NoStart").val(), NoEnd: $("#NoEnd").val(), Id: $("#Id").val(), Serial: $("#Serial").val(), DetailCount: detailCount+1
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                   
                        CardPass = data == "0";
               
                 
                }
            });

            if (CardPass == false)
            {
                layer.msg("防伪卡号已经被占用")
                return false;
            }

           

            if ($("#Serial").val() == "-1") {
                detailCount = detailCount + 1;
                $("#Serial").val(detailCount);

                $.each(arr, function (i, n) {
                    arr[i] = $("#" + i).val();
                });
                $("#Serial").val("-1");
                json.push($.extend(true, {}, arr))
            }
            else {
                var arrEdit = $.map(json, function (value) {
                    return value.Serial == $("#Serial").val() ? value : null;//isNaN:is Not a Number的缩写 
                }
                );
                $.each(arrEdit[0], function (i, n) {
                    arrEdit[0][i] = $("#" + i).val();
                });
            }
            BindGrid();
            if ($("#Serial").val() == -1) {
            } else {
                $('.cd-popup-add').removeClass('is-visible');

            }
            layer.msg("已保存,请注意修改防伪卡号");
        }
       
        function BindGrid()
        {
            arrayCheck = new Array();
            $("#gridDetail tbody").empty();
            var trHtml = $("#gridDetail tbody").find("tr").eq(0).html();
            //遍历行结果
            for (var i = 0; i < json.length; i++) {
                //var trnum = $("#" + gridId + " tbody").find("tr").slice(0).length - 1;
                //if (i > trnum) {


                //遍历行中每一列的key 

                var trHtml = "<tr><td><input type=\"checkbox\" class=\"pro_checkbox\" onclick=\"CheckDetail(this," + json[i]["Serial"] + ")\" value=\"" + json[i]["Serial"] + "\" /></td><td>" + json[i]["Bh"] + "</td><td>" + json[i]["orderid"] + "</td><td>" + json[i]["Qty"] + "</td><td>" + json[i]["NoStart"] + "</td><td>" + json[i]["NoEnd"] + "</td><td>" + (json[i]["NoQty"] == null ? "" : json[i]["NoQty"]) + "</td></tr>";

                $("#gridDetail tbody").append(trHtml);
            }
        }

        function SaveSales()
        {
           

            if (validateRow('girdSales', 0) == false)
            {
                return false;
            }
            if (json.length == 0)
            {
                layer.msg("订单销售明细不能为空！");
                return false;
            }
            $.ajax({
                type: "post",
                url: "ProductSales.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "SaveSales", Id: $("#Id").val(), SaleDate: $("#SaleDate").val(), Seller: $("#Seller").val(), Salesperson: $("#Salesperson").val()
                , BillDate: $("#BillDate").val(), BillNo: $("#BillNo").val(), BillClass: $("#BillClass").val(), Addr: $("#Addr").val(), Receiver: $("#Receiver").val()
                    , Tel: $("#Tel").val(), Distri: $("#Distri").val(), DistriNo: $("#DistriNo").val(), SalesDetail: JSON.stringify(json)
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                    if (data == "0")
                    {
                        layer.msg("保存失败！");
                    }
                    else
                    {
                        $("#Id").val(data);
                        $("#MakeContact").show();
                        layer.msg("保存成功！");
                    }
                }
            });
            
        }

       

        function MakeContactFun()
        {
           
            //    $('.cd-popup-contact').addClass('is-visible');
            window.open("GenerateContract.aspx?orderid="+$("#Id").val());
        }

        

        $(function ()
        {
            $(".cd-popup-container").draggable();
            var userClass = "<%=LoginUser.Class%>"
            if (userClass == "S" || userClass == "C" || userClass == "D") {
                if (userClass == "D")
                {
                    $(".SalesTR").find("input").attr("disabled", "disabled")
                    $(".SalesTR").find("input").css("background-color", "white").css("border-style", "none");
                }
                //
                $("button").show();
                $("#MakeContact").hide();
            }
            else {
                $("button").hide();
                $("#OrderDetail").show();
                $("#OrderDetail").text("查看详细");
               // $("#girdSales input,select").attr("disabled", "disabled")
            }
            if ('<%=Request["Id"]%>' == '') {
            }
            else {
                var EditJson = $.parseJSON('<%=EditJson%>');
                $("#Id").val(EditJson["Id"]);
                $("#Seller").val(EditJson["Seller"]);
                $("#Salesperson").val(EditJson["Salesperson"]);
                $("#SaleDate").val(EditJson["SaleDate"]);
                $("#BillNo").val(EditJson["BillNo"]);
                $("#BillDate").val(EditJson["BillDate"]);
                $("#BillClass").val(EditJson["BillClass"]);
                $("#Addr").val(EditJson["Addr"]);
                $("#Receiver").val(EditJson["Receiver"]);
                $("#Tel").val(EditJson["Tel"]);
                $("#Distri").val(EditJson["Distri"]);
                $("#DistriNo").val(EditJson["DistriNo"]);
                json = EditJson.DetailJson;
                detailCount = json.length;
                BindGrid();
            }

            if ($("#Id").val() != "") {
                $("#MakeContact").show();
            }

            //关闭窗口
            $('.cd-popup-contact').on('click', function (event) {
                if ($(event.target).is('.cd-popup-close')) {
                    event.preventDefault();
                    $(this).removeClass('is-visible');
                }
            });

            $(".detepickers").attr("readonly", "readonly");
            //打开窗口
            $('.cd-popup-addbtn').on('click', function (event) {
                $("#Serial").val(-1);
                $(".cd-popup-container input").val("");
                $.ajax({
                    type: "post",
                    url: "ProductSales.aspx",
                    cache: false,
                    async: false,
                    data: {
                        actiontype: "GetMaxCardNo"
                    },
                    dataType: "text",
                    success: function (data) {
                        if (data.length > 8) {
                            layer.msg("防伪卡号已经使用到最大值");
                        }
                        else {
                            $("#NoStart").val(data);
                            $("#NoEnd").val(data);
                            $("#NoQty").val(1);
                        }
                        
                    }
                });
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

            //打开窗口
            $('.cd-popup-editbtn').on('click', function (event) {
                if (arrayCheck.length == 0)
                {
                    layer.msg("请选择订单进行操作！");
                    return false;
                }
                else if (arrayCheck.length > 1)
                {
                    layer.msg("只能选择一条订单进行操作！");
                    return false;
                }
                
                event.preventDefault();
                if (arrSelect != null && arrSelect.length > 0) {
                    $.each(arrSelect[0], function (i, n) {
                        $("#" + i).val(arrSelect[0][i]);
                    });
                }
                $('.cd-popup-add').addClass('is-visible');
            });
            //关闭窗口
            $('.cd-popup-add').on('click', function (event) {
                if ($(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup-edit')) {
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
            

            $("#orderid").blur(function ()
            {
                var arrOrderSelect = $.map(test_list, function (value) {
                    return value.OrderNo == $("#orderid").val() ? value : null;//isNaN:is Not a Number的缩写 
                }
              );
                if (arrOrderSelect.length > 0) {
                    $("#Bh").val(arrOrderSelect[0].Bh);
                }
                else {
                    $("#Bh").val("");
                }
            })

            old_value = $("#orderid").val();
            var test_list = $.parseJSON('<%=OrderJson%>');

            BindAutoCompleteEvent("orderid", "auto_div", test_list)
        })
        
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div  >
        <input type="hidden" id="Id" />
        <input type="hidden" id="Serial" value="-1" />
        <div class="box" >
          <div class="title" >销售信息</div>
          <div class="divWidth" >
            <table width="100%" id="girdSales"  border="0" cellspacing="0" cellpadding="0" class="pro_table">
              <tr>
                <td class="pro_tableTd">客户<span class="red" >*</span></td>
                <td><select class="pro_select" id="Seller" >
                    <%foreach(ModelClient model in listSeler){ %>
                        <option value="<%=model.Serial %>" ><%=model.Client %></option>
                    <%} %>
                    </select></td>   
                <td class="pro_tableTd">发货日期</td>
                <td><input type="text" id="SaleDate"  class="detepickers pro_input" /></td>
                <td class="pro_tableTd">业务员</td>
                <td><input type="text" id="Salesperson" maxlength="50"  class="pro_input" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">发票号</td>
                <td><input type="text" id="BillNo" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">发票类型</td>
                <td><select class="pro_select" id="BillClass" >
                    <%foreach(ModelDictDetail model in listDictType){ %>
                        <option value="<%=model.Code %>" ><%=model.DictName %></option>
                    <%} %>
                    </select></td>
                <td class="pro_tableTd">开票日期</td>
                <td><input type="text" id="BillDate" class="detepickers pro_input" /></td>
              </tr>
             
              <tr>
                <td class="pro_tableTd">联系人</td>
                <td><input type="text" id="Receiver" maxlength="20"  class="pro_input" /></td>
                <td class="pro_tableTd">联系电话</td>
                <td><input type="text" id="Tel" maxlength="50"  class="pro_input number" /></td>
                <td class="pro_tableTd">货运公司</td>
                <td><input type="text" id="Distri" maxlength="100"  class="pro_input" /></td>
              </tr>
                 <tr>
                <td class="pro_tableTd">货运单号</td>
                <td><input type="text" id="DistriNo" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">收货单位地址</td>
                <td colspan="3"><input id="Addr" maxlength="100"  type="text" class="pro_input" /></td>
              </tr>
              <tr>
                <td colspan="6" style="text-align:right;">
                    <button class="ui-button" type="button" onclick="SaveSales()">保存</button>
                    <button type="button" class="ui-button cd-popup-addbtn">新增订单</button>
                    <button type="button" id="OrderDetail" class="ui-button cd-popup-editbtn">编辑订单</button>
                    <button type="button" class="ui-button" onclick="DeleteDetail()">删除订单</button>
                    <button type="button" id="MakeContact" style="display:none;" class="ui-button" onclick="MakeContactFun()">生成合同</button>
                </td>
              </tr>
            </table>   
          </div>
          <!--divWidth  end-->
          <div class="clear" ></div>
        </div>
        <!--box  end-->
        <%--<div class="save" ><button class="ui-button">保存</button></div>--%>
        <div class="divWidth1" >
          <div class="divTable" >
            <table style="width:100%;" border="0" id="gridDetail"  class="pro_table1">
              <thead>
                    <tr>
                        <th><input type="checkbox"  class="pro_checkbox" onclick="SelectAll(this)" /></th>
                        <th>存货编码</th>
                        <th>订货号</th>
                        <th>销售数量</th>
                        <th>防伪卡开始号</th>
                        <th>防伪卡结束号</th>
                        <th>防伪卡数量</th>
                    </tr>
                </thead>
              
              <tbody>

              </tbody>
                    
            </table>
          </div>      
      <!--pager  end-->
    </div>
    <div class="clear" ></div>
  </div>
  <div class="cd-popup-contact" >
      <div class="cd-popup-container-contact">
          
          <div class="box" >
              <div class="title" >合同管理</div>
              <div style="width:950px; height:500px;">
                    <%--<iframe src="GenerateContract.aspx?orderid=<%="42" %>" width="950"  style="width:90%; height:90%; border:none;"></iframe>--%>

              </div>
          </div>
            <a href="#0" class="cd-popup-close">关闭</a>
      </div>
 </div>
  <div class="cd-popup-add">
    <div class="cd-popup-container" style="height:268px;">
        <div class="box" >
          <div class="title" >订单详细</div>
          <div class="divWidth"  style="overflow:auto;" >
            <table width="100%" id="gridLayer" border="0" cellspacing="0" cellpadding="0" class="pro_table">
              <tr class="SalesTR">
                <td class="pro_tableTd">订货号<span class="red" >*</span></td>
                <td><div class="search"><input type="text" id="orderid" maxlength="50"  class="pro_input required" /><div id="auto_div" style="height:150px;" class="auto_div"></div></div></td>
                <td class="pro_tableTd">存货编码<span class="red" >*</span></td>
                <td><input type="text" id="Bh" value="" maxlength="50"   class="pro_input required" /></td>
                <td class="pro_tableTd">销售数量<span class="red" >*</span></td>
                <td><input type="text" id="Qty" maxlength="10" class="pro_input required number" /></td>
              </tr>
              <tr class="SalesTR">               
                <td class="pro_tableTd">防伪卡开始号<span class="red" >*</span></td>
                <td><input type="text" id="NoStart"   class="pro_input required number CardNoStart" /></td>
                  <td class="pro_tableTd">防伪卡结束号<span class="red" >*</span></td>
                <td><input type="text" id="NoEnd"    class="pro_input required number CardNoEnd" /></td>
                 <td class="pro_tableTd">防伪卡数量<span class="red" >*</span></td>
                <td><input type="text" id="NoQty" maxlength="10"  class="pro_input required number" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">生产批号</td>
                <td><input type="text" id="BatchNo" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">生产日期</td>
                <td><input type="text" id="ProdDate" class="detepickers pro_input" /></td>
                <td class="pro_tableTd">检验日期</td>
                <td><input type="text" id="TestDate" class="detepickers pro_input" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">材料类型</td>
                <td><select class="pro_select" id="OClass" >
                    <%foreach(ModelDictDetail model in listClassType){ %>
                        <option value="<%=model.Code %>" ><%=model.DictName %></option>
                    <%} %>
                    </select></td>
                <td class="pro_tableTd">材料批号</td>
                <td><input type="text" id="ObatchNo" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">批次数量</td>
                <td><input type="text" id="BtQty" maxlength="10"  class="pro_input number" /></td>
               
              </tr>
              <tr>
                <td class="pro_tableTd">收缩比</td>
                <td><input type="text" id="SRate" maxlength="10"  class="pro_input decimal" /></td>
                <td class="pro_tableTd">有效期</td>
                <td><input type="text" id="Valid" class="pro_input" /></td>
               <td colspan="2">&nbsp;</td>
              </tr>
             
              <tr>
                <td colspan="6" style="text-align:right;">
                  <button type="button" onclick="SaveOrderDetail()" class="ui-button">保存</button>
                </td>
              </tr>
            </table>   
          </div>
          <!--divWidth  end-->
          <div class="clear" ></div>
        </div>
        <!--box  end-->
        <a href="#0" class="cd-popup-close">关闭</a>
    </div>
</div>
</asp:Content>
