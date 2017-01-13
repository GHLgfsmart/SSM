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
				<div class="page-content" id="prints">
					<h3 style="font-weight:bold;text-align:center;">宏图软件物流中心拣货单</h3>
					<div class="row">
						<div class="col-xs-4">
							<label>单号：${picking.BIANHAO}</label>
						</div>
						<div class="col-xs-4">
							<label>出库单数：${picking.MATCOUNT}</label>
						</div>
						<div class="col-xs-4">
							<c:if test="${picking.STATE eq 1}">
								<label>装车状态：未装车</label>
							</c:if>
							<c:if test="${picking.STATE eq 2}">
								<label>装车状态：已装车</label>
							</c:if>
						</div>
					</div>
					
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="outstorage/pickingList.do" method="post" name="Form" id="Form">
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">出库单据</th>
									<th class="center">物资名称</th>
									<th class="center">单位</th>
									<th class="center">仓库名称</th>
									<th class="center">单据金额</th>
									<th class="center">物资数量</th>
									<th class="center">原始单号</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.BIANHAO}</td>
											<td class='center'>${var.NAME}</td>
											<td class='center'>${var.UNIT}</td>
											<td class='center'>${var.WARNAME}</td>
											<td class='center'>${var.MONEY}</td>
											<td class='center'>${var.COUNT}</td>
											<td class='center'>${var.RAW_NUMBER}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
						</form>
						</div>
						<!-- /.col -->
					</div>
					<div class="row">
						<div class="col-xs-6">
							<label>合计:</label>
						</div>
						<div class="col-xs-3" style="text-align:center;text-indent:40px;">
							<label>${picking.mtotal}</label>
						</div>
						<div class="col-xs-3" style="text-align:left;text-indent:20px;">
							<label>${picking.ctotal}</label>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-6" style="text-indent:30px;">
							<label>填单人：${picking.INSPECTOR}</label>
						</div>
						<div class="col-xs-6" style="text-align:center;">
							<label>生成时间：${picking.TIME}</label>
						</div>
					</div>
					<!-- /.row -->
					
				</div>
				<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<a class="btn btn-xs btn-info" title="打印" onclick="windowprint();">
										<i class="ace-icon fa fa-print bigger-120" title="打印"></i>
									</a>
									<a class="btn btn-sm btn-info" onclick="history.go(-1);">返回上一级</a>
								</td>
							</tr>
						</table>
				</div>
				<!-- /.page-content -->
			</div>
		</div>

	</div>

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="/WEB-INF/jsp/system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	</body>

<script type="text/javascript">
$(top.hangge());//关闭加载状态	
//检索
function tosearch(){
	top.jzts();
	$("#Form").submit();
}
function windowprint() {
	var headstr = "<html><head><title></title></head><body>";  
	var footstr = "</body>";
	var printDatad = document.getElementById("prints").innerHTML; 
	var oldstr = document.body.innerHTML;  
	document.body.innerHTML = headstr+printDatad+footstr; 
	window.print();  
	document.body.innerHTML = oldstr; 
	return false;
	
	/* var f = document.getElementById('print').innerHTML;
	window.print();
	location.reload([true]); */
}
</script>
</html>
