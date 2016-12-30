<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" type="text/css" href="static/ace/css/sweetalert.css">
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<style>
	textarea {
		padding: 10px;
		vertical-align: top;
		width: 200px;
	}
	textarea:focus {
		outline-style: solid;
		outline-width: 2px;
	}

</style>
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
								<form action="msg/${msg }.do" name="msgForm" id="msgForm" method="post">
									<input type="hidden" name="MSGID" id="MSGID" value="${pd.MSGID }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">标题：</td>
											<td><textarea style='resize: none;width: 98%;' name="MSGTITLE" id="MSGTITLE">${pd.MSGTITLE }</textarea></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">内容：</td>
											<td><textarea style='resize: none;width: 98%;' name="MSGCON" id="MSGCON" >${pd.MSGCON }</textarea></td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10">
												<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
												<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
											</td>
										</tr>
									</table>
									</div>
									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
								</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
	<script src='static/affiche/js/autosize.js'></script>
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script>
	autosize(document.querySelectorAll('textarea'));
</script>
<script type="text/javascript">
	$(top.hangge());
	//保存
	function save(){
		if($("#MSGTITLE").val()==""){
			$("#MSGTITLE").tips({
				side:3,
	            msg:'输入标题',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#MSGTITLE").focus();
			return false;
		}
		if($("#MSGCON").val()==""){
			$("#MSGCON").tips({
				side:3,
	            msg:'输入内容',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#MSGCON").focus();
			return false;
		}
			$("#msgForm").submit();
			swal({
		        title: "系统提示", 
		        text: "操作成功！", 
		        type: "success",
		        timer: 5544400,
		        showConfirmButton: false,
		        confirmButtonColor: "#ec6c62"
		    	});
			$("#zhongxin").hide();
			$("#zhongxin2").show();
	}
</script>
</html>