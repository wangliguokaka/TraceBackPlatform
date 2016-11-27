<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LineUserShow.aspx.cs" Inherits="SalesManage_LineUserShow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link href="../Css/style.css" rel="stylesheet" />
      <script type="text/javascript" src="../Scripts/jquery-1.5.2.min.js"></script>
     <%--<script type="text/javascript" src="../Juery/jquery-1.10.2.js"></script>--%>
     <link href="../Css/layer.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/highcharts.js"></script>
        <%--取消下面注释就可以在右上角看到效果 在框架内无法保存 需要设置安全站点http://export.highcharts.com/和安全级别--%>
    <%--<script type="text/javascript" src="../Scripts/exporting.js" charset="gb2312"></script>--%>
     <script type="text/javascript" src="../Scripts/layer.js"></script>
    <%--<script type="text/javascript" src="../Scripts/theme/dark-green.js"></script>--%>
   <script type="text/javascript">

       $(document).ready(function () {
           var mydate = new Date();
           $("#yearDrop").val(mydate.getFullYear());
           $("#monthDrop").val(mydate.getMonth()+1);

           DrawChart();
           
       });

       function DrawChart()
       {
          var index =  layer.load(1, {
                shade: [0.1,'#fff'] //0.1透明度的白色背景
           });

           var categories = '';
           var seirals ='';
           $.ajax({
               type: "post",
               url: "LineUserShow.aspx",
               cache: false,
               async: true,
               data: {
                   actiontype: "GetAccessDate", "SelectYear": $("#yearDrop").val(), "SelectMonth": $("#monthDrop").val()
               },
               dataType: "text",
               success: function (data) {
                   //用到这个方法的地方需要重写这个success方法
                   if (data == "0") {
                       layer.msg("数据获取失败！");
                   }
                   else {
                       categories = data.split('|')[0].split(',');
                       seirals = $.parseJSON(data.split('|')[1]);

                       var title = {
                           text: '患者查询记录分析'
                       };
                       var subtitle = {
                           text: ''
                       };
                       var xAxis = {
                           categories: categories,
                           labels: {
                               //rotation: -45, //字体倾斜
                               //align: 'right',
                               //style: { font: 'normal 13px 宋体' }
                           }
                       };
                       var yAxis = {
                           title: {
                               text: '访问量(次)'
                           }
                       };
                       var plotOptions = {
                           line: {
                               dataLabels: {
                                   enabled: true
                               },
                               enableMouseTracking: true
                           }
                       };
                       var series = seirals;

                       var json = {};

                       json.title = title;
                       json.subtitle = subtitle;
                       json.xAxis = xAxis;
                       json.yAxis = yAxis;
                       json.series = series;
                       json.plotOptions = plotOptions;
                       $('#container').highcharts(json);
                       layer.close(index);
                   }
               }
           });

           
       }
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <div style="margin-right:20px;margin-left:50px;margin-top:50px;padding-bottom:10px;border-bottom-width:1px; border-bottom-style:solid;border-bottom-color:#e6e6e6;">
         年份：&nbsp; &nbsp;<select class="ui-button" id="yearDrop">
             <option value=""></option>
             <%foreach (DataRow dr in dtYear.Rows){ %>
                 <option value="<%=dr[0] %>"><%=dr[0] %>年</option>            
             <%} %>
            
         </select>
         &nbsp; &nbsp; 月份：&nbsp; &nbsp;<select class="ui-button" id="monthDrop">
             <option></option>
             <%for (int i = 1; i <= 12; i++)
                 { %>
             <option value="<%=i %>"><%=i %>月</option>        
             <%} %>
         </select> &nbsp; &nbsp; &nbsp; &nbsp;
         <button type="button" value="" class="ui-button" onclick="DrawChart()">查询</button>
         
     </div>
       
  <div id="container">
    </div>
    </form>
</body>
</html>
