<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="${pageContext.request.contextPath}/static/highcharts4/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/highcharts4/js/highcharts.js" type="text/javascript"></script> 
<script type="text/javascript">
function onname() {
	var ids='${data3}';
	var ids1='${data4}';
	var ids2='${data5}';
	var ids3='${data6}';
	var chart=new Highcharts.Chart({
		chart: {
			renderTo:'container',
            type: 'column',
            events:{
            	load:function(event){
            
            	}
            }
        },
        title: {
            text: '入库计划单差异报表'
        },
        xAxis: {
        	categories: [
                '前15天数据',
                '后15天数据'
            ]
        },
        yAxis: {
            title: {
                text: '入库数量(/件)'
            }
        },
        series: [{
            name: '入库总数量',
            data: eval(ids)
        }, {
            name: '坏货数量',
            data: eval(ids1)
        }, {
            name: '缺货数量',
            data: eval(ids2)
        }, {
            name: '最终入库',
            data: eval(ids3)
        }]
	});
}
 
</script>
<title>Insert title here</title>
</head>
<body style="margin: 50px" onload="onname()">
 <div id="container" style="min-width: 800px;height: 400px"></div>
</body>
<script type="text/javascript">
$(top.hangge());
</script>
</html>