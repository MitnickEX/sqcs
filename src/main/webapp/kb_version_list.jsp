<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
<title>质量技术支持平台</title>
</head>

<%@ include file="kb.jsp"%>
<%@ include file="list_style.jsp"%>
<script type="text/javascript">
	function list_data() {
		var sr_sum = 0;
		var bug_sum = 0;
		var warn_sum = 0;
		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(),true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(),true);
		}

		if ($("#test_team").val().indexOf("无分组归属") > -1){
			$("#table_body").remove();
			alert("不支持无分组归属的系统信息查询!");
			return false;
		}

		$("#table_body").remove();
		var htmler = "<div id='table_body' style='overflow:auto; height:200px;'><table class='main_table'>";
		htmler += "<tr style='height: 50px;'>";
		htmler += "<td colspan='11' style='text-align:center; color: darkgreen; font-size: 20px;'>Loading...</td>";
		htmler += "</tr>";
		htmler += "</table></div>";
		$("#container").append(htmler);

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/version_list',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(),true),
				"group_name" : group_name,
				"system" : decodeURIComponent($("#system").val(), true),
				"date_begin" : decodeURIComponent($("#date_begin").val(), true),
				"date_end" : decodeURIComponent($("#date_end").val(), true),
				"time_type" : decodeURIComponent($("#time_type").val(), true)
			},
			success : function(result) {
				$("#table_body").remove();
				htmler = "<div id='table_body' style='overflow:auto; height:200px;'><table class='main_table'>";
				if (result.length == 0) {
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='11' style='text-align:center; color:darkgreen; font-size: 20px;'>没有查询到满足条件的版本信息</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jsonData = result[i];
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='text-align:center; width: 40px;'>" + (i + 1) + "</td>";
						htmler += "<td style='width: 150px;'>" + jsonData.system_alias + "</td>";
						htmler += "<td style='width: 190px;'>" + jsonData.system_version + "</td>";
						htmler += "<td style='text-align:center; width: 100px;'>" + jsonData.version_type + "</td>";
						htmler += "<td style='text-align:center; width: 100px;'>" + jsonData.version_status + "</td>";
						if (jsonData.sr_count == 0){
							htmler += "<td style='text-align:center; width: 60px;'>0</td>";
						}else{
							htmler += "<td style='text-align:center; width: 60px;'><a href='javascript:void(0)' onclick='sr_detail(\""
								+ jsonData.system_version + "\")'>" + jsonData.sr_count + "</a></td>";
						}
						
						if (jsonData.bug_count == 0){
							htmler += "<td style='text-align:center; width: 60px;'>0</td>";
						}else{
							htmler += "<td style='text-align:center; width: 60px;'><a href='javascript:void(0)' onclick='bug_detail(\""
								+ jsonData.system_version + "\")'>" + jsonData.bug_count + "</a></td>";
						}
						
						if (jsonData.warn_count == 0){
							htmler += "<td style='text-align:center; width: 60px;'>0</td>";
						}else{
							htmler += "<td style='text-align:center; width: 100px;'><a href='javascript:void(0)' onclick='get_warning(\""
								+ jsonData.system_version + "\")'>" + jsonData.warn_count + "</a></td>";
						}
						htmler += "<td style='text-align:center; width: 100px;'>" + jsonData.first_handover_test_time + "</td>";
						htmler += "<td style='text-align:center; width: 100px;'>" + jsonData.reviewtest_end_date + "</td>";
						htmler += "<td style='text-align:center; width: 80px;'>" + jsonData.is_delay + "</td>";
						htmler += "<td style='word-break:break-all;'>" + jsonData.environment + "</td>";
						htmler += "</tr>";

						sr_sum += parseInt(jsonData.sr_count);
						bug_sum += parseInt(jsonData.bug_count);
						warn_sum += parseInt(jsonData.warn_count);
					}
					htmler += "<tr style='height: 25px;'>";
					htmler += "<td style='text-align:center; width: 40px;'></td>";
					htmler += "<td style='width: 150px;'>汇总</td>";
					htmler += "<td style='width: 190px;'></td>";
					htmler += "<td style='text-align:center; width: 100px;'></td>";
					htmler += "<td style='text-align:center; width: 100px;'></td>";
					htmler += "<td style='text-align:center; width: 60px;'>" + sr_sum + "</td>";
					htmler += "<td style='text-align:center; width: 60px;'>" + bug_sum + "</td>";
					htmler += "<td style='text-align:center; width: 100px;'>" + warn_sum + "</td>";
					htmler += "<td style='text-align:center; width: 100px;'></td>";
					htmler += "<td style='text-align:center; width: 100px;'></td>";
					htmler += "<td style='text-align:center; width: 80px;'></td>";
					htmler += "<td style='word-break:break-all;'></td>";
					htmler += "</tr>";
				}
				htmler += "</table></div>";
				$("#container").append(htmler);
				div_height("table_body");
				hide();
				show_transfer("#table_body a", "float_div");
			}
		});
	};

	function sr_detail(verNo) {
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_srs").height() - 60;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/version_content',
			data : {
				"version" : verNo
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "该版本目前没有纳入任何需求";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='7' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 110px; text-align: center;'>" + jData.source_id + " </td>";
						htmler += "<td style='width: 180px; text-align: center;'>" + jData.submit_person + " </td>";
						htmler += "<td style='width: 110px; text-align: center;'>" + jData.benefit_name + " </td>";
						htmler += "<td style='width: 110px; text-align: center;'>" + jData.sr_code + "</td>";
						if (jData.man_power == null || jData.man_power == ''){
							htmler += "<td style='width: 80px; text-align: center;'></td>";
						} else{
							htmler += "<td style='width: 80px; text-align: center;'>" + jData.man_power + " 人日</td>";
						}
						htmler += "<td style='width: 80px; text-align: center;'>" + jData.bug_num + "</td>";
						htmler += "<td style='word-break:break-all;'>" + jData.sr_name + "</td>";
						htmler += "</tr>";
					}
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_srs");
			}
		});
		float_autofit();
	};

	function bug_detail(verNo){
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_defect").height() - 60;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/version_bug_list',
			data : {
				"version" : verNo
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "该版本目前没有发现缺陷";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='7' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 110px; text-align: center;'>" + jData.pro_id + " </td>";
						htmler += "<td style='width: 60px; text-align: center;'>" + jData.pro_status + " </td>";
						htmler += "<td style='width: 60px; text-align: center;'>" + jData.pro_pri + " </td>";
						htmler += "<td style='width: 80px; text-align: center;'>" + jData.pro_level + "</td>";
						htmler += "<td style='width: 180px; text-align: center;'>" + jData.pro_found_person + "</td>";
						htmler += "<td style='width: 180px; text-align: center;'>" + jData.pro_deal_person + "</td>";
						htmler += "<td style='word-break:break-all;'>" + jData.pro_theme + "</td>";
						htmler += "</tr>";
					}
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_defect");
			}
		});
		float_autofit();
	}

	function get_warning(verno) {
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_warn").height() - 60;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/warning_info',
			data : {
				"version" : verno,
				"warning_date" : "all",
				"warning_grade" : "all"
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "该版本目前没有任何异常";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='5' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						var system_version=$("#version").val();
						var warning_date = jData.warning_date;
						var rule_name = jData.rule_name;
						var warning_info = jData.warning_info;
						var warning_type = jData.warning_type;
						var warning_grade = jData.warning_grade;
						var params = "system_version;" + verno;
						var url = "kb_warning_list.jsp";
						var target = "_blank";
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='text-align:center; width:120px;'>" + warning_date + "</td>";
						htmler += "<td style='text-align:center; width:200px;'>" + rule_name + "</td>";

						if (warning_grade == 1) {
							htmler += "<td style='text-align:center; width:120px; background-color: goldenrod;'>一般</td>";
						} else if (warning_grade == 2) {
							htmler += "<td style='text-align:center; width:120px; background-color: salmon;'>严重</td>";
						} else if (warning_grade == 3) {
							htmler += "<td style='text-align:center; width:120px; background-color: red;'>非常严重</td>";
						} else {
							htmler += "<td style='text-align:center; width:120px; background-color: yellowgreen;'>提示</td>";
						}
						htmler += "<td style='text-align:center; width: 120px;'>" + jData.owner + "</td>";
						htmler += "<td>" + warning_info + ", <a href='javascript:void(0)' name = 'url_handle' onclick = 'url_handle(\"" + url + "\",\"" + params + "\",\"" + target + "\")'>更多信息点这里</a></td>";
						htmler += "</tr>";
					}
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_warn");
			}
		});
		float_autofit();
	};

	function show_only_current(father_id, id_to_show){
		var elements = $("#" + father_id + " > table");
		elements.each(function(){
			$(this).hide();
		});
		$("#" + id_to_show).show();
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

	function hide() {
		$("#float_div").hide();
	};

	function float_autofit(){
		var div_height = $("#float_div").height();
		$("#float_body").height(div_height - 60);
	};

	function set_default_date() { //默认上周五到这周四
		var now = new Date();
		var day = now.getDay();
		var last_fri = new Date((5 - day)*(3600*24*1000)+now.getTime());
		var this_thur = new Date((4 - day)*(3600*24*1000)+now.getTime());

		last_fri.setDate(last_fri.getDate() - 7);

		$("#date_begin").val(last_fri.format('yyyy-MM-dd'));
		$("#date_end").val(this_thur.format('yyyy-MM-dd'));
	};

	function query_org(){
		if ($("#group_type").val() == 'test_team') {
			$("#test_team").show();
			$("#dev_dept").hide();
			get_test_team();
			get_system();
			list_data();
		} else {
			$("#dev_dept").show();
			$("#test_team").hide();
			get_dev_dept();
			get_system();
			list_data();
		}
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

	$(function() {
		get_test_team('养老险测试组');
		get_system();
		set_default_date();
		list_data();
	});
</script>

<body>
	<div id="float_div" class="float_div">
		<div id="float_head" class="float_head">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
		<div id="float_body">
			<table class='main_table' id='float_srs' style="display:none;">
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='110px'>NEED号</th>
					<th width='180px'>需求提出人</th>
					<th width='110px'>受益人</th>
					<th width='110px'>SR号</th>
					<th width='80px'>预估人力</th>
					<th width='80px'>缺陷数</th>
					<th>需求摘要</th>
				</tr>
			</table>
			<table class='main_table' id='float_warn' style="display:none;">
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='120px'>预警日期</th>
					<th width='200px'>预警类型</th>
					<th width='120px'>预警级别</th>
					<th width='120px'>责任人</th>
					<th>预警内容</th>
				</tr>
			</table>

			<table class='main_table' id='float_defect' style="display:none;">
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='110px'>编号</th>
					<th width='60px'>状态</th>
					<th width='60px'>优先级</th>
					<th width='80px'>严重程度</th>
					<th width='180px'>发现人员</th>
					<th width='180px'>修复人员</th>
					<th>摘要</th>
				</tr>
			</table>
		</div>
		<div id="float_foot" class="float_foot">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
	</div>

	<div class="title-div">
		<span class="label-text">查询组织</span>
		<select class="select" style="width:8%" id="group_type" onchange="query_org();">
			<option value="test_team">测试分组</option>
			<option value="dev_dept">开发部门</option>
		</select>

		<select class="select" style="width:15%; display:none;" id="dev_dept" onchange="check_obtain(); get_system();"></select>
		<select class="select" style="width:15%;" id="test_team" onchange="check_obtain(); get_system();"></select>

		<span class="label-text">子系统</span>
		<select class="select" style="width:15%" id="system" onchange="check_obtain();"></select>
		<select class="select" style="width:8%" id="time_type" onchange="list_data();">
			<option value="handover">移交</option>
			<option value="release" selected="selected">下发</option>
		</select>
		<span class="label-text">起</span>
		<input class="cal-editor" type="text" id="date_begin" maxlength="10" onclick="new Calendar().show(this);"
			onchange="list_data();" readonly="readonly">
		<span class="label-text">止</span>
		<input class="cal-editor" type="text" id="date_end" maxlength="10" onclick="new Calendar().show(this);"
			onchange="list_data();" readonly="readonly">
	</div>

	<div id="container" style="min-width: 100%;">
		<table class='main_table' id='main_table'>
			<tr style='height: 40px; font-size: 20px; font-weight: 600;'>
				<td colspan='12' class='thead'>版本发布信息清单</td>
			</tr>
			<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
				<th width='40px' sortType='num'>序号</th>
				<th width='150px' sortType='string'>子系统</th>
				<th width='190px' sortType='string'>版本号</th>
				<th width='100px' sortType='string'>版本类型</th>
				<th width='100px' sortType='string'>版本状态</th>
				<th width='60px' sortType='num'>需求数</th>
				<th width='60px' sortType='num'>缺陷数</th>
				<th width='100px' sortType='num'>累计异常数</th>
				<th width='100px' sortType='date'>首移时间</th>
				<th width='100px' sortType='date'>封版时间</th>
				<th width='80px' sortType='date'>封版延期</th>
				<th sortType='string'>部署环境名称</th>
			</tr>
		</table>
	</div>
</body>
</html>
