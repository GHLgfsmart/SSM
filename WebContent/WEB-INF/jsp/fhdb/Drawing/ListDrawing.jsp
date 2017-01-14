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
<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
<link rel="stylesheet" type="text/css" href="static/ace/css/sweetalert.css">
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
						<form action="Drawing/ListDrawing.do" method="post" name="alertForm" id="alertForm">
							<input type="hidden" name="sh" id="sh" value=1>
							<input type="hidden" name="qs" id="qs" value=0>
							<input type="hidden" name="AUDITOR" id="AUDITOR" value="${Operator}">
							<input type="hidden" name="qshr" id="qshr" value="">
							<input type="hidden" name="updatetime" id="updatetime" value="${updatetime}">
							
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入编号" class="nav-search-input" id="keywords" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" /></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginEnd" id="lastLoginEnd"  value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select name="STATE" id="STATE" style="vertical-align:top;width: 120px;">
										<option value="">请选择状态</option>
										<option value="0">未审核</option>
										<option value="1">已审核</option>
								  	</select>
								</td>
								<c:if test="${QX.cha == 1 }">
									<td style="padding-left:2px;"><input type="reset" id="cz" value="刷新"></td>
									<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>搜索</a></td>
									<c:if test="${QX.toExcel == 1 }">
										<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="ExcelData();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i>导出</a></td></c:if>
									<c:if test="${QX.toExcel == 1 }">
										<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="printls();" title="打印"><i id="nav-search-icon" class="ace-icon fa fa-print bigger-150 nav-search-icon blue "></i>打印</a></td>
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
									<th class="center">单据编号</th>
									<th class="center">业务日期</th>
									<th class="center">录入时间</th>
									<th class="center">最后修改时间</th>
									<th class="center">经手人</th>
									<th class="center">调拨说明</th>
									<th class="center">审核状态</th>
									<th class="center">操作员</th>
									<th class="center">审核人</th>
									<th class="center">调出仓库</th>
									<th class="center">调入仓库</th>
									<th class="center">单据数量</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	 
							<c:choose>
								<c:when test="${not empty darList}">
								<c:if test="${QX.cha == 1}">
									<c:forEach items="${darList}" var="dar" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">
												<label><input type='checkbox' name="ID" id="ID"  value="${dar.ID }"  alt="${dar.STATE }"/><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 60px;">${vs.index+1}</td>
											<td class="center">${dar.BIANHAO}</td>
											<td class="center">${dar.BusinessDate}</td>
											<td class="center">${dar.ENTRY_TIME}</td>
											<td class="center">${dar.UPDATE_TIME}</td>
											<td class="center">${dar.USERNAME}</td>
											<td class="center">${dar.DRAWING_INST}</td>
											<c:if test="${dar.STATE eq 0}">
												<td class="center" style="font-size: 12px;"><span class="label label-danger">未审核</span></td>
											</c:if>
											<c:if test="${dar.STATE eq 1}">
												<td class="center" style="font-size: 12px;"><span class="label label-success">已审核</span></td>
											</c:if>
											<td class="center">${dar.INSPECTOR}</td>
											<td class="center">${dar.AUDITOR}</td>
											<td class="center">${dar.chu}</td>
											<td class="center">${dar.ru}</td>
											<td class="center">${dar.NUMBER_OF}</td>
												<td class="center">
												<c:if test="${QX.edit != 1}">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="修改" onclick="edit('${dar.ID}','${dar.STATE }','${dar.MATERIALS_ID }');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="修改"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="singleDel('${dar.ID}','${dar.STATE }');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-info" onclick="auditing('${dar.ID}','${dar.STATE}');">
														<i class="ace-icon fa fa-check-circle bigger-120" title="审核"></i>
													</a>
													</c:if>
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-info" onclick="abolish('${dar.ID}','${dar.STATE}');">
														<i class="ace-icon fa fa-times-circle bigger-120" title="去审"></i>
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
																<a style="cursor:pointer;" onclick="edit('${dar.ID}','${dar.STATE }','${dar.MATERIALS_ID }');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="blue">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="singleDel('${dar.ID}','${dar.STATE }');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="auditing('${dar.ID}','${dar.STATE}');" class="tooltip-success" data-rel="tooltip" title="审核">
																	<span class="blue">
																		<i  class="ace-icon fa fa-check-circle bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="abolish('${dar.ID}','${dar.STATE}');" class="tooltip-success" data-rel="tooltip" title="去审">
																	<span class="red">
																		<i class="ace-icon fa fa-times-circle bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="10" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="10" class="left"><font size="4" color="red">抱歉未找到数据!</font></td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						</div>
							<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
							<td style="vertical-align:top;">
								<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新开单</a>
								</c:if>
								<c:if test="${QX.del == 1 }">
									<a  class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" >批量删除</a>
								</c:if>
								
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
	

//导出excel
function ExcelData(){
	var keywords = $("#keywords").val();
	var STATE=$("#STATE").val();
	var lastLoginStart = $("#lastLoginStart").val();
	var lastLoginEnd = $("#lastLoginEnd").val();
	window.location.href='<%=basePath%>Drawing/Export.do?keywords='+keywords+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&STATE='+STATE;
}

//检索
function searchs(){
	top.jzts();
	$("#alertForm").submit();
}

//修改
function edit(ID,STATE,MATERIALS_ID){
	if (STATE==1) {
			bootbox.dialog({
				message: "<span class='bigger-110'>此单据已审核,请去审核后编辑!</span>",
				buttons: 			
				{ "button":{"className":"btn-sm btn-success","label":"确定"}}
			});
			
			return;
	}else{
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="编辑";
	 diag.URL = '<%=basePath%>Drawing/DrawingByid.do?ID='+ID+'&MATERIALS_ID='+MATERIALS_ID;
	 diag.Width = 900;
	 diag.Height = 600;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 nextPage(${page.currentPage});
		}
		diag.close();
	 };
	 diag.show();
	}
}
//新增
function add(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="新建仓库调拨单";
	 diag.URL = '<%=basePath%>Drawing/goAddPage.do';
	 diag.Width = 900;
	 diag.Height = 600;
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

/**
 * 审核
 */
function auditing(ID,STATE) {
		var AUDITOR=$("#AUDITOR").val();
	 	var UPDATE_TIME=$("#updatetime").val();
	 	var sh=$("#sh").val();
	 	if (STATE==1) {
	 			bootbox.dialog({
						message: "<span class='bigger-110'>此单据已审核,不能重复审核!</span>",
						buttons: 			
						{ "button":{"className":"btn-sm btn-success","label":"确定"}}
					});
				return false;
		}else{
			var url = '<%=basePath%>Drawing/${At}.do?ID='+ID+'&STATE='+sh+'&AUDITOR='+AUDITOR+'&UPDATE_TIME='+UPDATE_TIME;
	 		$.get(url,function(data){
	 				$(top.hangge());//关闭加载状态
	 					swal({   
	 						title: "系统提示",
	 						text: "审核成功!", 
	 						type: "success",
	 						confirmButtonText: "OK" },function(){
	 							nextPage('${page.currentPage}');
	 						});	
	 		});
	 	
		}
}

/**
 * 去审
 */
 function abolish(ID,STATE) {
		 var AUDITOR=$("#qshr").val();
		 var UPDATE_TIME=$("#updatetime").val();
		 var qs=$("#qs").val();
		 if (STATE==0) {
				bootbox.dialog({
						message: "<span class='bigger-110'>此单据已去核,不能重复去审!</span>",
						buttons: 			
						{ "button":{"className":"btn-sm btn-success","label":"确定"}}
					});
				return false;
			}else{
				 var url = '<%=basePath%>Drawing/${As}.do?ID='+ID+'&STATE='+qs+'&AUDITOR='+AUDITOR+'&UPDATE_TIME='+UPDATE_TIME;
			 		$.get(url,function(data){
			 				$(top.hangge());//关闭加载状态
			 					swal({   
			 						title: "系统提示",
			 						text: "去审成功!", 
			 						type: "success",
			 						confirmButtonText: "OK" },function(){
			 							nextPage('${page.currentPage}');
			 						});	
			 	});
			}
	}
	
//删除
 function singleDel(ID,STATE){
 	bootbox.confirm("确定要删除吗?", function(result) {
 		if(STATE==1){
				bootbox.dialog({
					message: "<span class='bigger-110'>单据已审核,请去审核后删除!</span>",
					buttons: 			
					{ "button":{"className":"btn-sm btn-success","label":"确定"}}
				});
				
				return;
			}
 		if(result) {
 			top.jzts();
 			var url = '<%=basePath%>Drawing/singleDel.do?ID='+ID;
 			$.get(url,function(data){
 				$(top.hangge());//关闭加载状态
 				if(data == 'success'){
 					swal({   
 						title: "系统提示",
 						text: "删除成功!", 
 						type: "success",
 						confirmButtonText: "OK" },function(){
 							nextPage('${page.currentPage}');
 						});
 				}else {
 					swal({   
 						title: "系统提示",
 						text: "删除失败!", 
 						type: "error",
 						confirmButtonText: "OK" });
 				}
 			});
 		}
 	});
 }


//批量操作
 function makeAll(msg){
	 var ID = '';
	 var STATE='';
	 for(var i=0;i < document.getElementsByName('ID').length;i++)
		{
			  if(document.getElementsByName('ID')[i].checked){
			  	if(ID=='') ID += document.getElementsByName('ID')[i].value;
			  	else ID += ',' + document.getElementsByName('ID')[i].value;
			  	if(STATE=='') STATE += document.getElementsByName('ID')[i].alt;
			  	else STATE += ',' + document.getElementsByName('ID')[i].alt;
			  }
			  if(STATE==1){
	  				bootbox.dialog({
	  					message: "<span class='bigger-110'>您选中的有单据已审核,请去审核后删除!</span>",
	  					buttons: 			
	  					{ "button":{"className":"btn-sm btn-success","label":"确定"}}
	  				});
	  				
	  				return;
	  			}
		}if(ID==''){
  				bootbox.dialog({
  					message: "<span class='bigger-110'>您没有选择任何内容!</span>",
  					buttons: 			
  					{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
  				});
  				return;
  			}else {
 			bootbox.confirm(msg, function(result) {
 			if(result) {
 				top.jzts();
 				var url = '<%=basePath%>Drawing/deletewar.do?ID='+ID;
 				$.get(url,function(data){
 					$(top.hangge());//关闭加载状态
 					if(data == 'success'){
 						swal({   
 							title: "系统提示",
 							text: "删除成功!", 
 							type: "success",
 							confirmButtonText: "OK" },function(){
 								nextPage('${page.currentPage}');
 							});
 					}else {
 						swal({   
 							title: "系统提示",
 							text: "删除失败!", 
 							type: "error",
 							confirmButtonText: "OK" });
 					}
 				});
 			}
 		});
 	}
 }
//删除
 function del(ID,STATE){
 	bootbox.confirm("确定要删除吗?", function(result) {
 		if (STATE==1) {
 			bootbox.dialog({
					message: "<span class='bigger-110'>您选中的单据已审核,请去审核后删除!</span>",
					buttons: 			
					{ "button":{"className":"btn-sm btn-success","label":"确定"}}
				});
				
				return;
		}else if(result) {
 			top.jzts();
 			window.location.href='<%=basePath%>Drawing/deletewar.do?ID='+ID
 		}
 	});
 }

$(function(){
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	
	
});
	
</script>
</html>
