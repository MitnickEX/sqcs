<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

<%@ include file="../kb.jsp"%>

<style type="text/css">
* {
	-webkit-margin-before: 0px;
	-webkit-margin-after: 0px;
	-webkit-padding-start: 10px;
	text-shadow: none;
	margin: 0;
	padding: 0;
}

ul {
	margin-bottom: 0;
}

li {
	line-height: 20px;
}

.menu-frame {
	z-index: 998;
	width: 16.50%;
	display: inline-block;
	vertical-align: top;
}

.menu-frame .topic-head {
	z-index: 999;
	background-color: rgba(100, 100, 150, 0.9);
	padding-left: 20px;
	padding-right: 20px;
	text-align: left;
	font-size: 22px;
	color: ghostwhite;
	font-weight: 500;
	font-family: 黑体;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	border: 1px solid rgba(100, 100, 150, 0.9);
}

.topic-head:hover {
	color: orange;
}

.main-frame {
	z-index: -1;
	width: 83%;
	display: inline-block;
	position: absolute;
	right: 2px;
	left: auto;
	overflow:auto;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	border: 1px solid rgba(100, 100, 150, 0.9);
}

.topic-body {
	z-index: 1002;
	width: 12%;
	background-color: rgba(70, 150, 200, 0.9);
	display: none;
	position: fixed;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	border: 1px solid rgba(100, 100, 150, 0.9);
}

.topic-links {
	z-index: 1001;
	text-align: left;
	display: block;
	width: 100%;
	height: 40px;
	line-height: 40px;
	padding-left: 30px;
	padding-right: 30px;
	margin-top: 10px;
	margin-bottom: 10px;
}

.topic-child-title {
	z-index: 1001;
	text-decoration: none;
	color: ghostwhite;
	font-weight: 500;
	font-size: 18px;
	font-family: "Vrinda", "华文细黑";
}

.topic-child-title:hover {
	font-size: 20px;
	font-weight: 600;
	font-family: 华文细黑;
	color: orange;
}

span {
	border: none;
}

body {
	padding-left: 1px;
	padding-right: 1px;
	padding-bottom: 10px;
}
</style>

<script type="text/javascript">
	var topic_loader = function() {
		var topicHead = $(".topic-head");
		var topicBody = $(".topic-body");
		for ( var i = 0; i < topicHead.length; i++) {
			topicHead[i].index = i;
			topicHead[i].onmouseover = function() {
				for ( var j = 0; j < topicBody.length; j++) {
					topicBody[j].index_j = j;
					topicBody[j].style.display = "none";
					topicBody[j].onmouseover = function() {
						this.style.display = "block";
					};
					topicBody[j].onmouseout = function() {
						this.style.display = "none";
					};
				}
				if (topicBody[this.index]) {
					topicBody[this.index].style.display = "block";
				}
			};
		}
	};

	var auto_fit = function() {
		var div_height = $(document).height() - 120;
		var line_height = parseInt(div_height / 6.03);
		$("#menu-frame").height(div_height);
		$("#main-frame").height(div_height);

		var heads = $(".topic-head");
		var bodies = $(".topic-body");
		var index = heads.length;
		var half_index = parseInt(index / 2);

		for ( var i = 0; i < half_index; i++) {
			var elementh = heads.eq(i);
			var posi = $(elementh).position();
			var elementb = bodies.eq(i);
			$(elementh).css("line-height", (line_height - 1 - 5 / 6) + "px");
			$(elementb).css("left", ($("#menu-frame").width() + posi.left) + "px");
			$(elementb).css("top", posi.top + "px");
			if (i != 0) {
				elementh.css("margin-top", "1px");
			}
		}

		for ( var i = half_index; i < index; i++) {
			var elementh = heads.eq(i);
			var posi = $(elementh).position();
			var elementb = bodies.eq(i);
			$(elementh).css("line-height", (line_height - 1) + "px");
			$(elementb).css("left", ($("#menu-frame").width() + posi.left) + "px");
			$(elementb).css("top", $(elementh).height() + posi.top - elementb.height() + "px");
			if (i != 0) {
				elementh.css("margin-top", "1px");
			}
		}
	};

	$(function() {
		topic_loader();
		auto_fit();
	});
</script>

<body>
	<div class="menu-frame" id="menu-frame">
		<div class="topic-head">
			<span class="head-text">测试自动化</span>
		</div>
		<ul class="topic-body">
			<li class="topic-links"><a class="topic-child-title" href="#">应用范畴</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">效益观念</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">测试设计</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">框架搭建</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">测试工具</a></li>
		</ul>
		<div class="topic-head">
			<span class="head-text">性能测试</span>
		</div>
		<ul class="topic-body">
			<li class="topic-links"><a class="topic-child-title" href="#">需求指标</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">方案场景</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">工具监控</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">分析调优</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">容量规划</a></li>
		</ul>

		<div class="topic-head">
			<span class="head-text">安全性测试</span>
		</div>
		<ul class="topic-body">
			<li class="topic-links"><a class="topic-child-title" href="#">漏洞与攻击</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">检查单测试</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">工具应用</a></li>
		</ul>
		<div class="topic-head">
			<span class="head-text">兼容性测试</span>
		</div>
		<ul class="topic-body">
			<li class="topic-links"><a class="topic-child-title" href="#">需求采集</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">环境设计</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">执行测试</a></li>
		</ul>
		<div class="topic-head">
			<span class="head-text">行业前沿</span>
		</div>
		<ul class="topic-body">
			<li class="topic-links"><a class="topic-child-title" href="#">云计算</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">大数据</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">物联网</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">人工智能</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">云测试</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">探索性测试</a></li>
		</ul>
		<div class="topic-head">
			<span class="head-text">综合应用</span>
		</div>
		<ul class="topic-body">
			<li class="topic-links"><a class="topic-child-title" href="#">持续集成</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">敏捷开发</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">灰度发布</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">A/B Testing</a></li>
			<li class="topic-links"><a class="topic-child-title" href="#">DevOps</a></li>
		</ul>
	</div>
	<div class="main-frame" id="main-frame">
	</div>
</body>
</html>