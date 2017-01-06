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
		<link href="static/ace/css/jquery-ui.css">
		
		<link href="static/SanJiLianDong/bootstrap.min.css" rel="stylesheet">
		<link href="static/SanJiLianDong/main.css" rel="stylesheet">
		<script src="static/SanJiLianDong/jquery-1.11.0.min.js" type="text/javascript"></script>
		<script src="static/SanJiLianDong/bootstrap.min.js"></script>
		<script src="static/SanJiLianDong/distpicker.data.js"></script>
		<script src="static/SanJiLianDong/distpicker.js"></script>
		<script src="static/SanJiLianDong/main.js"></script>
</head>
<body class="no-skin" onload="sanji()">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="supplierAndcustomer/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<input type="hidden" name="USER_ID" id="USER_ID" value="${pd.USER_ID}"/>
						<div id="zhongxin">
						<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top:10px;">
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">名称:</td>
								<td><input type="text" name="SUPNAME" id="SUPNAME" onblur="shijiao()" maxlength="50" placeholder="这里输入名称" title="名称" value="${obj.SUPNAME}" style="width:98%;"/></td>
								<td style="width:70px;text-align: right;padding-top: 13px;">拼音简码:</td>
								<td><input type="text" name="PINYIN" id="PINYIN" maxlength="50" placeholder="这里输入拼音简码" title="简码" value="${obj.PINYIN}"  readonly="readonly" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">类型:</td>
								<td colspan="9" id="type">
									<select class="chosen-select form-control" name="CATEGORIES_ID" id="CATEGORIES_ID" data-placeholder="请选择类型" style="vertical-align:top;" style="width:98%;" >
										<option value=""></option>
										<c:forEach items="${list}" var="ls">
											<option value="${ls.ID }" <c:if test="${ls.ID == obj.CATEGORIES_ID }">selected</c:if>>${ls.NAME}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">联系人:</td>
								<td><input type="text" name="CONTACT" id="CONTACT" value="${obj.CONTACT}" maxlength="32" placeholder="这里输入联系人" title="联系人" style="width:66%;"/></td>
								<td style="width:70px;text-align: right;padding-top: 13px;">联系电话:</td>
								<td><input type="text" name="PHONE" id="PHONE" value="${obj.PHONE}" maxlength="32" placeholder="这里输入联系电话" title="联系电话" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">传真:</td>
								<td><input type="text" name="FAX_PHONE" id="FAX_PHONE" value="${obj.FAX_PHONE}" maxlength="32" placeholder="这里输入传真" title="传真" style="width:98%;"/></td>
								<td style="width:70px;text-align: right;padding-top: 13px;">邮件:</td>
								<td><input type="text" name="MAIL" id="MAIL" value="${obj.MAIL}" maxlength="32" placeholder="这里输入邮件" title="邮件" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">地址:</td>
								<td colspan="9">
									<input type="hidden" name="ADDRESS" id="ADDRESS" value="${obj.ADDRESS}" />
									<div id="distpicker5" style="width:100%">
										<div class="form-group" style="width:25%;float:left">
											<label class="sr-only" for="province10">Province</label>
											<select class="form-control" id="province10"></select>&nbsp;
										</div>
										<div class="form-group" style="width:25%;float:left">
											<label class="sr-only" for="city10">City</label>
											<select class="form-control" id="city10"></select>&nbsp;
										</div>
										<div class="form-group" style="width:25%;float:left">
											<label class="sr-only" for="district10">District</label>
											<select class="form-control" id="district10"></select>
										</div>
									</div>
								</td>
							
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">开户行:</td>
								<td><input type="text" name="OPEN_ACCOUNT" id="OPEN_ACCOUNT" value="${obj.OPEN_ACCOUNT}" maxlength="32" placeholder="这里输入开户行址" title="开户行" style="width:98%;"/></td>
								<td style="width:70px;text-align: right;padding-top: 13px;">银行账号:</td>
								<td><input type="text" name="BANK" id="BANK" value="${obj.BANK}" maxlength="32" placeholder="这里输入银行账号" title="银行账号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">企业税号:</td>
								<td><input type="text" name="EIN" id="EIN" value="${obj.EIN}" maxlength="32" placeholder="这里输入企业税号" title="企业税号" style="width:98%;"/></td>
								<td style="width:70px;text-align: right;padding-top: 13px;">网站地址:</td>
								<td><input type="text" name="SITE_ADDRESS" id="SITE_ADDRESS" value="${obj.SITE_ADDRESS}" maxlength="32" placeholder="这里输入网站地址" title="网站地址" style="width:98%;"/></td>
							
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="9">
									<textarea rows="3" cols="46" name="NOTE" id="NOTE" placeholder="这里输入备注" title="备注"  style="width:98%;">${obj.NOTE}</textarea>
								</td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">操作人:</td>
								<td colspan="9"><input type="text" value="${pd.USERNAME}" name="USERNAME" id="USERNAME" maxlength="32" readonly title="操作人" style="width:66%;"/></td>
							</tr>
						<c:if test="${msg == 'edit' }">
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;">状态:</td>
								<td colspan="9">
									<select class="chosen-select form-control" name="STATE" id="STATE" data-placeholder="请输入状态" style="vertical-align:top;" style="width:98%;" >
										<option value="0" <c:if test="${obj.STATE == 0 }">selected</c:if>>合作</option>
										<option value="1" <c:if test="${obj.STATE == 1 }">selected</c:if>>流失</option>
									</select>
								</td>
							</tr>
						</c:if>
							<tr>
								<td class="center" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						
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
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script src="static/js/brief_code.js"></script>
		<script type="text/javascript">
		 $(function(){
			 $("#ENTRY_TIME").val(getCurrentDate());
		 });
		 
		 function sanji(){
			 if('${msg}' == 'edit'){
					var abc='${obj.ADDRESS}';//获取地址
					var cze=abc.split(","); 
	//-------------------------------------------------------------				
					  var all_options = document.getElementById("province10").options;
					  alert(all_options.length);
					   for (i=0; i<all_options.length; i++)
					   {
					      if (all_options[i].id.split('_')[1] == optionID)  // 根据option标签的ID来进行判断  测试的代码这里是两个等号
					      {
					         all_options[i].selected = true;
					      }
					   }
					$("#province10").selectmenu('refresh');//下拉框刷新
					/*  $("#province10").val().options[i].text=cze[0];
					$("#city10").val(2);
					$("#district10").val(cze[2]); 
					 */
				 }
		 }
		function shijiao(){
			var str = $("#SUPNAME").val(); 
		    if(str=='') return;
		    var arrRslt = makePy(str);
		    $("#PINYIN").val(arrRslt);
		}
		$(top.hangge());
		
		//保存
		function save(){
			if($("#SUPNAME").val()==""){
				$("#SUPNAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUPNAME").focus();
				return false;
			}
			
			if($("#CATEGORIES_ID").val()==""){
				$("#type").tips({
					side:3,
		            msg:'请选择类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CATEGORIES_ID").focus();
				return false;
			}
			
			if($("#CONTACT").val()==""){
				$("#CONTACT").tips({
					side:3,
		            msg:'请输入联系人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTACT").focus();
				return false;
			}
			
			var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;//手机号格式检验
			if($("#PHONE").val()==""){
				$("#PHONE").tips({
					side:3,
		            msg:'输入手机号',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#PHONE").focus();
				return false;
			}else if($("#PHONE").val().length != 11 && !myreg.test($("#PHONE").val())){
				$("#PHONE").tips({
					side:3,
		            msg:'手机号格式不正确',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#PHONE").focus();
				return false;
			}
			var fax= /^(\d{3,4}-)?\d{7,8}$/;		//传真格式检验
			if(!fax.test($("#FAX_PHONE").val())){
				$("#FAX_PHONE").tips({
					side:3,
		            msg:'传真格式不正确',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#FAX_PHONE").focus();
				return false;
			}
		var mail=/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/;	//邮箱验证
		if($("#MAIL").val()==""){
			$("#MAIL").tips({
				side:3,
	            msg:'输入邮箱',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#MAIL").focus();
			return false;
		}else if(!mail.test($("#MAIL").val())){
			$("#MAIL").tips({
				side:3,
	            msg:'邮箱格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#MAIL").focus();
			return false;
		}
		
		/* if($("#ADDRESS").val()==""){
			$("#ADDRESS").tips({
				side:3,
	            msg:'请输入地址',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ADDRESS").focus();
			return false;
		} */
		
		if($("#SITE_ADDRESS").val()==""){
				$("#SITE_ADDRESS").tips({
					side:3,
		            msg:'请输入网站地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SITE_ADDRESS").focus();
			return false;
		}
		
		if($("#OPEN_ACCOUNT").val()==""){
			$("#OPEN_ACCOUNT").tips({
				side:3,
	            msg:'请输入开户行',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#OPEN_ACCOUNT").focus();
			return false;
		}
		
		var num = /^\d*$/;  //全数字
		if($("#BANK").val()==""){
			$("#BANK").tips({
				side:3,
	            msg:'请输入银行账号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BANK").focus();
			return false;
		}else if(!num.exec($("#BANK").val()) && $("#BANK").val().length <16 || $("#BANK").val().length >19 ){
			$("#BANK").tips({
				side:3,
	            msg:'银行卡号格式错误',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#BANK").focus();
			return false;
		}
			var sh=/^[A-Z0-9]{15}$|^[A-Z0-9]{17}$|^[A-Z0-9]{18}$|^[A-Z0-9]{20}$/;	// 验证税号   15或者17或者18或者20位字母、数字组成
			if($("#EIN").val()==""){
				$("#EIN").tips({
					side:3,
		            msg:'请输入企业税号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EIN").focus();
			return false;
		}else if(!sh.test($("#EIN").val())){
			$("#EIN").tips({
				side:3,
	            msg:'企业税号格式错误',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EIN").focus();
			return false;
		}
			var ADDRESS=$("#province10").val()+","+$("#city10").val()+","+$("#district10").val();
			$("#ADDRESS").val(ADDRESS);
			$("#Form").submit();
			swal({
		        title: "系统提示", 
		        text: "操作成功！", 
		        type: "success",
		        /* showCancelButton: true, */
		        timer: 5544400,
		        showConfirmButton: false,
		        confirmButtonColor: "#ec6c62"
		    	});
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			
		}
		
		</script>
</body>
</html>