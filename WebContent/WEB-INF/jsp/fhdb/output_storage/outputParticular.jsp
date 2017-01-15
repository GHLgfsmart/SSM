<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../system/index/top.jsp"%>
	<style>
			body{
				background:white
			} 
	</style>
	
</head>
<body class="no-skin">

	<c:if test="${pd.TYPE eq 1 }">
		<div class="col-sm-4" style="width:100%;height:100%;margin-top:10px;">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="fa fa-info-circle"></i> 入库详细信息
            </div>
            <div class="panel-body">
               <!-- 面板内容 star-->
				
				<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
					<tr>
						<td style="text-align: center;padding-top: 13px;">单据编号:</td>
						<td style="text-align: center;padding-top: 13px;">物资名称:</td>
						<td style="text-align: center;padding-top: 13px;">仓库名称:</td>
						<td style="text-align: center;padding-top: 13px;">出入库类型:</td>
						<td style="text-align: center;padding-top: 13px;">单据金额:</td>
						<td style="text-align: center;padding-top: 13px;">单据数量:</td>
						<td style="text-align: center;padding-top: 13px;">操作员:</td>
						<td style="text-align: center;padding-top: 13px;">录入时间:</td>
					</tr>
					<tr>		
						<td class='center' style="text-align: center;">${pd.BIANHAO}</td>
						<td class='center' style="text-align: center;">${pd.NAME}</td>
						<td class='center' style="text-align: center;">${pd.WARNAME}</td>
						<td class='center' style="text-align: center;">${pd.OPTNAME}</td>
						<td class='center' style="text-align: center;">${pd.MONEY}</td>
						<td class='center' style="text-align: center;">${pd.NUMBER_OF}</td>
						<td class='center' style="text-align: center;">${pd.USERNAME}</td>
						<td class='center' style="text-align: center;">${pd.ENTRY_TIME}</td>
					</tr>
				</table>
				<div style="height:40px;"></div>
				<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
					<tr>
						<td style="text-align: center;padding-top: 13px;">最后修改时间:</td>
						<td style="text-align: center;padding-top: 13px;">原始单号:</td>
						<td style="text-align: center;padding-top: 13px;">状态:</td>
						<td style="text-align: center;padding-top: 13px;">备注:</td>
					</tr>
					<tr>
						<td class='center' style="text-align: center;">${pd.UPDATE_TIME}</td>
						<td class='center' style="text-align: center;">${pd.RAW_NUMBER}</td>
						<td class='center' style="text-align: center;">
							<c:if test="${pd.STATE == 0 }">待检验</c:if>
							<c:if test="${pd.STATE == 1 }">已检验</c:if>
							<c:if test="${pd.STATE == 2 }">不合格</c:if>
						</td>
						<td style="text-align: center;"> ${pd.NOTE }</td>
					</tr>
				</table>
				               
               <!-- 面板内容 end-->
            </div>
        </div>
    </div>
	</c:if>
	<c:if test="${pd.TYPE eq 2 }">
		<div class="col-sm-4" style="width:100%;height:100%;margin-top:10px;">
	        <div class="panel panel-info">
	            <div class="panel-heading">
	                <i class="fa fa-info-circle"></i> 出库详细信息
	            </div>
	            <div class="panel-body">
	               <!-- 面板内容 star-->
					
					<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
						<tr>
							<td style="text-align: center;padding-top: 13px;">单据编号:</td>
							<td style="text-align: center;padding-top: 13px;">物资名称:</td>
							<td style="text-align: center;padding-top: 13px;">仓库名称:</td>
							<td style="text-align: center;padding-top: 13px;">出入库类型:</td>
							<td style="text-align: center;padding-top: 13px;">单据金额:</td>
							<td style="text-align: center;padding-top: 13px;">单据数量:</td>
							<td style="text-align: center;padding-top: 13px;">操作员:</td>
							<td style="text-align: center;padding-top: 13px;">录入时间:</td>
						</tr>
						<tr>		
							<td class='center' style="text-align: center;">${pd.BIANHAO}</td>
							<td class='center' style="text-align: center;">${pd.NAME}</td>
							<td class='center' style="text-align: center;">${pd.WARNAME}</td>
							<td class='center' style="text-align: center;">${pd.OPTNAME}</td>
							<td class='center' style="text-align: center;">${pd.MONEY}</td>
							<td class='center' style="text-align: center;">${pd.NUMBER_OF}</td>
							<td class='center' style="text-align: center;">${pd.USERNAME}</td>
							<td class='center' style="text-align: center;">${pd.ENTRY_TIME}</td>
						</tr>
					</table>
					<div style="height:40px;"></div>
					<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
						<tr>
							<td style="text-align: center;padding-top: 13px;">最后修改时间:</td>
							<td style="text-align: center;padding-top: 13px;">原始单号:</td>
							<td style="text-align: center;padding-top: 13px;">审核人:</td>
							<td style="text-align: center;padding-top: 13px;">状态:</td>
							<td style="text-align: center;padding-top: 13px;">备注:</td>
						</tr>
						<tr>
							<td class='center' style="text-align: center;">${pd.UPDATE_TIME}</td>
							<td class='center' style="text-align: center;">${pd.RAW_NUMBER}</td>
							<td class='center' style="text-align: center;">
								<c:if test="${empty pd.AUDITOR}">暂无</c:if>
								<c:if test="${!empty pd.AUDITOR}">${pd.AUDITOR}</c:if>
							</td>
							<td class='center' style="text-align: center;">
								<c:if test="${pd.STATE == 0 }">待检验</c:if>
								<c:if test="${pd.STATE == 1 }">已检验</c:if>
								<c:if test="${pd.STATE == 2 }">不合格</c:if>
								<c:if test="${pd.STATE == 3 }">审核成功</c:if>
							</td>
							<td style="text-align: center;"> ${pd.NOTE }</td>
						</tr>
					</table>
					               
	               <!-- 面板内容 end-->
	            </div>
	        </div>
	    </div>
	</c:if>
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script>
		$(top.hangge());//关闭加载状态
		$(document).ready(function(){ 
			$(top.hangge());//关闭加载状态
			$(top.hangge());//关闭加载状态
		}); 
	</script>
</body>
</html>