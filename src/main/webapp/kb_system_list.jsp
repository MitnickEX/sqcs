<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3.org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<%@ include file="kb.jsp"%>
<%@ include file="list_style.jsp"%>

<head>
<title>质量技术支持平台</title>
<script type="text/javascript">
	function system_list() {
		$.ajax({
			async : true,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/sys_info_query',
			data : {
				"test_team" : decodeURIComponent($("#test_team").val()),
				"dev_dept" : decodeURIComponent($("#dev_dept").val()),
				"system" : decodeURIComponent($("#system").val()),
				"is_valid" : decodeURIComponent($("#is_valid").val())
			},
			success : function(result) {
				$("#table_body").remove();

				var htmler = "<div id='table_body' style='overflow:auto; height:200px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "没有查询到符合条件的信息";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='10' style='text-align:center; color:darkgreen; font-size: 20px;'>" + message + "</td>";
					htmler += "</tr>";

					htmler += "</table></div>";
					$("#container").append(htmler);
					return;
				}

				for ( var i = 0; i < result.length; i++) {
					var jData = result[i];
					htmler += "<tr style='height: 25px;'>";
					htmler += "<td align='center' style='width:70px;'>";
					var params = "dev_dept;" + jData.dev_dept + ";system_alias;" + jData.system_alias;
					var url = "envinfo/system_info_detail.jsp";
					var target = "_blank";
					htmler += "<a href='javascript:void(0)' name = 'url_handle' onclick = 'url_handle(\"" + url + "\",\"" + params + "\",\"" + target + "\")'>信息维护</a>";
					htmler += "</td>";
					htmler += "<td style='width: 150px'>" + jData.system_alias + "</td>";
					if (jData.version_count != "0") {
						htmler += "<td style='width: 70px' align='center'><a href='javascript:void(0)' name = 'show_version' onclick='show_version(\"" + $("#test_team").val() + "\",\"" + jData.system_alias + "\")'>" + jData.version_count + "</a></td>";
					} else {
						htmler += "<td style='width: 70px' align='center'>0</td>";
					}

					htmler += "<td style='width:150px'>" + jData.dev_dept + "</td>";
					htmler += "<td style='width:150px'>" + jData.dev_team + "</td>";
					htmler += "<td style='width:150px'>" + jData.test_dept + "</td>";
					htmler += "<td style='width:150px'>" + jData.test_team + "</td>";
					htmler += "<td style='width:160px; word-break:break-all;'>" + jData.dever + "</td>";
					htmler += "<td style='width:160px; word-break:break-all;'>" + jData.tester + "</td>";
					htmler += "<td style='word-break:break-all;'>" + jData.system_name + "</td>";

					htmler += "</tr>";
				}

				htmler += "</table></div>";
				$("#container").append(htmler);
				div_height("table_body");
				show_transfer("#table_body a[name=show_version]", "float_div");
			}
		});
	};
	
	function show_version(test_team, system_alias) {
		$("#float_div").css('display', "block");
		var height = $("#float_div").height() - $("#float_table").height() - 60;
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/version_info',
			data : {
				"system" : decodeURIComponent(system_alias, true),
				"test_team" : decodeURIComponent(test_team, true)
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "目前没有在测版本";
					htmler += "<tr style='height: 30px;'>";
					htmler += "<td colspan='8' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jsonData = result[i];
						var params = "system_version;" + jsonData.system_version;
						var url = "kb_warning_list.jsp";
						var target = "_blank";
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='text-align:center; width: 190px;'>" + jsonData.system_version + "</td>";
						htmler += "<td style='text-align:center; width: 100px;'>" + jsonData.version_type + "</td>";
						htmler += "<td style='text-align:center; width: 60px;'>" + jsonData.sr_count + "</td>";
						htmler += "<td style='text-align:center; width: 60px;'>" + jsonData.bug_count + "</td>";
						htmler += "<td style='text-align:center; width: 100px;'><a href='javascript:void(0)' name = 'url_handle' onclick = 'url_handle(\"" + url + "\",\"" + params + "\",\"" + target + "\")'>" + jsonData.warn_count + "</a></td>";
						htmler += "<td style='text-align:center; width: 120px;'>" + jsonData.first_handover_test_time + "</td>";
						htmler += "<td style='text-align:center; width: 120px;'>" + jsonData.reviewtest_end_date + "</td>";
						htmler += "<td style='word-break:break-all;'>" + jsonData.environment + "</td>";
						htmler += "</tr>";
					}
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
			}
		});
		float_autofit();
	};

	function get_dept() {
		$('#dev_dept').get(0).options.length = 0;
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_dept',
			success : function(deptResult) {
				depts = eval(deptResult);
				$('#dev_dept').append("<option selected='selected' value='unknown'>@_@ 臣妾不知道啊 @_@</option>");
				for ( var x = 0; x < depts.length; x++) {
					var dept = depts[x];
					$('#dev_dept').append("<option value=" + dept + ">" + dept + "</option>");
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

	function set_system_input() {
		if ($("#dev_dept").val() == 'unknown') {
			$("#table_body").remove();
			$("#system").show();
			$("#system_label").show();
			$("#system").val("3个字符以上可支持右模糊查询");
		} else {
			clear_input();
			$("#system").hide();
			$("#system_label").hide();
			system_list();
		}
	};

	function hide() {
		$("#float_div").hide();
	};

	function float_autofit() {
		var div_height = $("#float_div").height();
		$("#float_body").height(div_height - 60);
	};

	function clear_input() {
		$("#system").val("");
	};

	function check_unobtain() {
		var test_team = $("#test_team").val();
		if (test_team.indexOf("测试组") > -1) {
			$("#dev_dept_label").hide();
			$("#dev_dept").hide();
			clear_input();
			$("#system").hide();
			$("#system_label").hide();
			system_list();
		} else {
			$("#dev_dept_label").show();
			$("#dev_dept").show();
			get_dept();
			$("#table_body").remove();
		}
	};

	$(function() {
		get_test_team('无分组归属');
		$("#dev_dept_label").hide();
		$("#dev_dept").hide();
		check_unobtain();
	});
</script>
</head>

<body>

<body>
	<div class="title-div">
		<span class="label-text">测试分组</span>
		<select class="select" style="width: 15%" id="test_team" onchange="check_unobtain();"></select>

		<span class="label-text" id="dev_dept_label">开发部门</span>
		<select class="select" id="dev_dept" style="width: 20%" onchange="set_system_input();"></select>

		<span class="label-text" id="system_label" style="display:none;">子系统</span>
		<input type="text" id="system" class="editor" value="3个字符以上可支持右模糊查询" style="width: 15%; height:26px; text-align:center;" onclick="clear_input()">

		<span class="label-text" id="is_valid_label">是否有效</span>
		<select class="select" id="is_valid" style="width: 5%" onchange="system_list();">
			<option value="Y" selected="selected">Y</option>
			<option value="N">N</option>
		</select>

		<input type="button" value="查询" class="buttons" onClick="system_list();">
	</div>

	<div id="float_div" class="float_div">
		<div id="float_head" class="float_head">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
		<div id="float_body">
			<table class='main_table' id='main_table'>
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='190px'>版本号</th>
					<th width='100px'>版本类型</th>
					<th width='60px'>需求数</th>
					<th width='60px'>缺陷数</th>
					<th width='100px'>累计异常数</th>
					<th width='120px'>首移时间</th>
					<th width='120px'>封版时间</th>
					<th>部署环境</th>
				</tr>
			</table>
		</div>
		<div id="float_foot" class="float_foot" onclick="hide();">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
	</div>

	<div id="container" style="min-width: 100%; ">
		<table border=1 class='main_table' id='main_table'>
			<tr style='height: 40px; font-size: 18px; font-weight: 600;'>
				<td colspan='10' class='thead'>系统信息</td>
			</tr>

			<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
				<th align='center' width='70px'>操作</th>
				<th align='center' width='150px' sortType='string'>子系统简称</th>
				<th align='center' width='70px' sortType='num'>在测版本</th>
				<th align='center' width='150px' sortType='string'>开发部门</th>
				<th align='center' width='150px' sortType='string'>开发分组</th>
				<th align='center' width='150px' sortType='string'>测试部门</th>
				<th align='center' width='150px' sortType='string'>测试分组</th>
				<th align='center' width='160px' sortType='string'>开发负责人</th>
				<th align='center' width='160px' sortType='string'>测试负责人</th>
				<th align='center' sortType='string'>子系统名称</th>
			</tr>
		</table>
	</div>
</body>
</html>