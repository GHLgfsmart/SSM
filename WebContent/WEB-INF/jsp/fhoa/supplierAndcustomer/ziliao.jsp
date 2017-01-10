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
                <i class="fa fa-info-circle"></i> 供应商详细信息
            </div>
            <div class="panel-body">
               <!-- 面板内容 star-->
				
				<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
					<tr>
						<td style="text-align: center;padding-top: 13px;">名称:</td>
						<td style="text-align: center;padding-top: 13px;">拼音简码:</td>
						<td style="text-align: center;padding-top: 13px;">类型:</td>
						<td style="text-align: center;padding-top: 13px;">状态:</td>
						<td style="text-align: center;padding-top: 13px;">联系人:</td>
						<td style="text-align: center;padding-top: 13px;">联系电话:</td>
						<td style="text-align: center;padding-top: 13px;">传真:</td>
						<td style="text-align: center;padding-top: 13px;">邮件:</td>
						
					</tr>
					<tr>		
						<td class='center' style="text-align: center;">${obj.SUPNAME}</td>
						<td class='center' style="text-align: center;">${obj.PINYIN}</td>
						<td class='center' style="text-align: center;"> ${obj.NAME }</td>
						<td class='center' style="text-align: center;"> 
							<c:if test="${obj.STATE == 0 }">合作</c:if>
							<c:if test="${obj.STATE == 1 }">流失</c:if>
						</td>
						<td class='center' style="text-align: center;"> ${obj.CONTACT }</td>
						<td class='center' style="text-align: center;"> ${obj.PHONE}</td>
						<td class='center' style="text-align: center;"> ${obj.FAX_PHONE }</td>
						<td class='center' style="text-align: center;"> ${obj.MAIL}</td>
					</tr>
				</table>
				<div style="height:40px;"></div>
				<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
					<tr>
						<td style="text-align: center;padding-top: 13px;">地址:</td>
						<td style="text-align: center;padding-top: 13px;">网站地址:</td>
						<td style="text-align: center;padding-top: 13px;">开户行:</td>
						<td style="text-align: center;padding-top: 13px;">银行账号:</td>
						<td style="text-align: center;padding-top: 13px;">企业税号:</td>
						<td style="text-align: center;padding-top: 13px;">备注:</td>
					</tr>
					<tr>
						<td class='center' style="text-align: center;"> ${address}</td>
						<td class='center' style="text-align: center;"> ${obj.SITE_ADDRESS }</td>
						<td class='center' style="text-align: center;"> ${obj.OPEN_ACCOUNT }</td>
						<td class='center' style="text-align: center;"> ${obj.BANK }</td>
						<td style="text-align: center;"> ${obj.EIN }</td>
						<td style="text-align: center;"> ${obj.NOTE }</td>
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