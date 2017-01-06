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

<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
</head>
<body class="no-skin" onload="onname();">

	<div class="main-container" id="main-container">
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="department/list.do" method="post" name="Form" id="Form">
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">单据编号</th>
									<th class="center">名称</th>
									<th class="center">供应商名称</th>
									<th class="center">供应商分类</th>
									<th class="center">数量&nbsp;/个</th>
									<th class="center">金额 &nbsp;/<span style="color: red;"><i class="ace-icon fa fa-cny bigger-120"></i></span></td></th>
									<th class="center">录入时间</th>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.BIANHAO}</td>
											<td class='center'>${var.maNAME}</td>
											<td class='center'>${var.SUPNAME}</td>
											<td class='center'>${var.ccNAME}</td>
											<td class='center'>${var.COUNT}</td>
											<td class='center'>${var.MONEY}</td>
											<td class='center'>${var.MO_TIME}</td>
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
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="color: red;font-size: 24px;"><span id="money"></span><i class="ace-icon fa fa-cny"></i></td>
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
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		function onname() {
			var name='${pd.MO_TIME}';
			var arr=name.split("-");
			var date=new Date;
			var year=date.getFullYear();
			if(year==eval(arr[0])){
				arr[0]="今年 ";
			}else if(year==(eval(arr[0])-1)){
				arr[0]="去年 ";
			}else if(year==(eval(arr[0])-2)){
				arr[0]="前年 ";
			}
			if(arr[1]==null){
				if('${pd.boos}'=='true'){
					document.getElementById("money").innerHTML =""+arr[0]+"上半年收益为";
				}else if('${pd.boos}'=='false'){
					document.getElementById("money").innerHTML =""+arr[0]+"下半年收益为";
				}else{
					document.getElementById("money").innerHTML =""+arr[0]+"全年收益为";
				}
			}else{
				document.getElementById("money").innerHTML =""+arr[0]+arr[1]+"月份收益为";
			}
			
		}
	</script>


</body>
</html>