<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<link rel="stylesheet" href="static/js/common/jbox.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
		<style type="text/css">
		#dialog-add,#dialog-message,#dialog-comment{width:100%; height:100%; position:fixed; top:0px; z-index:99999999; display:none;}
		.commitopacity{position:absolute; width:100%; height:700px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
		.commitbox{width:100%; margin:0px auto; position:absolute; top:0px; z-index:99999;}
		.commitbox_inner{width:96%; height:255px;  margin:6px auto; background:#efefef; border-radius:5px;}
		.commitbox_top{width:100%; height:253px; margin-bottom:10px; padding-top:10px; background:#FFF; border-radius:5px; box-shadow:1px 1px 3px #e8e8e8;}
		.commitbox_top textarea{width:95%; height:195px; display:block; margin:0px auto; border:0px;}
		.commitbox_cen{width:95%; height:40px; padding-top:10px;}
		.commitbox_cen div.left{float:left;background-size:15px; background-position:0px 3px; padding-left:18px; color:#f77500; font-size:16px; line-height:27px;}
		.commitbox_cen div.left img{width:30px;}
		.commitbox_cen div.right{float:right; margin-top:7px;}
		.commitbox_cen div.right span{cursor:pointer;}
		.commitbox_cen div.right span.save{border:solid 1px #c7c7c7; background:#6FB3E0; border-radius:3px; color:#FFF; padding:5px 10px;}
		.commitbox_cen div.right span.quxiao{border:solid 1px #f77400; background:#f77400; border-radius:3px; color:#FFF; padding:4px 9px;}
		</style>
	</head>
	<style>
	textarea {
		padding: 10px;
		vertical-align: top;
		width: 200px;
	}
	textarea:focus {
		outline-style: solid;
		outline-width: 2px;
	}

</style>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<div class="main-content">

		<div id="zhongxin">
		<table style="width:98%;margin-top: 10px;margin-left: 9px;" >
			<tr>
				<td style="margin-top:0px;">
				 <div style="float: left;" style="width:81%"><input readonly="readonly" name="USERNAME" id="USERNAME" style="width: 98%;height:40px;border: none;font-size: 20px;color: #438EB9;" title="这里不能手动修改" value="${pd.username}"/></div>
					<div style="float: right;margin-right: 12px;" style="width:19%"><a class='btn btn-mini btn-info' title="选择用户" onclick="dialog_open();"><i class="ace-icon fa fa-search nav-search-icon"></i></a></div>
					<textarea style='resize: none;width: 98%; height: 300px;' name="CONTENT" id="CONTENT" ></textarea>
				</td>
			</tr>
			<tr>
				<td style="padding-top: 3px;">
					 <script id="editor" type="text/plain" style="width:643px;height:259px;"></script>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;padding-top: 15px;" id="nr">
					<a class="btn btn-mini btn-primary" onclick="sendFhsms();">发送</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><img src="static/images/jzx.gif" id='msg' /><br/><h4 class="lighter block green" id='msg'>正在发送...</h4><strong id="second_shows" class="red">3秒</strong>后关闭</div>
	</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<script src='static/affiche/js/autosize.js'></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.jBox-2.3.min.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.jBox-zh-CN.js"></script>
	<script>
	$(top.hangge());
	//发送
	function sendFhsms(){
		if($("#USERNAME").val()==""){
			$("#USERNAME").tips({
				side:3,
	            msg:'请选择用户名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#USERNAME").focus();
			return false;
		}
		if($("#CONTENT").val()==""){
			$("#CONTENT").tips({
				side:1,
	            msg:'请输入内容',
	            bg:'#AE81FF',
	            time:3
	        });
			return false;
		}
		$("#zhongxin").hide();
		$("#zhongxin2").show();
		var USERNAME = $("#USERNAME").val();
		var CONTENT = $("#CONTENT").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>fhsms/save.do?tm='+new Date().getTime(),
	    	data: {USERNAME:USERNAME,CONTENT:CONTENT},
			dataType:'json',
			cache: false,
			success: function(data){
				 $.each(data.list, function(i, list){
					 if(list.msg == 'ok'){
						 var count = list.count;
						 var ecount = list.ecount;
						 $("#msg").tips({
							side:3,
				            msg:'成功发出'+count+'条,失败'+ecount+'条',
				            bg:'#68B500',
				            time:3
					      });
						 top.fhsmsmsg(USERNAME); //websocket即时通讯去通知收信人有站内信接收 ，fhsmsmsg()函数 editUserH()在 WebRoot\static\js\myjs\head.js
					 }else{
						 $("#msg").tips({
								side:3,
					            msg:'发送失败,请联系管理员!',
					            bg:'#FF0000',
					            time:6
						 });
					 }
					 setTimeout("close()",3000);
					 timer(2);
				 });
			}
		});
		
	}
	//倒计时
	function timer(intDiff){
		window.setInterval(function(){
		$('#second_shows').html('<s></s>'+intDiff+'秒');
		intDiff--;
		}, 1000);
	} 
	function close(){
		top.Dialog.close();
	}
	setTimeout("ueditor()",500);
	function ueditor(){
		var ue = UE.getEditor('editor');
	}
	//跳转UserList
	/**选择*/
	var supplier = $("#USERNAME").val();
	function dialog_open(){
		    jBox.open(
		        "iframe:<%=basePath%>fhsms/listUsers.do",
		        "选择", 750, 400,
		        {buttons: {}, iframeScrolling: 'yes', showClose: true,
		            closed:function (){
		                $("#USERNAME").val(supplier);
		            }
		        }
		    );
		} 
	</script>
</body>
</html>