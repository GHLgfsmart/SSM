<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<meta http-equiv="Expires" content="0">
<meta http-equiv="kiben" content="no-cache">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />

<link rel="stylesheet" type="text/css" href="static/ace/css/sweetalert.css">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<style type="text/css">
a:link,a:visited{
 text-decoration:none;  /*超链接无下划线*/
}
a:hover{
 text-decoration:underline;  /*鼠标放上去有下划线*/
}
</style>
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
					<form action="inventory/list.do" method="post" name="inventoryForm" id="inventoryForm">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="${pd.lastEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select name="state" id="state" style="vertical-align:top;width: 120px;">
										<option value="">请选择状态</option>	
		 								<option value="0">未审核</option>
		 								<option value="1">通过</option>
		 								<option value="2">未通过</option>
								  	</select>
								</td>
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								<%-- <td><button onclick="shenHe('${inventory.ID}')">审核</button></td>
								<td><button onclick="quShen('${inventory.ID}')">去审</button></td> --%>
								<!-- <td><button onclick="windowprint()">报表</button></td> -->
							</tr>
						</table>
						<!-- 检索  -->
		<div id="bb">
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">编号</th>
									<th class="center">操作员</th>
									<th class="center">产品名称</th>
									<th class="center">审核状态</th>
									<th class="center">审核人</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>录入时间</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>修改时间</th>
									<th class="center">数量</th>
									<th class="center">库存</th>
									<th class="center">合计</th>
									<th class="center">备注</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
				    		<c:choose>
								<c:when test="${not empty inventoryList}">
									<c:forEach items="${inventoryList}" var="inventory" varStatus="vs">
										<input type="hidden" name="ID" id="ID" value="${pd.ID }"/>		
										<tr>
											<td class='center' style="width: 30px;">
												<c:if test="${user.USERNAME != 'admin'}"><label><input type='checkbox' name='ids' value="${inventory.ID }" id="${inventory.BIANHAO }" alt="${inventory.ADUDITOR }" title="${inventory.MANY }" class="ace"/><span class="lbl"></span></label></c:if>
												<c:if test="${user.USERNAME == 'admin'}"><label><input type='checkbox' disabled="disabled" class="ace" /><span class="lbl"></span></label></c:if>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="center">${inventory.BIANHAO }</td>
											<td class="center">${inventory.INSPECTOR }</td>
											<td class="center">${inventory.PRO_NAME }</td>
											<c:if test="${pd.username != null}">
												<td class="center">
													<c:if test="${inventory.STATE == 0}">
														<a href="<%=basePath%>inventory/yes.do?ID=${inventory.ID}&AUDITOR=${pd.username }"><font color="blue">YES</font></a><B>/</B>
														<a href="<%=basePath%>inventory/no.do?ID=${inventory.ID}&AUDITOR=${pd.username }"><font color="red">NO</font></a>
													</c:if>
													<c:if test="${inventory.STATE == 1}">
														<font>通过</font><B>/</B>
														<a href="<%=basePath%>inventory/quShen.do?ID=${inventory.ID}&AUDITOR=${pd.username }"><font color="red">去审</font></a>
														<%-- <a href="#" onclick="javascript:quShen('${inventory.ID}','${pd.username}')"><font color="red">去审</font></a> --%>
													</c:if>
													<c:if test="${inventory.STATE == 2}">
														<font>未通过</font><B>/</B>
														<a href="<%=basePath%>inventory/yes.do?ID=${inventory.ID}&AUDITOR=${pd.username }"><font color="blue">通过</font></a>
													</c:if>
												</td>
											</c:if>
											<c:if test="${pd.username == null }">
												<td class="center">
													<c:if test="${inventory.STATE == 0}">
														<a href="<%=basePath%>inventory/yes.do?ID=${inventory.ID}&AUDITOR=${inventory.AUDITOR}"><font color="blue">YES</font></a><B>/</B>
														<a href="<%=basePath%>inventory/no.do?ID=${inventory.ID}&AUDITOR=${inventory.AUDITOR}"><font color="red">NO</font></a>
													</c:if>
													<c:if test="${inventory.STATE == 1}">
														<font>通过</font><B>/</B>
														<a href="<%=basePath%>inventory/quShen.do?ID=${inventory.ID}&AUDITOR=${inventory.AUDITOR}"><font color="red">去审</font></a>
														<%-- <a href="#" onclick="javascript:quShen('${inventory.ID}','${pd.username}')"><font color="red">去审</font></a> --%>
													</c:if>
													<c:if test="${inventory.STATE == 2}">
														<font>未通过</font><B>/</B>
														<a href="<%=basePath%>inventory/yes.do?ID=${inventory.ID}&AUDITOR=${inventory.AUDITOR}"><font color="blue">通过</font></a>
													</c:if>
												</td>
											</c:if>
											<td class="center">${inventory.AUDITOR }</td>
											<td class="center">
											<fmt:parseDate value="${inventory.ENTRY_TIME}" pattern="yyyy-MM-dd HH:mm:ss" var="test"/>   
											<fmt:formatDate value="${test}" pattern="yyyy-MM-dd HH:mm:ss"/>  
											</td>
											<td class="center">
											<fmt:parseDate value="${inventory.UPDATE_TIME}" pattern="yyyy-MM-dd HH:mm:ss" var="test"/>   
											<fmt:formatDate value="${test}" pattern="yyyy-MM-dd HH:mm:ss"/>  
											</td>
										<%-- 	<td class="center">
											${inventory.ENTRY_TIME}
											</td>
											<td class="center">
											${inventory.UPDATE_TIME}
											</td> --%>
											<td class="center">${inventory.MANY }</td>
											<td class="center">${inventory.PRACTICAL}</td>
											<td class="center">${inventory.DECREASE_COUNT}</td>
											<td class="center">${inventory.NOTE}</td>
											<td class="center">
												<div class="hidden-sm hidden-xs btn-group">
													<a class="btn btn-xs btn-success" title="编辑" onclick="editUser('${inventory.ID}','${inventory.STATE}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													<a class="btn btn-xs btn-danger" onclick="delInventory('${inventory.ID }','${inventory.STATE}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
												</div>
											
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<li>
																<a style="cursor:pointer;" onclick="editUser('${inventory.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;" onclick="delUser('${inventory.ID }');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="14" class="center">没有相关数据</td>
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
								<a class="btn btn-mini btn-success" onclick="add();">新增</a>
								<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
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
	
	<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
	
	</body>

<script type="text/javascript">
$(top.hangge());

//检索
function searchs(){
	top.jzts();
	$("#inventoryForm").submit();
}

//删除
function delInventory(ID,STATE,msg){
	if(STATE==1){
		sweetAlert("系统提示", "不能删除已审核的单据！请去审后在删除！", "error");
		return false;
	}else {
		bootbox.confirm("确定要删除该单据吗?", function(result) {
			if(result) {
				top.jzts();
				var url = "<%=basePath%>inventory/deleteU.do?ID="+ID+"&tm="+new Date().getTime();
				$.get(url,function(data){
					nextPage(${page.currentPage});
				});
			};
		});
	}
}

//新增
function add(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="新增";
	 diag.URL = '<%=basePath%>inventory/goAddU.do';
	 diag.Width = 760;
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
function editUser(ID,STATE){
	if(STATE==1){
		sweetAlert("系统提示", "不能修改已审核的单据！请去审后在修改！", "error");
		return false;
	}else {
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="资料";
		 diag.URL = '<%=basePath%>inventory/goEditU.do?ID='+ID;
		 diag.Width = 760;
		 diag.Height = 510;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage(${page.currentPage});
			}
			diag.close();
		 };
		 diag.show();
	}
}

//修改
function quShen(ID,AUDITOR){
	bootbox.confirm("确定要修改该单据吗?", function(result) {
		if(result) {
			top.jzts();
			var url = "<%=basePath%>inventory/quShen.do?ID="+ID+"&AUDITOR="+AUDITOR;
			$.get(url,function(data){
				nextPage(${page.currentPage});
			});
		};
	});
}


//批量操作
function makeAll(msg){
	bootbox.confirm(msg, function(result) {
		if(result) {
			var str = '';
			var emstr = '';
			var phones = '';
			var username = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  	
				  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
				  	else emstr += ';' + document.getElementsByName('ids')[i].id;
				  	
				  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
				  	else phones += ';' + document.getElementsByName('ids')[i].alt;
				  	
				  	if(username=='') username += document.getElementsByName('ids')[i].title;
				  	else username += ';' + document.getElementsByName('ids')[i].title;
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
						url: '<%=basePath%>inventory/deleteAllU.do?tm='+new Date().getTime(),
				    	data: {IDS:str},
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

function windowprint() {
	var f = document.getElementById('bb').innerHTML;
	window.print();
	location.reload([true]);
}
		
</script>
</html>
