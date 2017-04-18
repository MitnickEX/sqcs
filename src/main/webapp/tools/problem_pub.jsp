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

<%@ include file="../list_style.jsp"%>

<script type="text/javascript">
	var oper_seq;

	function warnNoNull(ele) {
		ele.focus();
		ele.css("borderColor", "red");
		ele.css("borderWidth", "medium");
		ele.css("borderStyle", "dashed");
	};

	var commitCheck = function() {
		var pro_summary = $("#pro_summary");
		var pro_source = $("#pro_source");
		var pro_version = $("#version");
		var pro_detail = $("#pro_detail");
		var pro_owner;

		if (pro_summary.val() == "" || pro_summary.val() == null) {
			clearWarn("editor", pro_summary);
			warnNoNull(pro_summary);
			return false;
		} else if (pro_summary.val().length > 200) {
			alert("【问题概述】长度超过了 200 位，请在详细信息中陈述：" + pro_summary.val());
			clearWarn("editor", pro_summary);
			warnNoNull(pro_summary);
			return false;
		}

		if (pro_source.val() == "" || pro_source.val() == null) {
			clearWarn("editor", pro_source);
			warnNoNull(pro_source);
			return false;
		}

		if (pro_source.val() == "用户验收测试问题" || pro_source.val() == "开发测试缺陷"){
			pro_owner = $("#owner");
			if (pro_version.val().length > 50) {
				alert("【系统/版本】长度不允许超过 50 位，请修改：" + pro_version.val());
				clearWarn("editor", pro_version);
				warnNoNull(pro_version);
				return false;
			}
		} else{
			pro_owner = $("#pro_owner");
		}

		if (pro_owner.val() == "" || pro_owner.val() == null) {
			alert("【建议处理人】不允许为空，请选择！");
			clearWarn("editor", pro_owner);
			warnNoNull(pro_owner);
			return false;
		}

		if (pro_owner.val().length > 50) {
			alert("【建议处理人】长度不允许超过 50 位，请修改：" + pro_owner.val());
			clearWarn("editor", pro_owner);
			warnNoNull(pro_owner);
			return false;
		}

		if (pro_detail.val().length > 1000) {
			alert("【详细信息】长度不允许超过 1000 位，请修改：" + pro_detail.val());
			clearWarn("editor", pro_detail);
			warnNoNull(pro_detail);
			return false;
		}

		var index = $("#attach_table tr").length;
		if (index > 6){
			alert("附件上载个数超出限制，请删除多余附件！");
			return false;
		}
		return submit_data();
	};

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
			if (element[0].tagName.toLowerCase() != "select") {
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
				element.css("borderColor", "black");
			}
		}
	};

	function begin_edit() {
		var default_status = $("#pro_status").val();
		var default_source = $("#pro_source").val();

		$("#float_tr").remove();

		if (default_status == '已关闭'){
			var message = "该问题状态为：" + default_status + "，不需要继续处理！";
			var htmler = "<tr style=\"width: 100%; font-size: 20px; height: 50px; display: table-row;\" id=\"float_tr\">";
			htmler += "<td style=\"text-align: center; color: red;\" colspan=\"2\">"
					+ message + "</td></tr>";
			$("#info_table").append(htmler);
			return;
		}

		$("#pro_status").removeAttr("disabled");
		$("#pro_status").css("background-color","bisque");
		$("#pro_source").removeAttr("disabled");
		$("#pro_source").css("background-color","bisque");
		$("#real_fixer").removeAttr("disabled");
		$("#real_fixer").css("background-color","bisque");
		$("#fix_desc").removeAttr("disabled");
		$("#fix_desc").css("background-color","bisque");

		get_pro_source(default_source);
		get_pro_status(default_status);
		$("#save_data").removeAttr("disabled");
		$("#begin_edit").attr('disabled',"true");
	};

	function end_edit() {
		$("#save_data").attr('disabled',"true");
		$("#begin_edit").removeAttr("disabled");
	};

	function get_pro_source(defaults){
		$('#pro_source').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_pro_source',
			dataType : 'JSON',
			success : function(result) {
				results = eval(result);

				for ( var x = 0; x < results.length; x++) {
					var value = results[x];
					if (defaults == value) {
						$('#pro_source').append("<option selected=\"selected\" value=" + value + ">" + value + "</option>");
					} else {
						$('#pro_source').append("<option value=" + value + ">" + value + "</option>");
					}
				}
			}
		});
	};

	function get_pro_status(defaults){
		$('#pro_status').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : 'CreateProStatusAction.action',
			url : '/sqcs/query_pro_status',
			dataType : 'JSON',
			success : function(result) {
				results = eval(result);

				for ( var x = 0; x < results.length; x++) {
					var value = results[x];
					if (defaults == value) {
						$('#pro_status').append("<option selected=\"selected\" value=" + value + ">" + value + "</option>");
					} else {
						$('#pro_status').append("<option value=" + value + ">" + value + "</option>");
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

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_tteam_versions',
			data : {
				"test_team" : decodeURIComponent($("#test_team").val(), true)
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

	function get_responser() {
		$('#owner').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_testers',
			data : {
				"test_team" : decodeURIComponent($("#test_team").val(), true)
			},
			success : function(json) {
				versions = eval(json);
				$('#owner').append("<option value=''>=====请选择=====</option>");
				for ( var y = 0; y < versions.length; y++) {
					var version = versions[y];
					$('#owner').append("<option value=" + version + ">" + version + "</option>");
				}
			}
		});
	};

	function show_details(pro_id) {
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/problem_detail',
			data : {
				"pro_id" : decodeURIComponent(pro_id,true)
			},
			success : function(result) {
				var jsonData = result[0];

				var editor_html = "<input class='editor' type='text' ";
				var tarea_html = "<textarea class='editor' ";
				var select_html = "<select class='select' style='width: 99.8% !important;' type='text' ";

				$("#pro_id_td").html(editor_html + "id='pro_id' value='"
								+ jsonData.pro_id + "' disabled='disabled'>"
								+ "<input type='text' id='oper_seq' value='"
								+ jsonData.pro_attach + "' style='display:none;'>");

				$("#pro_summary_td").html(editor_html + "id='pro_summary' value='"
								+ jsonData.pro_summary + "' disabled='disabled'>");

				$("#pro_source_td").html(select_html
								+ "id='pro_source' disabled='disabled' onchange='getTeam('养老险测试组')'><option value='"
								+ jsonData.source_desc + "' selected='selected'>"
								+ jsonData.source_desc + "</option></select>");

				$("#pro_user_td").html(editor_html + "id='pro_user' value='"
								+ jsonData.pro_user + "' disabled='disabled'>");

				$("#pro_status_td").html(select_html
								+ "name='pro_status' id='pro_status' disabled='disabled'><option value='"
								+ jsonData.status_desc + "' selected='selected'>"
								+ jsonData.status_desc + "</option></select>");

				$("#sys_version_td").html(editor_html + "id='sys_version' value='"
								+ jsonData.sys_version + "' disabled='disabled'>");

				$("#suggest_fixer_td").html(editor_html + "id='suggest_fixer' value='"
								+ jsonData.suggest_fixer + "' disabled='disabled'>");

				$("#real_fixer_td").html(editor_html + "id='real_fixer' value='"
								+ jsonData.real_fixer + "' disabled='disabled'>");

				$("#pro_detail_td").html(tarea_html
								+ "id='pro_detail' disabled='disabled' style='height: 80px;'>"
								+ jsonData.pro_detail + "</textarea>");

				$("#fix_desc_td").html(tarea_html
								+ "id='fix_desc' disabled='disabled' style='height: 80px;'>"
								+ jsonData.fix_desc + "</textarea>");

				$("#create_date_td").html(editor_html + "id='create_date' value='"
								+ jsonData.create_date + "' disabled='disabled'>");

				$("#fix_date_td").html(editor_html + "id='fix_date' value='"
								+ jsonData.fix_date + "' disabled='disabled'>");

				$("#close_date_td").html(editor_html + "id='close_date' value='"
								+ jsonData.close_date + "' disabled='disabled'>");

				$("#float_tr").remove();
			}
		});
	};

	function get_attach(oper_seq, is_new) {
		var htmler = "<tr><th width='80px'>序号</th><th>文件名</th><th width='250px'>操作批次号</th>"
					+ "<th width='180px'>上载时间</th><th width='150px'>操作</th></tr>";

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/list_attach',
			data : {
				"oper_seq" : oper_seq
			},
			success : function(result) {
				if (result.length == 0) {
					var message = "暂无上载附件文件";
					htmler += "<tr style='height: 30px;'>";
					htmler += "<td colspan='5' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var file_id = result[i].file_id;
						var upload_date = result[i].upload_date;
						var file_name = result[i].file_name;
						var inner;

						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='text-align:center; width: 80px;'>" + ( i + 1 ) + "</td>";
						if (is_new || is_new == 'true'){
							htmler += "<td>" + file_name + "</td>";
							inner = "<a href='javascript:void(0)'" + " onclick='del_attach(\"" + file_id + "\");'>删除附件</a>";
						} else {
							var params = "fileId;" + file_id ;
							var url = "downloadAttachAction.action";
							var target = "_self";
							htmler += "<td><a href='javascript:void(0)' name = 'url_handle' onclick = 'url_handle(\"" + url + "\",\"" + params + "\",\"" + target + "\")'>" + file_name + "</a></td>";
							inner = "不可编辑";
						}

						htmler += "<td style='text-align:center; width: 250px;'>" + oper_seq + "</td>";
						htmler += "<td style='text-align:center; width: 180px;'>" + upload_date + "</td>";
						htmler += "<td style='text-align:center; width: 150px;'>" + inner + "</td>";
						htmler += "</tr>";
					}
				}
			}
		});
		$("#attach_table").html(htmler);
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
</script>
</html>