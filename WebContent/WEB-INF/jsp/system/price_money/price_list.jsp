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
<%@ include file="../index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin" onload="prices()">
	<div class="main-container" id="main-container">
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						
						<!-- 检索  -->
						<form action="price/list.do" method="post" name="priceForm" id="priceForm">
						<table style="margin-top:5px;">
							<tr><c:if test="${QX.cha == 1 && pd.UserName=='admin'}">
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" 
											name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="padding-left:2px;">
									<input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" 
										type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/>
								</td>
								<td style="padding-left:2px;">
									<input class="span10 date-picker" name="lastLoginEnd" name="lastLoginEnd"  value="${pd.lastLoginEnd}" 
										type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/>
								</td>
								
								<td style="vertical-align:top;padding-left:2px;">
									<a class="btn btn-light btn-xs" onclick="searchs();"  title="检索">
										<i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>
									</a>
								</td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">存储费/<span style="color: red;"><i class="ace-icon fa fa-cny bigger-120"></i></span></th>
									<th class="center">理货费/<span style="color: red;"><i class="ace-icon fa fa-cny bigger-120"></i></span></th>
									<th class="center" >装车费/<span style="color: red;"><i class="ace-icon fa fa-cny bigger-120"></i></span></th>
									<th class="center" >卸车费/<span style="color: red;"><i class="ace-icon fa fa-cny bigger-120"></i></span></th>
									<th class="center" >超时费/<span style="color: red;"><i class="ace-icon fa fa-cny bigger-120"></i></span></th>
									<th class="center" >开始天数/天</th>
									<th class="center" >超时天数/天</th>
									<th class="center" >人工费/<span style="color: red;"><i class="ace-icon fa fa-cny bigger-120"></i></span></th>
									<th class="center" >发布时间</th>
									<th class="center" >原因</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty listPrices}">
									<c:forEach items="${listPrices}" var="price" varStatus="vs">
										<c:if test="${pd.UserName=='admin' || price.STATE=='0'}">		
										<tr id="t${vs.index}">
											<td class='center' style="width: 30px;">
												<label><input type='checkbox' name='ids' value="${price.PRICE_ID }" alt="${price.STATE }" class="ace"/><span class="lbl"></span></label>
											</td>
											<td class="center">${vs.index+1}</td>
											<td class="center">${price.STORAGE}</td>
											<td class="center">${price.RICHARD}</td>
											<td class="center">${price.LOADING}</td>
											<td class="center">${price.UNLOADING}</td>
											<td class="center">${price.SURCHARGE}</td>
											<td class="center">${price.DAYS}</td>
											<td class="center">${price.EVERY_DAYS}</td>
											<td class="center">${price.ARTIFICIAL}</td>
											<td class="center">${price.MONEYTIME}</td>
											<td class="center">${price.WHY}</td>
											<td class="center">
												<div class="hidden-sm hidden-xs btn-group">
												<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="editPrice('${price.PRICE_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
												</c:if>
												<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="delPrice('${price.PRICE_ID }');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="editPrice('${price.PRICE_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="delPrice('${price.PRICE_ID }');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									</c:if>
									</c:forEach>
									<c:if test="${pd.sizes=='sizes' }">
									<tr class="main_info">
										<td colspan="10" class="center">没有相关数据</td>
									</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="10" class="center">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<td style="vertical-align:top;">
								<c:if test="${QX.add == 1 && pd.sizes=='sizes'}">
								<a class="btn btn-mini btn-success" onclick="add();">新增</a>
								</c:if>
								<c:if test="${QX.del == 1 && pd.UserName=='admin'}">
								<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
								</c:if>
							</td>
							<td style="vertical-align:top;"><div class="pagination" id="div" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
	<%@ include file="../index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
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

//检索
function searchs(){
	top.jzts();
	$("#priceForm").submit();
}
function prices() {
	var ids=document.getElementsByName('ids');
	if("${pd.UserName}"!='admin'){
		document.getElementById("div").style.display="none";
	}
	for(var i=0;i <ids.length ;i++){
		  if(document.getElementsByName('ids')[i].alt=='1'){
			  document.getElementById("t"+i).style.color="#f00";
		  }
  	}	  	
}
//删除delPrice('${price.PRICE_ID }
function delPrice(PRICE_ID){
	bootbox.confirm("确定要删除吗?", function(result) {
		if(result) {
			top.jzts();
			var url = "<%=basePath%>price/deleteU.do?PRICE_ID="+PRICE_ID;
			$.get(url,function(data){
				nextPage(${page.currentPage});
			});
		};           
	});
}

//新增
function add(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="新增";
	 diag.URL = '<%=basePath%>price/goAddU.do';
	 diag.Width = 469;
	 diag.Height = 510;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 if('${page.currentPage}' == '0'){
				 top.jzts();
				 setTimeout("self.location=self.location",100);
			 }else{
				 nextPage(${page.currentPage});
			 }
		}
		diag.close();
	 };
	 diag.show();
}

//修改
function editPrice(PRICE_ID){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="资料";
	 diag.URL = '<%=basePath%>price/goEditU.do?PRICE_ID='+PRICE_ID;
	 diag.Width = 469;
	 diag.Height = 510;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			nextPage(${page.currentPage});
		}
		diag.close();
	 };
	 diag.show();
}
$(function() {
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
})
//批量操作
function makeAll(msg){
	bootbox.confirm(msg, function(result) {
		if(result) {
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  }
			}
			if(str==''){
				bootbox.dialog({
					message: "<span class='bigger-110'>您没有选择任何内容!</span>",
					buttons: 			
					{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
				});
				$("#zcheckbox").tips({
					side:3,
		            msg:'点这里全选',
		            bg:'#AE81FF',
		            time:8
		        });
				
				return;
			}else{
				if(msg == '确定要删除选中的数据吗?'){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>price/deleteAllU.do?tm='+new Date().getTime(),
				    	data: {PRICE_ID:str},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							 $.each(data.list, function(i, list){
									nextPage(${page.currentPage});
							 });
						}
					});
				}
			}
		}
	});
}

</script>
</html>
