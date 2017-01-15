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
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
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
								<form action="price/${msg }.do" name="priceForm" id="priceForm" method="post">
									<input type="hidden" name="PRICE_ID" id="PRICE_ID" value="${pd.PRICE_ID }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">存储费:</td>
											<td><input type="number" name="STORAGE" id="STORAGE" value="${pd.STORAGE }" maxlength="32" placeholder="这里输入每件单价" title="存储费" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">理货费:</td>
											<td><input type="number" name="RICHARD" id="RICHARD" value="${pd.RICHARD }" maxlength="32" placeholder="这里输入每件理货费" title="理货费" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">装车费:</td>
											<td><input type="number" name="LOADING" id="LOADING"  value="${pd.LOADING }"  maxlength="32" placeholder="这里输入每件装车费" title="装车费" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">卸车费:</td>
											<td><input type="number" name="UNLOADING" id="UNLOADING"  value="${pd.UNLOADING }"  maxlength="32" placeholder="这里输入每件卸车费" title="卸车费" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">超时费:</td>
											<td><input type="number" name="SURCHARGE" id="SURCHARGE"value="${pd.SURCHARGE }" placeholder="这里输入每件超时费" maxlength="64" title="超时费" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">开始天数:</td>
											<td><input type="number" name="DAYS" id="DAYS"value="${pd.DAYS }" placeholder="输入从什么时候开始的天数" maxlength="64" title="开始的天数" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">超时天数:</td>
											<td><input type="number" name="EVERY_DAYS" id="EVERY_DAYS"value="${pd.EVERY_DAYS }" placeholder="输入每几天超时的天数" maxlength="64" title="超时的天数" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">人工费:</td>
											<td><input type="number" name="ARTIFICIAL" id="ARTIFICIAL"value="${pd.ARTIFICIAL }" placeholder="这里输入每件人工费" maxlength="64" title="人工费" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">备注:</td>
											<td><textarea style='resize: none;width: 98%;' name="WHY" id="WHY" >${pd.WHY }</textarea></td>
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
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script type="text/javascript">
	$(top.hangge());
	//保存
	function save(){
		if($("#STORAGE").val()==""){
			$("#STORAGE").tips({
				side:3,
	            msg:'存储费不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#STORAGE").focus();
		return false;
		}
		if($("#RICHARD").val()==""){
			$("#RICHARD").tips({
				side:3,
	            msg:'理货费不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#RICHARD").focus();
		return false;
		}if($("#LOADING").val()==""){
			$("#LOADING").tips({
				side:3,
	            msg:'装车费不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LOADING").focus();
		return false;
		}if($("#UNLOADING").val()==""){
			$("#UNLOADING").tips({
				side:3,
	            msg:'卸车费不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#UNLOADING").focus();
		return false;
		}if($("#SURCHARGE").val()==""){
			$("#SURCHARGE").tips({
				side:3,
	            msg:'超时费不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SURCHARGE").focus();
		return false;
		}
		var reg = new RegExp("^[0-9]*$");
		if($("#DAYS").val()==""){
			$("#DAYS").tips({
				side:3,
	            msg:'开始时间不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#DAYS").focus();
		return false;
		}
		if(!reg.test($("#DAYS").val())){
			$("#DAYS").tips({
				side:3,
	            msg:'数据格式不正确',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#DAYS").focus();
		return false;
		}if($("#EVERY_DAYS").val()==""){
			$("#EVERY_DAYS").tips({
				side:3,
	            msg:'超时时间不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#EVERY_DAYS").focus();
		return false;
		}
		if(!reg.test($("#EVERY_DAYS").val())){
			$("#EVERY_DAYS").tips({
				side:3,
	            msg:'数据格式不正确',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#EVERY_DAYS").focus();
		return false;
		}if($("#ARTIFICIAL").val()==""){
			$("#ARTIFICIAL").tips({
				side:3,
	            msg:'超时时间不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ARTIFICIAL").focus();
		return false;
		}
		else{
			$("#priceForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
</script>
</html>