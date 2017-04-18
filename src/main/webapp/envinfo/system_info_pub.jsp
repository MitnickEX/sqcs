<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="images/favicon.ico" type="image/x-icon" rel="icon" />
<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />

<style>
* {
	text-shadow: none;
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

.main_list {
	width: 100%;
	border: none;
	font-size: 15px;
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
	width: 99%;
	font-size: 16px;
	font-weight: 500;
	font-family: 微软雅黑;
	background-color: rgba(133, 213, 240, 0.3);
	border: 1px solid #CCC;
	padding: 2px 0 0 6px;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	color: #555;
	vertical-align: middle;
}

.editor:disabled {
	background-color: cornsilk;
}

.keys {
	width: 20%;
	font-size: 17px;
	font-weight: 600;
	font-family: 微软雅黑;
}

.buttons {
	background-color: rgba(95, 125, 190, 0.8);
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	width: 100px;
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

.fontRed {
	color: red;
}

.label-text {
	height: 30px;
	line-height: 30px;
	vertical-align: middle;
	font-size: 18px;
	font-weight: 500;
	font-family: 微软雅黑;
	margin-right: 5px;
}

.select {
	margin-bottom: 0;
	font-family: 微软雅黑;
	font-size: 15px;
	width: 220px;
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

.select:disabled {
	background-color: cornsilk;
}

.title-div {
	height: 80px;
	line-height: 60px;
}

body {
	background-color: rgb(250, 250, 210);
}

td {
	border: 1px solid #CCC;
	font-family: Arial, 微软雅黑;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	background-color: floralwhite;
	word-wrap: break-word;
	font-size: 16px;
}

th {
	border: 1px solid #CCC;
	background-color: rgba(190, 190, 190, 0.8);
	font-family: 微软雅黑;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}

.thead {
	text-align: center;
	border: 1px solid #CCC;
	background-color: rgba(150, 145, 180, 0.8);
	color: lightyellow;
}

.module_name {
	height: 20px;
	line-height: 20px;
	vertical-align: middle;
	color: darkseagreen;
}

.delete_img {
	height: 18px;
	line-height: 18px;
	margin-left:2px;
	margin-right:8px;
	cursor:pointer;
	vertical-align: middle;
}

#left-content {
	width: 100%;
	clear: both;
}

#left-content ul {
	list-style-type: none;
	text-align: left;
	list-style-type: none;
	height: 20px;
	line-height: 20px;
	padding: 2px 0 0 6px;
}

#left-content ul li {
	float: left;
	display: inline;
}
</style>

<script type="text/javascript">
	function closeWindow() {
		window.opener = null;
		window.open('', '_self');
		window.close();
	};

	function reset() {
		var elements = $(".editor");
		var element;
		for ( var i = 0; i < elements.length; i++) {
			element = elements.eq(i);
			if (element[0].tagName != "select" && element[0].tagName != "SELECT") {
				element.val("");
			}
		}
	};

	function clearWarn(className, currentElement) {
		var elements = $("." + className);
		for ( var i = 0; i < elements.length; i++) {
			var element = elements.eq(i);
			if (element != currentElement) {
				element.css("borderStyle", "solid");
				element.css("borderWidth", "thin");
				element.css("borderColor", "#CCC");
			}
		}
	};

	function setWarn(className, currentElement) {
		clearWarn(className, currentElement);
		currentElement.focus();
		currentElement.css("borderColor", "red");
		currentElement.css("borderWidth", "medium");
		currentElement.css("borderStyle", "dashed");
	};

	function beginEdit() {
		var old_dev_dept = $("#dev_dept").val();
		var old_dev_team = $("#dev_team").val();
		var old_test_dept = $("#test_dept").val();
		var old_test_team = $("#test_team").val();
		var old_dever = $("#dever").val();
		var old_tester = $("#tester").val();

		var elements = $(".editor");
		for ( var i = 0; i < elements.length; i++) {
			var element = elements.eq(i);
			if (element.attr("id").indexOf("system_alias") == -1 && element.attr("id").indexOf("system_name") == -1) {
				element.removeAttr("disabled");
			}
		}

		var selements = $(".select");
		for ( var i = 0; i < selements.length; i++) {
			selements.eq(i).removeAttr("disabled");
		}
		var checkements = $("input:checkbox");
		for ( var i = 0; i < checkements.length; i++) {
			checkements.eq(i).removeAttr("disabled");
		}

		get_dev_dept(old_dev_dept);
		get_dev_team(old_dev_team);
		get_test_dept(old_test_dept);
		get_test_team(old_test_team);

		$("#float_tr").remove();
		$("#save_data").removeAttr("disabled");
		$("#module_define").removeAttr("disabled");
		$("#begin_edit").attr('disabled', "true");
	};

	function endEdit() {
		$("#save_data").attr('disabled', "true");
		$("#begin_edit").removeAttr("disabled");
	};

	var commitCheck = function() {
		var dever = $("#dever");
		var tester = $("#tester");
		var assistants = $("#assistants");
		var case_source = $("#case_source");
		var reg = /^[a-zA-Z0-9,-;]+$/;

		if (dever.val() == "" || dever.val() == null) {
			clearWarn("editor", dever);
			setWarn("editor", dever);
			return false;
		} else if (dever.val().length > 100) {
			alert("【开发负责人】长度不允许超过 100 位，请修改：" + dever.val());
			clearWarn("editor", dever);
			setWarn("editor", dever);
			return false;
		} else if (reg.test(dever.val()) == false) {
			alert("请输入UM账号，谢谢！");
			setWarn("editor", dever);
			return false;
		}

		if (tester.val() == "" || tester.val() == null) {
			clearWarn("editor", tester);
			setWarn("editor", tester);
			return false;
		} else if (tester.val().length > 100) {
			alert("【测试负责人】长度不允许超过 100 位，请修改：" + tester.val());
			clearWarn("editor", tester);
			setWarn("editor", tester);
			return false;
		} else if (reg.test(tester.val()) == false) {
			alert("请输入UM账号，谢谢！");
			setWarn("editor", tester);
			return false;
		}

		if (assistants.val() == "" || assistants.val() == null) {
			alert("您没有维护辅助测试人员，请了解！");
		} else if (assistants.val().length > 200) {
			alert("【辅助测试人员】长度不允许超过 200 位，请修改：" + assistants.val());
			clearWarn("editor", assistants);
			setWarn("editor", assistants);
			return false;
		} else if (reg.test(assistants.val()) == false) {
			alert("请输入UM账号，谢谢！");
			setWarn("editor", assistants);
			return false;
		}

		if (case_source.val().length > 50) {
			alert("【开发负责人】长度不允许超过 50 位，请修改：" + case_source.val());
			clearWarn("editor", case_source);
			case_source.focus();
			case_source.css("borderColor", "red");
			case_source.css("borderWidth", "medium");
			case_source.css("borderStyle", "dashed");
			return false;
		}

		return submit_data();
	};

	function get_dev_dept(defaults) {
		$('#dev_dept').get(0).options.length = 0;
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_dept',
			success : function(deptResult) {
				depts = deptResult.listdata;

				for ( var x = 0; x < depts.length; x++) {
					var dept = depts[x];
					if (defaults == dept) {
						$('#dev_dept').append("<option selected=\"selected\" value=" + dept + ">" + dept + "</option>");
					} else {
						$('#dev_dept').append("<option value=" + dept + ">" + dept + "</option>");
					}
				}
			}
		});
	};

	function get_dev_team(defaults) {
		$('#dev_team').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : 'CreateDevTeamAction.action',
			dataType : 'JSON',
			data : {
				"dev_dept" : decodeURIComponent($("#dev_dept").val(), true)
			},
			success : function(teamResult) {
				teams = teamResult.listdata;

				for ( var x = 0; x < teams.length; x++) {
					var team = teams[x];
					if (defaults == team) {
						$('#dev_team').append("<option selected=\"selected\" value=" + team + ">" + team + "</option>");
					} else {
						$('#dev_team').append("<option value=" + team + ">" + team + "</option>");
					}
				}
			}
		});
	};

	function get_test_dept(defaults) {
		$('#test_dept').get(0).options.length = 0;
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_dept',
			success : function(deptResult) {
				depts = deptResult.listdata;

				for ( var x = 0; x < depts.length; x++) {
					var dept = depts[x];
					if (defaults == dept) {
						$('#test_dept').append("<option selected=\"selected\" value=" + dept + ">" + dept + "</option>");
					} else {
						$('#test_dept').append("<option value=" + dept + ">" + dept + "</option>");
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
			url : 'CreateDevTeamAction.action',
			dataType : 'JSON',
			data : {
				"dev_dept" : decodeURIComponent($("#test_dept").val(), true)
			},
			success : function(teamResult) {
				teams = teamResult.listdata;

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

	function get_user(user_ele_id, defaults) {
		$('#' + user_ele_id).get(0).options.length = 0;
		var dept_name = null;
		var team_name = null;

		if (user_ele_id.indexOf("dev") < 0){
			dept_name = $("#test_dept").val();
			team_name = $("#test_team").val();
		} else {
			dept_name = $("#dev_dept").val();
			team_name = $("#dev_team").val();
		}

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : 'QueryUserAction.action',
			dataType : 'JSON',
			data : {
				"dept_name" : decodeURIComponent(dept_name, true),
				"team_name" : decodeURIComponent(team_name, true)
			},
			success : function(result) {
				for ( var x = 0; x < result.length; x++) {
					var um_no = result[x].um_no;
					var name = result[x].full_name;
					if (defaults == um_no) {
						$('#' + user_ele_id).append("<option value='" + um_no + "' selected='selected'>" + um_no + " -- " + name + "</option>");
					} else {
						$('#' + user_ele_id).append("<option value='" + um_no + "'>" + um_no + " -- " + name + "</option>");
					}
				}
			}
		});
	};

	function set_is_valid(defaults){
		var elses = "Y";
		if (defaults.toUpperCase().indexOf('Y') > -1) {
			elses = "N";
		} else {
			elses = "Y";
		}
		$('#is_valid').append("<option selected=\"selected\" value=" + defaults + ">" + defaults + "</option>");
		$('#is_valid').append("<option value=" + elses + ">" + elses + "</option>");
	};

	function module_define(test_team, system_alias) {
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : 'QModuleDefineAction.action',
			data : {
				"test_team" : decodeURIComponent(test_team, true),
				"system_alias" : decodeURIComponent(system_alias, true)
			},
			success : function(result) {
				var check_html = "";
				var li_text = "";
				var temp = "";
				var jsonData = result.module;
				if (jsonData == null || jsonData == undefined) {
					li_text = "未定义模块";
				} else {
					var modules = jsonData.split(",");
					for ( var x = 0; x < modules.length; x++) {
						temp = modules[x];
						li_text = li_text + temp + "、";
					}
					li_text = li_text.substring(0, li_text.length - 1);
				}
				$("#module_li").text(li_text);
				$("#module_define_td").css('background-color', "cornsilk");
			}
		});
	};

	function warning_type(warning_define) {
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : 'WarningTypeAction.action',
			success : function(result) {
				var check_html = "";
				for ( var x = 0; x < result.length; x++) {
					var warning_type = result[x].warning_type;
					var warning_name = result[x].rule_name;
					check_html += "<input type='checkbox' name='wanrings' value='" + warning_type + "' disabled='disabled' onclick='set_checkbox(\"" + warning_type + "\")'>" + warning_name;
				}
				check_html += "<br><div style='color: green; padding-top: 10px; text-align: right; padding-right: 10px;'>&nbsp;开发过程质量预警规则详细说明请<a href='../tools/warning_tips.jsp' style='color: red; text-decoration: none;' target='_blank'>点击这里</a>查看</div>";
				$("#warning_rule_td").html(check_html);
				$("#warning_rule_td").css('background-color', "cornsilk");
				warning_checked(warning_define);
			}
		});
	};

	function set_checkbox(warning_type) {
		if ($("[value = " + warning_type + "]").attr("checked") == "checked") {
			$("[value = " + warning_type + "]:checkbox").attr("checked", false);
		} else {
			$("[value = " + warning_type + "]:checkbox").attr("checked", true);
		}
	};

	function warning_checked(warning_define) {
		var warning = new Array();
		var checkbox = new Array();
		var checkbox_id = "";
		if (warning_define.length > 0) {
			warning = warning_define.split(";");
			for ( var x = 0; x < warning.length; x++) {
				checkbox = warning[x].split(":");
				checkbox_id = checkbox[0];
				if (checkbox[1] == "Y") {
					$("[value = " + checkbox_id + "]:checkbox").attr("checked", true);
				} else {
					$("[value = " + checkbox_id + "]:checkbox").attr("checked", false);
				}
			}
		}
		if (warning_define == null || warning_define == undefined || warning_define == "") {
			$("[name='wanrings']").attr("checked", false);
		}
	};

	function show_details(dev_dept, system_alias) {

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : 'SystemDetailAction.action',
			data : {
				"dev_dept" : decodeURIComponent(dev_dept, true),
				"system_alias" : decodeURIComponent(system_alias, true)
			},
			success : function(result) {
				var jsonData = result.info[0];
				var editor_html = "<input class='editor' type='text' ";
				var select_html = "<select class='select' style='width: 99.8% !important;' type='text' ";
				var message = "请控录入UM账号，以英文半角分号或逗号隔开！";

				$("#dev_dept_td").html(select_html + "id='dev_dept' disabled='disabled' onchange='get_dev_team();get_user(\"dever\",\"\")'><option value='"
								+ jsonData.dev_dept + "' selected='selected'>" + jsonData.dev_dept + "</option></select>");
				$("#dev_team_td").html(select_html + "id='dev_team' disabled='disabled' onchange='get_user(\"dever\",\"\");'><option value='"
								+ jsonData.dev_team + "' selected='selected'>" + jsonData.dev_team + "</option></select>");
				$("#test_dept_td").html(select_html + "id='test_dept' disabled='disabled' onchange='get_test_team();get_user(\"tester\",\"\")'><option value='"
								+ jsonData.test_dept + "' selected='selected'>" + jsonData.test_dept + "</option></select>");
				$("#test_team_td").html(select_html + "id='test_team' disabled='disabled' onchange='get_user(\"tester\",\"\")'><option value='"
								+ jsonData.test_team + "' selected='selected'>" + jsonData.test_team + "</option></select>");
				$("#system_alias_td").html(editor_html + "id='system_alias' value='" + system_alias + "' disabled='disabled'>");
				$("#system_name_td").html(editor_html + "id='system_name' value='" + jsonData.system_name + "' disabled='disabled'>");
				$("#dever_td").html(select_html + "id='dever' disabled='disabled'><option value='" + jsonData.dever + "' selected='selected'></select>");
				$("#tester_td").html(select_html + "id='tester' disabled='disabled'><option value='" + jsonData.tester + "' selected='selected'></select>");
				$("#assistants_td").html(editor_html + "data-toggle='tooltip' title='" + message + "'id='assistants' value='" + jsonData.assistants.toUpperCase().replace(",", ";") + "' disabled='disabled'>");
				$("#case_source_td").html(editor_html + "id='case_source' value='" + jsonData.case_source + "' disabled='disabled'>");
				$("#is_valid_td").html(select_html + "id='is_valid' disabled='disabled'></select>");

				get_user('dever',jsonData.dever);
				get_user('tester',jsonData.tester);
				set_is_valid(jsonData.is_valid);
				module_define(jsonData.test_team, system_alias);
				warning_type(jsonData.warning_define.toUpperCase());
				$("#float_tr").remove();
			}
		});
	};
</script>
