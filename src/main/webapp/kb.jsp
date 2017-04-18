<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<!-- BEGIN HEAD -->

<head>
<link href="images/favicon.ico" type="image/x-icon" rel="icon" />
<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />

<title>质量技术支持平台</title>
</head>

<%@ include file="./public.jsp"%>

<script type="text/javascript">
$(function reset_posi () {
	var left_posi = $(".menu-items").eq(0).width() - 10 + "px";
	var elements = $(".has_childs ul");
	for (var i = 0; i < elements.length; i ++){
		elements.eq(i).css("left", left_posi);
	}
});
</script>

<body>
	<div class="navbar-top">
		<div class="navbar-inner">
			<div style="padding-left: 5px; padding-right: 5px; text-align: right; height: 50px;">
				<span class="brand"> <i class="icon-chart"></i><a href="<%=basePath%>" class="system-title">质量技术支持平台</a></span>
				<span class="right-top">
					质量技术支持平台 欢迎您，尊敬的：<span style='color: #FFFFFF;'><%=currentUser%></span>
				</span>
			</div>
		</div>
	</div>

	<div class="menu-main" id="menu-main">
		<div class="menu-items">
			<div class="menu-head">
				<span class="head-link">质量度量分析</span>
			</div>
			<ul class="menu-body">
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_analysis.jsp">缺陷趋势分析</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_density.jsp">缺陷密度分析</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_fix.jsp">缺陷时效分析—修复</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_verify.jsp">缺陷时效分析—验证</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_coder.jsp">缺陷人员分布—开发</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_defects_tester.jsp">缺陷人员分布—测试</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_repairs_num.jsp">缺陷修复次数</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_bug_distribute.jsp">缺陷模块分布</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_release_ana.jsp">版本发布分析</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_auto_results.jsp">自动化测试分析</a></li>
			</ul>
		</div>

		<div class="menu-items">
			<div class="menu-head">
				<span class="head-link">工作任务管理</span>
			</div>
			<ul class="menu-body">
				<li class="menu-links"><a class="link-content" style="color: gold;" href="<%=basePath%>/kb_workbench.jsp">我的工作台—任务跟踪</a></li>
				<li class="menu-links"><a class="link-content" style="color: cornsilk;" href="<%=basePath%>/kb_warning_list.jsp">版本质量预警分析</a></li>
				<li class="has_childs"><a class="link-content" style="color: gold;" href="#">预警分析汇总查询</a><span class="child_escape">›</span>
					<ul>
						<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_dept.jsp">按部门预警汇总分析</a></li>
						<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_system.jsp">按子系统预警汇总分析</a></li>
						<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_version.jsp">按版本预警汇总分析</a></li>
						<li><a class="link-content" href="<%=basePath%>/kb_warn_ana_test.jsp">按测试组预警汇总分析</a></li>
					</ul>
				</li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_sut_list.jsp">在测版本信息清单</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_version_list.jsp">版本发布信息清单</a></li>
			</ul>
		</div>

		<div class="menu-items">
			<div class="menu-head">
				<span class="head-link">测试环境管理</span>
			</div>
			<ul class="menu-body">
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_env_list.jsp">测试环境信息清单</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_system_list.jsp">子系统信息维护</a></li>
			</ul>
		</div>

		<div class="menu-items">
			<div class="menu-head">
				<span class="head-link">质量技术支持</span>
			</div>
			<ul class="menu-body">
				<li class="menu-links"><a class="link-content" href="#" target="_blank">接口测试平台</a></li>
				<li class="menu-links"><a class="link-content" href="#" target="_blank">性能测试平台</a></li>
				<li class="menu-links"><a class="link-content" href="#" target="_blank">精准测试平台</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/tools/tta.jsp">测试架构知识地图</a></li>
			    <li class="menu-links"><a class="link-content" href="<%=basePath%>/tools/checklist.jsp">探索测试检查单</a></li>
			</ul>
		</div>

		<div class="menu-items">
			<div class="menu-head">
				<span class="head-link">常用资源链接</span>
			</div>
			<ul class="menu-body">
				<li class="menu-links"><a class="link-content" href="http://192.20.103.238/redmine" target="_blank">Redmine</a></li>
				<li class="menu-links"><a class="link-content" href="#" target="_blank">TestLink</a></li>
				<li class="menu-links"><a class="link-content" href="http://www.ibm.com/developerworks/cn" target="_blank">IBM developerWorks</a></li>
				<li class="menu-links"><a class="link-content" href="http://stackoverflow.com/" target="_blank">FAQ—StackOverflow</a></li>
				<li class="menu-links"><a class="link-content" href="http://zh.wikipedia.org/wiki" target="_blank">Wikipedia—维基百科</a></li>
			</ul>
		</div>

		<div class="menu-items">
			<div class="menu-head">
				<span class="head-link">看板应用管理</span>
			</div>
			<ul class="menu-body">
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_problem_list.jsp">应用问题/缺陷管理</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_visitor_analysis.jsp">访问量分析—模块</a></li>
				<li class="menu-links"><a class="link-content" href="<%=basePath%>/kb_visitor_trend.jsp">访问量分析—趋势</a></li>
			</ul>
		</div>
	</div>
</body>
</html>