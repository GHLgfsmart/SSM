<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- jsp文件头和头部 -->
<%@include file="/WEB-INF/jsp/system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin" onload="idsid()">
	
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="goods/testPage1.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">姓名</th>
									<th class="center">年龄</th>
									<th class="center">手机号码</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr id="t${vs.index}">
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'><label><input type='hidden' name='name' value="${var.NAME}" class="ace" /></label>${var.NAME}</td>
											<td class='center'>${var.AGE}</td>
											<td class='center'>${var.PHONE}</td>
										</tr>
									
									</c:forEach>
								</c:when>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
							<table style="width:100%;">
								<tr>
									<td style="vertical-align:top;">
										<a class="btn btn-sm btn-success" onclick="elect('确定要删除选中的数据吗?');">选择</a>
										<a class="btn btn-sm btn-danger" onclick="window.parent.window.jBox.close();">取消</a>
									</td>
									<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
								</tr>
							</table>
						</div>
						</form>
					
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>

	</div>
	<!-- /.main-container -->
	
	<!-- 页面底部js¨ -->
	<%@ include file="/WEB-INF/jsp/system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script type="text/javascript">
$(top.hangge());//关闭加载状态	
//检索
function tosearch(){
	top.jzts();
	$("#Form").submit();
}
function idsid() {
	var idsid=window.parent.window.idsid;
	var states=window.parent.window.states;
	var state= new Array(); //定义一数组 
	state=states.split(";"); //字符分割
	
	var strs= new Array(); //定义一数组 
	strs=idsid.split(";"); //字符分割
	var fir = document.getElementsByName("ids");
	for(var i=0;i < fir.length;i++){
		for(var j=0;j<strs.length ;j++ ){		
			if(document.getElementsByName('ids')[i].value == strs[j] && state[j]!='2'){		
				document.getElementById("t"+i).style.color="#f00";
				fir[i].disabled = "disabled";
				
			}
		}
	}
}
//选择
function elect(msg){
	var xid = '';
	var xname = '';
	var idsid = '';
	var c=0;
	for(var i=0;i < document.getElementsByName('ids').length;i++){
	  if(document.getElementsByName('ids')[i].checked){
	  	if(xid=='') xid += document.getElementsByName('ids')[i].value;
	  	if(xname=='') xname += document.getElementsByName('name')[i].value;
	 	c=c+1;
	  }
	}
	if(xid==''){
		bootbox.dialog({
			message: "<span class='bigger-110'>您没有选择任何内容!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else if(c!=1){
		bootbox.dialog({
			message: "<span class='bigger-110'>请选择一条数据!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else {
		window.parent.window.m_Information = xname;
		window.parent.window.mid = xid;
		window.parent.window.idsid = idsid;
		window.parent.window.jBox.close();
	}
}

</script>
</html>
