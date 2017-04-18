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

<style>
.tips {
	text-align: left;
	float: right;
	position: fixed;
	bottom: 15px;
	top: auto;
	left: 20px;
	font-size: 16px;
	color: #FFF;
	font-family: "Arial", "微软雅黑";
}

.central {
	padding-left: 50px;
	width: 65%;
}

.message {
	text-align: right;
	float: right;
	position: fixed;
	bottom: 5px;
	top: auto;
	right: 20px;
	font-size: 15px;
	color: #FFF;
	font-family: "Arial","微软雅黑";
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
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: -1;
}

.text-div {
	line-height: 150px;
	height: 150px;
}

.big-text {
	font-size: 120px;
	color: darkorange;
	font-family: fantasy;
}

.small-text {
	text-align: left;
	font-size: 70px;
	color: gold;
	font-family: fantasy;
	font-style: italic;
}
</style>

<%@ include file="./kb.jsp"%>

<script type="text/javascript">
	$(function() {
		set_background();
	});

	function set_background() {
		var winWidth = window.document.body.offsetWidth;
		if (winWidth > 1920) {
			$("#back-ground").attr("src", "images/index-blue_big.jpg");
		} else {
			$("#back-ground").attr("src", "images/index-blue.jpg");
		}

		var winHeight = window.screen.height;
		var divHeight = winHeight/6;
		var delements = $(".text-div");
		for ( var k = 0; k < delements.length; k++) {
			var delement = delements.eq(k);
			delement.css("height", divHeight + "px");
			delement.css("line-height", divHeight + "px");
		}
	}
</script>

<body>
	<img src="./images/index-blue.jpg" class="back-ground" id="back-ground">
	<div class="central">
		<div style="text-align: left;" class="text-div">
			<span class="big-text">S</span> <span class="small-text">oftware</span>
		</div>
		<div style="text-align: center;" class="text-div">
			<span class="big-text">Q</span> <span class="small-text">uality</span>
		</div>
		<div style="text-align: right;" class="text-div">
			<span class="big-text">C</span> <span class="small-text">ontrol</span>
		</div>
	</div>

	<div class="message">
		© 开发者 &amp; 版权所有 ：刘毅<br /> 推荐使用 Chrome/Firefox 浏览，使用过程中的问题请<a href="./tools/problem_add.jsp"
			style="color: darkorange;" target="_blank">这里上报</a>
	</div>

	<div class="tips">
		本系统质量度量部分功能，推荐有软件工程专业背景的同事使用，更多<a href="http://www.ibm.com/developerworks/cn/rational/r-measurement/"
			style="color: darkorange;" target="_blank">软件度量与管理</a>的知识请浏览互联网
	</div>
</body>
</html>