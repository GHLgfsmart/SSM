﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
 <link href="plugins/zoomimage/css/custom.css" rel="stylesheet">
 <link href="plugins/fhform/css/animate.min.css" rel="stylesheet">
 <link href="static/login/css/style.min.css?v=4.0.0" rel="stylesheet"><base target="_blank">
<script src="plugins/echarts/echarts.min.js"></script>
</head>
<!-- <body class="no-skin"> -->
<body class="gray-bg" style="background-color: white;">
		<form action="<%=basePath%>login_default.do" method="post" id="defaultForm" name="defaultForm">
            <div class="ibox float-e-margins" style="width: 60%;height:268px;float: left;margin-top: 12px;border:7px #E7EAEC solid;margin-left: 12px;">
                <div class="ibox-title">
                    <h5 style="color: #438EB9;">-------公告栏-------</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link" onclick="searchs();">
                            <i class="fa fa-refresh"></i>
                        </a>
                    </div>
                </div>

                <div class="ibox-content timeline">

                    <div class="timeline-item">
                        <div class="row">
                            <div class="col-xs-3 date">
                                <i class="fa fa-briefcase"></i> ${pd.shi1 }
                                <br>
                                <small class="text-navy">${pd.shijain3 } 前</small>
                            </div>
                            <div class="col-xs-7 content no-top-border">
                                <p class="m-b-xs"><strong>${pd.MSGTITLE }</strong>
                                </p>

                                <p style="text-indent:2em; padding:0px; margin:0px; ">${pd.MSGCON }</p>
                                <p>
									<svg class="peity" height="16" width="64">
                                        <polygon fill="#1ab394" points="0 15 0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332 64 15"></polygon>
                                        <polyline fill="transparent" points="0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332" stroke="#169c81" stroke-width="1" stroke-linecap="square"></polyline>
                                    </svg>
									<svg class="peity" height="16" width="64">
                                        <polygon fill="#1ab394" points="0 15 0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332 64 15"></polygon>
                                        <polyline fill="transparent" points="0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332" stroke="#169c81" stroke-width="1" stroke-linecap="square"></polyline>
                         
                                    </svg>
                                    <svg class="peity" height="16" width="64">
                                        <polygon fill="#1ab394" points="0 15 0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332 64 15"></polygon>
                                        <polyline fill="transparent" points="0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332" stroke="#169c81" stroke-width="1" stroke-linecap="square"></polyline>
                         
                                    </svg>
                                    <svg class="peity" height="16" width="64">
                                        <polygon fill="#1ab394" points="0 15 0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332 64 15"></polygon>
                                        <polyline fill="transparent" points="0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332" stroke="#169c81" stroke-width="1" stroke-linecap="square"></polyline>
                         
                                    </svg>
                                    <svg class="peity" height="16" width="64">
                                        <polygon fill="#1ab394" points="0 15 0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332 64 15"></polygon>
                                        <polyline fill="transparent" points="0 10.5 1.7777777777777777 0.5 3.5555555555555554 5.5 5.333333333333333 7.166666666666666 7.111111111111111 0.5 8.88888888888889 8.833333333333332 10.666666666666666 3.833333333333332 12.444444444444443 10.5 14.222222222222221 12.166666666666666 16 0.5 17.77777777777778 2.166666666666666 19.555555555555554 3.833333333333332 21.333333333333332 8.833333333333332 23.11111111111111 7.166666666666666 24.888888888888886 13.833333333333334 26.666666666666664 12.166666666666666 28.444444444444443 0.5 30.22222222222222 7.166666666666666 32 8.833333333333332 33.77777777777778 3.833333333333332 35.55555555555556 12.166666666666666 37.33333333333333 3.833333333333332 39.11111111111111 3.833333333333332 40.888888888888886 10.5 42.666666666666664 7.166666666666666 44.44444444444444 12.166666666666666 46.22222222222222 10.5 48 10.5 49.77777777777777 12.166666666666666 51.55555555555555 13.833333333333334 53.33333333333333 5.5 55.11111111111111 0.5 56.888888888888886 2.166666666666666 58.666666666666664 2.166666666666666 60.44444444444444 10.5 62.22222222222222 3.833333333333332 64 8.833333333333332" stroke="#169c81" stroke-width="1" stroke-linecap="square"></polyline>
                         
                                    </svg>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form>
<style type="text/css">
#bodyC { font-size:12px; line-height:normal; margin-left:65%; margin-right:auto; padding:10px; width:300px; height:400px; text-align:left; position:relative; }
#bodyC a { color:#0E6DBC; }
#bodyC h3 { margin:0; margin-top:8px; }
#bodyC p { margin:0; line-height:150%; }
#bodyC form { margin:0; padding:0; }
#bodyC #bodyD { padding:6px; border-left:1px #327CBD solid; border-right:1px #327CBD solid; background-color:#ECF7FF; clear:both;}
#bodyC #nowclock { overflow:hidden; margin-bottom:6px; padding:5px; text-align:center; clear:both; }
#bodyC .titleC { margin-top:6px; height:36px; }
#bodyC #titleC { background-color:#FFFFFF; font-weight:bold; border:1px #AFD2F0 solid; border-bottom:none; cursor:pointer; }
#bodyC .title_ { border-bottom:1px #AFD2F0 solid; cursor:pointer; }
#bodyC #table { height:150px; border:1px #AFD2F0 solid; border-top:none; padding-top:10px; padding-bottom:8px; background-color:#FFFFFF; clear:both; }
#bodyC .point { color:#0E6DBC; }
#bodyC .red { color:#FF5500; }
#bodyC .is { margin:0; height:4px; font-weight:bold; text-align:center; font-size:1px; position:relative; clear:both; }
#bodyC .i1 { height:1px; width:292px; margin-left:4px; margin-right:4px; font-size:1px; background-color:#327CBD; overflow:hidden; }
#bodyC .i2 { height:1px; width:292px; margin-left:2px; margin-right:2px; font-size:1px; background-color:#ECF7FF; border-left:2px #327CBD solid; border-right:2px #327CBD solid; overflow:hidden; }
#bodyC .i3 { height:2px; width:296px; margin-left:1px; margin-right:1px; font-size:1px; background-color:#ECF7FF; border-left:1px #327CBD solid; border-right:1px #327CBD solid; overflow:hidden; }
#bodyC .i5 { position:absolute; top:2px; left:2px; width:290px; padding-left:6px; height:24px; line-height:24px; background-color:#499CE2; z-index:12; color:#FFFFFF; overflow:hidden; font-size:12px; }
</style>
<script type="text/javascript">
var midPath = 'music/';
var midType = '.mp3';
if(typeof('$')!='function'){
	var $=function(o){return document.getElementById(o)}}
	if(typeof('setCookie')!='function'){
		var setCookie=function(name,value,time){
			var cookieEnabled=(typeof navigator.cookieEnabled!='undefined'&&navigator.cookieEnabled)?true:false;
			if(cookieEnabled==false){
				alert('您的浏览器未开通cookie，程序无法正常使用！');
				return false}
			if(!time||isNaN(time))time=365;
			var cookieStr=encodeURIComponent(value);
			var expireStr=time>0?' expires='+(new Date(new Date().getTime()+time*24*60*60*1000).toGMTString())+';':'';
			document.cookie=name+'='+cookieStr+';'+expireStr+' path=/;'}}
	if(typeof('getCookie')!='function'){
		var getCookie=function(name){
			var arr=document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
			if(arr!=null&&arr!=false)return decodeURIComponent(arr[2]);
			return false}}
	function tick(){
		var date=new Date();
		window.setTimeout("tick()",1000);
		$('clock').innerHTML=date.getFullYear()+'年'+(date.getMonth()+1)+'月'+date.getDate()+'日 '+date.getHours().toString().replace(/^(d{1})$/,'0$1')+':'+date.getMinutes().toString().replace(/^(d{1})$/,'0$1')+':'+date.getSeconds().toString().replace(/^(d{1})$/,'0$1')+''}
	if(document.all){
		window.attachEvent('onload',startClock)}
	else{window.addEventListener('load',startClock,false)}
	function startClock(){tick();
	var base=new Date();
	var time_=base.getTime()+10*60*1000;
	var date=new Date(time_);
	$('h').value=date.getHours();
	$('m').value=date.getMinutes();
	var overSetClock=new Array();
	for(var i=1;i<=3;i++){
		var reg=false;
		var reg2=false;
		var reg3=false;
		if(overSetClock[i]=getCookie('cookieColok'+i+'')){
			if(reg=overSetClock[i].toString().split(':')){reg2=(parseFloat(reg[2])>parseFloat(base.getHours())||(parseFloat(reg[2])==parseFloat(base.getHours())&&parseFloat(reg[3])>parseFloat(base.getMinutes()))||parseFloat(reg[1])!=1)?true:false;reg3=(parseFloat(reg[2])<parseFloat(base.getHours())||(parseFloat(reg[2])==parseFloat(base.getHours())&&parseFloat(reg[3])<parseFloat(base.getMinutes()))||parseFloat(reg[1])==1)?true:false;if(reg2==true||reg3==true){tickC(reg[0],reg[1],reg[2]+':'+reg[3],reg[4],reg[5]);
			$('clock'+i+'ye').innerHTML=''+reg[2]+':'+reg[3]+''+(parseFloat(reg[1])!=1?'重复':''+(reg3==true?'明天':'')+'一次')+'√';
			$('clock'+i+'ye').title="闹钟"+i+"已设定。时间："+reg[2]+":"+reg[3]+"，"+(parseFloat(reg[1])!=1?"每天重复":"不重复")+"";
			$('clock'+i+'no').innerHTML='×';
			$('clock'+i+'no').title='关闭闹钟'+i+''}}}}}
	function xuan(obj,n){try{$('titleC').id=null}catch(err){}obj.id='titleC';
	$('clock123').value=n}function runMusic(fr,mid){
		var im_text='';
		if(document.all){im_text+='<bgsound src="'+midPath+mid+''+midType+'" autostart="true" loop="infinite" />'}
		else{im_text+='<object id="mediaplayer" width="480" height="330" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" align="center" border="0" type="application/x-oleobject" standby="Loading Windows Media Player components..." style="background-color:black"><param name="url" value="'+midPath+mid+''+midType+'"><param name="AutoStart" value="1"><param name="Balance" value="0"><param name="enabled" value="-1"><param name="EnableContextMenu" value="0"><param name="PlayCount" value="1"><param name="rate" value="1"><param name="currentPosition" value="0"><param name="currentMarker" value="0"><param name="defaultFrame" value=""><param name="invokeURLs" value="-1"><param name="baseURL" value=""><param name="stretchToFit" value="0"><param name="volume" value="100"><param name="mute" value="0"><param name="uiMode" value="full"><param name="windowlessVideo" value="0"><param name="fullScreen" value="0"><param name="enableErrorDialogs" value="0"><param name="SAMIStyle" value=""><param name="SAMILang" value=""><param name="SAMIFilename" value=""><param name="captioningID" value=""><EMBED src="'+midPath+mid+''+midType+'" width="480" height="330" type="audio/mpeg" loop="-1"></EMBED></object>'}
		var im=$(fr).contentWindow;im.document.designMode='on';
		im.document.contentEditable=true;
		im.document.open();
		im.document.writeln('<html><head></head><body>'+im_text+'</body></html>');
		im.document.close()}
	function tryM(obj){
		if(obj.innerHTML=='试听'){
			runMusic('tryMusicFr',$('mid').value);
			obj.innerHTML='关闭'}else{$('tryMusicFr').src='about:blank';
			obj.innerHTML='试听'}}function post(){var clock123=$('clock123').value.toString();
			if(clock123!='1'&&clock123!='2'&&clock123!='3'){clock123='1'}if($('clock'+clock123+'ye').innerHTML!=''){
				if(!confirm('闹钟'+clock123+'已设定，再次设定将覆盖上一个')){
					return false}}
			var repeat=$('repeat1').checked==true?1:365;
			var dateN=new Date();
			var timeN=dateN.getHours()+':'+dateN.getMinutes();
			var h=$('h').value;var m=$('m').value;var tmr='';
			if(repeat==1){if(h+':'+m==timeN){alert('设置的时间不能等于当前时间！');
			return false}else if(h+':'+m<timeN){tmr='明天';
			alert('提示：设置的时间小于当前时间，明天此时才会响铃。')}
			else{}}
			$('clock'+clock123+'ye').innerHTML=''+h+':'+m+''+(repeat!=1?'重复':''+tmr+'一次')+'√';
			$('clock'+clock123+'ye').title="闹钟"+clock123+"已设定。时间："+h+":"+m+"，"+(repeat!=1?"每天重复":"不重复")+"";
			$('clock'+clock123+'no').innerHTML='×';$('clock'+clock123+'no').title='关闭闹钟'+clock123+'';
			$('time').value=h+':'+m;
			var mid=$('mid').value;
			var text=$('text').value.replace(/:/g,'');
			tickC(clock123,repeat,h+':'+m,mid,text);
			setCookie('cookieColok'+clock123+'',''+clock123+':'+repeat+':'+h+':'+m+':'+mid+':'+text+'',repeat);
			alert('闹钟'+clock123+'已设定好！')}
			function del(n){
				if(confirm('确定关闭闹钟'+n+'么？'))
				{setCookie('cookieColok'+n+'','',0);
				$('clock'+n+'Fr').src='about:blank';
				$('clock'+n+'ye').innerHTML='';
				$('clock'+n+'ye').title='';
				$('clock'+n+'no').innerHTML='';$('clock'+n+'no').title=''}}
</script>
<script type="text/javascript">
function sendMusic(clock123,repeat,time,mid,text){
	runMusic('clock'+clock123+'Fr',mid);
	setTimeout('openMusic("'+clock123+'", "'+repeat+'", "'+time+'", "'+mid+'", "'+text+'");',2000)
	}
function tickC(clock123,repeat,time,mid,text){
	var once=window.setTimeout('tickC("'+clock123+'", "'+repeat+'", "'+time+'", "'+mid+'", "'+text+'")',1000);
	var dateC=new Date();
	var timeC=dateC.getHours()+':'+dateC.getMinutes();
	if(timeC==time){
		if(repeat.toString()=='1'){
			window.clearTimeout(once)
		}
		sendMusic(clock123,repeat,time,mid,text)}}
function openMusic(clock123,repeat,time,mid,text){
	window.focus();setCookie('cookieColok'+clock123+'','',0);
	if(confirm("闹钟"+clock123+"提醒您：现在是"+time+" "+text+" [点确定关闭]")){
		$('clock'+clock123+'Fr').src='about:blank'}
	if(repeat.toString()=='1'){$('clock'+clock123+'ye').innerHTML='';
	$('clock'+clock123+'ye').title='';$('clock'+clock123+'no').innerHTML='';
	$('clock'+clock123+'no').title=''}}
</script>
<div id="bodyC">
<div style="width:0px;height:0px;overflow:hidden;">
  <iframe id="tryMusicFr" name="tryMusicFr"></iframe>
  <iframe id="clock1Fr" name="clock1Fr"></iframe>
  <iframe id="clock2Fr" name="clock2Fr"></iframe>
  <iframe id="clock3Fr" name="clock3Fr"></iframe>
</div>
<div style="float:left;">
<div class="is">
  <div class="i1"></div>
  <div class="i2"></div>
  <div class="i3"></div>
  <div class="i5">闹钟提醒</div>
</div>
<div id="bodyD">
  <div style="height:24px;">&nbsp;</div>
  <div id="nowclock"><font id="clock" face="Arial" color="#000080" size="4" align="center">2010年01月01日 00时00分00秒</font></div>
  <!--form action="setclock.html" method="get" onsubmit="return post(this)"-->
  <form id="clockform">
    <input type="hidden" id="time" name="time" />
    <input type="hidden" id="clock123" name="clock123" value="1" />
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="titleC">
      <tr>
        <td align="center" class="title_" onclick="xuan(this,1)" id="titleC">闹钟1<br />
            <span id="clock1ye" class="red"></span><span id="clock1no" onclick="del(1)"></span></td>
        <td align="center" class="title_" onclick="xuan(this,2)">闹钟2<br />
            <span id="clock2ye" class="red"></span><span id="clock2no" onclick="del(2)"></span></td>
        <td align="center" class="title_" onclick="xuan(this,3)">闹钟3<br />
            <span id="clock3ye" class="red"></span><span id="clock3no" onclick="del(3)"></span></td>
      </tr>
    </table>
    <div id="table">
      <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td width="84" align="center">提醒时间：</td>
          <td>
            <select name="h" id="h">
              <option value="0">0</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
              <option value="13">13</option>
              <option value="14">14</option>
              <option value="15">15</option>
              <option value="16">16</option>
              <option value="17">17</option>
              <option value="18">18</option>
              <option value="19">19</option>
              <option value="20">20</option>
              <option value="21">21</option>
              <option value="22">22</option>
              <option value="23">23</option>
            </select>
            时
              <select name="m" id="m">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
                <option value="19">19</option>
                <option value="20">20</option>
                <option value="21">21</option>
                <option value="22">22</option>
                <option value="23">23</option>
                <option value="24">24</option>
                <option value="25">25</option>
                <option value="26">26</option>
                <option value="27">27</option>
                <option value="28">28</option>
                <option value="29">29</option>
                <option value="30">30</option>
                <option value="31">31</option>
                <option value="32">32</option>
                <option value="33">33</option>
                <option value="34">34</option>
                <option value="35">35</option>
                <option value="36">36</option>
                <option value="37">37</option>
                <option value="38">38</option>
                <option value="39">39</option>
                <option value="40">40</option>
                <option value="41">41</option>
                <option value="42">42</option>
                <option value="43">43</option>
                <option value="44">44</option>
                <option value="45">45</option>
                <option value="46">46</option>
                <option value="47">47</option>
                <option value="48">48</option>
                <option value="49">49</option>
                <option value="50">50</option>
                <option value="51">51</option>
                <option value="52">52</option>
                <option value="53">53</option>
                <option value="54">54</option>
                <option value="55">55</option>
                <option value="56">56</option>
                <option value="57">57</option>
                <option value="58">58</option>
                <option value="59">59</option>
              </select>
            分 </td>
        </tr>
        <tr>
          <td width="84" align="center">闹钟铃声：</td>
          <td>
            <select name="mid" id="mid">
              <option value='1'>滴滴</option>
              <option value='2'>八音盒</option>
              <option value='3'>竹林溪水清笛</option>
              <option value='4'>开场曲</option>
              <option value='5'>Whistle口哨</option>
            </select>
            <button type="button" onclick="tryM(this)">试听</button>
          </td>
        </tr>
        <tr>
          <td width="84" align="center">提示文字：</td>
          <td><input type="text" name="text" id="text" maxlength="40" value="休息，休息一下吧！" />
          </td>
        </tr>
        <tr>
          <td width="84" align="center">重复提醒：</td>
          <td><label for="repeat1">
            <input type="radio" name="repeat" id="repeat1" value="1" checked="checked" />
            不重复</label>
              <label for="repeat2">
              <input type="radio" name="repeat" id="repeat365" value="365" />
                每天提醒</label></td>
        </tr>
        <tr>
          <td width="84" align="center">&nbsp;</td>
          <td><button type="button" onclick="post();">开 启 定 时 闹 钟</button></td>
        </tr>
      </table>
    </div>
  </form>
</div>
<div>
<div class="is">
  <div class="i3"></div>
  <div class="i2"></div>
  <div class="i1"></div>
</div>
</div>
</div>
<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		function searchs(){
			alert()
			top.jzts();
			$("#defaultForm").submit();
		}
		function resh(){
			window.location.href="<%=basePath%>login_default.do";
		}
	</script>
	<div align="center">
	  	<iframe width="800px" scrolling="no" height="120" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=19&icon=1&temp=1&num=5"></iframe>
 	</div>
</body>
</html>