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
						
						<form action="<%=path %>/Drawing/${update}.do" name="Form" id="Form" method="post">
									<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
									<input type="hidden" name="UPDATE_TIME" id="UPDATE_TIME" value="${updatetime}"/>
							<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top: 30px;">
							<tr>
								<td style="padding-right: 50px;">
									单据编号:<input type="text" style="width: 180px;" id="BIANHAO" name="BIANHAO" value="${pd.BIANHAO}" readonly="readonly"/>
								</td>
								<td style="padding-right: 50px; height: 20px;">
									业务日期:<input type="date" id="BusinessDate" name="BusinessDate" value="${pd.BusinessDate}" style="width:180px; height:35px;">
								</td>
								<td style="padding-right: 50px;">
							    经手人:<select name="JINGSHUO_ID" id="JINGSHUO_ID" style="width: 180px;">
										<c:forEach items="${goAddPage}" var="role">
											<option value="${role.USER_ID }"  <c:if test="${role.USER_ID == pd.USER_ID }">selected</c:if>>${role.USERNAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</table>
						<table style="margin-top:20px;">
							<tr>
								
								<td style="padding-right: 50px;">
							调出仓库:<select  name="WAREHOUSE_OUT_ID" id="WAREHOUSE_OUT_ID" style="width: 140px;">
										<c:forEach items="${ListWA}" var="wa">
											<option value="${wa.ID }"<c:if test="${wa.ID == pds.WAREHOUSE_OUT_ID}">selected</c:if><c:if test="${wa.ID == pt.ID}">selected</c:if>>${wa.WARNAME }</option>
										</c:forEach>
								   </select>
								   <c:if test="${QX.cha == 1 }">
									<a class="btn btn-light btn-xs" onclick="searchs();"  title="搜索此仓库的产品"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a>
									</c:if>
								</td>
								<td style="padding-right: 50px;">
							调入仓库:<select name="WAREHOUSE_PUT_ID" id="WAREHOUSE_PUT_ID" style="width: 180px;" >
										<c:forEach items="${ListWA}" var="lw">
											<option value="${lw.ID }"<c:if test="${lw.ID == pds.WAREHOUSE_PUT_ID}">selected</c:if>>${lw.WARNAME }</option>
										</c:forEach>
								   </select>
								</td>
								<td >
									调拨说明:<input type="text" id="DRAWING_INST" name="DRAWING_INST"  value="${pd.DRAWING_INST}" style="width: 220px;">
								</td>
							</tr>
						</table>
						
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center">序号</th>
									<th class="center">编号</th>
									<th class="center">商品名称</th>
									<th class="center">数量</th>
									<th class="center">单位</th>
									<th class="center">备注</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty walist}">
									<c:if test="${QX.cha == 1 }">
											<c:forEach items="${walist}" var="sp" varStatus="vs">
												<tr>
													<td class='center' style="width: 30px;">
														<label><input type='checkbox' name="MATERIALS_ID" id="MATERIALS_ID"  value="${sp.ID }"/><span class="lbl"></span></label>
														<input type="hidden" id="osID" name="osID" value="${sp.osID}"/>
													</td>
													<td class='center' style="width: 30px;">${vs.index+1}</td>
													<td class="center">${sp.BIANHAO }</td>
													<td class="center">${sp.NAME }</td>
													<td class="center"><input type="text" name="COUNT" id="COUNT" value="${sp.COUNT}"  readOnly="true" style="border:none;outline:medium;text-align:center;width:100px;" /></td>
													<td class="center">${sp.UNIT}</td>
													<td class="center">${sp.NOTE}</td>
												</tr>
											</c:forEach>
								</c:if>
								</c:when>
								<c:when test="${not empty pdID}">
									<c:if test="${QX.cha == 1 }">
											<tr>
												<td class='center' style="width: 30px;">
													<input type="hidden" name="MATERIALS_ID" id="MATERIALS_ID"  value="${pdID.MATERIALS_ID}"/>
													<label><input type='checkbox' name="MATERIALS_ID" id="MATERIALS_ID"  value="${pdID.ID}"/><span class="lbl"></span></label>
												</td>
												<td class='center' style="width: 30px;">${vs.index+1}</td>
												<td class="center">${pdID.BIANHAO }</td>
												<td class="center"><input type="text" name="NAME" id="NAME" value="${pdID.NAME}"  readOnly="true" style="border:none;outline:medium;text-align:center;width:100px;" /></td>
												<td class="center"><input type="text" name="COUNT" id="COUNT" value="${pdID.COUNT}"  readOnly="true" style="border:none;outline:medium;text-align:center;width:100px;" /></td>
												<td class="center">${pdID.UNIT}</td>
												<td class="center">${pdID.NOTE}</td>
											</tr>
									</c:if>
								</c:when>
							</c:choose>				
							</tbody>
						</table>
							<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top; padding-right: 60px;">
									<c:if test="${QX.edit == 1 }">
									<a class="btn btn-mini btn-success" onclick="update();">确定</a>
									</c:if>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">关闭</a>
							</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
					</div>
						</form>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
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

//修改数据
function update(msg){

	var osID="";
	var MATERIALS_ID = "";
	var WAREHOUSE_PUT_ID="";
	var ID="";
 	for(var i=0;i < document.getElementsByName('MATERIALS_ID').length;i++)
 		{
 				if(document.getElementsByName('MATERIALS_ID')[i].checked){
 				  if(MATERIALS_ID=='') MATERIALS_ID += document.getElementsByName('MATERIALS_ID')[i].value;
 				  else MATERIALS_ID += ',' + document.getElementsByName('MATERIALS_ID')[i].value;
 				  if(osID=='') osID += document.getElementsByName('osID')[i].value;
				  else osID += ',' + document.getElementsByName('osID')[i].value;
 				  if(WAREHOUSE_PUT_ID=='') WAREHOUSE_PUT_ID += document.getElementsByName('WAREHOUSE_PUT_ID')[i].value;
				  else WAREHOUSE_PUT_ID += ',' + document.getElementsByName('WAREHOUSE_PUT_ID')[i].value;
 				 if(ID=='') ID += document.getElementsByName('ID')[i].value;
				  else ID += ',' + document.getElementsByName('ID')[i].value;
 				 }
 		 }
 		/* if(MATERIALS_ID==''){
 			bootbox.dialog({
 				message: "<span class='bigger-110'>您没有选择任何内容!</span>",
 				buttons: 			
 				{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
 			});
 			return;
 		} */
	if($("#DRAWING_INST").val()==""){
		$("#DRAWING_INST").tips({
			side:3,
            msg:'请输入调拨说明',
            bg:'#AE81FF',
            time:2
        });
		$("#DRAWING_INST").focus();
	return ;
	}
	if($("#WAREHOUSE_PUT_ID").val()==""){
		$("#WAREHOUSE_PUT_ID").tips({
			side:3,
            msg:'请选择要调入的仓库',
            bg:'#AE81FF',
            time:2
        });
		$("#WAREHOUSE_PUT_ID").focus();
	return ;
	}
	if($("#BusinessDate").val()==""){
		$("#BusinessDate").tips({
			side:3,
            msg:'请选择要调入的仓库',
            bg:'#AE81FF',
            time:2
        });
		$("#BusinessDate").focus();
	return ;
	}
	if($("#WAREHOUSE_OUT_ID").val() == $("#WAREHOUSE_PUT_ID").val()){
		$("#WAREHOUSE_PUT_ID").tips({
			side:3,
            msg:'调出的仓库和调入的仓库不能相同',
            bg:'#AE81FF',
            time:2
        });
		$("#WAREHOUSE_PUT_ID").focus();
	return ;
	}
	else{
 			$("#Form").submit();
 			$("#zhongxin").hide();
 			$("#zhongxin2").show();
 	}
 }
//搜索此仓库下的产品
function searchs(){
	var ID = $("#ID").val();
	var ckID = $("#WAREHOUSE_OUT_ID").val();
	window.location.href='<%=basePath%>Drawing/DrawingByid.do?ID='+ID+'&ckID='+ckID;
}

	
</script>
</html>
