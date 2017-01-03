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
		
	
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin">
						<table class="table table-striped table-bordered" style="margin-top:10px;font-align:center">
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">名称:</td>
								<td class='center' style="width:30%;text-align: center;">${obj.SUPNAME}</td>
								<td style="width:20%;text-align: center;padding-top: 13px;">拼音简码:</td>
								<td class='center' style="width:30%;text-align: center;">${obj.PINYIN}</td>
							</tr>
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">类型:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.NAME }</td>
								<td style="width:20%;text-align: center;padding-top: 13px;">状态:</td>
								<td class='center' style="width:30%;text-align: center;"> 
									<c:if test="${obj.STATE == 0 }">合作</c:if>
									<c:if test="${obj.STATE == 1 }">流失</c:if>
								</td>
							</tr>
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">联系人:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.CONTACT }</td>
								<td style="width:20%;text-align: center;padding-top: 13px;">联系电话:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.PHONE}</td>
							</tr>
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">传真:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.FAX_PHONE }</td>
								<td style="width:20%;text-align: center;padding-top: 13px;">邮件:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.MAIL}</td>
							</tr>
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">地址:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.ADDRESS }</td>
								<td style="width:20%;text-align: center;padding-top: 13px;">网站地址:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.SITE_ADDRESS }</td>
							</tr>
							
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">开户行:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.OPEN_ACCOUNT }</td>
								<td style="width:20%;text-align: center;padding-top: 13px;">银行账号:</td>
								<td class='center' style="width:30%;text-align: center;"> ${obj.BANK }</td>
							</tr>
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">企业税号:</td>
								<td colspan="3" class='center' style="text-align: center;"> ${obj.EIN }</td>
							</tr>
							<tr>
								<td style="width:20%;text-align: center;padding-top: 13px;">备注:</td>
								<td colspan="3" class='center' style="text-align: center;"> ${obj.NOTE }</td>
							</tr>
						</table>
						</div>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script>
	$(document).ready(function(){ 
		$(top.hangge());//关闭加载状态
	}); 
	</script>
</body>
</html>