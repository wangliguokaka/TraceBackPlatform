<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_Master/Master.master" CodeFile="DictManagement.aspx.cs" Inherits="SystemConfig_DictManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <script type="text/javascript">

       function SaveMainClass() {
           if (validateRow('tbMainClass', 1) == true) {
               AjaxHandle({ actiontype: "SaveMainClass", MainClass: $("#MainClass").val(), ClassID: $("#ClassID").val(), ClassName: $("#ClassName").val(), Sortno: $("#Sortno").val() });
           }

       }
       $(document).ready(function () {

           $("#ClassAdd").attr("disabled", "disabled");
           AjaxHandle({ actiontype: "GetMainClass" });

       });

       function AjaxHandle(paraData) {
           var IsSuccess = true;
           $.ajax({
               type: "post",
               url: "DictManagement.aspx",
               cache: false,
               async: false,
               data: paraData,
               dataType: "text",
               success: function (data) {
                   //用到这个方法的地方需要重写这个success方法
                 
                   if (data == "-1") {
                       IsSuccess = false;
                       layer.msg("操作失败！");

                   }
                   else {
                       if (data == "DictDetail") {
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
                  

               }
           });
           
               if (paraData.actiontype == "GetMainClass" || paraData.actiontype == "SaveMainClass") {
                   $("#tbMainClass tbody").find("tr").each(function () {

                       $(this).bind("click", function () {
                           $("#ClassAdd").removeAttr("disabled");
                           $("#selectMainClass").val($(this).find("input").eq(1).val());
                           ShowValue($(this).find("input").eq(0).val(), $(this).find("input").eq(1).val(), $(this).find("input").eq(2).val(), $(this).find("input").eq(3).val());
                           AjaxHandle({ actiontype: "GetDetail", selectMainClass: $("#selectMainClass").val() })
                       })
                   });
               }
            if (IsSuccess) {
               if (paraData.actiontype == "SaveMainClass" || paraData.actiontype == "SaveClass") {
                   layer.msg("操作完成！");
               }
           }
            $("#tbMainClass tbody tr").css("cursor", "pointer");
            $("#tbMainClass tbody input").css("cursor", "pointer");
       }

       //删除行
       function deleteRow(obj) {
           $.fn.tables.deleteRow(obj);
       }

       function deleteMainClassRow(obj) {
           layer.confirm('确认删除吗？', {

           }, function (index) {

               AjaxHandle({ actiontype: "SaveMainClass", deleteKey: $(obj).parent().parent().find("input").eq(0).val() });
               layer.close(index);
           }, function () {

           });

           // 
       }

       //增加行
       function addTableRow(gridId) {
           $.fn.tables.addRow(gridId);
       }
       function ShowValue(value0,value1, value2, value3) {
           $("#MainClass").val(value0);
           $("#ClassID").val(value1);
           $("#ClassName").val(value2);
           $("#Sortno").val(value3);
       }
       function addMailClassTableRow(gridId) {
           $.fn.tables.addRow(gridId);
           $("#" + gridId).find("tr").last().find("td").each(function (index, item) {

               if (index == 0) {

                   $(this).text($("#MainClass").val());
               }
               else if (index == 1) {

                   $(this).text($("#ClassID").val());
               }
               else if (index == 2) {
                   $(this).text($("#ClassName").val());
               }
               else if (index == 3) {
                   $(this).text($("#Sortno").val());
               }
               else {
                   $(this).parent().bind("click", function () {

                       ShowValue($(this).find("td").eq(0).text(), $(this).find("td").eq(1).text(), $(this).find("td").eq(2).text(), $(this).find("td").eq(3).text());
                   })
                   $(this).parent().css("cursor", "pointer");
                   $(this).html("<button type=\"button\" name=\"Id\" class=\"btn btn-link\" onclick=\"deleteRow(this)\">删除</button>")
               }

           });
       }

       //校验数据

       function validateRow(tableID, sliceIndex) {
           var ispass = $.fn.tables.validateRow(tableID, sliceIndex);

           if (!ispass) {
               layer.alert("还有必填项未填写！请继续完善后再保存!");
           }

           return ispass;

       }



       //取结果
       function SaveClass() {
           if ($('#tbClass tbody ').find("tr :visible").length == 0) {
               layer.alert("请添加子类信息！");
               return false;
           }
           if (validateRow('tbClass', 2)) {
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
     
    </script>
    <style type="text/css">
        .disabled 
        {
            background-color:white;
            text-align:center;
             height:25px;
        }

        .required {
            height:25px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td style=" width:40%; vertical-align:top;">
              
                    
                 
                    <div class="divWidth1" >
                        <table  id="tbMainClass" border="0" class="pro_table1" style="width:100%; " >
                        <thead>
                            <tr>
                                <th >大类编码：</th>
                                <th >分类编码：</th>
                                <th >分类名称：</th>
                                <th >序号：</th>
                                <th >操作</th>                      
                            </tr>
                            <tr>
                                <td ><input id="MainClass" type="text" style="width:120px;"  class="required" /></td>
                                <td ><input id="ClassID" type="text" style="width:120px;"  class="required" /></td>
                                <td><input id="ClassName" type="text" style="width:120px;"   class="required" /></td>
                                <td><input id="Sortno" type="text" style="width:30px;"  class="required" /></td>
                                <td><input type="button" style="width:60px;" class="ui-button" value="保存" onclick="SaveMainClass()" /></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="display:none; cursor:pointer;">
                                <td><input type="text" name="MainClass"  style="border:none;width:150px;" class="disabled" disabled="disabled" /> </td>
                                <td><input type="text" name="ClassID"  style="border:none;width:150px;" class="disabled" disabled="disabled" /> </td>
                                <td><input type="text" name="ClassName" style="border:none;width:150px;"class="disabled" disabled="disabled"/></td>
                                <td><input type="text" name="Sortno" style="border:none;width:40px;" class="disabled" disabled="disabled"/></td>  
                                <td><button type="button" name="Id" class="ui-button" style="width:60px;" onclick="deleteMainClassRow(this)">删除</button></td>                 
                            </tr>
                        </tbody>
                    </table>
                   </div>
               
            </td>
            <td style="width:10px;">&nbsp;</td>
            <td style=" width:58%; vertical-align:top;">
                <div class="divWidth1" style="min-height:100px;" >
                        <div style="margin:5px;5px;">
                            <input type="button" class="ui-button" value="保存" onclick="SaveClass()" />
                            <input type="button" class="ui-button" value="新增" onclick="addTableRow('tbClass')" />
                            
                        </div>
                    <div style="padding-left:10px; margin:4px;">
                        分类编码:<input id="selectMainClass" style="border:none;" name="selectMainClass" type="text" />
                    </div>
                         
                        <table  id="tbClass" border="0" class="pro_table1" style="width:100%;" >
                        <thead>
                            <tr>
                                <th style="width:120px;">项目编码</th>
                                <th style="width:120px;">项目名称</th>
                                <th style="width:120px;">项目序号</th>                         
                                <th><span class="icon icon-add">操作</span></th>
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
            </td>
        </tr>
    </table>
    <%--<div class="box" >
      <div class="title" >查询条件</div>
      
       
   
      <!--divWidth  end-->
      <div class="clear" ></div>
    </div>--%>
</asp:Content>