$(function () {
    //头部链接状态
    var currUrl = location.pathname;
    $('#nav-tabs a').each(function (i, e) {
        if ($(this).attr('href').indexOf(currUrl) == 0) {
            $(this).parents().siblings().removeClass('edited');
            $(this).parent().addClass('edited');
            $('#nav-tabs li:lt(' + i + ')').addClass('finished');
        }
    });

    $(".number").live('keyup', function () {
        onlyNumber(this);
    });
    
    $(".detepickers").live("focus", function () {
        
        $(this).datepicker({
            dateFormat: "yy-mm-dd",
            //showOn: "button", 
            //buttonImage: "images/calendar.png",
            //buttonImageOnly: true,
            monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],

            changeYear: true,
            changeMonth: true,
            onSelect: function () {
                $(this).removeClass("hasDatepicker");
               // $(this).attr("id", "");

            },
            onClose: function () {
                var errorMsg = "";
               // $(this).attr("id", "");
                $(this).removeClass("hasDatepicker");

                //if ($.trim($(this).val()) == "") {
                //    errorMsg = "日期为必填项!";
                //    $(this).addClass('error').after("<span class='help-block text-error'>" + errorMsg + "</span>");
                //}
                if ($.trim($(this).val()) != "") {
                    var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/;
                    if ($(this).val().match(reg) == null) {
                        errorMsg = "请输入正确的时间格式!";
                        $(this).addClass('error').after("<span class='help-block text-error'>" + errorMsg + "</span>");
                    }
                }
            }
            //  showOn: "both"
        });
    });

    //表格中必填项验证
    $(".required").live('blur', function () {
        if ($.trim($(this).val()) != "") {
            return;
        }

        //var errorMsg = "此字段为必填项";
        //switch ($(this).attr("type")) {
        //    case "text":
        //        if ($(this).attr("errormsg") != undefined) {
        //            errorMsg = $(this).attr("errormsg");
        //        }
        //        break;
        //    case "select":
        //        var sval = $(this).find("option:selected").val();
        //        if (sval === "-1") {
        //            if ($(this).attr("errormsg") != undefined) {
        //                errorMsg = $(this).attr("errormsg");
        //            }
        //        }
        //        break;
        //    default:
        //}

        //$(this).addClass('error').after("<span class='help-block text-error'>" + errorMsg + "</span>");

    });

    $(".error").live('focus', function () {
        $(this).removeClass('error').parent("td").find(".text-error").fadeOut(1500, function () { $(this).remove(); });

    });

    //非表格中必填项验证
    $(".requirednt").live('blur', function () {
        if ($.trim($(this).val()) != "") {
            return;
        }
        var errorMsg = "此字段为必填项";
        switch ($(this).attr("type")) {
            case "text":
                if ($(this).attr("errormsg") != undefined) {
                    errorMsg = $(this).attr("errormsg");
                }
                break;
            case "select":
                var sval = $(this).find("option:selected").val();
                if (sval === "-1") {
                    if ($(this).attr("errormsg") != undefined) {
                        errorMsg = $(this).attr("errormsg");
                    }
                }
                break;
            default:
        }

        $(this).addClass('errornt').after("<span class='help-block text-error'>" + errorMsg + "</span>");

    });

    $(".errornt").live('focus', function () {
        $(this).removeClass('errornt').parent().find(".text-error").fadeOut(1500, function () { $(this).remove(); });

    });

    //长度限制
    $(".maxlength").live('keyup', function () {
        var max = 0;
        if ($(this).attr("maxlength") == undefined) {
            max = 20;
        } else {
            max = parseInt($(this).attr("maxlength"));
        }

        $(this).val($(this).val().substring(0, max));

    });

    //控制复选框单选
    $(".checkboxs").live('click', function () {
        var $parent = $(this).parent();
        $parent.find("[type='checkbox']").each(function () {
            $(this).removeAttr('checked');
        });
        $(this).attr('checked', 'checked');
    });

    $(".serverCheckbox").live('click', function () {
        var $parent = $(this).parent().parent().parent();
        $parent.find("[type='checkbox']").each(function () {
            $parent.find("[type='checkbox']").each(function () {
                $(this).removeAttr('checked');
            });
            $(this).attr('checked', 'checked');
        });

        //控制单选框单选
        $(".radios").live('click', function () {
            var $parent = $(this).parent();

            $parent.children().each(function () {
                $(this).removeAttr('checked');
            });
            $(this).attr('checked', 'checked');
        });

        $(".serverRadios").live('click', function () {
            var $parent = $(this).parent().parent().parent();

            $parent.find("[type='radio']").each(function () {
                $(this).removeAttr('checked');
            });
            $(this).attr('checked', 'checked');
        });
    });

    //有无变化|有无此情况
    $('.radio :radio').live('click', (function () {
        //radio按钮值
        var cboxVal = $(this).attr('value');
        //表格ID
        var nearTableId = $(this).parents().next('.table').attr('id');
        if (cboxVal == 0)
            $(document.getElementById(nearTableId)).find('td').each(function () {
                $(this).children().attr("disabled", "disabled");
            });
        else
            $(document.getElementById(nearTableId)).find('td').each(function () {
                $(this).children().removeAttr("disabled");
            });
    }));

});

//增加行
function addTableRow(objId) {
    $.fn.tables.addRow(objId);
}

//控制只能输入数字
function onlyDecimal(obj) {
    if (obj.value.length > 20) {
        obj.value = obj.value.substring(0, 20);
    }
    obj.value = obj.value.replace(/[^\d.]/g, "");
    obj.value = obj.value.replace(/^\./g, "");
    obj.value = obj.value.replace(/\.{2,}/g, ".");
    obj.value = obj.value.replace(".", "$#$").replace(/\.replace/g, "").replace("$#$", ".");
}

function onlyNumber(obj) {
    if (obj.value.length > 20) {
        obj.value = obj.value.substring(0, 20);
    }
 
    obj.value = obj.value.replace(/[^\d]/g, '');
}

//验证是否为数字
function checkIsNumber(number) {
    //TODO:
}

//验证是否为日期
function checkIsDate(date) {
    //TODO:
}


//验证结束时间是否大于开始时间
function compareDate(startDate, endDate) {
    //TODO:
}

//检查是否为空
function checkIsEmpty() {
    //TODO:
}

//验证下拉框是否已选
function checkSelected() {
    //TODO:
}