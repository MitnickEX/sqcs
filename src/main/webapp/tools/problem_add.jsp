<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3.org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
<link href="images/favicon.ico" type="image/x-icon" rel="icon" />
<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
<title>问题上报</title>
</head>

<%@ include file="problem_pub.jsp"%>
<%@ include file="../pub_root.jsp"%>

<script type="text/javascript">
	var oper_seq = 0;

	function submit_data() {
		$("#float_tr").remove();

		var pro_summary = $("#pro_summary").val();
		var pro_source = $("#pro_source").val();
		var pro_version = $("#version").val();
		var pro_owner;
		if (pro_source == "用户验收测试问题" || pro_source == "开发测试缺陷"){
			pro_owner = $("#owner").val();
		} else {
			pro_owner = $("#pro_owner").val();
		}

		var pro_finder = '<%=userName%>';
		if (pro_finder == 'null' || pro_finder == 'undefined'){
			pro_finder = '';
		}
		var pro_detail = $("#pro_detail").val();

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/problem_add',
			data : {
				"pro_summary" : pro_summary,
				"pro_source" : pro_source,
				"pro_version" : pro_version,
				"pro_finder" : pro_finder,
				"pro_owner" : pro_owner,
				"pro_detail" : pro_detail,
				"pro_attach" : oper_seq
			},
			success : function(result) {
				alert(result);

				if (null == result || result == "") {
					message = '新增记录失败，请检查数据！';
				} else{
					if (pro_source == 'uat'){
						message = '上报问题成功，3秒之后自动刷新，您可以继续上报问题！';
					} else {
						message = '新增记录成功，3秒之后自动跳转到明细查询页面！';
					}
					redirect(message, result);
				}
			}
		});
	};

	function del_attach(fileId) {
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/delete_attach',
			data : {
				"file_id" : fileId
			}
		});
		get_attach(oper_seq, true);
	};

	function redirect(message, pro_id) {
		var htmler = "<tr style=\"width: 100%; font-size: 20px; height: 50px; display: table-row;\" id=\"float_tr\">";
		htmler += "<td style=\"text-align: center; color: red;\" colspan=\"2\">" + message + "</td></tr>";

		$("#info_table").append(htmler);
		var url = 'problem_fix.jsp?pro_id=' + pro_id;
		setTimeout("jumpurl('"+ url + "')",3000);
	};

	function jumpurl(url){
		window.location.href = url;
	};

	function source_choose(){
		var choice = $("#pro_source").val();
		if (choice == "用户验收测试问题" || choice == "开发测试缺陷"){
			$("#version_info").show();
			$("#owner").show();
			$("#pro_owner").hide();
			get_test_team();
			get_version();
			get_responser();
		} else{
			$("#version_info").hide();
			$("#owner").hide();
			$("#pro_owner").show();
		}
	};

	function file_upload(){
		$("#float_div").show();
		$("#attachment").attr("src",'file_upload.jsp?oper_seq=' + oper_seq);
		upload_autofit();
	};

	var random_num = function (min, max) {
		var range = max - min;
		var rand = Math.random();
		return(min + Math.round(rand * range));
	};

	function hide_upload(){
		$("#float_div").hide();
		get_attach(oper_seq, true);
	};

	function upload_autofit(){
		var div_height = $("#float_div").height();
		$("#float_body").height(div_height - 55);
	};

	$(function() {
		get_pro_source('质量控制系统问题');
		source_choose();
		oper_seq = new Date().Format("yyyyMMddHHmmssS") + random_num(10000000, 99999999);
		get_attach(oper_seq, true);
	});
</script>

<style>
.frames {
	width:100%;
	height:100%;
}

.float_div {
	display: none;
	position: absolute;
	top: 20%;
	left: 20%;
	width: 60%;
	height: 55%;
	border: 1px solid darkseagreen;
	background-color: rgb(250, 250, 210);
	z-index: 1002;
	-webkit-border-radius: 8px;
	-moz-border-radius: 8px;
	border-radius: 8px;
	margin: 0;
}

.float_head {
	height: 25px;
	line-height: 25px;
	background-color: darkseagreen;
	-webkit-border-top-left-radius: 7px;
	-webkit-border-top-right-radius: 7px;
	-moz-border-top-left-radius: 7px;
	-moz-border-top-right-radius: 7px;
	border-top-left-radius: 7px;
	border-top-right-radius: 7px;
}

.float_foot {
	height: 30px;
	line-height: 30px;
	background-color: darkseagreen;
	-webkit-border-bottom-left-radius: 7px;
	-webkit-border-bottom-right-radius: 7px;
	-moz-border-bottom-left-radius: 7px;
	-moz-border-bottom-right-radius: 7px;
	border-bottom-left-radius: 7px;
	border-bottom-right-radius: 7px;
}

.float_head a{
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 15px;
	float: right;
	text-decoration: none;
	color: #000;
	padding: 0 5px 5px 0;
}

a{
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 15px;
	text-decoration: none;
}
</style>

<body>
	<div id="float_div" class="float_div">
		<div id="float_head" class="float_head">
			<a href="javascript:void(0);" onclick="hide_upload();">关闭</a>
		</div>
		<div id="float_body">
			<iframe src="" frameborder="0" id="attachment" class="frames"></iframe>
		</div>
		<div id="float_foot" class="float_foot">
		</div>
	</div>

	<table border="1" cellpadding="3" cellspacing="0" class="main_table" id="info_table">
		<tr style="width: 100%; font-size: 22px; font-weight: 600;">
			<th align="center" colspan="2">问题上报</th>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">问题概述<font class="not-null">*</font></td>
			<td style="width: 80%" id="pro_summary_td">
				<input class="editor" type="text" id="pro_summary" value="">
			</td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">问题来源</td>
			<td style="width: 80%" id="pro_source_td">
				<select class="select" style="width: 25%" id="pro_source" onchange="source_choose()"></select>
			</td>
		</tr>
		<tr id="version_info">
			<td align="right" class="keys" align="right">系统/版本</td>
			<td style="width: 80%" id="pro_version_td">
				<select class="select" style="width: 25%" id="test_team" onchange="get_version(); get_responser()"></select>
				<select class="select" style="width: 25%" id="version"></select>
			</td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">建议处理人<font class="not-null">*</font></td>
			<td style="width: 80%" id="owner_td">
				<select class="select" style="width: 25%" id="owner"></select>
				<input class="editor" style="width: 24.35% !important; display: none" type="text" id="pro_owner" value="">
			</td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">详细信息</td>
			<td style="width: 80%" id="pro_detail_td">
				<textarea class="editor" style="height: 150px;" id="pro_detail"></textarea>
			</td>
		</tr>
		<tr id="float_tr" style="display: none;"></tr>
	</table>
	<br>

	<table border="1" cellpadding="3" cellspacing="0" class="main_table" id="attach_table">
	</table>
	<br>

	<div style="float: right;">
		<input class="buttons" type="button" id="reset" value="重置" onclick="reset();">
		<input class="buttons" type="button" id="upload" value="上传附件" onclick="file_upload();">
		<input class="buttons" type="button" id="save_data" value="保存" onclick="return commitCheck();">
		<input class="buttons" type="button" value="返回" id="goback" onclick="closeWindow();">
	</div>
</body>

</html>
