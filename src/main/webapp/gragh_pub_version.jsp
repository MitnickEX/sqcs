<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>质量技术支持平台</title>

<script type="text/javascript">
	function get_dev_dept(defaults) {
		$('#dev_dept').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_dept',
			dataType : 'JSON',
			success : function(teamResult) {
				teams = eval(teamResult);

				for ( var x = 0; x < teams.length; x++) {
					var team = teams[x];
					if (defaults == team) {
						$('#dev_dept').append("<option selected=\"selected\" value=" + team + ">" + team + "</option>");
					} else {
						$('#dev_dept').append("<option value=" + team + ">" + team + "</option>");
					}
				}
			}
		});
	};

	function get_test_team(defaults) {
		$('#test_team').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_test_team',
			dataType : 'JSON',
			success : function(teamResult) {
				teams = eval(teamResult);

				for ( var x = 0; x < teams.length; x++) {
					var team = teams[x];
					if (defaults == team) {
						$('#test_team').append("<option selected=\"selected\" value=" + team + ">" + team + "</option>");
					} else {
						$('#test_team').append("<option value=" + team + ">" + team + "</option>");
					}
				}
			}
		});
	};

	function get_version() {
		$('#version').get(0).options.length = 0;

		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(),true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(),true);
		}

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_versions',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(),true),
				"group_name" : group_name,
				"time_type" : decodeURIComponent($("#time_type").val(), true),
				"pro_date_begin" : decodeURIComponent($("#pro_date_begin").val(), true),
				"pro_date_end" : decodeURIComponent($("#pro_date_end").val(), true)
			},
			success : function(json) {
				versions = eval(json);
				for ( var y = 0; y < versions.length; y++) {
					var version = versions[y];
					$('#version').append("<option value=" + version + ">" + version + "</option>");
				}
			}
		});
	};

	function set_default_date() {
		var now = new Date();
		var begin = new Date(now);
		begin.setMonth(now.getMonth() - 1);
		var end_date = now.format("yyyy-MM-dd");
		var begin_date = begin.format("yyyy-MM-dd");

		$("#pro_date_begin").val(begin_date);
		$("#pro_date_end").val(end_date);
	};

	function check_obtain() {
		if ($("#test_team").val().indexOf("无分组归属") > -1) {
			$("#table_body").remove();
			alert("不支持无分组归属的系统信息查询!");
			return false;
		} else {
			list_data();
		}
	};

	function query_org(){
		if ($("#group_type").val() == 'test_team') {
			$("#test_team").show();
			$("#dev_dept").hide();
			get_test_team();
			get_version();
		} else {
			$("#dev_dept").show();
			$("#test_team").hide();
			get_dev_dept();
			get_version();
		}
	};

	$(function() {
		set_default_date();
	});
</script>

<style>
.select {
	margin-bottom: 0;
	font-family: 微软雅黑;
	font-size: 15px;
	width: 160px;
	background-color: rgba(133, 213, 240, 0.3);
	border: 1px solid #ccc;
	height: 30px;
	line-height: 30px;
	display: inline-block;
	padding: 4px 6px;
	color: #555;
	vertical-align: middle;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	font-weight: normal;
	cursor: pointer;
	margin-right: 5px;
}

.gragh-title {
	height: 80px;
	line-height: 50px;
	text-align: center;
	font-family: 微软雅黑;
	font-size: 18px;
}

.title-div {
	height: 80px;
	line-height: 60px;
}

.cal-editor {
	width: 110px !important;
	font-size: 15px;
	font-weight: 500;
	font-family: 微软雅黑;
	background-color: rgba(133, 213, 240, 0.3);
	border: 1px solid #CCC;
	height: 25px;
	color: #555;
	line-height: 25px;
	text-align: center;
	margin: 0 !important;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	vertical-align: middle;
	margin-right: 5px;
}

.label-text {
	height: 30px;
	line-height: 30px;
	vertical-align: middle;
	font-size: 16px;
	font-weight: 500;
	font-family: 微软雅黑;
	color: darkslategray;
	margin-right: 5px;
}

body {
	padding: 0;
	background-color: rgb(250, 250, 210);
}
</style>
</head>

<body>
	<div class="title-div">
		<span class="label-text">查询组织</span>
		<select class="select" style="width:8%" id="group_type" onchange="query_org();check_obtain();">
			<option value="test_team">测试分组</option>
			<option value="dev_dept">开发部门</option>
		</select>

		<select class="select" style="width:15%; display:none;" id="dev_dept" onchange="check_obtain(); get_version();"></select>
		<select class="select" style="width:15%;" id="test_team" onchange="check_obtain(); get_version();"></select>

		<select class="select" style="width:8%" id="time_type" onchange="check_obtain(); get_version()">
			<option value="release" selected="selected">下发</option>
			<option value="handover">移交</option>
		</select>
		<span class="label-text">起</span>
		<input class="cal-editor" type="text" id="pro_date_begin" maxlength="10" onclick="new Calendar().show(this);"
			onchange="get_version();list_data();" readonly="readonly">
		<span class="label-text">止</span>
		<input class="cal-editor" type="text" id="pro_date_end" maxlength="10" onclick="new Calendar().show(this);"
			onchange="get_version();list_data();" readonly="readonly">
		<span class="label-text">版本</span>
		<select class="select" style="width: 15%" id="version" name="version" onchange="check_obtain();"></select>
	</div>
</body>
</html>