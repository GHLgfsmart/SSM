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
		<link rel="stylesheet" type="text/css" href="static/ace/css/build.css"><!-- 洪青青     复选框  必须要有<link rel="stylesheet" href="static/ace/css/bootstrap.css" /> <link rel="stylesheet" href="static/ace/css/font-awesome.css" />-->
		<script type="text/javascript">
			//查看拼音首字母缩写
			function query(){  
			    var str = document.getElementById("NAME").value.trim();  
			    if(str == "") return;
			    var arrRslt = makePy(str);
				document.getElementById("PINYIN").value=arrRslt;
			}

			function getNowFormatDate() {
				moneytoo();//洪青青
				fname();//洪青青
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
					<c:if test="${msg eq 'materialsAdd'}">
						<legend>新增物资</legend>
					</c:if>
					<c:if test="${msg eq 'materialsEdit'}">
						<legend>修改物资</legend>
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
								<td style="width:79px;text-align: right;padding-top: 13px;">条形码:</td>
								<td><input type="text" name="BAR_CODE" id="BAR_CODE" value="${pd.BAR_CODE}" maxlength="30" placeholder="这里输入条形码" title="条形码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">物资名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="30" placeholder="这里输入物资名称" onchange="javascript:query();" title="物资名称" style="width:98%;"/></td>
								<td style="width:79px;text-align: right;padding-top: 13px;">拼音简码:</td>
								<td><input type="text" name="PINYIN" id="PINYIN" value="${pd.PINYIN}" maxlength="30" readonly="readonly" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">供应商:</td>
								<td>
									<input type="hidden" id="CUS_ID" name="CUS_ID" value="${pd.CUS_ID}" />
 									<input type="text" name="supname" id="supname" value="${pd.SUPNAME}" maxlength="30" readonly placeholder="这里选择供应商" title="供应商" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="elect();" type="button">选择</button>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">商品数量:</td>
								<td><input type="text" onblur="moneytoo()" name="COUNT" id="COUNT" value="${pd.COUNT }" maxlength="30" placeholder="这里输入商品数量" title="商品数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">单位:</td>
								<td><input type="text" name="UNIT" id="UNIT" value="${pd.UNIT}" maxlength="30" placeholder="这里输入单位" title="单位" style="width:98%;"/></td>
								<td style="width:79px;text-align: right;padding-top: 13px;">录入时间:</td>
								<td>
									<input type="text" name="ENTRY_TIME" id="ENTRY_TIME" value="${pd.ENTRY_TIME}" maxlength="30" title="录入时间" readonly="readonly" style="width:98%;"/>
									<input type="hidden" name="UPDATE_TIME" id="UPDATE_TIME" value="${pd.UPDATE_TIME}" />
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">操作员:</td>
								<td>
									<c:if test="${!empty pd.OPERATOR}">
										<input type="text" name="OPERATOR" id="OPERATOR" value="${pd.OPERATOR}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
									<c:if test="${empty pd.OPERATOR}">
										<input type="text" name="OPERATOR" id="OPERATOR" value="${sessionUser.USERNAME}" readonly="readonly" maxlength="30" title="操作员" style="width:98%;"/>
									</c:if>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">状态:</td>
								<td>
									<select id="STATE" name="STATE">
										<option value="0" selected>待入库</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">费用:</td>
								<td colspan="3">
								<fieldset style="float: left; padding-right: 25px;">
								<div class="checkbox checkbox-success">
									<input type="hidden" name="ID1" id="ID1" value="${pd1.ID }" />
									<input class="styled styled" id="STORAGE" name="STORAGE" value="${pd1.STORAGE}" type="checkbox" onclick="return false;" checked>
									<label for="checkbox10">
										存储费（<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.STORAGE }</span>  &nbsp;共<span style="color: red;" id="moneys">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i>
									</label>
								</div>
								</fieldset>
								<fieldset style="padding-right: 25px;">
								<div class="checkbox checkbox-success">
									<input type="checkbox" class="styled" id="RICHARD" name="RICHARD" value="${pd1.RICHARD}" checked>
									<label for="inlineCheckbox2"> 理货费（<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.RICHARD }</span>  &nbsp;共<span style="color: red;" id="moneys1">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i></label>
								</div> 
								</fieldset>
								<fieldset style="float: left; padding-right: 25px;">
								<div class="checkbox checkbox-success">
									<input type="checkbox" class="styled" id="LOADING" name="LOADING" value="${pd1.LOADING}" checked>
									<label for="inlineCheckbox2"> 装车费 （<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.LOADING }</span>  &nbsp;共<span style="color: red;" id="moneys2">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i></label>
								</div> 
								</fieldset>
								<fieldset style="float: left;">
								<div class="checkbox checkbox-success">
									<input type="checkbox" class="styled" id="UNLOADING" name="UNLOADING" value="${pd1.UNLOADING}" checked>
									<label for="inlineCheckbox2"> 卸车费 （<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.UNLOADING }</span>  &nbsp;共<span style="color: red;" id="moneys3">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i></label>
								</div> 
								</fieldset>
								</td>
							</tr>
							<tr>
								<td style="width:79px;height:80px;text-align: right;padding-top: 13px;">备注:</td>
								<td colspan="3">
									<%-- <input type="text" name="NOTE" id="NOTE" value="${pd.NOTE}" maxlength="30" placeholder="这里输入备注" title="备注" style="width:98%;height:100%"/> --%>
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
		//洪青青-----计算费用
		function moneytoo(){
			var COUNT=$("#COUNT").val();
			var name=parseInt(COUNT);
			if(!isNaN(name)){
				 var STORAGE =parseFloat('${pd1.STORAGE}') * name;//存储费
				 var RICHARD =parseFloat('${pd1.RICHARD}') * name;//理货费
				 var LOADING =parseFloat('${pd1.LOADING}') * name;//装车费
				 var UNLOADING =parseFloat('${pd1.UNLOADING}') * name;//卸车费
				 $("#STORAGE").val(STORAGE.toFixed(2));
				 $("#RICHARD").val(RICHARD.toFixed(2));
				 $("#LOADING").val(LOADING.toFixed(2));
				 $("#UNLOADING").val(UNLOADING.toFixed(2));
				 if((STORAGE+"").indexOf(".") > 0 ){
					 window.document .getElementById ("moneys").innerHTML=STORAGE.toFixed(2);//四舍五入
				 }else{
					 window.document .getElementById ("moneys").innerHTML=STORAGE+".00";
				 }
				 if((RICHARD+"").indexOf(".") > 0 ){
					 window.document .getElementById ("moneys1").innerHTML=RICHARD.toFixed(2);//四舍五入
				 }else{
					 window.document .getElementById ("moneys1").innerHTML=RICHARD+".00";
				 }
				 if((LOADING+"").indexOf(".") > 0 ){
					 window.document .getElementById ("moneys2").innerHTML=LOADING.toFixed(2);//四舍五入
				 }else{
					 window.document .getElementById ("moneys2").innerHTML=LOADING+".00";
				 }
				 if((UNLOADING+"").indexOf(".") > 0 ){
					 window.document .getElementById ("moneys3").innerHTML=UNLOADING.toFixed(2);//四舍五入
				 }else{
					 window.document .getElementById ("moneys3").innerHTML=UNLOADING+".00";
				 }
			}else if(COUNT != null && COUNT !=''){
				$("#COUNT").tips({
					side:3,
		            msg:'必须是数字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT").focus();
				return false;
			}
		}
		//洪青青 取消复选框 勾选
		function fname() {
			if('${msg}' == 'materialsEdit'){
				if('${pd2.RICHARD_STATE}' =='1'){
					document.getElementById('RICHARD').checked=false;
				}
				if('${pd2.LOADING_STATE}' =='1'){
					document.getElementById('LOADING').checked=false;
				}
				if('${pd2.UNLOADING_STATE}' =='1'){
					document.getElementById('UNLOADING').checked=false;
				}
			}
		}
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
			if($("#supname").val()==""){
				$("#supname").tips({
					side:3,
		            msg:'请选择供应商',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#supname").focus();
			return false;
			}

			if($("#COUNT").val()==""){
				$("#COUNT").tips({
					side:3,
		            msg:'请输入商品数量',
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
		var supplier =  $("#supname").val();
		var supid = $("#CUS_ID").val();
		function elect(){
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/SClist.do",
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
		
		</script>
</body>
</html>