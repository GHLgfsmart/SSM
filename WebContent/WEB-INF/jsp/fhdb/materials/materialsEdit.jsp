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
		<script type="text/javascript" src="static/js/common/brief_code.js"></script><!-- 引用拼音方法JS -->
		<script type="text/javascript">
			//查看拼音首字母缩写
			function query(){  
			    var str = document.getElementById("NAME").value.trim();  
			    if(str == "") return;
			    var arrRslt = makePy(str);
				document.getElementById("PINYIN").value=arrRslt;
			}

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
					<c:if test="${msg eq 'warehousingAdd'}">
						<legend>新增物资</legend>
					</c:if>
					<c:if test="${msg eq 'warehousingEdit'}">
						<legend>修改物资</legend>
					</c:if>
					<form action="warehousing/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="FHBUTTON_ID" id="FHBUTTON_ID" value="${pd.FHBUTTON_ID}"/>
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
								<td style="width:79px;text-align: right;padding-top: 13px;">条形码:</td>
								<td><input type="text" name="BAR_CODE" id="BAR_CODE" value="${pd.BAR_CODE}" maxlength="30" placeholder="这里输入条形码" title="条形码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">物资名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="30" placeholder="这里输入物资名称" onchange="javascript:query();" title="物资名称" style="width:98%;"/></td>
								<td style="width:79px;text-align: right;padding-top: 13px;">拼音简码:</td>
								<td><input type="text" name="PINYIN" id="PINYIN" value="${pd.BAR_CODE}" maxlength="30" readonly="readonly" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">供应商:</td>
								<td>
									<input type="hidden" name="CUS_ID" />
 									<input type="text" name="supname" id="supname" value="${pd.supplier.NAME}" maxlength="30" placeholder="这里选择供应商" title="供应商" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="elect();" type="button">选择</button>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">商品数量:</td>
								<td><input type="text" name="COUNT" id="COUNT" value="${pd.COUNT}" maxlength="30" placeholder="这里输入商品数量" title="商品数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">单位:</td>
								<td><input type="text" name="UNIT" id="UNIT" value="${pd.UNIT}" maxlength="30" placeholder="这里输入单位" title="单位" style="width:98%;"/></td>
								<td style="width:79px;text-align: right;padding-top: 13px;">录入时间:</td>
								<td>
									<input type="text" name="ENTRY_TIME" id="ENTRY_TIME" maxlength="30" title="录入时间" readonly="readonly" style="width:98%;"/>
									<input type="hidden" name="UPDATE_TIME" id="UPDATE_TIME" />
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">操作员:</td>
								<td>
									<c:if test="${!empty pd.operator}">
										<input type="text" name="operator" id="operator" value="${pd.operator}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
									<c:if test="${empty pd.operator}">
										<input type="text" name="operator" id="operator" value="${sessionUser.USERNAME}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">状态:</td>
								<td>
									<select id="STATE" name="STATE">
										<option value="0" selected>未入库</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:79px;height:80px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="3">
									<%-- <input type="text" name="NOTE" id="NOTE" value="${pd.NOTE}" maxlength="30" placeholder="这里输入备注" title="备注" style="width:98%;height:100%"/> --%>
									<textarea name="NOTE" cols="" rows="" style="width:98%;" class="textarea" placeholder="这里输入备注"></textarea>
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
			
			if($("#BAR_CODE").val()==""){
				$("#BAR_CODE").tips({
					side:3,
		            msg:'请输入条形码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BAR_CODE").focus();
			return false;
			}
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入物资名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#TEST").val()==""){
				$("#TEST").tips({
					side:3,
		            msg:'请选择供应商',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TEST").focus();
			return false;
			}

			var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
			if($("#COUNT").val()==""){
				$("#COUNT").tips({
					side:3,
		            msg:'请输入商品数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT").focus();
			return false;
			}else if(!myreg.test($("#COUNT").val())) {
				$("#COUNT").tips({
					side:3,
		            msg:'数量格式不正确',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT").focus();
			return false;
			}
			if($("#UNIT").val()==""){
				$("#UNIT").tips({
					side:3,
		            msg:'请输入单位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UNIT").focus();
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
		var supplier = "";
		var supid = "";
		function elect(){
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/testPage.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                //在弹出窗口页面，如果我们保存了数据，就将父页面里的变量isFreshFlag 值设置为2
		                /**if(isFreshFlag==2){
		                    location.reload();
		                }*/
		                $("#supname").val(supplier);
		                $("#CUS_ID").val(supid);
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