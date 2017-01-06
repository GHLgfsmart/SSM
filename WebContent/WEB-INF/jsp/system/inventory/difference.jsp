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
	<link rel="stylesheet" href="static/ace/css/sweetalert.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css"/>
	 
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
					<form action="inventory/cylist.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="MATERIALS_ID" id="MATERIALS_ID" data-placeholder="请选择产品" style="vertical-align:top;width: 120px;">
									<option value="">---选择产品---</option>
									<c:forEach items="${wz}" var="list">
										<option value="${list.MID }">${list.MNAME }</option>
									</c:forEach>
								  	</select>
								</td>
								<td width="10px;"></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="warehouse_ID" id="warehouse_ID" data-placeholder="请选择仓库" style="vertical-align:top;" style="width:98%;" >
										<option value="">---选择仓库---</option>
										<c:forEach items="${wz}" var="list">
											<option value="${list.WID }">${list.WNAME }</option>
										</c:forEach>
									</select>
								</td>
								<td width="10px;"></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="startTime" id="startTime"  value="${pd.startTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="录入开始"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastTime" id="lastTime"  value="${pd.lastTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="录入结束"/></td>
								<td width="10px;"></td>
								<c:if test="${QX.cha == 1 }">
									<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="gsearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
									<td width="20px;"></td>
									<td>
										  <button type="button" class="btn btn-default btn-sm" onclick="cl()">重置</button>						
									</td>
									<td width="20px;"></td><!-- 间距 -->
									<c:if test="${QX.toExcel == 1 }">
										<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="printls();" title="打印"><i id="nav-search-icon" class="ace-icon fa fa-print bigger-150 "></i></a></td>
										
									</c:if>
								</c:if>
							</tr>
						</table>
						<!-- 检索END -->
						<!-- 打印范围  start-->
						<div id="printData">
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">编号</th>
									<th class="center">产品</th>
									<th class="center">仓库</th>
									<th class="center">入库数</th>
									<th class="center">出库数</th>
									<th class="center">实际库存</th>
									<th colspan="2" class="center">损溢&nbsp;<font size="1px;" color="red">缺/坏</font></th>
									<th class="center">时间</th>
									<th class="center">原因</th>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty cylist}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${cylist}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.BIANHAO}</td>
											<td class='center'>${var.NAME}</td>
											<td class='center'> ${var.WNAME }</td>
											<td class='center'>${var.QUANTITY}</td>
											<td class='center'>${var.ck}</td>
											<td class='center'>${var.PRACTICAL}</td>
											<td class='center'><font color="red">${var.DAMAGEDQTY}</font></td>
											<td class='center'><font color="red">${var.SHORTQTY}</font></td>
											<td class="center">${var.ENTRY_TIME}</td>
											<td class='center'><font color="blue">${var.DAMAGEDREASON};&nbsp;${var.SHORTREASON}</font></td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						</div>
						<!-- 打印范围 End -->
						<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 打印 -->
	<!-- <script type="text/javascript" src="static/login/js/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="static/ace/js/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="static/ace/js/jquery.jqprint-0.3.js"></script> -->
	
	<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
	$(top.hangge());//关闭加载状态
	$(function(){  
		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		$(top.hangge());//关闭加载状态
	});
	
	//检索
	function gsearch(){
		top.jzts();
		$("#Form").submit();
	}

	//重置
	function cl(){
		$("select#warehouse_ID").val("");
		$("select#MATERIALS_ID").val("");
		$("#lastTime").val("");
		$("#startTime").val("");
	}
	
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
		
	</script>
</body>
</html>