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
					<c:if test="${msg eq 'pickingAdd'}">
						<legend>新增拣货单</legend>
					</c:if>
					<c:if test="${msg eq 'pickingEdit'}">
						<legend>修改拣货单</legend>
					</c:if>
					<form action="outstorage/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover" style="width:80%;">
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
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">出库单号:</td>
								<td>
									<input type="hidden" id="OUTID" name="OUTID" />
									<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="30" readonly placeholder="这里选择出库单号" title="出库单号" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="matelect();" type="button">选择</button>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">拣取数量:</td>
								<td><input type="number" name="COUNT" id="COUNT" value="${pd.COUNT}" readonly maxlength="30" placeholder="这里输入拣取数量" title="拣取数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">出库单数:</td>
								<td><input type="number" name="MATCOUNT" id="MATCOUNT" value="${pd.MATCOUNT}" readonly maxlength="30" placeholder="这里输入出库单数" title="出库单数" style="width:98%;"/></td>
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
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">录入时间:</td>
								<td>
									<input type="text" name="TIME" id="TIME" value="${pd.TIME}" maxlength="30" title="录入时间" readonly="readonly" style="width:98%;"/>
									<input type="hidden" name="STATE" id="STATE" value="1" />
									<input type="hidden" name="TYPE" id="TYPE" value="1" />
								</td>
							</tr>
							<tr>
								<td style="width:79px;height:80px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="2">
									<textarea id="NOTE" name="NOTE" cols="" rows="3" style="width:98%;" class="textarea" placeholder="这里输入备注">${pd.NOTE}</textarea>
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
			
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请选择出库计划单',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#COUNT").val()==""){
				$("#COUNT").tips({
					side:3,
		            msg:'请输入拣取数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT").focus();
			return false;
			}
			if($("#MATCOUNT").val()==""){
				$("#MATCOUNT").tips({
					side:3,
		            msg:'请输入出库计划单数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MATCOUNT").focus();
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
		var outputid = '${pd.oid}';  //获取已经选择的入库id
		/**选择入库单据*/
		var outname = "";
		var outid = "";
		var outcount = "";
		var count = "";
		function matelect(){
		    jBox.open(
		        "iframe:<%=basePath%>outstorage/electOutstoragePage.do?YK=1",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                $("#NAME").val(outname);
		                $("#OUTID").val(outid);
		                $("#MATCOUNT").val(outcount);
		                $("#COUNT").val(count);
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