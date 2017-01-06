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
<%@ include file="../../system/index/top.jsp"%>
<link rel="stylesheet" href="static/js/common/jbox.css" />
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
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
								<form action="warehouse/${msg }.do" name="pdForm" id="pdForm" method="post">
									<input type="hidden" name="ID" id="ID" value="${pd.ID }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">仓库名称:</td>
											<td><input type="text" name="WARNAME" id="WARNAME" value="${pd.WARNAME }" maxlength="32" placeholder="这里输入仓库名称" title="仓库名称"  style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">负责人:</td>
											<td>
												<input type="hidden" name="USER_ID" id="USER_ID" value="${pd.USER_ID }"/>
												<input type="text" name="USERNAME" id="USERNAME" value="${pd.USERNAME }" readonly maxlength="32" style="width:85%;"/>
												<button class="btn btn-mini radius" onclick="select();" type="button">选择</button>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">仓库大小:</td>
											<td>
												<input type="text" name="SIZE" id="SIZE" value="${pd.SIZE }"  maxlength="32"style="width:98%;"/>
												
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">仓库上限:</td>
											<td><input type="text" name="UPPER_LIMIT" id="UPPER_LIMIT" value="${pd.UPPER_LIMIT }"  maxlength="32" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">仓库下限:</td>
											<td><input type="text" name="LOWER_LIMIT" id="LOWER_LIMIT" value="${pd.LOWER_LIMIT }"  maxlength="32" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">实际库存:</td>
											<td><input type="text" name="PRACTICAL" id="PRACTICAL"  value="${pd.PRACTICAL }" maxlength="32" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">仓库地址:</td>
											<td><input type="text" name="ADDRESS" id="ADDRESS"  value="${pd.ADDRESS }" maxlength="32" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">备注:</td>
											<td><input type="text" name="NOTE" id="NOTE"value="${pd.NOTE }" maxlength="64" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10">
												<a class="btn btn-mini btn-primary" onclick="savepd();">保存</a>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<script type="text/javascript" src="static/js/common/jquery.jBox-2.3.min.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.jBox-zh-CN.js"></script>
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
	$(document).ready(function(){
		if($("#pd_id").val()!=""){
			$("#loginname").attr("readonly","readonly");
			$("#loginname").css("color","gray");
		}
	});
	
	//保存
	function savepd(){
		if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'输入仓库名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NAME").focus();
			return false;
		}
		var temp=/^\d+(\.\d+)?$/;
		if($("#USERNAME").val()==""){
			$("#USERNAME").tips({
				side:3,
	            msg:'请输入仓库负责人',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#USERNAME").focus();
			return false;
		}
		
		if($("#SIZE").val()==""){
			$("#SIZE").tips({
				side:3,
	            msg:'请输入仓库大小',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#SIZE").focus();
			return false;
		}
		var UPPER_LIMIT=$("#UPPER_LIMIT").val();
		if(UPPER_LIMIT==""){
			$("#UPPER_LIMIT").tips({
				side:3,
	            msg:'请输入仓库上限',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#UPPER_LIMIT").focus();
			return false;
		}else if(temp.test(UPPER_LIMIT)==false){
			 $("#UPPER_LIMIT").tips({
					side:3,
		            msg:'请输入整数',
		            bg:'#AE81FF',
		            time:3
	         });
			 $("#UPPER_LIMIT").focus();
				return false;
		 }
		var LOWER_LIMIT=$("#LOWER_LIMIT").val();
		if(LOWER_LIMIT ==""){
			$("#LOWER_LIMIT").tips({
				side:3,
	            msg:'请输入仓库下限',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#LOWER_LIMIT").focus();
			return false;
		}else if(temp.test(LOWER_LIMIT)==false){
			 $("#LOWER_LIMIT").tips({
					side:3,
		            msg:'请输入整数',
		            bg:'#AE81FF',
		            time:3
	         });
			 $("#LOWER_LIMIT").focus();
				return false;
		 }
		if(parseInt(UPPER_LIMIT) < parseInt(LOWER_LIMIT)){
			$("#LOWER_LIMIT").tips({
				side:3,
	            msg:'仓库下限不能大于仓库上限',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#LOWER_LIMIT").focus();
			return false;
		}
		if($("#PRACTICAL").val()==""){
			$("#PRACTICAL").tips({
				side:3,
	            msg:'请输入仓库现有库存',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PRACTICAL").focus();
			return false;
		}
		if($("#ADDRESS").val()==""){
			$("#ADDRESS").tips({
				side:3,
	            msg:'请输入仓库地址',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#ADDRESS").focus();
			return false;
		}else{
			$("#pdForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
	
	var supplier = "";
	var supid = "";
	function select(){
		jBox.open(
		        "iframe:<%=basePath%>warehouse/testPage.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                $("#USERNAME").val(supplier);
		                $("#USER_ID").val(supid);
		            }
		        }
		    );
	}
</script>
</html>