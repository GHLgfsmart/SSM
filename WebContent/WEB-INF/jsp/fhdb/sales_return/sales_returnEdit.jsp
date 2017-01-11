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
		<%@ include file="/WEB-INF/jsp/system/index/top.jsp"%>
		<link rel="stylesheet" href="static/js/common/jbox.css" />
		<link rel="stylesheet" type="text/css" href="static/ace/css/build.css"><!-- 洪青青     复选框  必须要有<link rel="stylesheet" href="static/ace/css/bootstrap.css" /> <link rel="stylesheet" href="static/ace/css/font-awesome.css" />-->
		<link rel="stylesheet" type="text/css" href="static/ace/css/sweetalert.css">
		<script type="text/javascript">

			function getNowFormatDate() {
				moneys();//洪青青
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
								<td><input type="text" name="OUT_CODE" readonly id="OUT_CODE" value="${pd.OUT_CODE}" maxlength="30" placeholder="这里输入出库单号" title="出库单号" style="width:80%;"/>
								<button class="btn btn-mini radius" onclick="elect();" type="button">选择</button>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">出库仓库:</td>
								<td>
									<input type="hidden" id="WAREHOUSE_OUT_ID" name="WAREHOUSE_OUT_ID" value="${pd.WAREHOUSE_OUT_ID}"/>
									<input type="text" name="OTNAME" id="OTNAME" readonly value="${pd.OTNAME}" maxlength="30" placeholder="这里选择出库仓库" title="出库仓库" style="width:80%;"/>
									<!-- <button class="btn btn-mini radius" onclick="otelect();" type="button">选择</button> -->
								</td>
								<td style="width:79px;text-align: left;padding-top: 13px;">入库仓库:</td>
								<td>
									<input type="hidden" id="WAREHOUSE_PUT_ID" name="WAREHOUSE_PUT_ID" value="${pd.WAREHOUSE_PUT_ID}"/>
									<input type="text" name="PTNAME" id="PTNAME" readonly value="${pd.PTNAME}" maxlength="30" placeholder="这里选择入库仓库" title="入库仓库" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="ptelect();" type="button">选择</button>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">制单时间:</td>
								<td>
 									<input type="text" name="MAKETIME" id="MAKETIME" value="${pd.MAKETIME}" maxlength="30" title="制单时间" style="width:98%;"/>
								</td>
								<td style="width:79px;text-align: right;padding-top: 13px;">退货数量:</td>
								<td><input type="number" name="COUNT"  onblur="moneytoo()" id="COUNT" value="${pd.COUNT}" maxlength="30" placeholder="这里输入退货数量" title="退货数量" style="width:98%;"/></td>
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
									<input type="hidden" id="OUTPUT_TYPE_ID" name="OUTPUT_TYPE_ID" value="${pd.OUTPUT_TYPE_ID}"/>
									<input type="hidden" id="STATE" name="STATE" value="0"/>
									<input type="text" name="OPTNAME" id="OPTNAME" readonly value="${pd.OPTNAME}" maxlength="30" placeholder="这里选择出入库类型" title="出入库类型" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="optelect();" type="button">选择</button>
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
										存储费（<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.STORAGE }</span>  &nbsp;共&nbsp;<span style="color: red;" id="moneys">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i>
									</label>
								</div>
								</fieldset>
								<fieldset style="padding-right: 25px;">
								<div class="checkbox checkbox-success">
									<input type="checkbox" class="styled" id="RICHARD" name="RICHARD" value="${pd1.RICHARD}" checked>
									<label for="inlineCheckbox2"> 理货费（<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.RICHARD }</span>  &nbsp;共&nbsp;<span style="color: red;" id="moneys1">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i></label>
								</div> 
								</fieldset>
								<fieldset style="float: left; padding-right: 25px;">
								<div class="checkbox checkbox-success">
									<input type="checkbox" class="styled" id="LOADING" name="LOADING" value="${pd1.LOADING}" checked>
									<label for="inlineCheckbox2"> 装车费 （<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.LOADING }</span>  &nbsp;共&nbsp;<span style="color: red;" id="moneys2">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i></label>
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
	<%@ include file="/WEB-INF/jsp/system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
 	<script type="text/javascript" src="static/js/jquery.tips.js"></script> 
	<script type="text/javascript" src="static/js/common/jquery.jBox-2.3.min.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.jBox-zh-CN.js"></script>
	<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//判断退货数量不能大于实际数量
		function COUNTname(COUNT,OUT_CODE) {
			bootbox.confirm("确定要退货["+COUNT+"]件吗?", function(result) {
				if(result) {
					top.jzts();
					var url = '<%=basePath%>warehousing/numbers.do?OUT_CODE='+OUT_CODE;
					$.get(url,function(data){
						$(top.hangge());//关闭加载状态
						var data1=data+'';
						if(data == 'fall') {
							swal({   
								title: "系统提示",
								text: "没有此订单!", 
								type: "error",
								confirmButtonText: "OK" });
						}else if(COUNT < parseInt(data)){
							swal({   
								title: "系统提示",
								text: "操作成功，请继续!", 
								type: "success",
								confirmButtonText: "OK" },function(){
									
								});
						}else if(COUNT > parseInt(data)){
							var strs= new Array(); //定义一数组 
							strs=data1.split(";"); //字符分割 
							var name='';
							if(strs[1]!=null && strs[2]!=null){
								name=(parseInt(strs[0])-parseInt(strs[2]))+"件,已退货"+strs[1]+'次';
							}else{
								name=strs[0]+'件,已退货0次';
							}
							swal({   
								title: "可以退货"+name,
								text: "退货数量不能大于实际数量!", 
								type: "error",
								confirmButtonText: "OK" }); 
						}
					});
				}
				});
		}
		function moneys(){
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
			}
		}
		//洪青青-----计算费用
		function moneytoo(){
			var COUNT=$("#COUNT").val();
			var name=parseInt(COUNT);
			if(!isNaN(name)){
				 var RETREAT_CODE=$("#RETREAT_CODE").val();
				 var OUT_CODE=$("#OUT_CODE").val();
				 COUNTname(name,OUT_CODE);
				 moneys();
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
		var materials = $("#NAME").val();
		var matid = $("#MATERIALS_ID").val();
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
		/**选择出库单*/
		var supplier =  $("#OUT_CODE").val();
		var COUNT =  $("#COUNT").val();
		var OUT_CODE=$("#OUT_CODE").val();
		var otwarid = $("#WAREHOUSE_OUT_ID").val();
		var otwarname = $("#OTNAME").val();
		function elect(){
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/OUTlist.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                $("#OUT_CODE").val(supplier);
		                $("#WAREHOUSE_OUT_ID").val(otwarid);
		                $("#OTNAME").val(otwarname);
		            }
		        }
		    );
		} 

		<%-- /**选择出库仓库*/
		function otelect(){
			var warid = $("#WAREHOUSE_OUT_ID").val();
			var warname = $("#OTNAME").val();
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/elect_warehousePage.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		            	$("#WAREHOUSE_OUT_ID").val(warid);
		                $("#OTNAME").val(warname);
		            }
		        }
		    );
		}  --%>
		/**选择入库仓库*/
		var warid = $("#WAREHOUSE_PUT_ID").val();
		var warname = $("#PTNAME").val();
		function ptelect(){
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/elect_warehousePage.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		            	$("#WAREHOUSE_PUT_ID").val(warid);
		                $("#PTNAME").val(warname);
		            }
		        }
		    );
		} 

		var optid = $("#OUTPUT_TYPE_ID").val();
		var optname = $("#OPTNAME").val();
		/**选择出入库类型*/
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
		</script>
</body>
</html>