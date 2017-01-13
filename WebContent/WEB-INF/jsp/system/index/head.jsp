		<div id="navbar" class="navbar navbar-default">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed');}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a class="navbar-brand">
						<small> <i class="fa fa-leaf"></i> ${pd.SYSNAME} </small>
					</a>
				</div>
				<div class="navbar-header pull-left" style="width: 56%;">
					<div class="navbar-brand" style="width: 100%">
					
					<marquee direction="left" behavior="scroll"scrollamount="10px">
						<span style="font-size: 18px;font-family:楷体;color: #FFFF00;">&lt;&lt;</span><span id="msgMSGTITLE" style="font-size: 18px;font-family:楷体;color: #FFFF00;">最新播报</span><span style="font-size: 18px;font-family:楷体;color: #FFFF00;">&gt;&gt;</span><span id="msgMSGCON" style="font-size: 16px;padding-left: 10px;font-family:楷体;"></span>
					</marquee>
					</div>
				</div>
				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">

						<li title="即时聊天" class="purple"  onclick="creatw();"><!-- creatw()在 WebRoot\plugins\websocketInstantMsg\websocket.js中 -->
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-bell icon-animated-bell"></i>
								<span class="badge badge-important"></span>
							</a>

							<ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-bell-o"></i>
									物流系统  即时通讯
								</li>
							</ul>
						</li>
						<li title="站内信" class="green" onclick="fhsms();" id="fhsmstss"><!-- fhsms()在 WebRoot\static\js\myjs\head.js中 -->
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-envelope icon-animated-vertical"></i>
								<span class="badge badge-success" id="fhsmsCount"></span>
							</a>
						</li>

						<!-- #section:basics/navbar.user_menu -->
						<li class="light-blue">
							<a data-toggle="dropdown"  class="dropdown-toggle" href="#">
								<img class="nav-user-photo" src="static/ace/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info" id="user_info">
								</span>
								<i class="ace-icon fa fa-caret-down"></i>
							</a>

							<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a onclick="editUserH();" style="cursor:pointer;"><i class="ace-icon fa fa-cog"></i>修改资料</a><!-- editUserH()在 WebRoot\static\js\myjs\head.js中 -->
								</li>
								<li id="systemset">
								<!--下面系统设置的方法 editSys(); -->
									<a style="cursor:pointer;"><i class="ace-icon fa fa-user"></i>系统设置</a><!-- editSys()在 WebRoot\static\js\myjs\head.js中 -->
								</li>
								<li class="divider"></li>
								<li>
									<a href="logout"><i class="ace-icon fa fa-power-off"></i>退出登录</a>
								</li>
							</ul>
						</li>

						<!-- /section:basics/navbar.user_menu -->
					</ul>
				</div>
				<!-- /section:basics/navbar.dropdown -->
			</div><!-- /.navbar-container -->
		</div>
		<div id="fhsmsobj"><!-- 站内信声音消息提示 --></div>