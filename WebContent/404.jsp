<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/static/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<link rel="stylesheet" href="static/404/css/main.css" type="text/css" media="screen, projection" /> <!-- main stylesheet -->
	<link rel="stylesheet" type="text/css" media="all" href="static/404/css/tipsy.css" /> <!-- Tipsy implementation -->

	<script type="text/javascript" src="static/404/scripts/jquery-1.7.2.min.js"></script> <!-- uiToTop implementation -->
	<script type="text/javascript" src="static/404/scripts/custom-scripts.js"></script>
	<script type="text/javascript" src="static/404/scripts/jquery.tipsy.js"></script> <!-- Tipsy -->

<script type="text/javascript">

$(document).ready(function(){
			
	universalPreloader();
						   
});

$(window).load(function(){

	universalPreloaderRemove();
	
	rotate();
    dogRun();
	dogTalk();
	
	$('.with-tooltip').tipsy({gravity: $.fn.tipsy.autoNS});
						   
});

</script>


<title>Not found</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>

<body>

<!-- Universal preloader -->
<div id="universal-preloader">
    <div class="preloader">
        <img src="static/404/images/universal-preloader.gif" alt="universal-preloader" class="universal-preloader-preloader" />
    </div>
</div>
<!-- Universal preloader -->

<div id="wrapper">
<!-- 404 graphic -->
<div class="graphic"></div>
<!-- 404 graphic -->
<!-- Not found text -->
	<div style="color: white; padding-left: 60%;">
    	<h1>Sorry..好像不能看了！</h1>
    </div>
<!-- Not found text -->



<div class="dog-wrapper">
<!-- dog running -->
	<div class="dog"></div>
<!-- dog running -->
	
<!-- dog bubble talking -->
	<div class="dog-bubble">
    	
    </div>
    
    <!-- The dog bubble rotates these -->
    <div class="bubble-options">
    	<p class="dog-bubble">
			汪! 汪!
        </p>
    	<p class="dog-bubble">
	        <br />
        	 您没有权限浏览！可能...
        </p>
        <p class="dog-bubble">
        	<br />
        	本页面可能已被<font color="red">删除</font>
        </p>
        <p class="dog-bubble">
        	我希望我有一个饼干<br /><img style="margin-top:8px" src="static/404/images/cookie.png" alt="cookie" />
        </p>
        <p class="dog-bubble">
        	<br />
        	如果该资源对你很重要，请与管理员联系。
        </p>
        <p class="dog-bubble">
        	<br />
			火星不太安全，我可以免费送你回地球
        </p>
        <p class="dog-bubble">
        	我在越来越接近？
        </p>
        <p class="dog-bubble">
        	I think I saw a <br /><img style="margin-top:8px" src="static/404/images/cat.png" alt="cat" />
        </p>
    </div>
    <!-- The dog bubble rotates these -->
<!-- dog bubble talking -->
</div>

<!-- planet at the bottom -->
	<div class="planet"></div>
<!-- planet at the bottom -->
</div>
<div style="text-align:center;">
<p>来源：<a href="#" title="宏图软件科技有限公司" target="_blank">宏图软件科技有限公司</a></p>

</div>
</body>
<script type="text/javascript">
$(top.hangge());
</script>
</html>