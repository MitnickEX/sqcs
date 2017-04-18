<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.fudax.sqcs.pub.controller.VisitorCounter"%>

<%@ include file="./pub_root.jsp"%>
<%
	VisitorCounter visitor = new VisitorCounter();
	visitor.recordVisitor(request);
%>

<link href="images/favicon.ico" type="image/x-icon" rel="icon" />
<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />

<script type="text/javascript">
	var agent ='<%=visitor.getVisitorAddress(request)%>';

	function setFrameHeight(obj) {
		var win = obj;
		if (document.getElementById) {
			if (win && !window.opera) {
				if (win.contentDocument && win.contentDocument.body.offsetHeight){
					win.height = win.contentDocument.body.offsetHeight + 40;
				} else if (win.Document && win.Document.body.scrollHeight){
					win.height = win.Document.body.scrollHeight + 40;
				}
			}
		}
	};

	function menu_width(className){
		var winWidth = window.document.body.offsetWidth;

		var elements = $(".menu-items");
		for ( var i = 0; i < elements.length; i++) {
			var element = elements.eq(i);
			if (winWidth > 1760){
				element.css("width", "16.554%");
			}else if(winWidth > 1570 && winWidth <= 1760){
				element.css("width", "16.535%");
			}else if(winWidth > 1414 && winWidth <= 1570){
				element.css("width", "16.525%");
			}else if(winWidth > 1280 && winWidth <= 1414){
				element.css("width", "16.515%");
			}else if(winWidth > 800 && winWidth <= 1280){
				element.css("width", "16.45%");
			} else{
				element.css("width", "16.4%");
			}
		}
	};

	function div_height(id){
		$("#" + id).height(window.screen.availHeight - 400);
	};

	var menu_loader = function () {
		var menuHead = $(".menu-head");
		var menuBody = $(".menu-body");
		for (var i = 0; i < menuHead.length; i++) {
			menuHead[i].index = i;
			menuHead[i].onmouseover = function () {
				for (var j = 0; j < menuBody.length; j++) {
					menuBody[j].index_j = j;
					menuBody[j].style.display = "none";
					menuBody[j].onmouseover = function () {
						this.style.display = "block";
					};
					menuBody[j].onmouseout = function () {
						this.style.display = "none";
					};
				}
				if (menuBody[this.index]) {
					menuBody[this.index].style.display = "block";
				}
			};
		}
	};

	function change_color_4ie(){
		var menus = $(".menu-items");
		var menus_body = $(".menu-body");
		var has_child = $(".has_childs ul");
		var navbar = $(".navbar-inner");
		navbar.eq(0).css("background-color", "#104E8B");
		for (var i = 0; i < menus.length; i++) {
			menus.eq(i).css("background-color", "#104E8B");
		}
		for (var i = 0; i < menus_body.length; i++) {
			menus_body.eq(i).css("background-color", "#104E8B");
		}
		for (var i = 0; i < has_child.length; i++) {
			has_child.eq(i).css("background-color", "#104E8B");
		}
	};

	window.onload = function () {
		var current_url = window.location.href;
		var root_url = '<%=basePath%>/';
		//root_no_port is for port transfer judgement
		var root_no_port = '<%=basePathWithNoProt%>/';

		menu_loader();
		menu_width();
		browserCheck();

		if (current_url.indexOf("index.jsp") > -1 || root_url.indexOf(current_url) > -1 || root_no_port.indexOf(current_url) > -1 ) {
			if (detectZoom() != 100){
				alert("您的网页缩放比例可能会影响展示效果，建议：\n"
					 + "1、若系统DPI为默认设置，使用 CTRL+0 还原缩放比例\n"
					 + "2、使用 CTRL+鼠标滚轮 来调整网页缩放比例至100%");
			}
		}
		tableSort();
	};

	function tableSort() {
		$('#container #main_table th').click(function() {
			var arr = new Array();
			var dataType = $(this).attr('sortType');
			var index = $('#container #main_table th').index(this) + 1;
			var row = $('#table_body .main_table tbody tr');
			for ( var i = 0; i < row.length; i++) {
				arr.push(row[i]);
			}

			if ($(this).attr("clicked") == "undefined") {
				arr.reverse();
				$(this).attr("clicked", "clicked");
			} else {
				arr.sort(sortStr(index, dataType));
				$(this).attr("clicked","undefined");
			}

			var fragment = document.createDocumentFragment();
			for ( var i = 0; i < arr.length; i++) {
				fragment.appendChild(arr[i]);
			}
			$('#container #table_body tbody').append(fragment);
		});
	};

	function sortStr(index, dataType) {
		return function(a, b) {
			var aText = $(a).find("td:nth-child(" + index + ")").text();
			var bText = $(b).find("td:nth-child(" + index + ")").text();

			if (dataType != 'string') {
				aText = Parse(aText, dataType);
				bText = Parse(bText, dataType);
				return aText > bText ? 1 : bText > aText ? -1 : 0;
			} else {
				return aText.localeCompare(bText);
			}
		};
	};

	function Parse(data, dataType) {
		switch (dataType) {
		case 'num':
			return parseFloat(data) || 0;
		case 'date':
			return Date.parse(data) || 0;
		default:
			return splitStr(data);
		}
	};

	function splitStr(data) {
		var re = /^[\$a-zA-z\u4e00-\u9fa5 ]*(.*?)[a-zA-z\u4e00-\u9fa5 ]*$/;
		data = data.replace(re, '$1');
		return parseFloat(data);
	};

	function browserCheck() {
		var Sys = {};
		var ua = navigator.userAgent.toLowerCase();
		var s;
		(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] : (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] : (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] : (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] : (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;

		if (Sys.ie < 10) {
			change_color_4ie();
			alert("请使用IE10.0及以上版本，或使用chrome和firefox浏览！");
		}
	};

	function show_transfer(show_eletag, elementId) {
		$(show_eletag).click(function(event) {
			var e = window.event || event;
			if (e.stopPropagation) {
				e.stopPropagation();
			} else {
				e.cancelBubble = true;
			}
			$("#" + elementId).show();
		});
		$("#" + elementId).click(function(event) {
			var e = window.event || event;
			if (e.stopPropagation) {
				e.stopPropagation();
			} else {
				e.cancelBubble = true;
			}
		});
		document.onclick = function() {
			$("#" + elementId).hide();
		};
	};
	
	function url_handle(url, params, target) {
		var datas = new Array();
		datas = params.split(";");
		var form1 = document.createElement("form");
		form1.id = "form1";
		form1.name = "form1";
		document.body.appendChild(form1);
		for ( var i = 0; i < datas.length - 1; i++) {
			var input = document.createElement("input");
			input.type = "hidden";
			input.name = datas[i];
			input.value = datas[i + 1];
			form1.appendChild(input);
			i++;
		}
		form1.method = "POST";
		form1.action = url;
		form1.target = target;
		form1.submit();
		document.body.removeChild(form1);
	}

	var detectZoom = function() {
		var ratio = 0, screen = window.screen, ua = navigator.userAgent.toLowerCase();
		if (~ua.indexOf('firefox')) {
			if (window.devicePixelRatio !== undefined) {
				ratio = window.devicePixelRatio;
			}
		} else if (~ua.indexOf('msie')) {
			if (screen.deviceXDPI && screen.logicalXDPI) {
				ratio = screen.deviceXDPI / screen.logicalXDPI;
			}
		} else if (window.outerWidth !== undefined && window.innerWidth !== undefined) {
			ratio = window.outerWidth / window.innerWidth;
		}

		if (ratio) {
			ratio = Math.round(ratio * 100);
		}

		if (ratio === 99 || ratio === 101) {
			ratio = 100;
		}

		return ratio;
	};
</script>

<style type="text/css">
* {
	-webkit-margin-before: 0px;
	-webkit-margin-after: 0px;
	-webkit-padding-start: 10px;
	text-shadow: none;
	margin: 0;
	padding: 0;
}

html,body {
	margin: 0;
	padding: 0;
}

body {
	background-color: rgb(250, 250, 210) !important;
	padding: 100px 10px 50px 10px;
}

a {
	color: #08c;
	text-decoration: none
}

a:hover,a:focus {
	color: darkorange;
	text-decoration: none;
}

ul {
	margin-bottom: 0;
}

li {
	line-height: 20px;
}

.menu-main {
	line-height: 25px;
	display: inline-block;
	width: 100%;
	overflow: visible;
	font-family: 微软雅黑;
	margin-top: 0;
	margin-left: 0;
	float: right;
	position: absolute;
	top: 50px;
	left: 0;
	z-index: 99;
}

.menu-items {
	display: inline-block;
	width: 16.5%;
	vertical-align: top;
	line-height: 30px;
	overflow: visible;
	text-align: center;
	background-color: rgba(100, 100, 150, 0.9);
	border: 1px solid #CCC;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	float: left;
	z-index: 999;
}

.menu-head {
	display: inline-block;
	width: 100%;
	z-index: 999;
}

.menu-body {
	background-color: rgba(90, 70, 150, 0.7);
	border: 1px solid #CCC;
	-webkit-border-bottom-right-radius: 4px;
	-webkit-border-bottom-left-radius: 4px;
	-moz-border-bottom-right-radius: 4px;
	-moz-border-bottom-left-radius: 4px;
	border-bottom-right-radius: 4px;
	border-bottom-left-radius: 4px;
	display: none;
	z-index: 999;
}

.has_childs {
	font-size: 15px;
	line-height: 30px;
	height: 30px;
	text-align: left;
	width: 100%;
	display: block;
	padding-left: 10px;
	padding-bottom: 5px;
	z-index: 1001;
}

.has_childs:hover ul {
	display: block;
	list-style: none;
}

.has_childs ul {
	background-color: rgba(90, 70, 150, 0.8);
	border: 1px solid aliceblue;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	display: none;
	list-style: none;
	position: relative;
	top: -35px;
	z-index: 9999;
	overflow: hidden;
}

.has_childs ul li {
	padding-left: 10px;
}

.child_escape {
	float: right;
	margin-right: 15px;
	color: ghostwhite;
	font-size: 18px;
}

.head-link {
	color: white;
	font-size: 20px;
	font-weight: 500;
	font-family: 华文新魏;
}

.head-link:hover {
	color: orange;
}

.menu-links {
	font-size: 15px;
	line-height: 40px;
	text-align: left;
	display: block;
	width: 100%;
	padding-left: 10px;
}

.link-content {
	text-decoration: none;
	color: white;
	font-size: 17px;
	font-weight: 500;
	line-height: 40px;
	font-family: "Vrinda", "华文细黑";
}

.link-content:hover {
	color: orange;
}

.gragh-show {
	padding-top: 5px;
}

.system-title {
	color: #FFFFFF;
	font-size: 20pt;
	font-weight: 600;
	text-decoration: none;
	font-family: 微软雅黑;
}

.navbar {
	*position: relative;
	*z-index: 0;
	margin-bottom: 20px;
	overflow: visible;
}

.navbar-inner {
	background-color: rgba(80, 70, 110, 0.90);
}

.navbar-top {
	position: fixed;
	right: 0;
	left: 0;
	z-index: 0;
	top: 0;
}

.brand {
	color: #D5D5D5;
	float: left;
	line-height: 45px;
}

.icon-chart {
	background: url("<%=basePath%>/images/icon-chart.png") no-repeat;
	width: 41px;
	height: 33px;
	display: block;
	float: left;
	margin-right: 10px;
	margin-top: 8px;
}

.right-top {
	font-size: 16px;
	text-align: right;
	line-height: 50px;
	color: azure;
	font-family: 微软雅黑;
}

.float_div {
	display: none;
	position: fixed;
	top: 15%;
	left: 10%;
	width: 80%;
	height: 70%;
	border: 1px solid skyblue;
	background-color: rgb(250, 250, 210);
	z-index: 1002;
	-webkit-border-radius: 8px;
	-moz-border-radius: 8px;
	border-radius: 8px;
	margin: 0;
}

.float_head {
	height: 30px;
	line-height: 30px;
	text-align: right;
	padding-right: 8px;
	background-color: rgba(70, 150, 200, 0.9);;
	-webkit-border-top-left-radius: 7px;
	-webkit-border-top-right-radius: 7px;
	-moz-border-top-left-radius: 7px;
	-moz-border-top-right-radius: 7px;
	border-top-left-radius: 7px;
	border-top-right-radius: 7px;
}

.float_head span {
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 15px;
	text-decoration: none;
	color: ghostwhite;
}

.float_foot {
	height: 30px;
	line-height: 30px;
	text-align: left;
	padding-left: 8px;
	background-color: rgba(70, 150, 200, 0.9);;
	-webkit-border-bottom-left-radius: 7px;
	-webkit-border-bottom-right-radius: 7px;
	-moz-border-bottom-left-radius: 7px;
	-moz-border-bottom-right-radius: 7px;
	border-bottom-left-radius: 7px;
	border-bottom-right-radius: 7px;
}

.float_foot span {
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 15px;
	text-decoration: none;
	color: ghostwhite;
}

#float_body .main_table {
	border-collapse: collapse;
	border: none;
}

#float_body .main_table th {
	border: 1px solid #CCC;
	background-color: rgb(180, 200, 210);
	font-family: 微软雅黑;
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	border-radius: 0;
}

#float_body .main_table td {
	border: 1px solid #CCC;
	background-color: floralwhite;
	font-family: 微软雅黑;
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	border-radius: 0;
}
</style>