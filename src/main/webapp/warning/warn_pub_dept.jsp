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

	function set_default_date(){
		var now = new Date();
		var begin = new Date(now);
		begin.setMonth(now.getMonth() - 1);
		var end_date = now.format("yyyy-MM-dd");
		var begin_date = begin.format("yyyy-MM-dd");

		$("#start_date").val(begin_date);
		$("#end_date").val(end_date);
	};

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

.gragh-title{
	height: 80px;
	line-height: 50px;
	text-align: center;
	font-family: 微软雅黑;
	font-size: 18px;
}

.title-div{
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
	padding: 0 !important;
	background-color: rgb(250, 250, 210);
}
</style>
</head>

<body>
	<div class="title-div">
		<span class="label-text">开发部门</span>
		<select class="select" style="width:15%" id="dev_dept" onchange="list_data();"></select>

		<span class="label-text">下发时间 起</span>
		<input class="cal-editor" type="text" id="start_date" maxlength="10"
				onclick="new Calendar().show(this);" onchange="list_data();" readonly="readonly">

		<span class="label-text">止</span>
		<input class="cal-editor" type="text" id="end_date" maxlength="10"
				onclick="new Calendar().show(this);" onchange="list_data();" readonly="readonly">
	</div>
</body>
</html>