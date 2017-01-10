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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="static/ace/css/sweetalert.css">
</head>
<body class="no-skin" onload="listname();">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="warehouse/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="keywords" name="keywords" autocomplete="off" value="${page.pd.keywords }" />
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="gsearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<c:if test="${QX.toExcel == 1 }">
									<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">编号</th>
									<th class="center">名称</th>
									<th class="center">管理员</th>
									<th class="center">大小/平方米</th>
									<th class="center">上限/个</th>
									<th class="center">下限/个</th>
									<th class="center">实际库存/个</th>
									<th class="center">地址</th>
									<th class="center">开/关</th>
									<th class="center">修改时间</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty warehouseList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${warehouseList}" var="ware" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;"><input type="hidden" name='ids' value="${ware.ADDRESS }" class="ace"/>${vs.index+1}</td>
											<td class='center'>${ware.WARNAME}</td>
											<td class='center'>${ware.USERNAME}</td>
											<td class='center'>${ware.SIZE}</td>
											<td class='center'>${ware.UPPER_LIMIT}</td>
											<td class='center'>${ware.LOWER_LIMIT }</td>
											<td class='center'>${ware.PRACTICAL }</td>
											<td class='center'><span id="t${vs.index }"></span><input type="hidden" id="ENTRY_TIME" name="ENTRY_TIME" value="${ware.ENTRY_TIME }"/></td>
											<td class='center' style="height: 20px;">
												<label>
													<input name="STATE" id="STATE" onclick="STATEname('${ware.ID}');" value="${ware.STATE }" class="ace ace-switch ace-switch-3"  <c:if test="${ware.STATE==0 }">checked="checked"</c:if>  type="checkbox" >
													<span class="lbl"></span>
												</label>
											</td>
											<td class='center'>${ware.UPDATE_TIME }</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${ware.ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${ware.ID}');">
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
																<a style="cursor:pointer;" onclick="edit('${ware.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${ware.ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
									<a class="btn btn-sm btn-success" onclick="add();">新增</a>
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
		//美化
		function listname(){
			 var fir = document.getElementsByName("ids");
			 for(var i=0;i < fir.length;i++){
				var abc=fir[i].value;//获取地址
				var cze=abc.split(",");
				if(cze[2] ==null && cze[4] ==null){
					document.getElementById("t"+i).innerHTML=cze[0];
				}else if(cze[4] ==null){
					document.getElementById("t"+i).innerHTML=cze[0]+cze[2];
				}else{
					document.getElementById("t"+i).innerHTML=cze[0]+cze[2]+cze[4];
				}
			 }
		}
		//检索
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		int
		//开关
		function STATEname(ID){
			var STATE=$("#STATE").val();
			$.ajax({
				type: "POST",
				url: "<%=basePath%>warehouse/editSTATE.do?ID="+ID+"&STATE="+STATE,
		    	data: encodeURI(""),
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
				}
			});
			if(STATE =='0'){
				$("#STATE").val("1");
			}else if(STATE =='1'){
				$("#STATE").val("0");
			}
		}
		//导出excel
		function toExcel(){
			var keywords = $("#nav-search-input").val();
			var lastLoginStart = $("#lastLoginStart").val();
			var lastLoginEnd = $("#lastLoginEnd").val();
			var USER_ID = $("#USER_ID").val();
			window.location.href='<%=basePath%>warehouse/excel.do?keywords='+keywords+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&USER_ID='+USER_ID;
		}
		
		//去此ID下子级列表
		function goSondict(WAREHOUSE_ID){
			top.jzts();
			window.location.href="<%=basePath%>warehouse/list.do?DEPARTMENT_ID="+DEPARTMENT_ID;
		};
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>warehouse/goSaveWare.do';
			 diag.Width = 800;
			 diag.Height = 500;
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
			bootbox.confirm("确定要删除这条数据吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>warehouse/deleteWare.do?ID="+ID;
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
						}else if(data == 'fall'){
							swal({   
								title: "系统提示",
								text: "删除失败!", 
								type: "error",
								confirmButtonText: "OK" });
						}
					});
				};
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>warehouse/goEditWare.do?ID='+Id;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>