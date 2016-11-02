<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DictManagement.aspx.cs" Inherits="SystemConfig_DictManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <script type="text/javascript" src="../Scripts/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.20.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui-tables.js"></script>
    <script type="text/javascript">

        function SaveMainClass() {

            AjaxHandle({ actiontype: "SaveMainClass", ClassID: $("#ClassID").val(), ClassName: $("#ClassName").val(), Sortno: $("#Sortno").val() });
            
         }
         $(document).ready(function () {
             
             AjaxHandle({ actiontype: "SaveMainClass" });
             
         });

         function AjaxHandle(paraData)
         {
             $.ajax({
                 type: "post",
                 url: "DictManagement.aspx",

                 cache: false,
                 async: false,
                 data: paraData,
                 dataType: "text",
                 success: function (data) {
                     //用到这个方法的地方需要重写这个success方法
                     $("#tbMainClass tbody").find("tr").slice(1).remove();
                     $.fn.tables.bindData('tbMainClass', data);
                 }
             });

             $("#tbMainClass tbody").find("tr").each(function () {

                 $(this).bind("click", function () {

                     ShowValue($(this).find("input").eq(0).val(), $(this).find("input").eq(1).val(), $(this).find("input").eq(2).val());
                 })
             });
         }
        //
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input type="button" value="保存" onclick="SaveMainClass()" />
        <table class="table table-editable" id="tbMainClass">
            <thead>
                <tr>
                    <th>分类编码：</th>
                    <th>分类名称：</th>
                    <th>序号：</th>
                    <th><a href="javascript:addMailClassTableRow('tbMainClass')" title="新增"><span class="icon icon-add">xinzeng</span></a></th>                      
                </tr>
                <tr>
                    <td><input id="ClassID" type="text"  style="width: 100px" class="required" /></td>
                    <td><input id="ClassName" type="text" style="width: 100px" class="required" /></td>
                    <td><input id="Sortno" type="text" style="width: 150px" class="required" /></td>
                    <td></td>
                </tr>
            </thead>
            <tbody>
                <tr style="display:none;">
                    <td><input type="text" name="ClassID" style="border:none;" disabled="disabled" /> </td>
                    <td><input type="text" name="ClassName" style="border:none;"disabled="disabled"/></td>
                    <td><input type="text" name="Sortno" style="border:none;" disabled="disabled"/></td>  
                    <td><button type="button" name="Id" class="btn btn-link" onclick="deleteMainClassRow(this)">删除</button></td>                 
                </tr>
            </tbody>
        </table>
        <div class="table-toolbar"></div>
    </div>
    <div>
        <table class="table table-editable" id="tbRelativesJob">
            <thead>
                <tr>
                    <th>编码</th>
                    <th>名称</th>
                    <th>序号</th>                         
                    <th><a href="javascript:addTableRow('tbRelativesJob')" title="新增"><span class="icon icon-add">xinzeng</span></a></th>
                </tr>
            </thead>
            <tbody>
                <tr >
                    <td>
                        <input name="Code" type="text" errormsg="必填" style="width: 100px" class="required" /></td>
                    <td>
                        <input name="DictName" type="text" style="width: 100px" class="required" /></td>
                    <td>
                        <input name="SortNo" type="text" style="width: 150px" class="required" /></td>                    
                    <td>
                        <button type="button" name="Id" class="btn btn-link" onclick="deleteRow(this)"><span class="icon icon-remove"></span></button>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="table-toolbar"></div>
    </div>

         <script type="text/javascript">
  
             var ee = 4;
             var resultArray = new Array();
             
            
             resultArray.push({ ClassID: "", ClassName: "", Sortno: "" });
           
             resultArray.push({ ClassID: "555", ClassName: "", Sortno: "" });
           
        //删除行
        function deleteRow(obj) {                 
           $.fn.tables.deleteRow(obj);
        }

        function deleteMainClassRow(obj)
        {
            AjaxHandle({ actiontype: "SaveMainClass", deleteKey: $(obj).parent().parent().find("input").eq(0).val() });
        }

        //增加行
        function addTableRow(gridId) {
            $.fn.tables.addRow(gridId);
        }
        function ShowValue(value1,value2,value3)
        {
           
            $("#ClassID").val(value1);
            $("#ClassName").val(value2);
            $("#Sortno").val(value3);
        }
        function addMailClassTableRow(gridId)
        {
            $.fn.tables.addRow(gridId);
            $("#" + gridId).find("tr").last().find("td").each(function (index, item) {
              
                if (index == 0)
                {
                   
                    $(this).text($("#ClassID").val());
                }
                else if (index == 1)
                {
                    $(this).text($("#ClassName").val());
                }
                else if (index == 2) {
                    $(this).text($("#Sortno").val());
                }
                else {
                    $(this).parent().bind("click", function () {
                       
                        ShowValue($(this).find("td").eq(0).text(), $(this).find("td").eq(1).text(), $(this).find("td").eq(2).text());
                    })
                    $(this).parent().css("cursor", "pointer");
                    $(this).html("<button type=\"button\" name=\"Id\" class=\"btn btn-link\" onclick=\"deleteRow(this)\">删除</button>")
                }
                
            });
        }

        //校验数据

        function validateRow()
        {
            var ispass = $.fn.tables.validateRow('tbRelativesJob');
           
            if (!ispass) {
                layer.alert("还有必填项未填写！请继续完善后再保存!");
            }

        }

        //取结果
        function getRowResult()
        {
            var relativesJob = $.fn.tables.getResult('tbRelativesJob');
            $("#resultData").text(relativesJob.join('|'));

            //这种写法也可取到
            //var rowResult = $("#tbRelativesJob").tables.getResult('tbRelativesJob');
            //alert(rowResult);

            
        }

        function bindData()
        {
            $.fn.tables.bindData('tbRelativesJob', $("#hdRelatives").val());
        }
    </script>
    </form>
</body>
</html>
