<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3.org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<style>
* {
	text-shadow: none;
	font-family: Arial, 微软雅黑;
}

body {
	background-color: rgb(250, 250, 210);
}

.gragh-title{
	height: 80px;
	line-height: 50px;
	text-align: center;
	font-family: 微软雅黑;
	font-size: 18px;
}

.tips {
	height: 40px;
	line-height: 40px;
	text-align:center;
}

.main_table {
	width: 100%;
	border: 1px solid #CCC;
	font-size: 15px;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	margin: 0;
	border-spacing: 1px;
}

.detail-list {
	width: 100%;
	font-size: 17px;
	font-weight: 500;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}

.editor {
	height: 22px;
	line-height: 22px;
	width: 99%;
	font-size: 15px;
	font-weight: 500;
	font-family: 微软雅黑;
	background-color: rgba(133, 213, 240, 0.3);
	border: 1px solid #CCC;
	padding: 2px 0 0 6px;
	color: #555;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	vertical-align: middle;
}

.editor:disabled {
	background-color: cornsilk;
}

.cal-editor {
	width: 110px !important;
	font-size: 15px;
	font-weight: 500;
	font-family: 微软雅黑;
	background-color: rgba(133, 213, 240, 0.3);
	border: 1px solid #CCC;
	height: 25px;
	line-height: 25px;
	color: #555;
	text-align: center;
	margin: 0;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	vertical-align: middle;
	margin-right: 5px;
}

.keys {
	width: 20%;
	font-size: 16px;
	font-weight: 600;
	font-family: 微软雅黑;
}

.buttons {
	background-color: rgba(95, 125, 190, 0.8);
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	width: 100px !important;
	height: 30px;
	cursor: pointer;
	text-align: center;
	font-size: 15px;
	font-weight: 600;
	font-family: 微软雅黑;
	color: ghostwhite;
}

.buttons:hover {
	background-color: rgba(105, 105, 165, 1);
}

.buttons:active {
	background-color: rgba(105, 105, 165, 0.5);
}

.buttons:disabled {
	background-color: rgba(45, 52, 60, 0.5);
}

.not-null {
	color: red;
}

.label-text {
	height: 30px;
	line-height: 30px;
	vertical-align: middle;
	font-size: 17px;
	font-weight: 500;
	font-family: 微软雅黑;
	color: darkslategray;
	margin-right: 5px;
}

.select {
	margin-bottom: 0;
	font-family: 微软雅黑;
	font-size: 15px;
	width: 180px;
	height: 30px;
	line-height: 30px;
	display: inline-block;
	padding: 2px 6px;
	color: #555;
	vertical-align: middle;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	font-weight: normal;
	cursor: pointer;
	margin: 0;
	border: 1px solid #CCC;
	background-color: rgba(133, 213, 240, 0.3);
	margin-right: 5px;
}

.select-mini {
	font-family: 微软雅黑;
	font-size: 15px;
	width: 120px;
	background-color: rgba(133, 213, 240, 0.3);
	border: 1px solid #ccc;
	height: 23px;
	line-height: 23px;
	display: inline-block;
	color: #555;
	vertical-align: middle;
	font-weight: normal;
	cursor: pointer;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	margin-right: 5px;
}

.title-div {
	height: 80px;
	line-height: 60px;
}

td {
	border: 1px solid #CCC;
	font-family: Verdana, 黑体;
	font-weight: 500;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	background-color: floralwhite;
}

th {
	border: 1px solid #CCC;
	background-color: rgba(190, 190, 190, 0.8);
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	font-family: 微软雅黑;
	cursor: pointer;
}

.thead {
	text-align: center;
	border: 1px solid #CCC;
	background-color: rgba(150, 145, 180, 0.8);
	color: white;
}

a {
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 15px;
	text-decoration: none;
}
</style>
