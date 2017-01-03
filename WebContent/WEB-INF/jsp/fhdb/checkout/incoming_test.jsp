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
		<script type="text/javascript">

			function getNowFormatDate() {
			    var date = new Date();
			    var seperator1 = "-";
			    var seperator2 = ":";
			    var month = date.getMonth() + 1;
			    var strDate = date.getDate();
			    var minutes = date.getMinutes();
			    var seconds = date.getSeconds();
			    if (month >= 1 && month <= 9) {
			        month = "0" + month;
			    }
			    if (strDate >= 0 && strDate <= 9) {
			        strDate = "0" + strDate;
			    }
			    if (minutes >= 0 && minutes <= 9) {
			    	minutes = "0" + minutes;
			    }
			    if (seconds >= 0 && seconds <= 9) {
			    	seconds = "0" + seconds;
			    }
			    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
			            + " " + date.getHours() + seperator2 + minutes
			            + seperator2 + seconds;
			    
			    if('${pd.TIME}' != null & '${pd.TIME}' != "") {
			    	$("#TIME").val('${pd.TIME}');
				}else {
					$("#TIME").val(currentdate);
				}
			}
		</script>
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
					<c:if test="${msg eq 'checkoutAdd'}">
						<legend>新增检验单</legend>
					</c:if>
					<c:if test="${msg eq 'checkoutEdit'}">
						<legend>修改检验单</legend>
					</c:if>
					<form action="${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<input type="hidden" name="yan" id="yan" value="${pd.yan}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">单号:</td>
								<td>
									<c:if test="${!empty pd.BIANHAO}">
										<input type="text" name="SOURCECODE" id="SOURCECODE" value="${pd.BIANHAO}" maxlength="30" readonly="readonly" style="width:98%;"/>
									</c:if>
									<c:if test="${!empty pd.SOURCECODE}">
										<input type="text" name="SOURCECODE" id="SOURCECODE" value="${pd.SOURCECODE}" maxlength="30" readonly="readonly" style="width:98%;"/>
									</c:if>
									<c:if test="${!empty pd.RETREAT_CODE}">
										<input type="text" name="SOURCECODE" id="SOURCECODE" value="${pd.RETREAT_CODE}" maxlength="30" readonly="readonly" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">检测单类型:</td>
								<td>
									<input type="hidden" id="OUTPUT_TYPE_ID" name="OUTPUT_TYPE_ID" value="${pd.OUTPUT_TYPE_ID}"/>
									<input type="text" name="OPTNAME" id="OPTNAME" value="${pd.OPTNAME}" maxlength="30" readonly placeholder="这里选择类型" title="类型" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="optelect();" type="button">选择</button>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">总数量:</td>
								<td>
									<c:if test="${!empty pd.COUNT }">
										<input type="number" name="QUANTITY" id="QUANTITY" value="${pd.COUNT}" maxlength="30" readonly placeholder="这里输入总数量" title="总数量" style="width:98%;"/>
									</c:if>
 									<c:if test="${!empty pd.QUANTITY }">
										<input type="number" name="QUANTITY" id="QUANTITY" value="${pd.QUANTITY}" maxlength="30" readonly placeholder="这里输入总数量" title="总数量" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">检测时间:</td>
								<td>
									<input type="text" name="TIME" id="TIME" value="${pd.TIME}" maxlength="30" title="检测时间" readonly="readonly" style="width:98%;"/>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">坏货数量:</td>
								<td>
 									<input type="number" name="DAMAGEDQTY" id="DAMAGEDQTY" value="${pd.DAMAGEDQTY}" maxlength="30" placeholder="这里输入坏货数量" title="坏货数量" style="width:98%;"/>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">坏货原因:</td>
								<td>
 									<input type="text" name="DAMAGEDREASON" id="DAMAGEDREASON" value="${pd.DAMAGEDREASON}" maxlength="30" placeholder="这里输入坏货原因" title="坏货原因" style="width:98%;"/>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">缺货数量:</td>
								<td>
 									<input type="number" name="SHORTQTY" id="SHORTQTY" value="${pd.SHORTQTY}" maxlength="30" placeholder="这里输入缺货数量" title="缺货数量" style="width:98%;"/>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">缺货原因:</td>
								<td>
 									<input type="text" name="SHORTREASON" id="SHORTREASON" value="${pd.SHORTREASON}" maxlength="30" placeholder="这里输入缺货原因" title="缺货原因" style="width:98%;"/>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">操作员:</td>
								<td>
									<c:if test="${!empty pd.INSPECTOR}">
										<input type="text" name="INSPECTOR" id="INSPECTOR" value="${pd.INSPECTOR}" readonly="readonly" maxlength="30" title="检测员" style="width:98%;"/>
									</c:if>
									<c:if test="${empty pd.INSPECTOR}">
										<input type="text" name="INSPECTOR" id="INSPECTOR" value="${sessionUser.USERNAME}" readonly="readonly" maxlength="30" title="检测员" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">检验结果:</td>
								<td>
									<input type="hidden" name="OPID" id="OPID" value="${oppd.ID}"/>
									<select class="chosen-select form-control" name="STATE" id="STATE" data-placeholder="请选择状态" style="vertical-align:top;width: 120px;">
										<c:if test="${!empty oppd.STATE}">
											<c:if test="${oppd.STATE eq 1}">
												<option value="1" selected>已检验</option>
												<option value="2">不合格</option>
											</c:if>
											<c:if test="${oppd.STATE eq 2}">
												<option value="1">已检验</option>
												<option value="2" selected>不合格</option>
											</c:if>
										</c:if>
										<c:if test="${empty oppd.STATE}">
											<option value="1" selected>已检验</option>
											<option value="2">不合格</option>
										</c:if>
										
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
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
			
			if($("#QUANTITY").val()==""){
				$("#QUANTITY").tips({
					side:3,
		            msg:'请输入总数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#QUANTITY").focus();
			return false;
			}
			if($("#DAMAGEDQTY").val()==""){
				$("#DAMAGEDQTY").tips({
					side:3,
		            msg:'请输入坏货数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DAMAGEDQTY").focus();
			return false;
			}
			if($("#DAMAGEDREASON").val()==""){
				$("#DAMAGEDREASON").tips({
					side:3,
		            msg:'请输入坏货原因',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DAMAGEDREASON").focus();
			return false;
			}

			if($("#SHORTQTY").val()==""){
				$("#SHORTQTY").tips({
					side:3,
		            msg:'请输入缺货数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SHORTQTY").focus();
			return false;
			}

			if($("#SHORTREASON").val()==""){
				$("#SHORTREASON").tips({
					side:3,
		            msg:'请输入缺货原因',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SHORTREASON").focus();
			return false;
			}
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		/**选择供应商*/
		var materials = "";
		var matid = "";
		function optelect(){
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/electMaterialsPage.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                $("#NAME").val(materials);
		                $("#MATERIALS_ID").val(matid);
		            }
		        }
		    );
		} 
		<%-- 
		function elect(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>warehousing/testPage.do';
			 diag.Width = 700;
			 diag.Height = 530;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		--%>
		</script>
</body>
</html>