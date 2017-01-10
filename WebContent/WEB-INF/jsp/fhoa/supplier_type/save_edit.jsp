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
		<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
		<link rel="stylesheet" rel="stylesheet" href="static/ace/css/sweetalert.css" />
		<script type="text/javascript" src="static/ace/js/jquery-ui.js"></script>
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12" style="margin-top:80px;">
					
					<form action="categories/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="UID" id="UID" value="${null == UID ? ID : UID}"/>
						<c:if test="${msg == 'edit' }">
							<input type="hidden" name="ID" id="ID" value="${pd.ID }">
						</c:if>
						<div id="zhongxin">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:79px;height:50px;text-align: right;padding-top: 13px;">上级:</td>
								<td>
									<c:if test="${UID == '0' }">
										<div class="col-xs-4 label label-lg label-light arrowed-in arrowed-right">
											<b>(无) 此部门为顶级</b>
										</div>
									</c:if>
									<c:if test="${UID != '0' && UID != null }">
										<div class="col-xs-4 label label-lg label-light arrowed-in arrowed-right">
											<b>${pds.NAME}</b>
										</div>
									</c:if>
								</td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="50" placeholder="这里输入名称" title="名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="NOTE" id="NOTE" value="${pd.NOTE}" maxlength="50" placeholder="这里输入名称" title="名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td class="center" colspan="10" >
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
				return false;
			}
			if($("#NOTE").val()==""){
				$("#type").tips({
					side:3,
		            msg:'请选择类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NOTE").focus();
				return false;
			}
			checkName();
		}
		function checkName(){
			var NAME=$("#NAME").val();
			var ckes='${msg}';
			var url = '<%=basePath%>categories/checkName.do?NAME='+NAME+'&ckes='+ckes;
			$.get(url,function(data){
				$(top.hangge());//关闭加载状态
				if(data == 'success'){
					$("#Form").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				}else {
					$("#NAME").tips({
						side:3,
			            msg:'该供应商类型已存在！',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#NAME").focus();
					return false;
				}
			});
		}
		</script>
</body>
</html>