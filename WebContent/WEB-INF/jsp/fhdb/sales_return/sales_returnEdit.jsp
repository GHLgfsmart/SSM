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
			    
			    if('${pd.MAKETIME}' != null & '${pd.MAKETIME}' != "") {
			    	$("#MAKETIME").val('${pd.MAKETIME}');
				}else {
					$("#MAKETIME").val(currentdate);
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
					<c:if test="${msg eq 'sales_returnAdd'}">
						<legend>新增退货单</legend>
					</c:if>
					<c:if test="${msg eq 'sales_returnEdit'}">
						<legend>修改退货单</legend>
					</c:if>
					<form action="warehousing/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">单据编号:</td>
								<td>
									<c:if test="${empty pd.RETREAT_CODE}">
										<input type="text" name="RETREAT_CODE" id="RETREAT_CODE" value="${dj}" maxlength="30" readonly="readonly" style="width:98%;"/>
									</c:if>
									<c:if test="${!empty pd.RETREAT_CODE}">
										<input type="text" name="RETREAT_CODE" id="RETREAT_CODE" value="${pd.RETREAT_CODE}" maxlength="30" readonly="readonly" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">出库单号:</td>
								<td><input type="text" name="OUT_CODE" id="OUT_CODE" value="${pd.OUT_CODE}" maxlength="30" placeholder="这里输入出库单号" title="出库单号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">出库仓库:</td>
								<td>
									<input type="hidden" id="WAREHOUSE_OUT_ID" name="WAREHOUSE_OUT_ID" value="001"/>
									<input type="text" name="OTNAME" id="OTNAME" value="${pd.OTNAME}" maxlength="30" placeholder="这里选择出库仓库" title="出库仓库" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="otelect();" type="button">选择</button>
								</td>
								<td style="width:79px;text-align: left;padding-top: 13px;">入库仓库:</td>
								<td>
									<input type="hidden" id="WAREHOUSE_PUT_ID" name="WAREHOUSE_PUT_ID" value="001"/>
									<input type="text" name="PTNAME" id="PTNAME" value="${pd.PTNAME}" maxlength="30" placeholder="这里选择入库仓库" title="入库仓库" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="ptelect();" type="button">选择</button>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">制单时间:</td>
								<td>
 									<input type="text" name="MAKETIME" id="MAKETIME" value="${pd.MAKETIME}" maxlength="30" title="制单时间" style="width:98%;"/>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">单据数量:</td>
								<td><input type="number" name="COUNT" id="COUNT" value="${pd.COUNT}" maxlength="30" placeholder="这里输入单据数量" title="单据数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">操作员:</td>
								<td>
									<c:if test="${!empty pd.INSPECTOR}">
										<input type="text" name="INSPECTOR" id="INSPECTOR" value="${pd.INSPECTOR}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
									<c:if test="${empty pd.INSPECTOR}">
										<input type="text" name="INSPECTOR" id="INSPECTOR" value="${sessionUser.USERNAME}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">出入库类型:</td>
								<td>
									<input type="hidden" id="OUTPUT_TYPE_ID" name="OUTPUT_TYPE_ID" value="003"/>
									<input type="text" name="OPTNAME" id="OPTNAME" value="${pd.OPTNAME}" maxlength="30" placeholder="这里选择出入库类型" title="出入库类型" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="optelect();" type="button">选择</button>
								</td>
							</tr>
							<tr>
								<td style="width:79px;height:80px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="3">
									<textarea name="NOTE" cols="" rows="3" style="width:98%;" class="textarea" placeholder="这里输入备注">${pd.NOTE}</textarea>
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
			
			if($("#OUT_CODE").val()==""){
				$("#OUT_CODE").tips({
					side:3,
		            msg:'出库单号不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OUT_CODE").focus();
			return false;
			}
			if($("#OTNAME").val()==""){
				$("#OTNAME").tips({
					side:3,
		            msg:'请选择入库仓库',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OTNAME").focus();
			return false;
			}
			if($("#PTNAME").val()==""){
				$("#PTNAME").tips({
					side:3,
		            msg:'请选择入库仓库',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PTNAME").focus();
			return false;
			}

			if($("#COUNT").val()==""){
				$("#COUNT").tips({
					side:3,
		            msg:'请输入退货数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT").focus();
			return false;
			}
			
			if($("#NOTE").val()==""){
				$("#NOTE").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NOTE").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		/**选择供应商*/
		var materials = "";
		var matid = "";
		function matelect(){
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