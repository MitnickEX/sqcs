<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3.org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<%@ include file="kb.jsp"%>
<%@ include file="tools/problem_pub.jsp"%>

<head>
<title>质量技术支持平台</title>
<script type="text/javascript">
	function list_data() {
		var pro_source = $("#pro_source").val();
		var pro_status = $("#pro_status").val();
		var pro_date_begin = $("#pro_date_begin").val();
		var end_date = $("#pro_date_end").val();
		var pro_date_end = addDays(end_date, 1);

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/problem_list',
			data : {
				"pro_source" : pro_source,
				"pro_status" : pro_status,
				"pro_date_begin" : pro_date_begin,
				"pro_date_end" : pro_date_end
			},
			success : function(result) {
				$("#table_body").remove();

				var htmler = "<div id='table_body' style='overflow:auto; height:200px;'><table class='main_table'>";

				if (result.length == 0) {
					var message = "暂无【" + $("#pro_status").val() + "】状态的问题";
					htmler += "<tr style='height: 30px;'>";
					htmler += "<td colspan='5' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var pro_id = result[i].pro_id;
						var pro_status = result[i].status_desc;
						var pro_summary = result[i].pro_summary;
						var real_fixer = result[i].real_fixer;
						var create_date = result[i].create_date;
						var params = "pro_id;" + pro_id;
						var url = "tools/problem_fix.jsp";
						var target = "_blank";
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td align='center' width='80px'>" + pro_id + "</td>";
						htmler += "<td align='center' width='120px'>" + pro_status + "</td>";
						htmler += "<td align='center' width='115px'>";
						htmler += "<a href='javascript:void(0)' name = 'url_handle' onclick = 'url_handle(\"" + url + "\",\"" + params + "\",\"" + target + "\")'>明细 & 处理</a>";
						htmler += "</td>";
						htmler += "<td align='center' width='120px'>" + real_fixer + "</td>";
						htmler += "<td align='center' width='180px'>" + create_date + "</td>";
						htmler += "<td>" + pro_summary + "</td>";
						htmler += "</tr>";
					};
				}

				htmler += "</table></div>";
				$("#container").append(htmler);
				div_height("table_body");
			}
		});
	};

	function set_default_date(){
		var now = new Date();
		var begin = new Date(now);
		begin.setMonth(now.getMonth() - 1);
		var end_date = now.format("yyyy-MM-dd");
		var begin_date = begin.format("yyyy-MM-dd");

		$("#pro_date_begin").val(begin_date);
		$("#pro_date_end").val(end_date);
	};

	$(function() {
		get_pro_source('质量控制系统问题');
		get_pro_status('待处理');
		set_default_date();
		list_data();
	});
</script>
</head>

<body>
	<div class="title-div">
		<span class="label-text">问题来源：</span> <select class="select" id="pro_source" name="pro_source" onchange="list_data();">
		</select>
		<span class="label-text">问题状态：</span> <select class="select" id="pro_status" name="pro_status" onchange="list_data();">
		</select>
		<span class="label-text">上报起</span>
			<input class="cal-editor" type="text" id="pro_date_begin" name="pro_date_begin" maxlength="10"
				onclick="new Calendar().show(this);" onchange="list_data()" readonly="readonly">
		<span class="label-text">上报止</span>
			<input class="cal-editor" type="text" id="pro_date_end" name="pro_date_end" maxlength="10"
				onclick="new Calendar().show(this);" onchange="list_data()" readonly="readonly">
		<input type="button" value="查询" class="buttons" onClick="list_data()" style="width: 80px !important">
		<input type="button" value="上报问题" class="buttons" onClick="window.open('./tools/problem_add.jsp')">
	</div>

	<div id="container" style="min-width: 100%; ">
		<table border=1 class='main_table' id='main_table'>
			<tr style='height: 40px; font-size: 18px; font-weight: 600;'>
				<th colspan='6' class='thead'>系统信息</th>
			</tr>
			<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
				<th align='center' width='80px' sortType='num'>问题编号</th>
				<th align='center' width='120px' sortType='string'>问题状态</th>
				<th align='center' width='115px' sortType='string'>操作</th>
				<th align='center' width='120px' sortType='string'>处理人</th>
				<th align='center' width='180px' sortType='date'>上报时间</th>
				<th align='center' sortType='string'>问题概述</th>
			</tr>
		</table>
	</div>
</body>
</html>