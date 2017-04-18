<%@page import="com.fudax.sqcs.env.info.model.RequestResult"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="images/favicon.ico" type="image/x-icon" rel="icon" />
<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />

<style>
* {
	text-shadow:none;
}

.main_table {
	width: 100%;
	border: 1px solid #CCC;
	font-size: 15px;
	-webkit-border-radius: 4px; 
	-moz-border-radius: 4px;
	border-radius: 4px;
	margin:0;
	border-spacing:1px;
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
	width: 99% !important;
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
	font-family: Arial,微软雅黑;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	background-color: floralwhite;
	word-wrap:break-word;
}

th {
	border: 1px solid #CCC;
	background-color: rgba(190, 190, 190, 0.8);
	font-family: 微软雅黑;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	cursor: pointer;
}

.thead {
	text-align: center;
	border: 1px solid #CCC;
	background-color: rgba(150, 145, 180, 0.8);
	color: lightyellow;
}
</style>

<script type="text/javascript">
	function closeWindow(){
		window.opener = null;
		window.open('', '_self');
		window.close();
	};

	function reset(){
		var elements = $(".editor");
		var element;
		for ( var i = 0; i < elements.length; i++) {
			element = elements.eq(i);
			if (element[0].tagName != "select" && element[0].tagName != "SELECT"){
				element.val("");
			}
		}
	};

	function clearWarn(className, currentElement){
		var elements = $("." + className);
		for ( var i = 0; i < elements.length; i++) {
			var element = elements.eq(i);
			if (element != currentElement){
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
		var old_dept = $("#dev_dept").val();
		var old_team = $("#test_team").val();
		var old_dev = $("#dev_team").val();

		var elements = $(".editor");
		for ( var i = 0; i < elements.length; i++) {
			elements.eq(i).removeAttr("disabled");
		}

		var selements = $(".select");
		for ( var i = 0; i < selements.length; i++) {
			selements.eq(i).removeAttr("disabled");
		}

		get_dev_dept(old_dept);
		get_test_team(old_team);
		getDevTeam(old_dev);

		$("#float_tr").remove();
		$("#save_data").removeAttr("disabled");
		$("#begin_edit").attr('disabled',"true");
	};

	function endEdit() {
		$("#save_data").attr('disabled',"true");
		$("#begin_edit").removeAttr("disabled");
	};

	var commitCheck = function() {
		var reg_subsys = /^[a-zA-Z0-9,-;]+$/;
		var reg_ins = /^[a-zA-Z0-9,_;]+$/;

		var sysName = $("#system_name");
		var deptName = $("#dev_dept");
		var testTeam = $("#test_team");
		var devTeam = $("#dev_team");
		var inName = $("#instance_name");

		var loginAddr = $("#login_address");
		var t3Uri = $("#t3_uri");
		var jdbcTns = $("#jdbc_tns");
		var testUsers = $("#test_users");
		var desc = $("#description");

		if (sysName.val() == "" || sysName.val() == null) {
			clearWarn("editor", sysName);
			setWarn("editor", sysName);
			return false;
		} else if (reg_subsys.test(sysName.val()) == false) {
			sysName.val("子系统简称以数字、字母和中划线组成，谢谢！");
			setWarn("editor", sysName);
			return false;
		} else if(sysName.val().length > 20){
			sysName.val("【系统名称】长度不允许超过 20 位，请修改：" + sysName.val());
			clearWarn("editor", sysName);
			setWarn("editor", sysName);
			return false;
		}

		if (inName.val() == "" || inName.val() == null) {
			clearWarn("editor", inName);
			setWarn("editor", inName);
			return false;
		} else if (reg_ins.test(inName.val()) == false) {
			inName.val("环境实例名以字母、数字和下划线组成，谢谢！");
			setWarn("editor", inName);
			return false;
		} else if(inName.val().length > 50){
			inName.val("长度不允许超过 50 位，请修改：" + inName.val());
			clearWarn("editor", inName);
			setWarn("editor", inName);
			return false;
		}

		if(loginAddr.val().length > 800){
			loginAddr.val("长度不允许超过 800 位，请修改：" + loginAddr.val());
			clearWarn("editor", loginAddr);
			setWarn("editor", loginAddr);
			return false;
		}

		if(t3Uri.val().length > 200){
			t3Uri.val("长度不允许超过 200 位，请修改：" + t3Uri.val());
			clearWarn("editor", t3Uri);
			setWarn("editor", t3Uri);
			return false;
		}

		if(jdbcTns.val().length > 500){
			jdbcTns.val("长度不允许超过 500 位，请修改：" + jdbcTns.val());
			clearWarn("editor", jdbcTns);
			setWarn("editor", jdbcTns);
			return false;
		}

		if(testUsers.val().length > 100){
			testUsers.val("长度不允许超过 100 位，请修改：" + testUsers.val());
			clearWarn("editor", testUsers);
			setWarn("editor", testUsers);
			return false;
		}

		if(desc.val().length > 200){
			desc.val("长度不允许超过 200 位，请修改：" + desc.val());
			clearWarn("editor", desc);
			setWarn("editor", desc);
			return false;
		}

		return submit_data();
	};

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

	function get_system() {
		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(),true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(),true);
		}

		$('#system').get(0).options.length = 0;
		$.ajax({
			async: false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_systems',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(),true),
				"group_name" : group_name
			},
			success : function(json) {
				systems = eval(json);
				$('#system').append("<option value='all'>全部系统</option>");
				for ( var y = 0; y < systems.length; y++) {
					var system = systems[y];
					$('#system').append("<option value=" + system + ">" + system + "</option>");
				}
			}
		});
	};

	function getDevTeam(defaults) {
		$('#dev_team').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_adev_team',
			dataType : 'JSON',
			data : {
				"dev_dept" : decodeURIComponent($("#dev_dept").val(), true)
			},
			success : function(teamResult) {
				teams = eval(teamResult);

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
		} else {
			$("#dev_dept").show();
			$("#test_team").hide();
			get_dev_dept();
		}
	};

	$(function() {
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
	});

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

	function show_details(systemId) {
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : 'showDetailAction.action',
			data : {
				"system_id" : systemId
			},
			success : function(result) {
				var jsonData = result.sysInfo[0];

				var address = jsonData.login_address;
				system_name = jsonData.system_name;
				instance_name = jsonData.instance_name;
				var tns = jsonData.jdbc_tns;
				var multi_url = "";
				var multi_tns = "";

				var addArray = address.split(";");
				for ( var i = 0; i < addArray.length; i++) {
					if (i == addArray.length - 1) {
						multi_url = multi_url + addArray[i];
					} else {
						multi_url = multi_url + addArray[i] + "\r\n";
					}
				}
				var tnsArray = tns.split(";");
				for ( var i = 0; i < tnsArray.length; i++) {
					if (i == tnsArray.length - 1) {
						multi_tns = multi_tns + tnsArray[i];
					} else {
						multi_tns = multi_tns + tnsArray[i] + "\r\n";
					}
				}

				var editor_html = "<input class='editor' type='text' ";
				var tarea_html = "<textarea class='editor' ";
				var select_html = "<select class='select' style='width: 99.8% !important;' type='text' ";

				$("#system_name_td").html(editor_html
								+ "name='system_name' id='system_name' value='"
								+ jsonData.system_name
								+ "' disabled='disabled'><input type='hidden' name='system_id' id='system_id' value='"
								+ jsonData.system_id + "'>");

				$("#instance_name_td").html(editor_html
								+ "name='instance_name' id='instance_name' value='"
								+ jsonData.instance_name
								+ "' disabled='disabled'>");

				$("#dept_name_td").html(select_html
								+ "name='dept_name' id='dev_dept' disabled='disabled' onchange='get_test_team();getDevTeam();'><option value='"
								+ jsonData.dept_name
								+ "' selected='selected'>"
								+ jsonData.dept_name
								+ "</option></select>");

				$("#test_team_td").html(select_html
								+ "name='test_team' id='test_team' disabled='disabled' onchange='getDevTeam();'><option value='"
								+ jsonData.test_team
								+ "' selected='selected'>"
								+ jsonData.test_team
								+ "</option></select>");

				$("#dev_team_td").html(select_html
								+ "name='dev_team' id='dev_team' disabled='disabled'><option value='"
								+ jsonData.dev_team
								+ "' selected='selected'>"
								+ jsonData.dev_team
								+ "</option></select>");

				$("#login_address_td").html(tarea_html
								+ "name='login_address' id='login_address' disabled='disabled' style='height: 100px;'>"
								+ multi_url + "</textarea>");

				$("#t3_uri_td").html(editor_html
								+ "name='t3_uri' id='t3_uri' value='"
								+ jsonData.t3_uri
								+ "' disabled='disabled'>");

				$("#jdbc_tns_td").html(tarea_html
								+ "name='jdbc_tns' id='jdbc_tns' disabled='disabled' style='height: 80px;'>"
								+ multi_tns + "</textarea>");

				$("#test_users_td").html(editor_html
								+ "name='test_users' id='test_users' value='"
								+ jsonData.test_users
								+ "' disabled='disabled'>");

				$("#description_td").html(editor_html
								+ "name='description' id='description' value='"
								+ jsonData.description
								+ "' disabled='disabled'>");

				$("#float_tr").remove();
			}
		});
	};
</script>
