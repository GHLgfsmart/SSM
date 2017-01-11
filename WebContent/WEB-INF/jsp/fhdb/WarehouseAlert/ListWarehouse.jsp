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
<%@ include file="/WEB-INF/jsp/system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						
						<!-- 检索  -->
						<form action="Drawing/LikeList.do" method="post" name="alertForm" id="alertForm">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords}" placeholder="请输入关键字" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
									<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
									<c:if test="${QX.toExcel == 1 }">
									<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
									</c:if>
									<c:if test="${QX.toExcel == 1 }">
										<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="printls();" title="打印"><i id="nav-search-icon" class="ace-icon fa fa-print bigger-150 nav-search-icon blue "></i></a></td>
									</c:if>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
						<div id="printData">
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center">序号</th>
									<th class="center">商品编号</th>
									<th class="center">商品名称</th>
									<th class="center">计量单位</th>
									<th class="center">所在仓库</th>
									<th class="center">库存上限</th>
									<th class="center">实际库存</th>
									<th class="center">库存下限</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty warList}">
									<c:forEach items="${warList}" var="war" varStatus="vs">
												
										<tr>
											<td class='center' style="width: 30px;">
												<label><input type='checkbox' value="${war.ID }"/><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 60px;"><font color="red">${vs.index+1}</font></td>
											<td class="center"><font color="red">${war.BIANHAO }</font></td>
											<td class="center"><font color="red">${war.NAME }</font></td>
											<td class="center"><font color="red">${war.UNIT }</font></td>
											<td class="center"><font color="red">${war.WARNAME}</font></td>
											<td class="center"><font color="red"><b>${war.UPPER_LIMIT}</b></font> </td>
											<td class="center"><font color="red"><b>${war.COUNT}</b></font> </td>
											<td class="center"><font color="red"><b>${war.LOWER_LIMIT}</b></font></td>
										</tr>
									
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="10" class="left"><font size="4" color="red">抱歉您输入的关键字未找到!</font></td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
							</div>
							<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;"><div class="pagination" style="float: left;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
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
$(top.hangge());

//打印
function  printls(){
	var headstr = "<html><head><title></title></head><body>";  
	var footstr = "</body>";
	var printDatad = document.getElementById("printData").innerHTML; 
	var oldstr = document.body.innerHTML;  
	document.body.innerHTML = headstr+printDatad+footstr; 
	window.print();  
	document.body.innerHTML = oldstr; 
	return false;
}

//检索
function searchs(){
	top.jzts();
	$("#alertForm").submit();
}

//导出excel
function toExcel(){
	var keywords = $("#nav-search-input").val();
	window.location.href='<%=basePath%>Drawing/ExportData.do?keywords='+keywords;
}
	
</script>
</html>
