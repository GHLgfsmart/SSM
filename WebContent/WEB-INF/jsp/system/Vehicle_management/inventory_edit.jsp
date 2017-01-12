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
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
								<form action="inventory/${msg }.do" name="inventoryForm" id="inventoryForm" method="post">
									<input type="hidden" name="ID" id="ID" value="${pd.ID }"/>
									<input type="hidden" name="MATERIALSID" id="MATERIALSID" value="${pd.MATERIALS_ID }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr hidden="true">
											<td style="width:79px;text-align: right;padding-top: 13px;">编号:</td>
											<td><input type="text" name="BIANHAO" id="BIANHAO" value="${pd.BIANHAO }" maxlength="32" placeholder="这里输入编号" title="编号" style="width:98%;" onblur="hasN('${pd.ID }')"/></td>
										</tr>
										<tr hidden="true">
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">物资:</td>
											<td>
												<input type="hidden" name="MATERIALS_ID" id="MATERIALS_ID" />
			 									<input type="text" name="PRO_NAME" id="PRO_NAME" value="${pd.PRO_NAME}" maxlength="30" placeholder="这里选择物资" title="物资" style="width:80%;" readonly="readonly"/>
												<button class="btn btn-mini radius" onclick="elect();" type="button">选择</button>
											</td>
										</tr>
										<c:if test="${pd.ID == null }">
											<tr>
												<td style="width:79px;text-align: right;padding-top: 13px;">操作员:</td>
												<td><input type="text" name="INSPECTOR" id="INSPECTOR"  value="${pd.username}"  maxlength="32" readonly="readonly" style="width:98%;"/></td>
											</tr>
											<tr>
												<td style="width:100px;text-align: right;padding-top: 13px;">录入时间:</td>
												<td>
													<input class="span10 date-picker" name="ENTRY_TIME" id="ENTRY_TIME"  value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:148px;"/>
												</td>
											</tr>
											<%-- <tr>
												<td style="width:79px;text-align: right;padding-top: 13px;">最后修改时间:</td>
												<td>
													<input class="span10 date-picker" name="UPDATE_TIME" id="UPDATE_TIME"  value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:148px;"/>
												</td>
											</tr> --%>
										</c:if>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">实际数量:</td>
											<td><input type="text" name="MANY" id="MANY" onblur="check()" value="${pd.MANY }"  style="width:98%;"/></td>
										</tr>
										<%-- <c:if test="${pd.ID == null }"> --%>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">实际库存:</td>
											<td><input type="text" name="PRACTICAL" id="PRACTICAL" value="${pd.PRACTICAL }" style="width:98%;" readonly="readonly"/></td>
										</tr>
										<%-- </c:if>
										<c:if test="${pd.ID != null }">
											<tr>
												<td style="width:79px;text-align: right;padding-top: 13px;">实际库存:</td>
												<td><input type="text" name="PRACTICAL" id="PRACTICAL" value="${pd.PRACTICAL }" style="width:98%;" readonly="readonly"/></td>
											</tr>
										</c:if> --%>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">损益合计:</td>
											<td><input type="text" name="DECREASE_COUNT" id="DECREASE_COUNT"  value="${pd.DECREASE_COUNT }" readonly="readonly" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">备注:</td>
											<td><input type="text" name="NOTE" id="NOTE"  value="${pd.NOTE }" style="width:98%;"/></td>
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
		if($("#PRO_NAME").val()==""){
			$("#PRO_NAME").tips({
				side:3,
	            msg:'选择产品',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PRO_NAME").focus();
			return false;
		}
		
		if($("#MANY").val()==""){
			$("#MANY").tips({
				side:3,
	            msg:'输入实际数量',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#MANY").focus();
			return false;
		}
		
		
		$("#inventoryForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
		
	}
	
	/**选择物资*/
	var m_Information = "";
	var mid = "";
	var co = "";
	var idsid=document.getElementById('MATERIALSID').value;
	function elect(){
	    jBox.open(
	        "iframe:<%=basePath%>inventory/testPage.do",
	        "选择", 680, 360,
	        {buttons: {}, iframeScrolling: 'yes', showClose: true,
	            closed:function (){
	                $("#PRO_NAME").val(m_Information);
	                $("#PRACTICAL").val(co);
	                $("#MATERIALS_ID").val(mid);
	                $("#MATERIALSID").val(idsid);
	            }
	        }
	    );
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
	
	//判断编码是否存在
	function hasN(ID){
		var BIANHAO = $.trim($("#BIANHAO").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>inventory/hasN.do',
	    	data: {BIANHAO:BIANHAO,ID:ID,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#BIANHAO").tips({
							side:3,
				            msg:'编号 '+BIANHAO+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#BIANHAO").val('');
				 }
			}
		});
	}
	
	function check(){
		 var temp=/^\d+(\.\d+)?$/;
		 var s = document.getElementById("MANY");
		 if(temp.test(s.value)==false){
			 $("#MANY").tips({
					side:3,
		            msg:'请输入整数',
		            bg:'#AE81FF',
		            time:3
	         });
			 $("#MANY").val("");
			 $("#DECREASE_COUNT").val("");
		 }else {
			 doVerify();
		 }
	}
	
	function doVerify(){
		
		var MANY = $("#MANY").val();
		var PRACTICAL = $("#PRACTICAL").val();
		var DECREASE_COUNT = MANY-PRACTICAL;
		$("#DECREASE_COUNT").val(DECREASE_COUNT);
	}
</script>
</html>