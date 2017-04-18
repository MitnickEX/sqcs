<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
<title>质量技术支持平台</title>
</head>

<%@ include file="./kb.jsp"%>

<style>
body {
	background-color: rgba(250, 250, 210, 0.5) !important;
	padding: 100px 10px 50px 10px;
}

.message {
	text-align: right;
	float: right;
	position: fixed;
	bottom: 15px;
	top: auto;
	right: 20px;
	font-size: 16px;
	color: rgb(80, 70, 110);
	font-family: "Arial", "微软雅黑";
}

.tips {
	text-align: left;
	float: right;
	position: fixed;
	bottom: 15px;
	top: auto;
	left: 20px;
	font-size: 16px;
	color: rgb(80, 70, 110);
	font-family: "Arial", "微软雅黑";
}

.footer-auth {
	text-align: right;
	position: fixed;
	bottom: 10px;
	right: 10px;
	top: auto;
	font-size: 15px;
	color: #FFF;
	font-family: 微软雅黑;
}

.back-ground {
	width: 100%;
	height: 100%;
	position: absolute;
	width: 45%;
	height: 60%;
	top: 20%;
	left: 25%;
	right: 0;
	bottom: 0;
	z-index: -1;
}

.left-top {
	text-align: center;
	position: absolute;
	left: 16%;
	top: 26%;
	overflow: visible;
	background-image: url('./images/blue-line.jpg');
	background-size: 100%;
	border: 1px solid black;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.left-top:hover .menus {
	display: block;
}

.left-bottom {
	position: absolute;
	left: 11%;
	bottom: 30%;
	overflow: visible;
	text-align: center;
	background-image: url('./images/blue-line.jpg');
	background-size: 100%;
	border: 1px solid black;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.left-bottom:hover .menus {
	display: block;
}

.right-top {
	text-align: center;
	position: absolute;
	right: 16.5%;
	top: 30%;
	overflow: visible;
	background-image: url('./images/blue-line.jpg');
	background-size: 100%;
	border: 1px solid black;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.right-top:hover .menus {
	display: block;
}

.right-bottom {
	text-align: center;
	position: absolute;
	right: 21.5%;
	bottom: 26%;
	overflow: visible;
	background-image: url('./images/blue-line.jpg');
	background-size: 100%;
	border: 1px solid black;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.right-bottom:hover .menus {
	display: block;
}

.small-text {
	font-size: 28px;
	color: rgba(225, 225, 225, 0.8);
	font-family: 微软雅黑;
	margin-bottom: 0;
}

.line {
	position: absolute;
	width: 160px;
	height: 1px;
	display: none;
}

.menus {
	background-color: rgba(90, 70, 150, 0.7);
	border: 1px solid rgb(115, 115, 150);
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	display: none;
	z-index: 999;
}

.menus li ul {
	background-color: rgba(90, 70, 150, 0.8);
	border: 1px solid rgb(115, 115, 150);
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	display: none;
	list-style: none;
	position: relative;
	top: -40px;
	left: 0;
	z-index: 9999;
	overflow: hidden;
}
</style>

<script type="text/javascript">
	var winHeight = window.screen.availHeight;
	var winWidth = window.screen.availWidth;

	$(function() {
		$("#menu-main").hide();
		set_background();
		if (!browserCheck()) {
			$("#body").css("background-color", "rgb(253, 252, 232)");
			var texts = $(".small-text");
			for ( var k = 0; k < texts.length; k++) {
				var text = texts.eq(k);
				text.css("color", "white");
			}
		}
		set_buttom_menu();
	});

	function set_buttom_menu(){
		var left_posi = $("#left-bottom").width() - 10 + "px";
		var elements = $(".menus li ul");
		for (var i = 0; i < elements.length; i ++){
			elements.eq(i).css("left", left_posi);
		}

		var space = Math.floor((winWidth - 1000) /100) + 1;

		var element_0 = $("#left-bottom");
		var element_1 = $("#left-bottom .menus").eq(0);
		element_1.css("bottom", element_0.height() + element_1.height() + space + "px");

		var element_2 = $("#right-bottom");
		var element_3 = $("#right-bottom .menus").eq(0);
		element_3.css("bottom", element_2.height() + element_3.height() + space + "px");
	};

	function set_background() {
		var divHeight = winHeight / 6;
		var delements = $(".text-div");
		for ( var k = 0; k < delements.length; k++) {
			var delement = delements.eq(k);
			delement.css("height", divHeight + "px");
			delement.css("line-height", divHeight + "px");
		}

		var menus = $(".menus");
		for (var i = 0; i < menus.length; i++) {
			menus.eq(i).css("background-color", "rgb(90, 70, 150)");
		}

		var line_width = winWidth / 8;
		if (winWidth < 1400){
			line_width = winWidth / 7;
		}
		var line_height = winHeight / 24;

		$("#left-bottom").css("width", line_width + "px");
		$("#left-bottom").css("height", line_height + "px");
		$("#left-bottom").css("line-height", line_height + "px");

		$("#right-bottom").css("width", line_width + "px");
		$("#right-bottom").css("height", line_height + "px");
		$("#right-bottom").css("line-height", line_height + "px");

		$("#left-top").css("width", line_width + "px");
		$("#left-top").css("height", line_height + "px");
		$("#left-top").css("line-height", line_height + "px");

		$("#right-top").css("width", line_width + "px");
		$("#right-top").css("height", line_height + "px");
		$("#right-top").css("line-height", line_height + "px");

		var line_len = winWidth / 12;

		var position_a = $("#left-bottom").position();
		$("#line-left-bottom").css("left", (position_a.left + line_width + 2) + "px");
		$("#line-left-bottom").css("top", (position_a.top + line_height / 2) + "px");
		$("#line-left-bottom").css("width", line_len + "px");
		$("#line-left-bottom").show();

		var position_b = $("#left-top").position();
		$("#line-left-top").css("left", (position_b.left + line_width + 2) + "px");
		$("#line-left-top").css("top", (position_b.top + line_height / 2) + "px");
		$("#line-left-top").css("width", line_len + "px");
		$("#line-left-top").show();

		var position_a = $("#right-bottom").position();
		$("#line-right-bottom").css("left", (position_a.left - line_len) + "px");
		$("#line-right-bottom").css("top", (position_a.top + line_height / 2) + "px");
		$("#line-right-bottom").css("width", line_len + "px");
		$("#line-right-bottom").show();

		var position_a = $("#right-top").position();
		$("#line-right-top").css("left", (position_a.left - line_len) + "px");
		$("#line-right-top").css("top", (position_a.top + line_height / 2) + "px");
		$("#line-right-top").css("width", line_len + "px");
		$("#line-right-top").show();

		var texts = $(".small-text");
		for ( var k = 0; k < texts.length; k++) {
			var text = texts.eq(k);
			text.css("font-size", winWidth / 60 + "px");
		}
	}
</script>

<body id="body">
	<img src="./images/sqcs.jpg" class="back-ground" id="back-ground">
	<div id="left-bottom" class="left-bottom">
		<span class="small-text">我是测试主管</span>
		<ul class="menus" style="position: relative;">
			<li class="menu-links"><a class="link-content" style="color: gold;" href="<%=basePath%>/kb_warning_list.jsp">版本质量预警分析</a></li>
			<li class="has_childs"><a class="link-content" style="color: orange;" href="#">预警分析汇总查询</a><span
				class="child_escape">›</span>
				<ul>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_dept.jsp">按部门预警汇总分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_system.jsp">按子系统预警汇总分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_version.jsp">按版本预警汇总分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_test.jsp">按测试组预警汇总分析</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">开发流程明细分析</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_analysis.jsp">缺陷趋势分析</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_density.jsp">缺陷密度分析</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_fix.jsp">缺陷时效分析—修复</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_verify.jsp">缺陷时效分析—验证</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_coder.jsp">缺陷人员分布—开发</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_tester.jsp">缺陷人员分布—测试</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_repairs_num.jsp">缺陷修复次数</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_distribute.jsp">缺陷模块分布</a></li>
				</ul></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_sut_list.jsp">在测版本信息清单</a></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_version_list.jsp">版本发布信息清单</a></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_accidents.jsp">UIOC及重大事件分析</a></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_release_ana.jsp">版本发布分析</a></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/uat_feedback.jsp">业务满意度查看</a></li>
			<li class="has_childs"><a class="link-content" href="#">SQCS应用系统管理</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_problem_list.jsp">应用问题/缺陷管理</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_visitor_analysis.jsp">访问量分析—模块</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_visitor_trend.jsp">访问量分析—趋势</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/tools/dbcon_test.jsp" target="_blank">看板数据源监控</a></li>
					<li class="menu-links"><a class="link-content" onclick="return agent_check();"
						href="<%=basePath%>/tools/admin.jsp">数据同步管理</a></li>
				</ul></li>
		</ul>
	</div>
	<div id="right-bottom" class="right-bottom">
		<span class="small-text">我是测试人员</span>
		<ul class="menus" style="position: relative;">
			<li class="has_childs"><a class="link-content" href="#">测试工具支持服务</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="http://cnsz024103:8080/quicktest" target="_blank">快速测试跟踪系统</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_spcode_relation.jsp">SPR—存储过程关联</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_interface_list.jsp">ITS—接口测试模拟器</a></li>
					<li class="menu-links"><a class="link-content" href="http://sqms-dpm.paic.com.cn/dpm" target="_blank">DPM—开发过程管理</a></li>
					<li class="menu-links"><a class="link-content" href="http://tm.paic.com.cn:80/testlink/" target="_blank">TESTLINK—缺陷管理</a></li>
					<li class="menu-links"><a class="link-content" href="http://rsms.pingan.com.cn/rsms/" target="_blank">RSMS—基础架构信息</a></li>
					<li class="menu-links"><a class="link-content" href="http://km.paic.com.cn:9000/ciauto/#all" target="_blank">质量技术交流社区</a></li>
					<li class="menu-links"><a class="link-content" href="http://pacloud.paic.com.cn/login!doInit.action"
						target="_blank">平安云(IAAS)门户</a></li>
				</ul></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/tools/checklist.jsp">探索测试检查单</a></li>
			<li class="has_childs"><a class="link-content" href="#">版本质量度量分析</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_analysis.jsp">缺陷趋势分析</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_density.jsp">缺陷密度分析</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_verify.jsp">缺陷时效分析—验证</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_tester.jsp">缺陷人员分布—测试</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_repairs_num.jsp">缺陷修复次数</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_distribute.jsp">缺陷模块分布</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">CI-持续集成分析</a><span class="child_escape">›</span>
				<ul>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_ana.jsp">CI—静态扫描分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_cud.jsp">CI—开发者测试分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_uat.jsp">CI—验收测试分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_cov.jsp">CI—测试覆盖率分析</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">AT-自动化测试分析</a><span class="child_escape">›</span>
				<ul>
					<li><a class="link-content" href="<%=basePath%>/kb_auto_web.jsp">AT—自动化WEB测试</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_auto_interface.jsp">AT—自动化接口测试</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_auto_calulate.jsp">AT—自动化算法测试</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">测试环境管理维护</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_env_list.jsp">测试环境信息清单</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_system_list.jsp">子系统信息维护</a></li>
					<li class="menu-links"><a class="link-content" onclick="return browserCheck();"
						href="<%=basePath%>/kb_env_relation.jsp" target="_blank">测试环境关联关系图</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_env_config.jsp">测试环境配置项对比</a></li>
					<li class="menu-links"><a class="link-content" href="http://10.31.177.125:9999/MVC/" target="_blank">测试环境监控平台</a></li>
				</ul></li>
		</ul>
	</div>
	<div id="left-top" class="left-top">
		<span class="small-text">我是开发主管</span>
		<ul class="menus">
			<li class="has_childs"><a class="link-content" style="color: orange;" href="#">预警分析汇总查询</a><span
				class="child_escape">›</span>
				<ul>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_dept.jsp">按部门预警汇总分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_system.jsp">按子系统预警汇总分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_version.jsp">按版本预警汇总分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_test.jsp">按测试组预警汇总分析</a></li>
				</ul></li>
			<li class="menu-links"><a class="link-content" style="color: gold;" href="<%=basePath%>/kb_warning_list.jsp">版本质量预警分析</a></li>
			<li class="has_childs"><a class="link-content" href="#">产品过程质量分析</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_analysis.jsp">缺陷趋势分析</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_density.jsp">缺陷密度分析</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_fix.jsp">缺陷时效分析—修复</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_coder.jsp">缺陷人员分布—开发</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_repairs_num.jsp">缺陷修复次数</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_distribute.jsp">缺陷模块分布</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/uat_feedback.jsp">业务满意度查看</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">CI-持续集成分析</a><span class="child_escape">›</span>
				<ul>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_ana.jsp">CI—静态扫描分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_cud.jsp">CI—开发者测试分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_uat.jsp">CI—验收测试分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_cov.jsp">CI—测试覆盖率分析</a></li>
				</ul></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_sut_list.jsp">在测版本信息清单</a></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_version_list.jsp">版本发布信息清单</a></li>
			<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_release_ana.jsp">版本发布分析</a></li>
		</ul>
	</div>
	<div id="right-top" class="right-top">
		<span class="small-text">我是开发人员</span>
		<ul class="menus">
			<li class="has_childs"><a class="link-content" href="#">工作效率度量分析</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_fix.jsp">缺陷时效分析—修复</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_repairs_num.jsp">缺陷修复次数</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">版本质量度量分析</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_density.jsp">缺陷密度分析</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_coder.jsp">缺陷人员分布—开发</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_distribute.jsp">缺陷模块分布</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">CI-持续集成分析</a><span class="child_escape">›</span>
				<ul>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_ana.jsp">CI—静态扫描分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_cud.jsp">CI—开发者测试分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_uat.jsp">CI—验收测试分析</a></li>
					<li><a class="link-content" href="<%=basePath%>/kb_ci_cov.jsp">CI—测试覆盖率分析</a></li>
				</ul></li>
			<li class="has_childs"><a class="link-content" href="#">测试工具支持服务</a><span class="child_escape">›</span>
				<ul>
					<li class="menu-links"><a class="link-content" href="http://cnsz024103:8080/quicktest" target="_blank">快速测试跟踪系统</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_spcode_relation.jsp">SPR—存储过程关联</a></li>
					<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_interface_list.jsp">ITS—接口测试模拟器</a></li>
					<li class="menu-links"><a class="link-content" href="http://sqms-dpm.paic.com.cn/dpm" target="_blank">DPM—开发过程管理</a></li>
					<li class="menu-links"><a class="link-content" href="http://tm.paic.com.cn:80/testlink/" target="_blank">TESTLINK—缺陷管理</a></li>
					<li class="menu-links"><a class="link-content" href="http://rsms.pingan.com.cn/rsms/" target="_blank">RSMS—基础架构信息</a></li>
					<li class="menu-links"><a class="link-content" href="http://km.paic.com.cn:9000/ciauto/#all" target="_blank">质量技术交流社区</a></li>
					<li class="menu-links"><a class="link-content" href="http://pacloud.paic.com.cn/login!doInit.action"
						target="_blank">平安云(IAAS)门户</a></li>
				</ul></li>
		</ul>
	</div>

	<div id="line-left-bottom" class="line" style="border-top: solid rgb(27, 138, 238) 2px;"></div>
	<div id="line-left-top" class="line" style="border-top: solid rgb(20, 144, 240) 2px;"></div>
	<div id="line-right-bottom" class="line" style="border-top: solid rgb(24, 148, 241) 2px;"></div>
	<div id="line-right-top" class="line" style="border-top: solid rgb(25, 141, 240) 2px;"></div>

	<div class="message">
		© 开发者 &amp; 版权所有 ：平安科技测试管理部 技术中心<br /> 推荐使用 Chrome/Firefox 浏览，使用过程中的问题请<a href="./tools/problem_add.jsp"
			style="color: darkorange;" target="_blank">这里上报</a>
	</div>

	<div class="tips">
		本系统质量度量部分功能，推荐有软件工程专业背景的同事使用，更多<a href="http://www.ibm.com/developerworks/cn/rational/r-measurement/"
			style="color: darkorange;" target="_blank">软件度量与管理</a>的知识请浏览互联网
	</div>
</body>
</html>