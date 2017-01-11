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

<!-- --三级联动 -->
<link href="static/SanJiLianDong/bootstrap.min.css" rel="stylesheet">
<link href="static/SanJiLianDong/main.css" rel="stylesheet">

<script src="static/SanJiLianDong/bootstrap.min.js"></script>
<script src="static/SanJiLianDong/distpicker.data.js"></script>
<script src="static/SanJiLianDong/distpicker.js"></script>
<script src="static/SanJiLianDong/main.js"></script>
</head>
<body class="no-skin" onload="sanji();">
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
								<form action="goods/${msg }.do" name="goodsForm" id="goodsForm" method="post">
									<input type="hidden" name="ID" id="ID" value="${pd.ID }"/>
									<input type="hidden" name="PID" id="PID" value="${pd.P_ID }"/>
									<input type="hidden" name="DID" id="DID" value="${pd.D_ID }"/>
									<input type="hidden" name="CID" id="CID" value="${pd.C_ID }"/>
									<input type="hidden" name="STATES" id="STATES" value="${pd.STATE }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px; color: black;"><B>司机:</B></td>
											<td>
												<input type="hidden" name="D_ID" id="D_ID" />
			 									<input type="text" name="D_NAME" id="D_NAME" value="${pd.D_NAME}" maxlength="30" placeholder="这里选择司机" title="司机" style="width:80%;" readonly="readonly"/>
												<button class="btn btn-mini radius" onclick="elect1();" type="button">选择</button>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px; color: black;"><B>车牌号:</B></td>
											<td>
												<input type="hidden" name="C_ID" id="C_ID" />
			 									<input type="text" name="C_BRAND" id="C_BRAND" value="${pd.C_BRAND}" maxlength="30" placeholder="这里选择货车" title="货车" style="width:80%;" readonly="readonly"/>
												<button class="btn btn-mini radius" onclick="elect2();" type="button">选择</button>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px; color: black;"><B>载重:</B></td>
											<td>
			 									<input type="text" name="C_WEIGHT" id="C_WEIGHT" value="${pd.C_WEIGHT}" maxlength="30" title="载重" style="width:80%;" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px; color: black;"><B>拣取数量:</B></td>
											<td>
												<input type="hidden" name="P_ID" id="P_ID" />
			 									<input type="text" name="P_COUNT" id="P_COUNT" value="${pd.P_COUNT}" maxlength="30" placeholder="这里选择拣取数量" title="拣取数量" style="width:80%;" readonly="readonly"/>
												<button class="btn btn-mini radius" onclick="elect3();" type="button">选择</button>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px; color: black;"><B>出库单数:</B></td>
											<td><input type="text" name="P_MATCOUNT" id="P_MATCOUNT" value="${pd.P_MATCOUNT }" style="width:80%;" readonly="readonly"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px; color: black;"><B>始发地:</B></td>
											<td>
												<input type="text" name="START_ADDRESS" id="START_ADDRESS"  value="${pd.START_ADDRESS }" style="width:98%;"/>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px; color: black;"><B>目的地:</B></td>
											<td>
												<input type="hidden" name="ADDRESS" id="ADDRESS"  value="${pd.ADDRESS }" style="width:98%;"/>
												<div id="distpicker5" style="width:100%">
													<div class="" style="width:25%;float:left"><!-- ----hqq class="form-group" -->
														<select class="form-control" id="province10" onchange="save_name()"></select>&nbsp;
													</div>
													<div id="cityhqq" style="width:25%;float:left"><!-- ----hqq class="form-group" -->
														<select class="form-control" id="city10"></select>&nbsp;
													</div>
													<div id="districthqq" style="width:25%;float:left"><!-- ----hqq class="form-group" -->
														<select class="form-control" id="district10"></select>
													</div>
													<!-- ---------假的显示框 -->
													<div id="cityhqq1" style="width:25%;float:left"><!-- ----hqq class="form-group" -->
														<select class="form-control" id="jdnamehqq"></select>&nbsp;
													</div>
													<div id="districthqq1" style="width:25%;float:left"><!-- ----hqq class="form-group" -->
														<select class="form-control" id="jdnamehqq1"></select>
													</div>
												</div>
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
	function save_name(){
		 if('${msg}' == 'editU'){
			 $('#cityhqq1').hide();//隐藏
			 $('#districthqq1').hide();
			 $('#cityhqq').show();//显示
			 $('#districthqq').show();
		 }
	 }
	function sanji(){
		$.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js', function(_result) {
	        if (remote_ip_info.ret == '1') {
	            /* alert('国家：' + remote_isp_info.country + '<BR>省：' + remote_ip_info.province + '<BR>市：' + remote_ip_info.city + '<BR>区：' + remote_ip_info.district + '<BR>ISP：' + remote_ip_info.isp + '<BR>类型：' + remote_ip_info.type + '<BR>其他：' + remote_ip_info.desc); */
	            /* alert(remote_ip_info.country +remote_ip_info.province +'省' +  remote_ip_info.city + '市' + remote_ip_info.district +'区'); */
	            var country = remote_ip_info.country +remote_ip_info.province +'省' +  remote_ip_info.city + '市';
	            $("#START_ADDRESS").val(country);
	        	//alert(country);
	        } else {
	            alert('没有找到匹配的IP地址信息！');
	        }
	    });
		 if('${msg}' == 'editU'){
				var abc='${pd.ADDRESS}';//获取地址
				var cze=abc.split(",");
				var province10=parseInt(cze[1]);
				$('#cityhqq').hide();
				$('#districthqq').hide();
				window.document.getElementById("province10").options[province10].selected="selected";
				//根据id查找对象， 
				var obj=document.getElementById('jdnamehqq'); 
				//添加一个选项 
				obj.add(new Option(cze[2],cze[3])); //这个只能在IE中有效 
				//根据id查找对象， 
				var obj=document.getElementById('jdnamehqq1'); 
				//添加一个选项 
				obj.add(new Option(cze[4],cze[5])); //这个只能在IE中有效 
		 }else if('${msg }' == 'saveU'){
			$('#cityhqq1').hide();
			$('#districthqq1').hide();
		}
	 }
	//保存
	function save(){
		if($("#D_NAME").val()==""){
			$("#D_NAME").tips({
				side:3,
	            msg:'选择司机',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#D_NAME").focus();
			return false;
		}
		
		if($("#C_BRAND").val()==""){
			$("#C_BRAND").tips({
				side:3,
	            msg:'选择货车',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#C_BRAND").focus();
			return false;
		}
		
		if($("#P_COUNT").val()==""){
			$("#P_COUNT").tips({
				side:3,
	            msg:'选择货物',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#P_COUNT").focus();
			return false;
		}
		/* if($("#ADDRESS").val()==""){
			$("#ADDRESS").tips({
				side:3,
	            msg:'输入目的地',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#ADDRESS").focus();
			return false;
		} */
		var select=document.getElementById("province10");  
	    var lastIndex = select.selectedIndex; 
	    var lastValue = select.options[lastIndex].value;
	    var select1=document.getElementById("city10");  
	    var lastIndex1 = select1.selectedIndex;
	    var lastValue1 = select1.options[lastIndex1].value;
	    var select2=document.getElementById("district10");  
	    var lastIndex2 = select2.selectedIndex;
	    var lastValue2 = select2.options[lastIndex2].value;
		var ADDRESS=lastValue+","+lastIndex+","+lastValue1+","+lastIndex1+","+lastValue2+","+lastIndex2;
		$("#ADDRESS").val(ADDRESS);
		$("#goodsForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
		
	}
	
	/**选择司机*/
	var m_Information = $("#D_NAME").val();
	var mid = $("#D_ID").val();
	var idsid=document.getElementById('DID').value;
	var states=document.getElementById('STATES').value;
	function elect1(){
	    jBox.open(
	        "iframe:<%=basePath%>goods/testPage1.do",
	        "选择", 680, 360,
	        {buttons: {}, iframeScrolling: 'yes', showClose: true,
	            closed:function (){
	                $("#D_NAME").val(m_Information);
	                $("#D_ID").val(mid);
	                $("#DID").val(idsid);
	                $("#STATES").val(states);
	            }
	        }
	    );
	} 
	
	/**选择货物*/
	var MATCOUNT = $("#P_MATCOUNT").val();
	var m_count= $("#P_COUNT").val();
	var mid = $("#P_ID").val();
	var idsid2=document.getElementById('PID').value;
	function elect3(){
	    jBox.open(
	        "iframe:<%=basePath%>goods/testPage3.do",
	        "选择", 680, 360,
	        {buttons: {}, iframeScrolling: 'yes', showClose: true,
	            closed:function (){
	                $("#P_COUNT").val(m_count);
	                $("#P_MATCOUNT").val(MATCOUNT);
	                $("#P_ID").val(mid);
	                $("#PID").val(idsid2);
	            }
	        }
	    );
	} 
	
	/*选择货车*/
	var m_brand = $("#C_BRAND").val();
	var m_weight= $("#C_WEIGHT").val();
	var mid = $("#C_ID").val();
	var states=document.getElementById('STATES').value;
	var idsid3=document.getElementById('CID').value;
	function elect2() {
		jBox.open(
	        "iframe:<%=basePath%>goods/testPage2.do",
	        "选择", 680, 360,
	        {buttons: {}, iframeScrolling: 'yes', showClose: true,
	            closed:function (){
	                $("#C_BRAND").val(m_brand);
	                $("#C_WEIGHT").val(m_weight);
	                $("#C_ID").val(mid);
	                $("#CID").val(idsid3);
	                $("#STATES").val(states);
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
	function hasN(){
		var BIANHAO = $.trim($("#BIANHAO").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>goods/hasN.do',
	    	data: {BIANHAO:BIANHAO,tm:new Date().getTime()},
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