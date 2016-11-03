<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DictManagement.aspx.cs" Inherits="SystemConfig_DictManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link href="../Css/layer.css" rel="stylesheet" />
     <script type="text/javascript" src="../Scripts/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.20.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui-tables.js"></script>
     <script type="text/javascript" src="../Scripts/layer.js"></script>
    <script type="text/javascript">

        function SaveMainClass()
        {
            if (validateRow('tbMainClass',1) == true)
            {
                AjaxHandle({ actiontype: "SaveMainClass", ClassID: $("#ClassID").val(), ClassName: $("#ClassName").val(), Sortno: $("#Sortno").val() });
            }
            
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
                     if (data == "DictDetail")
                     { 
                     } 
                     else if (paraData.actiontype == "GetDetail") {
                         $("#tbClass tbody").find("tr").slice(1).remove();
                         $.fn.tables.bindData('tbClass', data);
                     }
                     else {
                         $("#tbMainClass tbody").find("tr").slice(1).remove();
                         $.fn.tables.bindData('tbMainClass', data);
                     }
                 }
             });
             if (paraData.actiontype == "SaveMainClass")
             {
                 $("#tbMainClass tbody").find("tr").each(function () {

                     $(this).bind("click", function () {
                         $("#selectMainClass").val($(this).find("input").eq(0).val());
                         ShowValue($(this).find("input").eq(0).val(), $(this).find("input").eq(1).val(), $(this).find("input").eq(2).val());
                         AjaxHandle({ actiontype: "GetDetail",selectMainClass:$("#selectMainClass").val(), })
                     })
                 });
             }
            
         }

         //删除行
         function deleteRow(obj) {
             $.fn.tables.deleteRow(obj);
         }

         function deleteMainClassRow(obj) {
            layer.confirm('确认删除吗？', {
                  
                }, function(index){
                    
                    AjaxHandle({ actiontype: "SaveMainClass", deleteKey: $(obj).parent().parent().find("input").eq(0).val() });
                  layer.close(index);
                }, function(){
                 
                });

           // 
         }

         //增加行
         function addTableRow(gridId) {
             $.fn.tables.addRow(gridId);
         }
         function ShowValue(value1, value2, value3) {

             $("#ClassID").val(value1);
             $("#ClassName").val(value2);
             $("#Sortno").val(value3);
         }
         function addMailClassTableRow(gridId) {
             $.fn.tables.addRow(gridId);
             $("#" + gridId).find("tr").last().find("td").each(function (index, item) {

                 if (index == 0) {

                     $(this).text($("#ClassID").val());
                 }
                 else if (index == 1) {
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

         function validateRow(tableID,sliceIndex) {
             var ispass = $.fn.tables.validateRow(tableID,sliceIndex);

             if (!ispass) {
                 layer.alert("还有必填项未填写！请继续完善后再保存!");
             }

            return ispass;

         }



         //取结果
         function SaveClass() {
            if($('#tbClass tbody ').find("tr :visible").length==0)
            {
                layer.alert("请添加子类信息！");
                return false;
            }
             if (validateRow('tbClass',2)) {
                 var relativesJob = $.fn.tables.getResult('tbClass');
                 relativesJob = relativesJob.join('|');
                 AjaxHandle({ actiontype: "SaveClass", selectMainClass: $("#selectMainClass").val(), data: relativesJob.toString() });

             }
             //这种写法也可取到
             //var rowResult = $("#tbRelativesJob").tables.getResult('tbRelativesJob');
             //alert(rowResult);


         }

         function bindData() {
             $.fn.tables.bindData('tbRelativesJob', $("#hdRelatives").val());
         }
        //
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input id="selectMainClass" name="selectMainClass" type="hidden" />
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
        <input type="button" value="保存" onclick="SaveClass()" />
        <table class="table table-editable" id="tbClass">
            <thead>
                <tr>
                    <th style="width:120px;">编码</th>
                    <th style="width:120px;">名称</th>
                    <th style="width:120px;">序号</th>                         
                    <th><a href="javascript:addTableRow('tbClass')" title="新增"><span class="icon icon-add">xinzeng</span></a></th>
                </tr>
            </thead>
            <tbody>
                <tr style="display:none;">
                    <td>
                        <input name="Code" type="text" style="width: 100px" class="required" /></td>
                    <td>
                        <input name="DictName" type="text" style="width: 100px" class="required" /></td>
                    <td>
                        <input name="SortNo" type="text" style="width: 150px" class="required" /></td>                    
                    <td>
                        <button type="button" name="Id" class="btn btn-link" onclick="deleteRow(this)">删除</button>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="table-toolbar"></div>
    </div>
    </form>
</body>
</html>
