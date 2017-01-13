<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.text.*"%>
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
<link rel="stylesheet" href="static/js/common/jbox.css" />
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="static/js/common/brief_code.js"></script><!-- 引用拼音方法JS -->
</head>
<body class="no-skin">
<%-- 	session：${pd.USERNAME}
	session:<%=session.getAttribute("user")%> --%>
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container" style="margin-top:30px;">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
								<form action="driver/${msg }.do" name="driverForm" id="driverForm" method="post">
									<input type="hidden" name="ID" id="ID" value="${pd.ID }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">姓名:</td>
											<td><input type="text" name="NAME" id="NAME" value="${pd.NAME }"  style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">年龄:</td>
											<td><input type="text" name="AGE" id="AGE" onblur="check1()" value="${pd.AGE }" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">电话号码:</td>
											<td><input type="text" name="PHONE" id="PHONE" onblur="check2('${pd.ID }')" value="${pd.PHONE }" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">电子邮箱:</td>
											<td><input type="text" name="EMAIL" id="EMAIL" onblur="check3('${pd.ID }')"  value="${pd.EMAIL }" style="width:98%;"/></td>
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
	<script type="text/javascript" src="static/js/common/jquery.jBox-2.3.min.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.jBox-zh-CN.js"></script>
	<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
</body>
<script type="text/javascript">
    $(top.hangge());
	$(document).ready(function(){
		if($("#user_id").val()!=""){
			$("#loginname").attr("readonly","readonly");
			$("#loginname").css("color","gray");
		}
	}); 
	//保存
	function save(){
		if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NAME").focus();
			return false;
		}
		
		if($("#AGE").val()==""){
			$("#AGE").tips({
				side:3,
	            msg:'输入年龄',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#AGE").focus();
			return false;
		}
		
		if($("#AGE").val() < 20 || $("#AGE").val() >60) {
			 $("#AGE").tips({
					side:3,
		            msg:'年龄不符合法定驾驶年龄,(20-60)',
		            bg:'#AE81FF',
		            time:2
	         });
			 $("#AGE").val("");
			 return false;
		 }
		
		if($("#PHONE").val()==""){
			$("#PHONE").tips({
				side:3,
	            msg:'输入电话号码',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}
		
		if($("#EMAIL").val()==""){
			$("#EMAIL").tips({
				side:3,
	            msg:'输入电子邮件',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}
		
		$("#driverForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
		
	}
	
	$(function() {
		//下拉框
		if(!ace.vars['touch']) {
			$('.chosen-select').chosen({allow_single_deselect:true}); 
			$(window)
			.off('resize.chosen')
			.on('resize.chosen', function() {
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			}).trigger('resize.chosen');
			$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
				if(event_name != 'sidebar_collapsed') return;
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			});
			$('#chosen-multiple-style .btn').on('click', function(e){
				var target = $(this).find('input[type=radio]');
				var which = parseInt(target.val());
				if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
				 else $('#form-field-select-4').removeClass('tag-input-style');
			});
		}
	});
	
	
	function check1(){
		 var temp=/^\d+(\.\d+)?$/;
		 var s = document.getElementById("AGE");
		 if(temp.test(s.value)==false){
			 $("#AGE").tips({
					side:3,
		            msg:'请输入整数',
		            bg:'#AE81FF',
		            time:2
	         });
			 $("#AGE").val("");
		 }
	}
	
	function check2(ID){
		var temp=/^1[3,5,8]\d{9}$/;
		var s = document.getElementById("PHONE");
		if(temp.test(s.value)==false){
			 $("#PHONE").tips({
					side:3,
		            msg:'请输入正确的手机号码',
		            bg:'#AE81FF',
		            time:3
	         });
			 $("#PHONE").val("");
		 }
		var PHONE = $.trim($("#PHONE").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>driver/hasN.do',
	    	data: {PHONE:PHONE,ID:ID,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#PHONE").tips({
							side:3,
				            msg:'号码 '+PHONE+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#PHONE").val('');
				 }
			}
		});
	}
	
	function check3(ID){
		var temp=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		var s = document.getElementById("EMAIL");
		if(temp.test(s.value)==false){
			 $("#EMAIL").tips({
					side:3,
		            msg:'请输入正确的邮箱',
		            bg:'#AE81FF',
		            time:3
	         });
			 $("#EMAIL").val("");
		 }
		var EMAIL = $.trim($("#EMAIL").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>driver/hasE.do',
	    	data: {EMAIL:EMAIL,ID:ID,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱 '+EMAIL+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#EMAIL").val('');
				 }
			}
		});
	}
</script>
</html>