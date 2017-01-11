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
		<link rel="stylesheet" type="text/css" href="static/ace/css/build.css"><!-- 洪青青     复选框  必须要有<link rel="stylesheet" href="static/ace/css/bootstrap.css" /> <link rel="stylesheet" href="static/ace/css/font-awesome.css" />-->
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
					<c:if test="${msg eq 'outstorageAdd'}">
						<legend>新增出库单</legend>
					</c:if>
					<c:if test="${msg eq 'outstorageEdit'}">
						<legend>修改出库单</legend>
					</c:if>
					<form action="outstorage/${msg }.do" name="Form" id="Form" method="post">
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
									<input type="hidden" id="MATERIALS_ID" name="MATERIALS_ID" />
									<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="30" readonly placeholder="这里选择物资" title="物资" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="matelect();" type="button">选择</button>
								</td>
								<td style="width:79px;text-align: left;padding-top: 13px;">出入库类型:</td>
								<td>
									<input type="hidden" id="OUTPUT_TYPE_ID" name="OUTPUT_TYPE_ID" value="002"/>
									<input type="text" name="OPTNAME" id="OPTNAME" value="${pd.OPTNAME}" maxlength="30" placeholder="这里选择出入库类型" title="出入库类型" style="width:80%;"/>
									<button class="btn btn-mini radius" onclick="optelect();" type="button">选择</button>
									<input type="hidden" id="WAREHOUSE_ID" name="WAREHOUSE_ID" value="001"/>
									<input type="hidden" value="2" id="TYPE" name="TYPE"/>
									<input type="hidden" value="0" id="STATE" name="STATE"/>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">单据金额:</td>
								<td>
 									<input type="number" name="MONEY" id="MONEY" readonly value="${pd.MONEY}" maxlength="30" placeholder="这里输入单据金额" title="单据金额" style="width:98%;"/>
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
								<td style="width:79px;text-align: right;padding-top: 13px;">费用:</td>
								<td colspan="3">
								<fieldset style="padding-right: 25px;">
								<div class="checkbox checkbox-success">
									<input type="checkbox" class="styled" id="SURCHARGE" name="SURCHARGE" onclick="return false;" value="${pd1.SURCHARGE}" checked>
									<label for="inlineCheckbox2"> 超时费（<span style="color: #438EB9;">每<span style="color: red;" id="money">${pd1.SURCHARGE }</span>  &nbsp;共<span style="color: red;" id="moneys1">0</span> </span>）/<i class="ace-icon fa fa-cny red"></i></label>
								</div> 
								</fieldset>
								<input type="hidden" name="DAYS" id="DAYS" value="${pd1.DAYS}"/>
								<input type="hidden" name="EVERY_DAYS" id="EVERY_DAYS" value="${pd1.EVERY_DAYS}"/>
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
		/**选择供应商*/
		var materials = $("#NAME").val();
		var matid = $("#MATERIALS_ID").val();
		var ENTRY_TIME='';
		function matelect(){
			var OUT_TIME=$("#ENTRY_TIME").val();
		    jBox.open(
		        "iframe:<%=basePath%>warehousing/electMaterialsPage.do?STATE=1",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                $("#NAME").val(materials);
 						if(matid != $("#MATERIALS_ID").val()){
			                $("#MATERIALS_ID").val(matid);
			                var strs= new Array(); //定义一数组 
			        		strs=OUT_TIME.split(" "); //字符分割  
			        		var strs1= new Array(); //定义一数组 
			        		strs1=ENTRY_TIME.split(" "); //字符分割  
			                var days=dateDiff(strs[0], strs1[0]);//计算天数
			                var DAYSS=$("#DAYS").val();
			                var daysss=parseInt(DAYSS);
			                var EVERY_DAYS=$("#EVERY_DAYS").val();
			                var EVERY_DAYSS=parseInt(EVERY_DAYS);
			                var SURCHARGE=$("#SURCHARGE").val();
			                var SURCHARGES=parseFloat(SURCHARGE);
			       			var url = "<%=basePath%>outstorage/moneys.do?ID="+matid
			    			$.get(url,function(data){
			    				if(data == 'fall') {
			    					$("#MONEY").val('0');
			    					window.document .getElementById ("moneys1").innerHTML="0";
			    				}else {
			    					var data1= new Array(); //定义一数组 
					        		data1=data.split(";"); //字符分割  
					        		var count=parseInt(data1[1]);
			    					if(days>daysss){
			    						var money=parseInt(data1[0]);
			    						var moneytot=((days-daysss)/EVERY_DAYSS*SURCHARGES)*count;
			    						window.document .getElementById ("moneys1").innerHTML=moneytot;
			    						money+=moneytot;
			    						$("#MONEY").val(money);
					                }else{
					                	$("#MONEY").val(data1[0]);
					                	window.document .getElementById ("moneys1").innerHTML="0";
					                }
			    				}
			    			});
 						}
		            }
		        }
		    );
		} 
		function dateDiff(date1, date2) {
	            var type1 = typeof date1, type2 = typeof date2;
	            if (type1 == 'string')
	                date1 = stringToTime(date1);
	            else if (date1.getTime)
	                date1 = date1.getTime();
	            if (type2 == 'string')
	                date2 = stringToTime(date2);
	            else if (date2.getTime)
	                date2 = date2.getTime();
	            return (date1 - date2) / (1000 * 60 * 60 * 24); //结果是小时 
	        }
	        //字符串转成Time(dateDiff)所需方法 
	        function stringToTime(string) {
	            var f = string.split(' ', 2);
	            var d = (f[0] ? f[0] : '').split('-', 3);
	            var t = (f[1] ? f[1] : '').split(':', 3);
	            return (new Date(
	           parseInt(d[0], 10) || null,
	           (parseInt(d[1], 10) || 1) - 1,
	            parseInt(d[2], 10) || null,
	            parseInt(t[0], 10) || null,
	            parseInt(t[1], 10) || null,
	            parseInt(t[2], 10) || null
	            )).getTime();
	        }
		</script>
</body>
</html>