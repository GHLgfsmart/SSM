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
			    
			    if('${pd.ENTRY_TIME}' != null & '${pd.ENTRY_TIME}' != "") {
			    	$("#ENTRY_TIME").val('${pd.ENTRY_TIME}');
				}else {
					$("#ENTRY_TIME").val(currentdate);
				}
			    $("#UPDATE_TIME").val(currentdate);
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
					<c:if test="${msg eq 'output_storageAdd'}">
						<legend>新增入库单</legend>
					</c:if>
					<c:if test="${msg eq 'output_storageEdit'}">
						<legend>修改入库单</legend>
					</c:if>
					<form action="warehousing/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">单据编号:</td>
								<td>
									<c:if test="${empty pd.BIANHAO}">
										<input type="text" name="BIANHAO" id="BIANHAO" value="${dj}" maxlength="30" readonly="readonly" style="width:98%;"/>
									</c:if>
									<c:if test="${!empty pd.BIANHAO}">
										<input type="text" name="BIANHAO" id="BIANHAO" value="${pd.BIANHAO}" maxlength="30" readonly="readonly" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">原始单号:</td>
								<td><input type="text" name="RAW_NUMBER" id="RAW_NUMBER" value="${pd.RAW_NUMBER}" maxlength="30" placeholder="这里输入原始单号" title="原始单号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">物资:</td>
								<td>
									<input type="hidden" id="MATERIALS_ID" name="MATERIALS_ID" value="${pd.MATERIALS_ID}"/>
									<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="30" readonly placeholder="这里选择物资" title="物资" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="matelect();" type="button">选择</button>
								</td>
								<td style="width:79px;text-align: left;padding-top: 13px;">出入库类型:</td>
								<td>
									<input type="hidden" id="OUTPUT_TYPE_ID" name="OUTPUT_TYPE_ID" value="${pd.OUTPUT_TYPE_ID }"/>
									<input type="text" name="OPTNAME" id="OPTNAME" value="${pd.OPTNAME}" readonly maxlength="30" placeholder="这里选择出入库类型" title="出入库类型" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="optelect();" type="button">选择</button>
									<input type="hidden" id="WAREHOUSE_ID" name="WAREHOUSE_ID" value="23702a39949744679b4ad0d09eb3f7f2"/>
									<input type="hidden" value="0" id="STATE" name="STATE"/>
									<input type="hidden" value="1" id="TYPE" name="TYPE"/>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">单据金额:</td>
								<td>
 									<input type="number" name="MONEY" id="MONEY" value="${pd.MONEY}" maxlength="30" placeholder="这里输入单据金额" title="单据金额" style="width:98%;"/>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">单据数量:</td>
								<td><input type="number" name="NUMBER_OF" id="NUMBER_OF" value="${pd.NUMBER_OF}" maxlength="30" placeholder="这里输入单据数量" title="单据数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">操作员:</td>
								<td>
									<c:if test="${!empty pd.USER_ID}">
										<input type="hidden" id="USER_ID" name="USER_ID" value="${pd.USER_ID}"/>
										<input type="text" name="USERNAME" id="USERNAME" value="${pd.USERNAME}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
									<c:if test="${empty pd.USER_ID}">
										<input type="hidden" id="USER_ID" name="USER_ID" value="${sessionUser.USER_ID }"/>
										<input type="text" name="USERNAME" id="USERNAME" value="${sessionUser.USERNAME}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">录入时间:</td>
								<td>
									<input type="text" name="ENTRY_TIME" id="ENTRY_TIME" value="${pd.ENTRY_TIME}" maxlength="30" title="录入时间" readonly="readonly" style="width:98%;"/>
									<input type="hidden" name="UPDATE_TIME" id="UPDATE_TIME" value="${pd.UPDATE_TIME}" />
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
			
			if($("#RAW_NUMBER").val()==""){
				$("#RAW_NUMBER").tips({
					side:3,
		            msg:'原始单号不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RAW_NUMBER").focus();
			return false;
			}
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请选择物资',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#OPTNAME").val()==""){
				$("#OPTNAME").tips({
					side:3,
		            msg:'请选择出入库类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OPTNAME").focus();
			return false;
			}

			if($("#MONEY").val()==""){
				$("#MONEY").tips({
					side:3,
		            msg:'请输入单据金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MONEY").focus();
			return false;
			}
			var reg = new RegExp("^[0-9]*$");
			if($("#NUMBER_OF").val()==""){
				$("#NUMBER_OF").tips({
					side:3,
		            msg:'请输入单据数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_OF").focus();
			return false;
			}
			if(!reg.test($("#NUMBER_OF").val())){
				$("#NUMBER_OF").tips({
					side:3,
		            msg:'数据格式不正确',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_OF").focus();
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

		var mid = '${pd.MATID}';  //获取已经选择的物资id
		/**选择供应商*/
		var materials = $("#NAME").val();
		var matid = $("#MATERIALS_ID").val();
		function matelect(){
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/electMaterialsPage.do?STATE=0",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                $("#NAME").val(materials);
		                $("#MATERIALS_ID").val(matid);
		            }
		        }
		    );
		} 

		
		var optid = $("#OUTPUT_TYPE_ID").val();
		var optname = $("#OPTNAME").val();
		function optelect(){
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/electOutPutTypePage.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		            	$("#OUTPUT_TYPE_ID").val(optid);
		            	$("#OPTNAME").val(optname);
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