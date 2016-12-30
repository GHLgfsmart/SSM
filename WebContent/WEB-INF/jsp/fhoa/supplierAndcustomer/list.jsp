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
	<link rel="stylesheet" href="static/ace/css/sweetalert.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
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
					<form action="supplierAndcustomer/list.do" method="post" name="Form" id="Form">
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
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="CATEGORIES_ID" id="CATEGORIES_ID" data-placeholder="请选择类型" style="vertical-align:top;width: 120px;">
									<option value="">类型</option>
									<c:forEach items="${list}" var="list">
										<option value="${list.ID }">${list.NAME }</option>
									</c:forEach>
								  	</select>
								</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="STATE" id="STATE" data-placeholder="请输入状态" style="vertical-align:top;" style="width:98%;" >
										<option value="">状态</option>
										<option value="0">合作</option>
										<option value="1">流失</option>
									</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="gsearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
								<%-- <c:if test="${QX.FromExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="ace-icon fa fa-cloud-upload bigger-110 nav-search-icon blue"></i></a></td></c:if> --%>
								</c:if>
							</tr>
						</table>
						<!-- 检索END -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								
								<tr>
									<th class="center" style="width:35px;">
										<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">名称</th>
									<th class="center">类型</th>
									<th class="center">联系人</th>
									<th class="center">联系电话</th>
									<th class="center">地址</th>
									<th class="center">邮件</th>
									<th class="center">状态</th>
									<th class="center">备注</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">
												<label><input type='checkbox' name='ids' value="${var.ID }" id="${var.MAIL }" class="ace"/><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>
												<a title="详细信息" style="text-decoration:none;cursor:pointer;" onclick="findByID('${var.ID}');">${var.SUPNAME}</a>
											</td>
											<td class='center'> ${var.NAME }</td>
											<td class='center'>${var.CONTACT}</td>
											<td class='center'>${var.PHONE}</td>
											<td class='center'>${var.ADDRESS}</td>
											<td class='center'><a title="发送电子邮件" style="text-decoration:none;cursor:pointer;" onclick="sendEmail('${var.MAIL }');">${var.MAIL}</a></td>
											<td class='center'>
												<c:if test="${var.STATE == 0 }">合作</c:if>
												<c:if test="${var.STATE == 1 }">流失</c:if>
											</td>
											<td class='center' width="300px">${var.NOTE}</td>
											<!-- 操作 -->
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.ID}');">
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
																<a style="cursor:pointer;" onclick="edit('${var.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
										<a class="btn btn-mini btn-success" onclick="add();">新增</a>
										</c:if>
										<c:if test="${QX.email == 1 }">
											<a title="批量发送电子邮件" class="btn btn-mini btn-primary" onclick="makeAll('确定要给选中的用户发送邮件吗?');">
												<i class="ace-icon fa fa-envelope bigger-120"></i>
											</a>
										</c:if>
										<c:if test="${QX.del == 1 }">
										<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" >
											<i class='ace-icon fa fa-trash-o bigger-120'></i>
										</a>
										</c:if>
									</td>
									<td style="vertical-align:top;">
										<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
									</td>
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
	<script type="text/javascript" src="static/ace/js/sweet-alert.min.js"></script>
	<script type="text/javascript">
	
	$(top.hangge());//关闭加载状态
	
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送电子邮件";
			 diag.URL = '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL;
			 diag.Width = 660;
			 diag.Height = 486;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//进入详细资料
		function findByID(ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="详细资料";
			 diag.URL = '<%=basePath%>supplierAndcustomer/gofindByID.do?ID='+ID;
			 diag.Width = 660;
			 diag.Height = 486;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		
		//检索
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>supplierAndcustomer/goAdd.do';
			 diag.Width = 700;
			 diag.Height = 550;
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
		//删除
		function del(ID){
			bootbox.confirm("确定要删除该记录吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>supplierAndcustomer/delete.do?ID="+ID
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
				swal({
			        title: "系统提示", 
			        text: "操作成功！", 
			        type: "success",
			        timer: 55444000,
			        showConfirmButton: false,
			        confirmButtonColor: "#ec6c62"
			    });
			});
		}

		//修改
		function edit(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>supplierAndcustomer/goUpdate.do?ID='+id;
			 diag.Width = 700;
			 diag.Height = 550;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
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
		
		//导出excel
		function toExcel(){
			var keywords = $("#nav-search-input").val();
			var ID = $("#ID").val();
			window.location.href='<%=basePath%>supplierAndcustomer/toExcel.do?keywords='+keywords+'&ID='+ID;
		}

		
		//批量操作
		function makeAll(msg){
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
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
					side:1,
		          msg:'点这里全选',
		          bg:'#AE81FF',
		          time:8
		      });
				return;
			}else {
				bootbox.confirm(msg, function(result) {
					if(result) {
						top.jzts();
						var url = '<%=basePath%>supplierAndcustomer/deleteAll.do?IDS='+str;
						$.get(url,function(data){
							if(data == 'success'){
								swal({
							        title: "系统提示", 
							        text: "操作成功！", 
							        type: "success",
							        timer: 55444000,
							        showConfirmButton: false,
							        confirmButtonColor: "#ec6c62"
							    });
							}else {
								swal({
							        title: "系统提示", 
							        text: "操作成功！", 
							        type: "error",
							        timer: 55444000,
							        showConfirmButton: false,
							        confirmButtonColor: "#ec6c62"
							    });
							}
							nextPage(${page.currentPage});
						});
					}
				});
			}
		}
		
	</script>


</body>
</html>