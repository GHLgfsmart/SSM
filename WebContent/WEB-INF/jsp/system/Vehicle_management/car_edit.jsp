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
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />

<link rel="stylesheet" href="static/js/common/jbox.css" />
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="static/js/common/brief_code.js"></script><!-- 引用拼音方法JS -->
</head>
<body class="no-skin">
<%-- 	session：${pd.USERNAME}
	session:<%=session.getAttribute("user")%> --%>
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container" style="margin-top:25px;">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
								<form action="car/${msg }.do" name="carForm" id="carForm" method="post">
									<input type="hidden" name="ID" id="ID" value="${pd.ID }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">车牌号:</td>
											<td><input type="text" name="BRAND" id="BRAND" onblur="check1('${pd.ID }')" value="${pd.BRAND }" style="width:100%" /></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">购买时间:</td>
											<td>
												<input class="span10 date-picker" data-date-format="yyyy-mm-dd" type="text" name="TIMES" id="TIMES" value="${pd.TIMES }" style="width:100%" readonly/>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">载重:</td>
											<td><input type="text" name="WEIGHT" id="WEIGHT" onblur="check()" value="${pd.WEIGHT }" style="width:100%" /></td>
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>	
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
		if($("#BRAND").val()==""){
			$("#BRAND").tips({
				side:3,
	            msg:'输入车牌号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BRAND").focus();
			return false;
		}
		
		if($("#TIMES").val()==""){
			$("#TIMES").tips({
				side:3,
	            msg:'输入购买日期',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#TIMES").focus();
			return false;
		}
		
		if($("#WEIGHT").val()==""){
			$("#WEIGHT").tips({
				side:3,
	            msg:'输入载重',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#WEIGHT").focus();
			return false;
		}
		
		if($("#WEIGHT").val() < 5 || $("#WEIGHT").val() >40) {
			 $("#WEIGHT").tips({
					side:3,
		            msg:'载重标准为5-40/t)',
		            bg:'#AE81FF',
		            time:2
	         });
			 $("#WEIGHT").val("");
			 return false;
		 }
		
		$("#carForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
		
	}
	
	function check1(ID){
		var BRAND = $.trim($("#BRAND").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>car/hasNum.do',
	    	data: {BRAND:BRAND,ID:ID,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#BRAND").tips({
							side:3,
				            msg:'该车牌号 '+BRAND+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#BRAND").val('');
				 }
			}
		});
		var reg =/^[0-9a-zA-Z]{4}$/; 
		var obj = document.getElementById("BRAND");  
		if(!reg.test(obj.value)){  
			$("#BRAND").tips({
				side:3,
	            msg:'车牌号为4位',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BRAND").val("");
	    }  
	}
	
	$(function() {
		
		/* $(".form_datetime").datetimepicker({
		 	minView:'month',            //设置时间选择为年月日 去掉时分秒选择
		    format:'yyyy-mm-dd',
		    autoclose:true,
		    todayHighlight:true,//是否高亮当前时间
		    autoclose:true,//当选择一个日期之后是否立即关闭此日期时间选择器

		    todayBtn:true,
		    language:'zh-CN'              //设置时间控件为中文
		}); */
		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
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
	
	
	function check(){
		 var temp=/^\d+(\.\d+)?$/;
		 /* var temp=^[+-]?\d+(\.\d+)?$; */
		 var s = document.getElementById("WEIGHT");
		 if(temp.test(s.value)==false){
			 $("#WEIGHT").tips({
					side:3,
		            msg:'请输入整数',
		            bg:'#AE81FF',
		            time:2
	         });
			 $("#WEIGHT").val("");
		 }
	}
	 
	
	
</script>
<script type="text/javascript">

</script>
</html>