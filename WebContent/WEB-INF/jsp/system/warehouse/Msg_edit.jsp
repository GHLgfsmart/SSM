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
<%@ include file="../index/top.jsp"%>
</head>
<body class="no-skin">
<div align="center">

	<img src="<%=basePath%>DisplayChart?filename=${fileName }" width="75%" height="50%" border="0">
</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<script src='static/affiche/js/autosize.js'></script>
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<!-- <script src="static/ace/js/chosen.jquery.js"></script> -->
	<!--提示框-->
	<!-- <script type="text/javascript" src="static/js/jquery.tips.js"></script> -->
</body>
<script>
	autosize(document.querySelectorAll('textarea'));
</script>
<script type="text/javascript">
	$(top.hangge());
</script>
</html>