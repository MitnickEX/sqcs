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

<%@ include file="kb.jsp"%>
<body>
	<div class="gragh-show">
		<iframe src="./sqa/bug_finder_system.jsp" width=100% crolling="no" onload="setFrameHeight(this);"
			leftmargin="0" topmargin="0" frameborder="0"></iframe>

		<iframe src="./sqa/bug_finder_version.jsp" width=100% crolling="no" onload="setFrameHeight(this);"
			leftmargin="0" topmargin="0" frameborder="0"></iframe>
	</div>
</body>
</html>
