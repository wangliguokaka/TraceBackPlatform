<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master" CodeFile="CustomerManage.aspx.cs" Inherits="SystemConfig_CustomerManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        var arrSelect = null;
        $(function () {

         
            $("#detailCountry").bind("change", function () {
 
                $.getJSON("../Handler/GetDataHandler.ashx?IsCN=<%=IsCN %>&ddlType=Province&ddlId=" + $("#detailCountry").val(), function (data) {

                   $("#detailProvince").empty();
                   $("#detailProvince").append(" <option value=\"-1\">&nbsp;</option>");
                   var provinceValue = -1;
                   if (arrSelect != null && arrSelect.length > 0 )
                   {
                       provinceValue = arrSelect[0].Province;
                   }
                    for (var i = 0; i < data.length; i++) {
                        $("#detailProvince").append($("<option></option>").val(data[i].ID).html(data[i].Cname));
                        if (provinceValue != "") {
                            $("#detailProvince").val(provinceValue);
                        }
                    };
                    $("#detailProvince").change();
                });
            });


            $("#detailProvince").bind("change", function () {
                $.getJSON("../Handler/GetDataHandler.ashx?IsCN=<%=IsCN %>&ddlType=City&ddlId=" + $("#detailProvince").val(), function (data) {

                    $("#detailCity").empty();
                    $("#detailCity").append(" <option value=\"-1\">&nbsp;</option>");
                   
                    var cityValue = -1;
                    if (arrSelect != null && arrSelect.length > 0) {
                        cityValue = arrSelect[0].City;
                    }
                    for (var i = 0; i < data.length; i++) {
                        $("#detailCity").append($("<option ></option>").val(data[i].ID).html(data[i].Cname));
                        if (cityValue != "") {
                            $("#detailCity").val(cityValue);
                        }
                    };
                });
            });
             $("#Class").val('<%=CustomerType%>')
            $("#detailClass").val('<%=CustomerType%>')
            GetDataList(0);
            createPage(10, 10, allRowCount);
            $("#detailCountry").change();
           
           
            
            //打开窗口
            $('.cd-popup-addbtn').on('click', function (event) {
                $(".cd-popup-container input").val("");
                $("#detailCountry").val(-1)                
                $("#detailCountry").change();           
               // alert($("#ID").val())
                $("#ID").val("-1");
                event.preventDefault();
                $('.cd-popup-add').addClass('is-visible');
            });

            
            //ESC关闭
            $(document).keyup(function (event) {
                if (event.which == '27') {
                    $('.cd-popup-add').removeClass('is-visible');
                }
            });

            //打开窗口
            $('.cd-popup-editbtn').on('click', function (event) {
               
                if (arrayCheck.length == 0) {
                    layer.msg("请选择订单进行编辑！");
                    return false;
                }
                else if (arrayCheck.length > 1) {
                    layer.msg("只能选择一条订单进行编辑！");
                    return false;
                }
                event.preventDefault();

                if (arrSelect.length > 0)
                {
                    $.each(arrSelect[0], function (i, n) {
                        $("#detail" + i).val(arrSelect[0][i]);
                    });
                    $("#detailCountry").change();
                }
                $("#ID").val("0");
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

            $(".cd-popup-container").draggable();
        });

        function SaveCustomer()
        {
            if (validateRow('gridCustomer', 0) == false) {
                return false;
            }
            $.ajax({
                type: "post",
                url: "CustomerManage.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "SaveCustomer", Id: $("#ID").val()=="-1"?"":arrayCheck.toString(), Class: $("#detailClass").val(), Serial: $("#detailSerial").val(), Client: $("#detailClient").val()
                , linkman: $("#detaillinkman").val(), Tel: $("#detailTel").val(), Tel2: $("#detailTel2").val(), Country: $("#detailCountry").val(), Province: $("#detailProvince").val()
                    , City: $("#detailCity").val(), Email: $("#detailEmail").val(), Addr: $("#detailAddr").val(), UserName: $("#detailUserName").val(), Passwd: $("#detailPasswd").attr("checked")
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                    if (data == "0") {
                        layer.msg("保存失败！");
                    }
                    if (data == "-1") {
                        layer.msg("账号分配不能重复！");
                    }
                    else {
                        $("#Id").val(data);
                        layer.msg("保存成功！");

                        GetDataList(0);
                        createPage(10, 10, allRowCount);
                    }
                }
            });
        }

        function deleteCustomer() {
            if (arrayCheck.length == 0) {
                layer.msg("请选择要删除的记录");
                return false;
            }
            layer.confirm('确认删除这个客户吗？', {

            }, function (index) {

                $.ajax({
                    type: "post",
                    url: "CustomerManage.aspx",
                    cache: false,
                    async: false,
                    data: {
                        actiontype: "SaveCustomer", Id: arrayCheck.toString()
                    },
                    dataType: "text",
                    success: function (data) {
                        //用到这个方法的地方需要重写这个success方法
                        if (data == "0") {
                            layer.msg("删除失败！");
                        }
                        else {                          
                            layer.msg("删除成功！");
                        }

                        GetDataList(0);
                        createPage(10, 10, allRowCount);
                    }
                });
                layer.close(index);
            }, function () {

            });

            //
        }

        function SearchList()
        {
            GetDataList(0);
            createPage(10, 10, allRowCount);
        }
       
        function CheckDetail(obj, id) {
            arrayCheck = new Array();
            $("#CustomerDetail tbody input[type='checkbox']:checked").each(function () {

                arrayCheck.push($(this).val());
            })

            if ($(obj).attr("checked") == "checked") {
                //$("#Serial").val(SerialIndex);
                arrSelect = $.map(json, function (value) {
                    return value.ID == id ? value : null;//isNaN:is Not a Number的缩写
                }
                );
                $.each(arrSelect[0], function (i, n) {
                    $("#detail" + i).val(arrSelect[0][i]);
                });
            }

            $("#detailCountry").change();

        }

        function createPage(pageSize, buttons, total) {
            $(".pagination").jBootstrapPage({
                pageSize: pageSize,
                total: total,
                maxPageButton: buttons,
                onPageClicked: function (obj, pageIndex) {
                    GetDataList(pageIndex)
                   // $('#pageIndex').html('您选择了第<font color=red>' + (pageIndex + 1) + '</font>页');
                }
            });
        }
        var arrayCheck = new Array();
        function SelectAll(obj) {
            $("#CustomerDetail tbody input[type='checkbox']").each(function () {

                $(obj).attr("checked") == "checked" ? $(this).attr("checked", "checked") : $(this).removeAttr("checked");
                CheckDetail(obj,$(this).val());
            })
        }

        var json = $.parseJSON("[]");// 定义一个json对象
        var allRowCount = 0;
        function GetDataList(PageIndex)
        {
           
            $.ajax({
                type: "post",
                url: "CustomerManage.aspx",
                cache: false,
                async: false,
                data: {
                    "actiontype": "GetCustomerManageList", "PageIndex": PageIndex, "Serial": $("#Serial").val(), "Class": $("#Class").val(), "linkman": $("#linkman").val(), "Client": $("#Client").val()
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                   
                    var returnData = $.parseJSON(data);
                    allRowCount = returnData[0].RowCount
                    json = returnData[0].JsonData;
                    $("#CustomerDetail tbody").empty();
                    $("#selectAllCheck").removeAttr("checked");
                    arrayCheck = new Array();
                    //遍历行结果
                    for (var i = 0; i < json.length; i++) {
                        //var trnum = $("#" + gridId + " tbody").find("tr").slice(0).length - 1;
                        //if (i > trnum) {


                        //遍历行中每一列的key

                        var trHtml = "<tr><td><input type=\"checkbox\" class=\"pro_checkbox\" onclick=\"CheckDetail(this," + json[i]["ID"] + ")\"  value=\"" + json[i]["ID"] + "\" /></td><td>" + json[i]["Serial"] + "</td><td>" + json[i]["Client"] + "</td><td>" + json[i]["UserName"] + "</td><td>" + json[i]["Tel"] + "</td><td>" + json[i]["Tel2"] + "</td><td>" + json[i]["Email"] + "</td></tr>";

                        $("#CustomerDetail tbody").append(trHtml);
                    }
                    $('.cd-popup-add').removeClass('is-visible');
                }
            });
        }

        function Transfer(Class)
        {
            if (Class == "A")
            {
                return "经销商";
            }
            else  if (Class == "B")
            {
                return "加工厂";
            }
            else if (Class == "C")
            {
                return "本公司员工";
            }
            else
            {
                return "本公司文员";
            }
        }

        function printDirent() {
            if (isIe()) {
                try {
                    document.all.WebBrowser.ExecWB(7, 1);
                }
                catch (Err) {
                    window.print();
                }
            }
            else {
                window.print();
            }
        }

        function isIe() {
            return ("ActiveXObject" in window);
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="box" >
      <div class="title" >查询条件</div>
        <input id="ID" type="hidden" />
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>

           <td width="10%" class="pro_tableTd" ><%if (("C,D").IndexOf(CustomerType) > -1){ %>姓名<%}else{ %>公司名称<%} %></td>
            <td width="23%"><input type="text" id="Client" class="pro_input" /></td>
            <%if (("C,D").IndexOf(CustomerType) > -1){ %>
              <td colspan="4">&nbsp;</td>
              <%} else { %>
            <td width="10%" class="pro_tableTd" >公司编码</td>
            <td width="23%"><input type="text" id="Serial" class="pro_input" /></td>           
             <td width="10%" class="pro_tableTd">联系人</td>
            <td width="24%"><input type="text" id="linkman" class="pro_input" /></td>
              <%} %>
            <td width="6%" class="pro_tableTd" style="display:none;">公司类别</td>
            <td width="20%"><select class="pro_select required" id="Class" style="display:none;"><option value=""></option><option value="A">经销商</option><option value="B">加工厂</option><option value="C">本公司员工</option><option value="D">本公司文员</option></select></td>

          </tr>
          <tr>
            <td colspan="8" style="text-align:right;">
              <button class="ui-button" type="button" onclick="SearchList()">查询</button>
              <button class="ui-button cd-popup-addbtn" type="button"><%if (("C,D").IndexOf(CustomerType) > -1){ %>添加人员<%}else{ %>添加客户<%} %></button>
              <button class="ui-button cd-popup-editbtn" type="button" ><%if (("C,D").IndexOf(CustomerType) > -1){ %>编辑人员<%}else{ %>编辑客户<%} %></button>
              <button class="ui-button" type="button" onclick="deleteCustomer()"><%if (("C,D").IndexOf(CustomerType) > -1){ %>删除人员<%}else{ %>删除客户<%} %></button>
                <object id="WebBrowser" width="0" height="0"  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>
            </td>
          </tr>
        </table>  
      </div>
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>
    <!--box  end-->
    <div class="divWidth1" >
      <div class="divTable" style="height:300px; overflow:auto;" >
        <table border="0" style="width:100% "  id="CustomerDetail" cellspacing="0" cellpadding="0" class="pro_table1">
          <thead>
            <tr>
                <th><input type="checkbox" id="selectAllCheck" class="pro_checkbox" onclick="SelectAll(this)" /></th>
                <th><%if (("C,D").IndexOf(CustomerType) > -1){ %>员工编码<%}else{ %>公司编码<%} %></th>               
                <th><%if (("C,D").IndexOf(CustomerType) > -1){ %>员工姓名<%}else{ %>公司名称<%} %></th>
                <th>账号</th>
                <th>手机</th>
                <th>电话</th>
                <th>Email</th>
              </tr>        
          </thead>
            <tbody>

            </tbody>
        </table>
      </div>
     
      <!--pager  end-->
    </div>
     <div  >
        <ul class="pagination"></ul>
      </div>
    <div class="cd-popup-add">
    <div class="cd-popup-container">
        <div class="box" >
          <div class="title" >客户信息</div>
          <div class="divWidth"  style="overflow:auto;" >
            <table width="100%" border="0" id="gridCustomer" cellspacing="0" cellpadding="0" class="pro_table">
              <tr>
                <td class="pro_tableTd" style="display:none;">公司类别<span class="red" >*</span></td>
                <td style="display:none;"><select class="pro_select required" id="detailClass" disabled="disabled" ><option value="A">经销商</option><option value="B">加工厂</option><option value="C">本公司员工</option><option value="D">本公司文员</option></select></td>
                <td class="pro_tableTd"><%if (("C,D").IndexOf(CustomerType) > -1){ %>员工编码<%}else{ %>公司编码<%} %><span class="red" >*</span></td>
                <td><input type="text" class="pro_input required" maxlength="50" id="detailSerial" /></td>
                <td class="pro_tableTd"><%if (("C,D").IndexOf(CustomerType) > -1){ %>员工姓名<%}else{ %>公司名称<%} %><span class="red" >*</span></td>
                <td><input type="text" class="pro_input required" maxlength="50"  id="detailClient" /></td>
                <td class="pro_tableTd">账号<span class="red" >*</span></td>
                <td><input type="text" class="pro_input required"  maxlength="50"  id="detailUserName" /></td>               
              </tr>
               
              <tr>                
                <td class="pro_tableTd">手机</td>
                <td><input type="text" class="pro_input" maxlength="50"  id="detailTel"  /></td>
                <td class="pro_tableTd">电话</td>
                <td><input type="text" class="pro_input" maxlength="50"  id="detailTel2" /></td>
                <td class="pro_tableTd">E_mail</td>
                <td><input type="text" class="pro_input" maxlength="50"  id="detailEmail" /></td>
              </tr>
               
                 <%if (("A,B").IndexOf(CustomerType) > -1){ %>
              <tr>
                <td class="pro_tableTd">国家</td>
                <td><select class="pro_select" id="detailCountry"><option value="-1"></option><option value="0">中国</option></select></td>
                <td class="pro_tableTd" >省</td>
                <td><select class="pro_select" id="detailProvince"><option value="-1"></option></select></td>
                <td class="pro_tableTd">市</td>
                <td><select class="pro_select" id="detailCity"><option value="-1"></option></select></td>
              </tr>
                 <%} %>
              <tr>
                <td class="pro_tableTd">密码重置</td>
                <td style="float:left;"><input type="checkbox" class="pro_input"   id="detailPasswd"/></td>
                   <%if (("A,B").IndexOf(CustomerType) > -1){ %>
                    <td class="pro_tableTd">联系人</td>
                    <td><input type="text" class="pro_input" maxlength="50"  id="detaillinkman"  /></td>
                    <td colspan="2">&nbsp</td>
                   <%}else{ %>
                     <td class="pro_tableTd"  colspan="4">&nbsp;</td>
                  <%} %>
              </tr>
              <tr>
                <td class="pro_tableTd">详细地址</td>
                <td colspan="5"><input type="text" class="pro_input" maxlength="100" style="width:80%;"  id="detailAddr"  /></td>
              
              </tr>        
              
              <tr>
                <td colspan="6" style="text-align:right;">
                  <button class="ui-button" type="button" onclick="SaveCustomer()" >保存</button>
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
    <!--divWidth1  end-->
   
</asp:Content>
