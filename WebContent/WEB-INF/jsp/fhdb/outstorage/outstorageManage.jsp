﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<link rel="stylesheet" type="text/css" href="static/ace/css/sweetalert.css">
<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
</head>
<body class="no-skin">

	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="outstorage/outstorageList.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="keywords" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="最近登录开始"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginEnd" name="lastLoginEnd"  value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="最近登录结束"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="STATE" id="STATE" data-placeholder="请选择状态" style="vertical-align:top;width: 120px;">
										<option value=""></option>
										<option value="0">待检验</option>
										<option value="1">已检验</option>
										<option value="2">不合格</option>
										<option value="3">审核成功</option>
								  	</select>
								</td>
								<c:if test="${QX.cha == 1 }">
									<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
									<td width="10px"></td>
									<td><button type="button" class="btn btn-default btn-sm" onclick="cl()">重置</button></td>
									<td width="10px"></td>
									<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-cloud-download bigger-110 nav-search-icon blue"></i>导出</a></td></c:if>
								</c:if>
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
									<th class="center">单据编号</th>
									<th class="center">原始单号</th>
									<th class="center">物资名称</th>
									<th class="center">仓库名称</th>
									<th class="center">出入库类型</th>
									<!-- <th class="center">单据金额</th>
									<th class="center">单据数量</th> -->
									<th class="center">录入时间</th>
									<!-- <th class="center">最后修改时间</th> -->
									<th class="center">状态</th>
									<th class="center">操作员</th>
									<th class="center">审核人</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<input type="hidden" value="${var.MATERIALS_ID }" name="matid" id="matid"/>
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ID}" class="ace" /><span class="lbl"></span></label>
												<input type='hidden' name='sstate' id="sstate" value="${var.STATE}" class="ace" />
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>
												<a title="详细信息" style="text-decoration:none;cursor:pointer;" onclick="particular('${var.ID}');">${var.BIANHAO}</a>
											</td>
											<td class='center'>${var.RAW_NUMBER}</td>
											<td class='center'>${var.materials.NAME}</td>
											<td class='center'>${var.warehouse.WARNAME}</td>
											<td class='center'>${var.output_put.OPTNAME}</td>
											<%-- <td class='center'>${var.MONEY}</td>
											<td class='center'>${var.NUMBER_OF}</td>--%>
											<td class='center'>${var.ENTRY_TIME}</td>
											<%-- <td class='center'>${var.UPDATE_TIME}</td>  --%>
											<c:if test="${var.STATE eq 0}">
												<td class='center'><span class="label label-default">待检验</span></td>
											</c:if>
											<c:if test="${var.STATE eq 1}">
												<td class='center'><span class="label label-success">已检验</span></td>
											</c:if>
											<c:if test="${var.STATE eq 2}">
												<td class='center'><span class="label label-danger">不合格</span></td>
											</c:if>
											<c:if test="${var.STATE eq 3}">
												<td class='center'><span class="label label-info">审核成功</span></td>
											</c:if>
											<td class='center'>${var.user.USERNAME}</td>
											<c:if test="${empty var.AUDITOR}">
												<td class='center'>暂无</td>
											</c:if>
											<c:if test="${!empty var.AUDITOR}">
												<td class='center'>${var.AUDITOR}</td>
											</c:if>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.ID}','${var.STATE}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.ID}','${var.STATE}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
													<c:if test="${QX.sms == 1 }">
													<a class="btn btn-xs btn-info" onclick="examine('${var.ID}','${var.STATE}');">
														<i class="ace-icon fa fa-sign-in bigger-120" title="检验"></i>
													</a>
													</c:if>
													<c:if test="${QX.email == 1 }">
														<a class="btn btn-xs btn-info" onclick="auditing('${var.ID}','${var.STATE}','${var.WAREHOUSE_ID }','${var.materials.COUNT }');">
															<i class="ace-icon fa fa-check-circle bigger-120" title="审核"></i>
														</a>
														
														<%-- <c:if test="${empty var.AUDITOR}">
															<a class="btn btn-xs btn-info" onclick="remove_auditing('${var.ID}','${var.STATE}','1');">
																<i class="ace-icon fa fa-times-circle bigger-120" title="去审"></i>
															</a>
														</c:if>
														<c:if test="${!empty var.AUDITOR}">
															<a class="btn btn-xs btn-info" onclick="remove_auditing('${var.ID}','${var.STATE}','${var.AUDITOR }');">
																<i class="ace-icon fa fa-times-circle bigger-120" title="去审"></i>
															</a>
														</c:if> --%>
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
																<a style="cursor:pointer;" onclick="edit('${var.ID}','${var.STATE}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ID}','${var.STATE}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.sms == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="examine('${var.ID}','${var.STATE}');" class="tooltip-error" data-rel="tooltip" title="检验">
																	<span class="blue">
																		<i class="ace-icon fa fa-sign-in bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.email == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="auditing('${var.ID}','${var.STATE}','${var.WAREHOUSE_ID }','${var.materials.COUNT }');" class="tooltip-error" data-rel="tooltip" title="审核">
																	<span class="blue">
																		<i class="ace-icon fa fa-check-circle bigger-120"></i>
																	</span>
																</a>
																<%-- <c:if test="${empty var.AUDITOR}">
																	<a style="cursor:pointer;" onclick="remove_auditing('${var.ID}','${var.STATE}','1');" class="tooltip-error" data-rel="tooltip" title="去审">
																		<span class="blue">
																			<i class="ace-icon fa fa-times-circle bigger-120"></i>
																		</span>
																	</a>
																</c:if>
																<c:if test="${!empty var.AUDITOR}">
																	<a style="cursor:pointer;" onclick="remove_auditing('${var.ID}','${var.STATE}','${var.AUDITOR}');" class="tooltip-error" data-rel="tooltip" title="去审">
																		<span class="blue">
																			<i class="ace-icon fa fa-times-circle bigger-120"></i>
																		</span>
																	</a>
																</c:if> --%>
																
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
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-success" onclick="add();">新开单</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-sm btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
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

	</div>

	<!-- basic scripts -->
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
$(top.hangge());//关闭加载状态	
//检索
function tosearch(){
	top.jzts();
	$("#Form").submit();
}

//查看详细信息
function particular(ID){
	top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	/*  diag.Title ="详细资料"; */
	 diag.URL = '<%=basePath%>warehousing/output_storageParticular.do?ID='+ID;
	 diag.Width = 1200;
	 diag.Height = 360;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//重置
function cl(){
	$("#keywords").val("");
	$("#lastLoginStart").val("");
	$("#lastLoginEnd").val("");
}

//导出excel
function toExcel(){
	var keywords = $("#keywords").val();
	var lastLoginStart = $("#lastLoginStart").val();
	var lastLoginEnd = $("#lastLoginEnd").val();
	var STATE = $("#STATE").val();
	window.location.href='<%=basePath%>outstorage/output_storageExcel.do?keywords='+keywords+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&STATE='+STATE+'&TYPE=2';
}

//新增
function add(){
	var str = '';
	for(var i=0;i < document.getElementsByName('matid').length;i++){
	  	if(str=='') str += document.getElementsByName('matid')[i].value;
	  	else str += ';' + document.getElementsByName('matid')[i].value;
	}
	
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="新增";
	 diag.URL = '<%=basePath%>outstorage/outstorageAddPage.do?MATID='+str;
	 diag.Width = 850;
	 diag.Height = 500;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 if('${page.currentPage}' == '0'){
				 top.jzts();
				 setTimeout("self.location=self.location",100);
			 }else{
				 nextPage('${page.currentPage}');
			 }
		}
		diag.close();
	 };
	 diag.show();
}

//检验
function examine(Id,state){
	if(state!=0){
		bootbox.dialog({
			message: "<span class='bigger-110'>您已经检验过了!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else{
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="检验";
		 diag.URL = '<%=basePath%>outstorage/checkoutAddPage.do?ID='+Id;
		 diag.Width = 850;
		 diag.Height = 500;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				 if('${page.currentPage}' == '0'){
					 top.jzts();
					 setTimeout("self.location=self.location",100);
				 }else{
					 nextPage('${page.currentPage}');
				 }
			}
			diag.close();
		 };
		 diag.show();
	}
}

//审核
function auditing(Id,state,warid,count){
	if(state==0){
		bootbox.dialog({
			message: "<span class='bigger-110'>商品未检验，暂时无法审核!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else {
		 if(state==1) {
			 	top.jzts();
				var url = '<%=basePath%>outstorage/outstorageAuditing.do?STATE=3&ID='+Id+'&WAREHOUSE_ID='+warid+'&COUNT='+count;
				$.get(url,function(data){
					$(top.hangge());//关闭加载状态
					if(data == 'success'){
						swal({   
							title: "系统提示",
							text: "审核成功!", 
							type: "success",
							confirmButtonText: "OK" },function(){
								nextPage('${page.currentPage}');
							});
					}else {
						swal({   
							title: "系统提示",
							text: "审核失败!", 
							type: "error",
							confirmButtonText: "OK" });
					}
				});
		}else if(state==2) {
			bootbox.confirm("检验不合格，确定要审核吗?", function(result) {
				if(result) {
					top.jzts();
					var url = '<%=basePath%>outstorage/outstorageAuditing.do?STATE=3&ID='+Id+'&WAREHOUSE_ID='+warid+'&COUNT='+count;;
					$.get(url,function(data){
						$(top.hangge());//关闭加载状态
						if(data == 'success'){
							swal({   
								title: "系统提示",
								text: "审核成功!", 
								type: "success",
								confirmButtonText: "OK" },function(){
									nextPage('${page.currentPage}');
								});
						}else {
							swal({   
								title: "系统提示",
								text: "审核失败!", 
								type: "error",
								confirmButtonText: "OK" });
						}
					});
				}
			});
		}else if(state==3) {
			bootbox.dialog({
				message: "<span class='bigger-110'>已处于审核成功状态，无需审核!</span>",
				buttons: 			
				{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
			});
			return;
		}
	}
}

//去审
function remove_auditing(Id,state,AUDITOR){
	if(state!=3){
		bootbox.dialog({
			message: "<span class='bigger-110'>出库未审核，无法去审！</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else {
		var u = '${sessionUser.USERNAME}';
		if(u!=AUDITOR){
			bootbox.dialog({
				message: "<span class='bigger-110'>必须是审核人才能去审！</span>",
				buttons: 			
				{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
			});
			return;
		}else {
			bootbox.confirm("确定要去审吗?", function(result) {
				if(result) {
					top.jzts();
					var url = '<%=basePath%>outstorage/outstorageAuditing.do?STATE=1&ID='+Id;
					$.get(url,function(data){
						$(top.hangge());//关闭加载状态
						if(data == 'success'){
							swal({   
								title: "系统提示",
								text: "去审成功!", 
								type: "success",
								confirmButtonText: "OK" },function(){
									nextPage('${page.currentPage}');
								});
						}else {
							swal({   
								title: "系统提示",
								text: "去审失败!", 
								type: "error",
								confirmButtonText: "OK" });
						}
					});
				}
			});
		}
	}
}

//删除
function del(Id,state){
	if(state==3){
		bootbox.dialog({
			message: "<span class='bigger-110'>已审核成功，不允许删除!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else {
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result) {
				top.jzts();
				var url = '<%=basePath%>outstorage/outstorageDel.do?ID='+Id;
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

//修改
function edit(Id,STATE){
	if(STATE==1) {
		bootbox.dialog({
			message: "<span class='bigger-110'>已检验合格，不允许修改!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else if(STATE==3) {
		bootbox.dialog({
			message: "<span class='bigger-110'>已审核成功，不允许修改!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else {
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑";
		 diag.URL = '<%=basePath%>outstorage/outstorageEditPage.do?ID='+Id;
		 diag.Width = 850;
		 diag.Height = 500;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				 nextPage(${page.currentPage});
			}
			diag.close();
		 };
		 diag.show();
	}
}
//批量操作
function makeAll(msg){
	var str = '';
	var state = '';
	for(var i=0;i < document.getElementsByName('ids').length;i++){
	  if(document.getElementsByName('ids')[i].checked){
	  	if(str=='') str += document.getElementsByName('ids')[i].value;
	  	else str += ',' + document.getElementsByName('ids')[i].value;
	  	if(state=='') state += document.getElementsByName('sstate')[i].value;
	  	else state += ',' + document.getElementsByName('sstate')[i].value;
	  }
	}
	var c = 0;
	var strs= new Array(); //定义一数组 
	strs=state.split(","); //字符分割 
	for(var j=0;j<strs.length ;j++ ){
		if(strs[j]==3){
			c+=1;
		}
	}
	if(str==''){
		bootbox.dialog({
			message: "<span class='bigger-110'>您没有选择任何内容!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		$("#zcheckbox").tips({
			side:1,
          msg:'点这里全选',
          bg:'#AE81FF',
          time:8
      });
		return;
	}else if(c!=0){
		bootbox.dialog({
			message: "<span class='bigger-110'>已有数据审核成功，不允许删除!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}else if(msg!=''){
		bootbox.confirm(msg, function(result) {
			if(result) {
				top.jzts();
				var url = '<%=basePath%>warehousing/sales_returnBatchDel.do?DATA_IDS='+str;
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
$(function() {
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	
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


	
	//复选框全选控制
	var active_class = 'active';
	$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
		var th_checked = this.checked;//checkbox inside "TH" table header
		$(this).closest('table').find('tbody > tr').each(function(){
			var row = this;
			if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
			else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
		});
	});
});
</script>
</html>
