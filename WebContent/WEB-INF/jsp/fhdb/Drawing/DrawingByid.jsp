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
		<link rel="stylesheet" href="static/js/common/jbox.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/common/brief_code.js"></script><!-- 引用拼音方法JS -->
	</head>
<body class="no-skin" onload="getNowFormatDate();">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container" style="width：80%;"align="center">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					<form action="Drawing/${amend}.do" name="Form" id="Form" method="post">
									<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
									<input type="hidden" name="UPDATE_TIME" id="UPDATE_TIME" value="${updatetime}"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table style="margin-top: 30px;">
										<tr>
											<td style="margin-right: 90px;padding-top: 50px;">
												业务日期:<input type="date" name="BusinessDate" id="BusinessDate" value="${pd.BusinessDate}" style="width:180px; height:35px;"/>
											</td>
										</tr>
										<tr>
											<td style="margin-right: 90px;padding-top: 50px;">
												调拨说明:<input type="text" name="DRAWING_INST" id="DRAWING_INST" value="${pd.DRAWING_INST}" style="width:180px; height:35px;"/>
											</td>
										</tr>
										<tr>
											<td style="text-align: center; padding-top: 30px;" colspan="10">
												<a class="btn btn-mini btn-primary" onclick="save();">确定</a>
												<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
											</td>
										</tr>
									</table>
									</div>
									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
								</form>
	
					<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
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
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.jBox-2.3.min.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.jBox-zh-CN.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			
			if($("#BusinessDate").val()==""){
				$("#BusinessDate").tips({
					side:3,
		            msg:'业务日期不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BusinessDate").focus();
			return false;
			}
			if($("#DRAWING_INST").val()==""){
				$("#DRAWING_INST").tips({
					side:3,
		            msg:'调拨说明不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DRAWING_INST").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		</script>
</body>
</html>