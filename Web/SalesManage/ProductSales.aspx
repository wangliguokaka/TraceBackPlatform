<%@ Page Language="C#" MasterPageFile="~/App_Master/Master.master" AutoEventWireup="true" CodeFile="ProductSales.aspx.cs" Inherits="SalesManage_ProductSales" %>

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
                var arrSelect = $.map(json, function (value) {
                    return value.Serial == SerialIndex ? value : null;//isNaN:is Not a Number的缩写 
                }
                );
                $.each(arrSelect[0], function (i, n) {
                    $("#" + i).val(arrSelect[0][i]);
                });
            }          

        }

        function SelectAll(obj)
        {
            $("#gridDetail tbody input[type='checkbox']").each(function () {

                $(obj).attr("checked") == "checked"?$(this).attr("checked", "checked"):$(this).removeAttr("checked");
            })

            arrayCheck = new Array();
            $("#gridDetail tbody input[type='checkbox']:checked").each(function () {

                arrayCheck.push($(this).val());
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
            })
            
            BindGrid();
        }

        function SaveOrderDetail()
        {
            if (validateRow('gridLayer', 0) == false) {
                return false;
            }
            if ($("#Serial").val() == "-1") {
                detailCount = detailCount + 1;
                $("#Serial").val(detailCount);

                $.each(arr, function (i, n) {
                    arr[i] = $("#" + i).val();
                });

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
            $('.cd-popup-add').removeClass('is-visible');
            
        }
       
        function BindGrid()
        {
            $("#gridDetail tbody").empty();
            var trHtml = $("#gridDetail tbody").find("tr").eq(0).html();
            //遍历行结果
            for (var i = 0; i < json.length; i++) {
                //var trnum = $("#" + gridId + " tbody").find("tr").slice(0).length - 1;
                //if (i > trnum) {


                //遍历行中每一列的key 

                var trHtml = "<tr><td><input type=\"checkbox\" class=\"pro_checkbox\" onclick=\"CheckDetail(this," + json[i]["Serial"] + ")\" value=\"" + json[i]["Serial"] + "\" /></td><td>" + json[i]["Bh"] + "</td><td>" + json[i]["orderid"] + "</td><td>" + json[i]["Qty"] + "</td><td>" + json[i]["OClass"] + "</td><td>" + json[i]["BatchNo"] + "</td><td>" + json[i]["ProdDate"] + "</td></tr>";

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
                , BillDate: $("#BillDate").val(), BillNo: $("#BillNo").val(), BillClass: $("#BillClass").val(), SalesDetail: JSON.stringify(json)
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
                        layer.msg("保存成功！");
                    }
                }
            });
            
        }

        function validateRow(tableID, sliceIndex) {
            var ispass = $.fn.tables.validateRow(tableID, sliceIndex);

            if (!ispass) {
                layer.alert("还有必填项未填写！请继续完善后再保存!");
            }

            return ispass;

        }

        function MakeContact()
        {
           
            //    $('.cd-popup-contact').addClass('is-visible');
            window.open("GenerateContract.aspx?orderid=<%="42" %>");
        }

        

        $(function ()
        {
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
                json = EditJson.DetailJson;
                BindGrid();
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
                    layer.msg("请选择订单进行编辑！");
                    return false;
                }
                else if (arrayCheck.length > 1)
                {
                    layer.msg("只能选择一条订单进行编辑！");
                    return false;
                }
                event.preventDefault();
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
            old_value = $("#orderid").val();
            $("#orderid").focus(function () {
                if ($("#orderid").val() == "") {
                    AutoComplete("auto_div", "orderid", test_list);
                }
            });

            var test_list = [{ name: "小张", Bh: "xiaozhang" }, { name: "小王", Bh: "xiaowang" }, { name: "大王", Bh: "dawang" }];

            $("#orderid").keyup(function () {

                AutoComplete("auto_div", "orderid", test_list);
            });

            $("#orderid").blur(function ()
            {
                var arrSelect = $.map(test_list, function (value) {
                    return value.name == $("#orderid").val() ? value : null;//isNaN:is Not a Number的缩写 
                }
              );
                if (arrSelect.length > 0) {
                    $("#Bh").val(arrSelect[0].Bh);
                }
                else {
                    $("#Bh").val("");
                }
            })

            var search_text = document.getElementById("orderid");

            search_text.addEventListener("input", function () {
                AutoComplete("auto_div", "orderid", test_list);
            }, false);
        })
        
</script>
    <style type="text/css">
        .search
        {
            left: 0;
            position: relative;
        }

        #auto_div
        {
            display: none;
            width: 200px;
            border: 1px #EDEDED solid;
            background: #FFF;
            position: absolute;
            top: 22px;
            left: 0;
            color: #323232;
        }
    </style>
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
                <td class="pro_tableTd">经销商<span class="red" >*</span></td>
                <td><input type="text" id="Seller" class="pro_input required" /></td>
                <td class="pro_tableTd">业务员</td>
                <td><input type="text" id="Salesperson" class="pro_input" /></td>
                <td class="pro_tableTd">发货日期<span class="red" >*</span></td>
                <td><input type="text" id="SaleDate"  class="detepickers pro_input required" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">发票号</td>
                <td><input type="text" id="BillNo" class="pro_input" /></td>
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
                <td colspan="6" style="text-align:right;">
                    <button class="ui-button" type="button" onclick="SaveSales()">保存</button>
                    <button type="button" class="ui-button cd-popup-addbtn">新增订单</button>
                    <button type="button" class="ui-button cd-popup-editbtn">编辑订单</button>
                    <button type="button" class="ui-button" onclick="DeleteDetail()">删除订单</button>
                    <button type="button" class="ui-button" onclick="MakeContact()">生成合同</button>
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
                        <th>材料类型</th>
                        <th>生产批号</th>
                        <th>生产日期</th>
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
                    <iframe src="GenerateContract.aspx?orderid=<%="42" %>" width="950"  style="width:90%; height:90%; border:none;"></iframe>

              </div>
          </div>
            <a href="#0" class="cd-popup-close">关闭</a>
      </div>
 </div>
  <div class="cd-popup-add">
    <div class="cd-popup-container">
        <div class="box" >
          <div class="title" >订单详细</div>
          <div class="divWidth" >
            <table width="100%" id="gridLayer" border="0" cellspacing="0" cellpadding="0" class="pro_table">
              <tr>
                <td class="pro_tableTd">订货号<span class="red" >*</span></td>
                <td><div class="search"><input type="text" id="orderid" maxlength="50"  class="pro_input required" /><div id="auto_div"></div></div></td>
                <td class="pro_tableTd">存货编码<span class="red" >*</span></td>
                <td><input type="text" id="Bh" value="" maxlength="50"   class="pro_input required" /></td>
                <td class="pro_tableTd">销售数量<span class="red" >*</span></td>
                <td><input type="text" id="Qty" maxlength="10" class="pro_input required number" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">防伪卡数量<span class="red" >*</span></td>
                <td><input type="text" id="NoQty" maxlength="10"  class="pro_input required number" /></td>
                <td class="pro_tableTd">防伪卡开始号<span class="red" >*</span></td>
                <td><input type="text" id="NoStart" maxlength="50"  class="pro_input required" /></td>
                  <td class="pro_tableTd">防伪卡结束号<span class="red" >*</span></td>
                <td><input type="text" id="NoEnd" maxlength="50"  class="pro_input required" /></td>
                
              </tr>
              <tr>
                <td class="pro_tableTd">粉料类型</td>
                <td><input type="text" id="OClass" maxlength="10"  class="pro_input" /></td>
                <td class="pro_tableTd">粉料批号</td>
                <td><input type="text" id="ObatchNo" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">生产批号<span class="red" >*</span></td>
                <td><input type="text" id="BatchNo" maxlength="50"  class="pro_input required" /></td>
               
              </tr>
              <tr>
                 <td class="pro_tableTd">生产日期<span class="red" >*</span></td>
                <td><input type="text" id="ProdDate" class="detepickers pro_input required" /></td>
                <td class="pro_tableTd">检验日期</td>
                <td><input type="text" id="TestDate" class="detepickers pro_input" /></td>
                <td class="pro_tableTd">批次数量</td>
                <td><input type="text" id="BtQty" maxlength="10"  class="pro_input number" /></td>
               
              </tr>
              <tr>
                <td class="pro_tableTd">收缩比</td>
                <td><input type="text" id="SRate" maxlength="10"  class="pro_input" /></td>
                <td class="pro_tableTd">有效期</td>
                <td><input type="text" id="Valid" class="pro_input" /></td>
                 <td class="pro_tableTd">货运单号</td>
                <td><input type="text" id="DistriNo" maxlength="50"  class="pro_input" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">收货单位地址</td>
                <td colspan="5"><input id="Addr" maxlength="100"  type="text" class="pro_input" /></td>
              </tr>
              <tr>
                <td class="pro_tableTd">联系人</td>
                <td><input type="text" id="Receiver" maxlength="20"  class="pro_input" /></td>
                <td class="pro_tableTd">联系电话</td>
                <td><input type="text" id="Tel" maxlength="50"  class="pro_input" /></td>
                <td class="pro_tableTd">货运公司</td>
                <td><input type="text" id="Distri" maxlength="100"  class="pro_input" /></td>
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
