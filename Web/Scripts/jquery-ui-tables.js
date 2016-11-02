/***********************
*DESC:表格动态增加行插件
*Author:张琪鹏 
*Date:2014-07-22
*
************************/

; (function ($) {
    $.fn.tables = function (option) {
        //定义默认参数
        var defaults = {
            name: "", //grid id
            deleteName: this, //delete object
            tbResult: ""
        };
        //整合传入参数
        var opt = $.extend({}, defaults, option);

    };

    //增加行
    $.fn.tables.addRow = function (gridId) {
        var tbRow = $("#" + gridId +" tbody").find("tr").eq(0).html();
        var num = $("#" + gridId + " tbody tr").length;
        $("#" + gridId).append("<tr id=" + num + ">" + tbRow + "</tr>");
        $("#" + gridId).find("tr").last().find("td").last().children().removeAttr("name").attr("value", "");
    };

    //删除行 
    //参数obj  当前对象
    $.fn.tables.deleteRow = function (obj) {
        var $this = $(obj);
        if ($this.parents("table").find("tr").length <= 2) {
            return false;
        }
        $this.parents("tr").remove();
    };

    //取表格所有数据
    //返回值为一个数组，数组内每一个元素对应一行内的数据;
    $.fn.tables.getResult = function (gridId) {

        var resultArray = new Array();
        $("#" + gridId + " tbody").find("tr").slice(0).each(function () {

            var trResult = "{";

            $(this).find("td").each(function () {
                var $child = $(this).children();

                if ($child.length > 1) {
                    //td下有多个元素的(多个元素会用"|"拼接起来)
                    //td下有多个元素的暂时禁用
                    //$child.each(function () {
                    //    //alert($(this).attr("type"));
                    //    switch ($(this).attr("type")) {
                    //        case "text":
                    //            //alert($child.val() + "文件框的!");

                    //             trResult += '"' + $(this).attr("name") + '"' + ":" + '"' + $(this).val() + '"' + ",";
                    //            break;
                    //        case "select":
                    //            // alert($(this).find("option:selected").text());

                    //            trResult += '"' + $(this).attr("name") + '"' + ":" + '"' + $(this).find("option:selected").val() + '"' + ",";
                    //            break;
                    //        case "checkbox":

                    //            if ($(this).attr("checked") === "checked") {

                    //                trResult += '"' + $(this).attr("name") + '"' + ":" + '"' + $(this).val() + '"' + ",";
                    //            }
                    //            break;

                    //        case "radio":
                    //            if ($(this).attr("checked") === "checked") {

                    //                trResult += '"' + $(this).attr("propertys") + '"' + ":" + '"' + $(this).val() + '"' + ",";
                    //            }
                    //            break;

                    //        default:
                    //    }

                    //});
                    // trResult.push(valueStr);

                } else {
                    //td 下只有一个元素
                    switch ($child.attr("type")) {
                        case "text":

                            trResult += '"' + $child.attr("name") + '"' + ":" + '"' + $child.val() + '"' + ",";
                            break;
                        case "select":

                            trResult += '"' + $child.attr("name") + '"' + ":" + '"' + $child.find("option:selected").val() + '"' + ",";
                            break;
                        case "checkbox":
                            if ($(this).attr("checked") === "checked") {
                                trResult += '"' + $child.attr("name") + '"' + ":" + '"' + $child.val() + '"' + ",";
                            } else {
                                trResult += '"' + $child.attr("name") + '"' + ":0" + '"' + ",";
                            }
                            break;
                        case "radio":
                            if ($(this).attr("checked") === "checked") {
                                trResult += '"' + $child.attr("propertys") + '"' + ":" + '"' + $child.val() + '"' + ",";
                            } else {
                                trResult += '"' + $child.attr("propertys") + '"' + ":0" + '"' + ",";
                            }
                            break;


                        default:
                    }
                }
            });

            trResult = trResult.substring(0, trResult.length - 1);
            resultArray.push(trResult + "}");

        });

        return resultArray;
    };

    //验证行
    $.fn.tables.validateRow = function (gridId) {

        //是否验证通过
        var isPass = true;

        $("#" + gridId).find("tr").slice(1).each(function () {

            $(this).find("td").each(function () {
                if ($(this).children().hasClass('text-error'))
                {
                    return isPass = false;
                }

                var $this = $(this).children();

                if ($this.length > 1) {
                    //checkbox选中数
                    if ($(this).find("input[type='checkbox']").length > 0) {
                        var checkedNum = $(this).find("input[type='checkbox'][checked]").length;
                        if (checkedNum <= 0) {
                            //TODO:复选框应该默认有选中项目不需要做验证
                            // message = "此字段必填";
                            //return message;
                        }
                    }
                    //radio选中数
                    if ($(this).find("input[type='radio']").length > 0) {
                        var radioNum = $(this).find("input[type='radio'][checked]").length;
                        if (radioNum <= 0) {
                            //TODO:复选框应该默认有选中项目不需要做验证
                            //message = "此字段必填";
                            //return message;
                        }
                    }
                } else {
                   
                    switch ($this.attr("type")) {
                        case "text":
                            var errorMsg = "此字段为必填项!";
                            if ($this.hasClass("required")) {
                                if ($.trim($this.val()) == "") {

                                    isPass = false;
                                   
                                    if ($this.attr("errormsg") == undefined) {

                                        $this.addClass('error').after("<span class='help-block text-error'>" + errorMsg + "</span>");
                                    } else {
                                        errorMsg = $this.attr("errormsg");
                                        $this.addClass('error').after("<span class='help-block text-error'>" + errorMsg + "</span>");
                                    }
                                }
                            }
                            if ($this.hasClass("detepickers")) {
                                if ($.trim($this.val()) == "") {
                                    isPass = false;
                                    $this.addClass('error').after("<span class='help-block text-error'>" + errorMsg + "</span>");
                                }
                            }
                            break;
                        case "select":
                            //默认有选中项不需要做验证
                            //若选中项为“请选择”时可以根据选中值来验证
                            break;
                        default:
                    }
                }
            });

        });
        return isPass;

    };

    //绑定数据
    $.fn.tables.bindData = function (gridId, tbResult) {

        //返回结果为一个数组
        // var result = $("#<%=hd"+gridId+".ClientID %>").val();
        var jsons = $.parseJSON(tbResult);
        if (jsons == null) {
            return;
        }
        var trHtml = $("#" + gridId + " tbody").find("tr").eq(0).html();

        //遍历行结果
        for (var i = 0; i < jsons.length; i++) {
            //var trnum = $("#" + gridId + " tbody").find("tr").slice(0).length - 1;
            //if (i > trnum) {
                $("#" + gridId).append("<tr>" + trHtml + "</tr>");

            //}

            //遍历行中每一列的key 
            for (var key in jsons[i]) {

                $("#" + gridId + " tbody").find("tr").eq(i + 1).find("td").each(function () {
                    var $child = $(this).children();

                    if ($child.attr("name") === key || $child.attr("propertys") === key) {

                        switch ($child.attr("type")) {
                            case "text":
                                $child.val(jsons[i][key]);
                                break;
                            case "select":
                                //可以根据value 来设置选中项目
                                $child.find("option").each(function () {
                                    var value = $(this).val();
                                    if (value === jsons[i][key]) {
                                        $(this).attr("selected", true);
                                    }
                                });

                                break;
                            case "checkbox":
                                //可以根据value 来设置选中项目

                                $child.each(function () {
                                    var name = $(this).attr("name");
                                    if (name === key && $(this).val() === jsons[i][key]) {
                                        $(this).attr("checked", true);
                                    }
                                });

                            case "radio":
                                $child.each(function () {
                                    var name = $(this).attr("propertys");
                                    if (name === key && $(this).val() === jsons[i][key]) {
                                        $(this).attr("checked", true);
                                    }
                                });
                                break;
                            case "a":
                            case "button":
                                $child.attr("value", jsons[i][key]);
                                break;
                            default:
                        }
                    }
                });

            }

        }
    };

})(jQuery);