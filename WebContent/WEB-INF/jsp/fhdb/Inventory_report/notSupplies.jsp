<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="/WEB-INF/jsp/system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<form action="TheReport/notThereport.do" method="post" name="alertForm" id="alertForm">
							<table style="margin-top:10px; margin-left: 150px">
								<tr>
									<td style="padding-left:2px; font-size: 16px;"><b>按日期搜索:</b></td>
									<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" placeholder="开始日期"/></td>
									<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginEnd" id="lastLoginEnd"  value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" placeholder="结束日期"/></td>
									
									<c:if test="${QX.cha == 1 }">
										<td style="vertical-align:top;padding-left:4px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
									</c:if>
									<td style="padding-left:2px;"><input type="reset" id="cz" value="刷新"></td>
								</tr>
							</table>
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="container" style="min-width: 550px;height: 550px"></div>
	<!-- 页面底部js¨ -->
	<%@ include file="/WEB-INF/jsp/system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script src="static/js/highcharts.js"></script> 
</body>

<script type="text/javascript">
$(top.hangge());



//按日期查询数据并已饼状图形显示
function searchs() {
	$(function () {
		var lastLoginStart = $("#lastLoginStart").val();
		var lastLoginEnd = $("#lastLoginEnd").val();
		var chart=new Highcharts.Chart({
			chart: {
				renderTo:'container',
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false,
	            events:{
	            	load:function(event){
	            		var series=this.series[0];
	            		// ajax请求后台加载数据
	            		$.post("${pageContext.request.contextPath}/TheReport/notThereport.do",{'lastLoginStart':lastLoginStart,'lastLoginEnd':lastLoginEnd},function(result){
	            			var xArr=new Array();
	            			for(var i=0;i<result.length;i++){
	            				xArr[i]=new Array();
	            				xArr[i][0]=result[i].NAME;
	            				xArr[i][1]=result[i].COUNT;
	            				xArr[i][2]=result[i].UNIT;
	            			}
	            			series.setData(xArr);
	            		},"json");
	            	}
	            }
	        },
	        title: {
	            text: '待入库物资统计'
	        },
	        tooltip: {
	        	formatter:function(){
	        		return '<b>'+this.point.name+'</b>:'+Highcharts.numberFormat(this.percentage,1)+'% ('+'数量:'+this.y+'件)'	
	        	}
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: true,
	                    color: '#000000',
	                    connectorColor: '#000000',
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '比例',
	            data: [
	               
	            ]
	        }]
		});
		});
}

//统计全部未入库的物资
$(function () {
	var chart=new Highcharts.Chart({
		chart: {
			renderTo:'container',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            events:{
            	load:function(event){
            		var series=this.series[0];
            		// ajax请求后台加载数据
            		$.post("${pageContext.request.contextPath}/TheReport/notThereport.do",function(result){
            			var xArr=new Array();
            			for(var i=0;i<result.length;i++){
            				xArr[i]=new Array();
            				xArr[i][0]=result[i].NAME;
            				xArr[i][1]=result[i].COUNT;
            				xArr[i][2]=result[i].UNIT;
            			}
            			series.setData(xArr);
            		},"json");
            	}
            }
        },
        title: {
            text: '待入库物资统计'
        },
        tooltip: {
        	formatter:function(){
        		return '<b>'+this.point.name+'</b>:'+Highcharts.numberFormat(this.percentage,1)+'% ('+'数量:'+this.y+'件)'	
        	}
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: '比例',
            data: [
               
            ]
        }]
	});
	});

$(function(){
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
});
</script>
</html>
