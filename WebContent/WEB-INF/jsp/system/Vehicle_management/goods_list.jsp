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
<body class="no-skin" onload="onChecks()">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						
						<!-- 检索  -->
					<form action="goods/list.do" method="post" name="goodsForm" id="goodsForm">
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
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" id="lastEnd"  value="${pd.lastEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select name="state" id="state" style="vertical-align:top;width: 120px;">
										<option value="">请选择状态</option>	
		 								<option value="0">待发货</option>
		 								<option value="1">派送中</option>
		 								<option value="2">已派送</option>
								  	</select>
								</td>
								<td width="10px"></td>
								<td><button type="button" class="btn btn-default btn-sm" onclick="cl()">重置</button></td>
								<td width="10px"></td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
						<table id="simple-table" class="table table-striped table-bordered table-hover"  
				             style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">司机</th>
									<th class="center">车牌号</th>
									<th class="center">载重<B>/t</B></th>
									<th class="center">拣取数量</th>
									<th class="center">出库单数</th>
									<th class="center">始发地</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>发货时间</th>
									<th class="center">目的地</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>到货时间</th>
									<th class="center">状态</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
				    		<c:choose>
								<c:when test="${not empty goodsList}">
								 <c:if test="${QX.cha == 1 }">
									<c:forEach items="${goodsList}" var="goods" varStatus="vs">
										<input type="hidden" name="ID" id="ID" value="${pd.ID }"/>
										<input type="hidden" name="P_ID" id="P_ID" value="${goods.P_ID }"/>
										<input type="hidden" name="D_ID" id="D_ID" value="${goods.D_ID }"/>
										<input type="hidden" name="C_ID" id="C_ID" value="${goods.C_ID }"/>
										<input type="hidden" name="STATE" id="STATE" value="${goods.STATE }"/>
										<tr id="t${vs.index}">
											<td class='center' style="width: 30px;">
												<c:if test="${user.USERNAME != 'admin'}"><label><input type='checkbox' name='ids' id="${goods.P_ID }" alt="${goods.ADDRESS }" value="${goods.ID }" title="${goods.STATE }" class="ace"/><span class="lbl"></span></label></c:if>
												<c:if test="${user.USERNAME == 'admin'}"><label><input type='checkbox' disabled="disabled" class="ace" /><span class="lbl"></span></label></c:if>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="center">${goods.D_NAME }</td>
											<td class="center">赣B ${goods.C_BRAND }</td>
											<td class="center">${goods.C_WEIGHT }</td>
											<td class="center">${goods.P_COUNT }</td>
											<td class="center">${goods.P_MATCOUNT }</td>
											<td class="center">${goods.START_ADDRESS }</td>
											<td class="center">
												<fmt:parseDate value="${goods.START_TIME}" pattern="yyyy-MM-dd HH:mm:ss" var="test"/>   
												<fmt:formatDate value="${test}" pattern="yyyy-MM-dd HH:mm:ss"/>  
											</td>
											<td class="center"><span id="tt${vs.index }"></span></td>
											<td class="center">
												<fmt:parseDate value="${goods.END_TIME}" pattern="yyyy-MM-dd HH:mm:ss" var="test"/>   
												<fmt:formatDate value="${test}" pattern="yyyy-MM-dd HH:mm:ss"/>  
											</td>
											<td class="center">
												<c:if test="${goods.STATE == 0}">
													<B><font color="red">待发货</font></B>
												</c:if>
												<c:if test="${goods.STATE == 1}">
													<B><font color="brown">派送中</font></B>
												</c:if>
												<c:if test="${goods.STATE == 2}">
													<B><font color="green">已派送</font></B>
												</c:if>
											</td>
											<td class="center">
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
														<a class="btn btn-xs btn-success" title="编辑" onclick="editUser('${goods.ID}','${goods.STATE}');">
															<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
														</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
														<a class="btn btn-xs btn-danger" onclick="delGoods('${goods.ID }','${goods.P_ID}');">
															<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
														</a>
													</c:if>
													<c:if test="${QX.email == 1 }">
													  <c:if test="${goods.STATE == 0 }">
														<a class="btn btn-xs btn-info" onclick="faHuo('${goods.ID}','${goods.STATE}');">
															<i class="ace-icon fa fa-truck bigger-120" title="确认发货"></i>
														</a>
													  </c:if>
													  <c:if test="${goods.STATE == 1 }">
													  	<a class="btn btn-xs btn-info" onclick="daoHuo('${goods.ID}','${goods.STATE}');">
															<i class="ace-icon fa fa-rocket bigger-120" title="确认到货"></i>
														</a>
													  </c:if>
													</c:if>
													<c:if test="${QX.email == 1 }">
														
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
																<a style="cursor:pointer;" onclick="editUser('${goods.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
														  </c:if>
														  <c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="delGoods('${goods.ID }','${goods.STATE}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
														  </c:if>
														  <c:if test="${QX.email == 1 }">
														  	<li>
																<a style="cursor:pointer;" onclick="faHuo('${goods.ID}','${goods.STATE}');" class="tooltip-error" data-rel="tooltip" title="确认发货">
																	<span class="red">
																		<i class="ace-icon fa fa-truck bigger-120"></i>
																	</span>
																</a>
															</li>
														  </c:if>	
														  <c:if test="${QX.email == 1 }">
														  	<li>
																<a style="cursor:pointer;" onclick="daoHuo('${goods.ID}','${goods.STATE}');" class="tooltip-error" data-rel="tooltip" title="确认到货">
																	<span class="red">
																		<i class="ace-icon fa fa-rocket bigger-120"></i>
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
											<td colspan="14" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="14" class="center">没有相关数据</td>
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
								<a class="btn btn-mini btn-success" onclick="add();">新增</a>
							  </c:if>
							  <c:if test="${QX.del == 1 }">
								<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
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

//重置
function cl(){
	$("select#STATE").val("");
	$("#nav-search-input").val("");
	$("#lastStart").val("");
	$("#lastEnd").val("");
}

function onChecks() {
	namelist();
	var fir = document.getElementsByName("ids");
	for(var i=0;i < fir.length;i++){
		if(document.getElementsByName('ids')[i].title =='2' || document.getElementsByName('ids')[i].title =='1'){
			document.getElementById("t"+i).style.color="#f00";
			fir[i].disabled = "disabled";
		}
	}
}

function namelist(){
	 var fir = document.getElementsByName("ids");
	 for(var i=0;i < fir.length;i++){
		var abc=fir[i].alt;//获取地址
		var cze=abc.split(",");
		if(cze[2] ==null && cze[4] ==null){
			document.getElementById("tt"+i).innerHTML=cze[0];
		}else if(cze[4] ==null){
			document.getElementById("tt"+i).innerHTML=cze[0]+cze[2];
		}else{
			document.getElementById("tt"+i).innerHTML=cze[0]+cze[2]+cze[4];
		}
	 }
}

//检索
function searchs(){
	top.jzts();
	$("#goodsForm").submit();
}

//删除
function delGoods(ID,P_ID,STATE){
	if(STATE==1){
		sweetAlert("系统提示", "不能删除派送中的单据！", "error");
		return false;
	}else if(STATE == 2){
		sweetAlert("系统提示", "不能删除已送至目的地的单据！", "error");
		return false;
	}else {
		bootbox.confirm("确定要删除该单据吗?", function(result) {
			if(result) {
				top.jzts();
				var url = '<%=basePath%>goods/deleteU.do?ID='+ID+'&P_ID='+P_ID;
				$.get(url,function(data){
					nextPage(${page.currentPage});
				});
			};
		});
	}
}

function daoHuo(ID,STATE) {
	if(STATE == 0) {
		sweetAlert("系统提示", "该货物还没发货或呢！", "error");
		return false;
	}else if(STATE == 2){
		sweetAlert("系统提示", "该货物已送至目的地！", "error");
		return false;
	}else {
		$.post("<%=basePath%>goods/yes.do",{ID:ID},function(msg){
			sweetAlert("操作成功!", "修改成功！", "success");
			$("#goodsForm").submit();
		});
	}
}

function faHuo(ID,STATE) {
	if(STATE == 1) {
		sweetAlert("系统提示", "该货物正在路上呢！", "error");
		return false;
	}else if(STATE == 2){
		sweetAlert("系统提示", "该货物已送至目的地！", "error");
		return false;
	}else {
		$.post("<%=basePath%>goods/faHuo.do",{ID:ID},function(msg){
			sweetAlert("操作成功!", "修改成功！", "success");
			$("#goodsForm").submit();
		});
	}
}

//新增
function add(){
	var ids=document.getElementsByName('ids');
	var P_ID="";
	var D_ID="";
	var C_ID="";
	var STATE="";
	var DNAME="";
	for(var i=0;i < ids.length;i++){
		
		if(P_ID=='') P_ID += document.getElementsByName('P_ID')[i].value;
		else
			P_ID += ";"+document.getElementsByName('P_ID')[i].value;
			
		if(D_ID=='') D_ID += document.getElementsByName('D_ID')[i].value;
		else
			D_ID += ";"+document.getElementsByName('D_ID')[i].value;
			
		if(C_ID=='') C_ID += document.getElementsByName('C_ID')[i].value;
		else
			C_ID += ";"+document.getElementsByName('C_ID')[i].value;
			
		if(STATE=='') STATE += document.getElementsByName('STATE')[i].value;
		else
			STATE += ";"+document.getElementsByName('STATE')[i].value;
	}
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="新增";
	 diag.URL = '<%=basePath%>goods/goAddU.do?P_ID='+P_ID+'&D_ID='+D_ID+'&C_ID='+C_ID+'&STATE='+STATE;
	 diag.Width = 800;
	 diag.Height = 480;
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
		sweetAlert("系统提示", "不能修改派送中的单据！", "error");
		return false;
	}else if(STATE == 2){
		sweetAlert("系统提示", "不能修改已送至目的地的单据！", "error");
		return false;
	}else {
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="资料";
		 diag.URL = '<%=basePath%>goods/goEditU.do?ID='+ID;
		 diag.Width = 800;
		 diag.Height = 480;
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
	bootbox.confirm(msg, function(result) {
		if(result) {
			var str = '';
			var str1= '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
						  if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  	
				  }
			}
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
						  if(str1=='') str1 += document.getElementsByName('ids')[i].id;
						  	else str1 += ',' + document.getElementsByName('ids')[i].id;
						  	
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
						url: '<%=basePath%>goods/deleteAllU.do?tm='+new Date().getTime(),
				    	data: {IDS:str,PIDS:str1},
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

</script>
</html>
