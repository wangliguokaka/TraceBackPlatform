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


Date.prototype.Format = function (fmt) { //author: meizz   
    var o = {
        "M+": this.getMonth() + 1,                 //月份   
        "d+": this.getDate(),                    //日   
        "h+": this.getHours(),                   //小时   
        "m+": this.getMinutes(),                 //分   
        "s+": this.getSeconds(),                 //秒   
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
        "S": this.getMilliseconds()             //毫秒   
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
//增加行
function addTableRow(objId) {
    $.fn.tables.addRow(objId);
}

function validateRow(tableID, sliceIndex) {
    var ispass = $.fn.tables.validateRow(tableID, sliceIndex);

    if (!ispass) {
        layer.alert("还有必填项未填写！请继续完善后再保存!");
    }

    return ispass;

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

var old_value = "";
var highlightindex = -1;   //高亮

//自动完成
function AutoComplete(auto, search, mylist) {
    if ($("#" + search).val() != old_value || old_value == "") {
        var autoNode = $("#" + auto);   //缓存对象（弹出框）
        var carlist = new Array();
        var n = 0;
        old_value = $("#" + search).val();

        //for (i in mylist) {
        //    if (mylist[i].indexOf(old_value) >= 0) {
        //        carlist[n++] = mylist[i];
        //    }
        //}
        $(mylist).each(function (index, item) {
            if (item.OrderNo.indexOf(old_value) >= 0  ) {
                carlist[n++] = item.OrderNo;
            }
        }
        )
        if (carlist.length == 0) {
            autoNode.hide();
            return;
        }
        autoNode.empty();  //清空上次的记录
        for (i in carlist) {
            var wordNode = carlist[i];   //弹出框里的每一条内容

            var newDivNode = $("<div>").attr("id", i);    //设置每个节点的id值
            newDivNode.attr("style", "font:14px/25px arial;height:25px;padding:0 8px;cursor: pointer;");

            newDivNode.html(wordNode).appendTo(autoNode);  //追加到弹出框

            //鼠标移入高亮，移开不高亮
            newDivNode.mouseover(function () {
                if (highlightindex != -1) {        //原来高亮的节点要取消高亮（是-1就不需要了）
                    autoNode.children("div").eq(highlightindex).css("background-color", "white");
                }
                //记录新的高亮节点索引
                highlightindex = $(this).attr("id");
                $(this).css("background-color", "#ebebeb");
            });
            newDivNode.mouseout(function () {
                $(this).css("background-color", "white");
            });

            //鼠标点击文字上屏
            newDivNode.click(function () {
                //取出高亮节点的文本内容
                var comText = autoNode.hide().children("div").eq(highlightindex).text();
                highlightindex = -1;
                //文本框中的内容变成高亮节点的内容
                $("#" + search).val(comText);

                var arrSelect = $.map(mylist, function (value) {
                    return value.OrderNo == comText ? value : null;//isNaN:is Not a Number的缩写 
                }
               );
                if (arrSelect.length > 0)
                {
                    $("#Bh").val(arrSelect[0].Bh);
                }
                
               
            })
            if (carlist.length > 0) {    //如果返回值有内容就显示出来
                autoNode.show();
            } else {               //服务器端无内容返回 那么隐藏弹出框
                autoNode.hide();
                //弹出框隐藏的同时，高亮节点索引值也变成-1
                highlightindex = -1;
            }
        }
    }

    //点击页面隐藏自动补全提示框
    document.onclick = function (e) {
        var e = e ? e : window.event;
        var tar = e.srcElement || e.target;
        if (tar.id != search) {
            if ($("#" + auto).is(":visible")) {
                $("#" + auto).css("display", "none")
            }
        }
    }

}

(function ($, h, c) { var a = $([]), e = $.resize = $.extend($.resize, {}), i, k = "setTimeout", j = "resize", d = j + "-special-event", b = "delay", f = "throttleWindow"; e[b] = 250; e[f] = true; $.event.special[j] = { setup: function () { if (!e[f] && this[k]) { return false } var l = $(this); a = a.add(l); $.data(this, d, { w: l.width(), h: l.height() }); if (a.length === 1) { g() } }, teardown: function () { if (!e[f] && this[k]) { return false } var l = $(this); a = a.not(l); l.removeData(d); if (!a.length) { clearTimeout(i) } }, add: function (l) { if (!e[f] && this[k]) { return false } var n; function m(s, o, p) { var q = $(this), r = $.data(this, d); r.w = o !== c ? o : q.width(); r.h = p !== c ? p : q.height(); n.apply(this, arguments) } if ($.isFunction(l)) { n = l; return m } else { n = l.handler; l.handler = m } } }; function g() { i = h[k](function () { a.each(function () { var n = $(this), m = n.width(), l = n.height(), o = $.data(this, d); if (m !== o.w || l !== o.h) { n.trigger(j, [o.w = m, o.h = l]) } }); g() }, e[b]) } })(jQuery, this);
//$("#div").resize(function(){...}); 