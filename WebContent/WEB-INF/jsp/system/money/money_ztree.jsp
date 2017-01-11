<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<body>
	
<table style="width:100%;" border="0">
	<tr>
		<td style="width:15%;" valign="top" bgcolor="#F9F9F9">
			<div style="width:15%;">
				<ul id="leftTree" class="tree"></ul>
			</div>
		</td>
		<td style="width:85%;" valign="top" >
			<iframe name="treeFrame" id="treeFrame" frameborder="0" src="<%=basePath%>money/list.do?MO_TIME=${pd.MO_TIME}&STATE=2&currentPage=${null == pd.dnowPage || '' == pd.dnowPage?'1':pd.dnowPage}" style="margin:0 auto;width:100%;height:100%;"></iframe>
		</td>
	</tr>
</table>
<script type="text/javascript">
		$(top.hangge());
		var zTree;
		$(document).ready(function(){
			var setting = {
			    showLine: true,
			    checkable: false
			};
			var date=new Date;
			var year=date.getFullYear();
			var zn = [{"checked":false,"nodes":[{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-01&STATE=2","name":"一月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-02&STATE=2","name":"二月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-03&STATE=2","name":"三月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-04&STATE=2","name":"四月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-05&STATE=2","name":"五月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-06&STATE=2","name":"六月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-07&STATE=2","name":"七月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-08&STATE=2","name":"八月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-09&STATE=2","name":"九月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-10&STATE=2","name":"十月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-11&STATE=2","name":"十一月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"-12&STATE=2","name":"十二月份","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"&STATE=2","name":"全年","target":"treeFrame"},
			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"&boos=true&STATE=2","name":"上半年","target":"treeFrame"},
  			{"checked":false,"url":"money/list.do?MO_TIME="+(year-2)+"&boos=false&STATE=2","name":"下半年","target":"treeFrame"}
			],"url":"money/list.do?MO_TIME="+(year-2)+"&STATE=2","name":"前年","target":"treeFrame"},
			
			{"checked":false,"nodes":[{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-01&STATE=2","name":"一月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-02&STATE=2","name":"二月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-03&STATE=2","name":"三月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-04&STATE=2","name":"四月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-05&STATE=2","name":"五月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-06&STATE=2","name":"六月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-07&STATE=2","name":"七月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-08&STATE=2","name":"八月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-09&STATE=2","name":"九月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-10&STATE=2","name":"十月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-11&STATE=2","name":"十一月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"-12&STATE=2","name":"十二月份","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"&STATE=2","name":"全年","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"&boos=true&STATE=2","name":"上半年","target":"treeFrame"},
			              			{"checked":false,"url":"money/list.do?MO_TIME="+(year-1)+"&boos=false&STATE=2","name":"下半年","target":"treeFrame"}
			              			],"url":"money/list.do?MO_TIME="+(year-1)+"&STATE=2","name":"去年","target":"treeFrame"},
			              			
			{"checked":false,"open":true,"nodes":[{"checked":false,"url":"money/list.do?MO_TIME="+year+"-01&STATE=2","name":"一月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-02&STATE=2","name":"二月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-03&STATE=2","name":"三月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-04&STATE=2","name":"四月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-05&STATE=2","name":"五月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-06&STATE=2","name":"六月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-07&STATE=2","name":"七月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-08&STATE=2","name":"八月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-09&STATE=2","name":"九月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-10&STATE=2","name":"十月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-11&STATE=2","name":"十一月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"-12&STATE=2","name":"十二月份","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"&STATE=2","name":"全年","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"&boos=true&STATE=2","name":"上半年","target":"treeFrame"},
				              			{"checked":false,"url":"money/list.do?MO_TIME="+year+"&boos=false&STATE=2","name":"下半年","target":"treeFrame"}
				              			],"url":"money/list.do?MO_TIME="+year+"&STATE=2","name":"今年","target":"treeFrame"}]

			var zTreeNodes = eval(zn);
			zTree = $("#leftTree").zTree(setting, zTreeNodes);
		});
	
		function treeFrameT(){
			var hmainT = document.getElementById("treeFrame");
			var bheightT = document.documentElement.clientHeight;
			hmainT .style.width = '100%';
			hmainT .style.height = (bheightT-26) + 'px';
		}
		treeFrameT();
		window.onresize=function(){  
			treeFrameT();
		};
</SCRIPT>
</body>
</html>

