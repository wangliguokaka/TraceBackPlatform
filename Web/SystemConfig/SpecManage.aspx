<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master" CodeFile="SpecManage.aspx.cs" Inherits="SystemConfig_SpecManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">


        $(function () {
            GetDataList(0);
            createPage(10, 10, allRowCount);
           

            //打开窗口
            $('.cd-popup-addbtn').on('click', function (event) {
              
                event.preventDefault();
                $('.cd-popup-add').addClass('is-visible');
            });

            //关闭窗口
            $('.cd-popup-add').on('click', function (event) {
                $("#ID").val("-1");
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
                if (arrayCheck.length == 0) {
                    layer.msg("请选择订单进行编辑！");
                    return false;
                }
                else if (arrayCheck.length > 1) {
                    layer.msg("只能选择一条订单进行编辑！");
                    return false;
                }
                event.preventDefault();
                $('.cd-popup-add').addClass('is-visible');
            });
            //关闭窗口
            $('.cd-popup-add').on('click', function (event) {
                if ($(event.target).is('.cd-popup-close')) {
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

            $("#detailProductName").focus(function () {
                //if ($("#orderid").val() == "") {
                CommonAutoComplete("auto_div", "detailProductName", [{ "NodeName": "全瓷义齿用氧化锆瓷块" }, { "NodeName": "二硅酸锂玻璃陶瓷" }]);

               // }
            });

            $("#detailProductName").keyup(function () {
               
                CommonAutoComplete("auto_div", "detailProductName", [{ "NodeName": "全瓷义齿用氧化锆瓷块" }, { "NodeName": "二硅酸锂玻璃陶瓷" }]);
            });

            $("#auto_div").css("width", $("#detailProductName").width());
            
        });

        function SaveSpec()
        {
            if (validateRow('gridSpec', 0) == false) {
                return false;
            }

            $.ajax({
                type: "post",
                url: "SpecManage.aspx",
                cache: false,
                async: false,
                data: {
                    actiontype: "SaveSpec", Id: arrayCheck.toString(), Bh: $("#detailBh").val(), Class: $("#detailClass").val(), ProductName: $("#detailProductName").val()
                , Spec: $("#detailSpec").val(), exterior: $("#detailexterior").val(), size: $("#detailsize").val(), OrderNo: $("#detailOrderNo").val(), Remark: $("#detailRemark").val(), Color: $("#detailColor").val()
                },
                dataType: "text",
                success: function (data) {
                    //用到这个方法的地方需要重写这个success方法
                    if (data == "0") {
                        layer.msg("保存失败！");
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

        function deleteSpec() {
            if (arrayCheck.length == 0) {
                layer.msg("请选择要删除的记录");
                return false;
            }
            layer.confirm('确认删除这个规格型号吗？', {

            }, function (index) {

                $.ajax({
                    type: "post",
                    url: "SpecManage.aspx",
                    cache: false,
                    async: false,
                    data: {
                        actiontype: "SaveSpec", Id: arrayCheck.toString()
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
                var arrSelect = $.map(json, function (value) {
                    return value.ID == id ? value : null;//isNaN:is Not a Number的缩写 
                }
                );
                $.each(arrSelect[0], function (i, n) {
                    $("#detail" + i).val(arrSelect[0][i]);
                });
            }

        }

        function createPage(pageSize, buttons, total) {
            $(".pagination").jBootstrapPage({
                pageSize: pageSize,
                total: total,
                maxPageButton: buttons,
                onPageClicked: function (obj, pageIndex) {
                    GetDataList(pageIndex)
                    // $('.pagination').html('您选择了第<font color=red>' + (pageIndex + 1) + '</font>页');
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
                url: "SpecManage.aspx",
                cache: false,
                async: false,
                data: {
                    "actiontype": "GetSpecManageList", "PageIndex": PageIndex,"Bh":$("#Bh").val(), "Class": $("#Class").val(), "OrderNo": $("#OrderNo").val()
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

                        var trHtml = "<tr><td><input type=\"checkbox\" class=\"pro_checkbox\" onclick=\"CheckDetail(this," + json[i]["ID"] + ")\"  value=\"" + json[i]["ID"] + "\" /></td><td>" + json[i]["Bh"] + "</td><td>" + json[i]["Class"] + "</td><td>" + json[i]["OrderNo"] + "</td><td>" + json[i]["Color"] + "</td><td>" + json[i]["Size"] + "</td><td>" + json[i]["exterior"] + "</td></tr>";

                        $("#CustomerDetail tbody").append(trHtml);
                    }
                    $('.cd-popup-add').removeClass('is-visible');
                }
            });
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
            height:200px;
            border: 1px #EDEDED solid;
            background: #FFF;
            position: absolute;
            top: 22px;
            left: 0;
            color: #323232;
            overflow:auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="box" >
      <div class="title" >查询条件</div>
        <input id="ID" type="hidden" />
      <div class="divWidth" >
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro_table">
          <tr>
            <td width="6%" class="pro_tableTd">编码</td>
            <td width="20%"><input type="text" id="Bh" class="pro_input" /></td>
            <td width="6%" class="pro_tableTd" >类别<span class="red" >*</span></td>
            <td width="20%"><input type="text" id="Class" class="pro_input" /></td>
            <td width="6%" class="pro_tableTd">订货号</td>
            <td width="20%"><input type="text" id="OrderNo" class="pro_input" /></td>
           
          </tr>
          <tr>
            <td colspan="6" style="text-align:right;">
              <button class="ui-button" type="button" onclick="SearchList()">查询</button>
              <button class="ui-button cd-popup-addbtn" type="button">添加产品规格</button>
              <button class="ui-button cd-popup-editbtn" type="button" >编辑产品规格</button>
              <button class="ui-button" type="button" onclick="deleteSpec()">删除产品规格</button>
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
      <div class="divTable" style="height:300px; overflow:hidden;" >
        <table border="0" style="width:100% "  id="CustomerDetail" cellspacing="0" cellpadding="0" class="pro_table1">
          <thead>
            <tr>
                <th><input type="checkbox" id="selectAllCheck" class="pro_checkbox" onclick="SelectAll(this)" /></th>
                <th>编码</th>
                <th>类别</th>
                <th>订货号</th>
                <th>颜色</th>
                <th>尺寸</th>
                <th>外形</th>
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
    <div class="cd-popup-container" style="height:200px;">
        <div class="box"  >
          <div class="title" >产品规格</div>
          <div class="divWidth"  style="overflow:hidden;" >
            <table width="100%" border="0" id="gridSpec" cellspacing="0" cellpadding="0" class="pro_table">
              <tr>
                <td class="pro_tableTd">编码<span class="red" >*</span></td>
                <td><input type="text" class="pro_input required" id="detailBh" /></td>
                  <td class="pro_tableTd">订单号<span class="red" >*</span></td>
                <td><input type="text" class="pro_input required" id="detailOrderNo" /></td>
                <td class="pro_tableTd">类别<span class="red" >*</span></td>
                <td><input type="text" class="pro_input required" id="detailClass" /></td>
                
              </tr>
              <tr>
                   <td class="pro_tableTd">产品名称</td>
                <td><div class="search"><input type="text" class="pro_input" id="detailProductName" /><div id="auto_div"></div></div></td>
              
                <td class="pro_tableTd">外形</td>
                <td><input type="text" class="pro_input" id="detailexterior"  /></td>
                <td class="pro_tableTd">尺寸</td>
                <td><input type="text" class="pro_input" id="detailsize" /></td>
              </tr>       
              <tr>
                 <td class="pro_tableTd">规格</td>
                <td><input type="text" class="pro_input" id="detailSpec"  /></td>
                <td class="pro_tableTd">颜色</td>
                <td><input type="text" class="pro_input" id="detailColor" /></td> 
                  <td colspan="2">&nbsp;</td> 
          
              </tr>
              <tr>
                <td class="pro_tableTd">备注</td>
                <td colspan="5"><input type="text" class="pro_input" id="detailRemark"  /></td>
              </tr>        
         
              <tr>
                <td colspan="6" style="text-align:right;">
                  <button class="ui-button" type="button" onclick="SaveSpec()" >保存</button>
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

