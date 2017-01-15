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

		<div class="col-sm-4" style="width:100%;height:100%;margin-top:10px;">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="fa fa-info-circle"></i> 物资详细信息
            </div>
            <div class="panel-body">
               <!-- 面板内容 star-->
				
				<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
					<tr>
						<td style="text-align: center;padding-top: 13px;">单据编号:</td>
						<td style="text-align: center;padding-top: 13px;">物资名称:</td>
						<td style="text-align: center;padding-top: 13px;">拼音简码:</td>
						<td style="text-align: center;padding-top: 13px;">条形码:</td>
						<td style="text-align: center;padding-top: 13px;">供应商:</td>
						<td style="text-align: center;padding-top: 13px;">商品数量:</td>
						<td style="text-align: center;padding-top: 13px;">单位(件):</td>
						<td style="text-align: center;padding-top: 13px;">录入时间:</td>
					</tr>
					<tr>		
						<td class='center' style="text-align: center;">${pd.BIANHAO}</td>
						<td class='center' style="text-align: center;">${pd.NAME}</td>
						<td class='center' style="text-align: center;">${pd.PINYIN}</td>
						<td class='center' style="text-align: center;">${pd.BAR_CODE}</td>
						<td class='center' style="text-align: center;">${pd.SUPNAME}</td>
						<td class='center' style="text-align: center;">${pd.COUNT}</td>
						<td class='center' style="text-align: center;">${pd.UNIT}</td>
						<td class='center' style="text-align: center;">${pd.ENTRY_TIME}</td>
					</tr>
				</table>
				<div style="height:40px;"></div>
				<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
					<tr>
						<td style="text-align: center;padding-top: 13px;">最后修改时间:</td>
						<td style="text-align: center;padding-top: 13px;">操作员:</td>
						<td style="text-align: center;padding-top: 13px;">状态:</td>
						<td style="text-align: center;padding-top: 13px;">备注:</td>
					</tr>
					<tr>
						<td class='center' style="text-align: center;">${pd.UPDATE_TIME}</td>
						<td class='center' style="text-align: center;">${pd.OPERATOR}</td>
						<td class='center' style="text-align: center;">
							<c:if test="${pd.STATE == 0 }">待入库</c:if>
							<c:if test="${pd.STATE == 1 }">已入库</c:if>
							<c:if test="${pd.STATE == 2 }">已出库</c:if>
						</td>
						<td style="text-align: center;"> ${pd.NOTE }</td>
					</tr>
				</table>
				               
               <!-- 面板内容 end-->
            </div>
        </div>
    </div>
	
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