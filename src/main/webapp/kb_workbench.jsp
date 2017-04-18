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
</head>

<script type="text/javascript">
	var get_yesterday = function(currentDate){
		var date = new Date(currentDate);
		var yesterday = date.setDate(date.getDate() - 1);
		yesterday = date.format("yyyy-MM-dd");
		return yesterday;
	};

	function list_versions(system_version) {
		var currentDate = $("#work_date").val();
		var errorColor = "lightgrey";
		var toDealColor = "gold";
		var yesterday = get_yesterday(currentDate);
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/my_work',
			data : {
				"system_version" : system_version,
				"work_date" : currentDate
			},
			success : function(json) {
				workdata = json[0];
				var status = "";
				var message = "";
				var color = "floralwhite";
				var userData = 0;
				var default_color = "floralwhite";
				var htmler = "<tr style='height: 30px;' name='datas'>";
				var params = "system_version;" + system_version + "warning_date;" + yesterday;
				var url = "kb_warning_list.jsp";
				var target = "_blank";
				htmler += "<td style='text-align:center;' rowspan=11><div style='color:#08c;cursor:pointer;' onclick = 'url_handle(\"" + url + "\",\"" + params + "\",\"" + target + "\")'>" + system_version + "</div>（点此查看版本异常）</td>";

				userData = parseInt(workdata.need_add_to_rm_fact - workdata.add_to_rm_fact_lastday);
				if (userData > 0) {
					status = "需处理";
					message = "新纳入需求" + userData + "个，请及时准备测试用例";
					color = toDealColor;
				} else {
					status = "正常";
					message = "版本需求清单";
					color = default_color;
				}
				htmler += "<td style='text-align:center;background-color: " + color + "'>版本—需求纳入</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.add_to_rm_fact_lastday + "（前一天）</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.need_add_to_rm_fact + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><a href='javascript:void(0);' onclick='sr_detail(\""
						+ system_version + "\", \"add_to_rm\");'>" + message + "</a></td></tr>";

				userData = parseInt(workdata.need_add_to_rm_fact - workdata.need_deploy_stg_fact);
				if (userData > 0) {
					status = "需处理";
					message = "未移交需求" + userData + "个，点击查看版本需求清单";
					color = toDealColor;
				} else {
					status = "正常";
					message = "版本需求清单";
					color = default_color;
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>版本—需求移交</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.need_add_to_rm_fact + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.need_deploy_stg_fact + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><a href='javascript:void(0);' onclick='sr_detail(\""
						+ system_version + "\", \"dev_complete\");'>" + message + "</a></td></tr>";

				message = "查看详情";
				if (workdata.st_plan_execute_percent - workdata.st_actual_execute_percent > 0) {
					status = "需处理";
					color = toDealColor;
				} else {
					status = "正常";
					color = default_color;
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>测试执行—ST</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + (workdata.st_plan_execute_percent * 100).toFixed(2) + "%</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + (workdata.st_actual_execute_percent * 100).toFixed(2) + "%</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><a href='javascript:void(0);' onclick='test_schedule(\""
						+ system_version + "\", \"ST\");'>" + message + "</a></td></tr>";

				message = "查看详情";
				if (workdata.st_plan_execute_percent - workdata.uat_actual_execute_percent > 0) {
					status = "需处理";
					color = toDealColor;
				} else {
					status = "正常";
					color = default_color;
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>测试执行—UAT</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + (workdata.st_plan_execute_percent * 100).toFixed(2) + "%</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + (workdata.uat_actual_execute_percent * 100).toFixed(2) + "%</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><a href='javascript:void(0);' onclick='test_schedule(\""
						+ system_version + "\", \"UAT\");'>" + message + "</a></td></tr>";

				var bug_found_plan = parseInt(workdata.bug_found_plan);
				var bug_found_actual = parseInt(workdata.bug_found_actual);
				var linkHead = "";
				var linkTail = "";
				if (bug_found_plan == 0) {
					status = "正常";
					color = default_color;
					message = "尚未分析版本缺陷趋势";
				} else {
					message = "点击查看版本缺陷趋势周期";
					linkHead = "<a href='javascript:void(0);' onclick='bug_trend_gragh(\"" + system_version + "\");'>";
					linkTail = "</a>";
					if (bug_found_plan > bug_found_actual) {
						status = "需处理";
						color = toDealColor;
					} else {
						status = "正常";
						color = default_color;
					}
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>缺陷—累计发现</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + bug_found_plan + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + bug_found_actual + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + linkHead + message + linkTail + "</td></tr>";

				userData = parseInt(workdata.bug_deal_plan - workdata.bug_deal_actual);
				if (userData > 0) {
					status = "需处理";
					message = "待修复缺陷" + userData + "个，请注意跟踪";
					color = toDealColor;
				} else {
					status = "正常";
					message = "";
					color = default_color;
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>缺陷—修复跟踪</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.bug_deal_plan + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.bug_deal_actual + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><a href='javascript:void(0);' onclick='bug_detail(\""
						+ system_version + "\", \"deal\");'>" + message + "</a></td></tr>";

				userData = parseInt(workdata.bug_close_plan - workdata.bug_close_actual);
				if (userData > 0) {
					status = "需处理";
					message = "待验证缺陷" + userData + "个，请及时验证";
					color = toDealColor;
				} else {
					status = "正常";
					message = "";
					color = default_color;
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>缺陷—验证处理</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.bug_close_plan + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + workdata.bug_close_actual + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><a href='javascript:void(0);' onclick='bug_detail(\""
						+ system_version + "\", \"check\");'>" + message + "</a></td></tr>";

				if (workdata.current_coverage == undefined) {
					status = "异常";
					message = "无法找到变更覆盖率数据，请联系毛皓、邹文涛处理";
					color = errorColor;
					userData = "无法获取";
				} else {
					userData = parseInt(workdata.current_coverage);
					if (userData < 100) {
						status = "需处理";
						message = "请完善对变更的测试场景覆盖";
						color = toDealColor;
					} else {
						status = "正常";
						message = "";
						color = default_color;
					}
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>变更覆盖率分析</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>100.00%</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><div style='color:#08c; cursor:pointer;' onclick='no_data();'>" + userData + "</div></td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + message + "</td></tr>";

				var userData = workdata.environment;
				var linkPre = "";
				var linkEnd = "";
				if (null == userData || userData == '') {
					message = "请联系版本经理尽快修正版本测试环境及计划数据";
					status = "需处理";
					color = toDealColor;
					userData = "版本经理未选择测试环境";
				} else {
					linkPre = "<div style='color:#08c; cursor:pointer;' onclick = window.open('http://blog.163.com/pengjintaogz@126/blog/static/16229906820143249562967/')>";  
					linkEnd = "</div>";
					if (workdata.env_warning == undefined){
						message = "<div style='color:#08c; cursor:pointer;' onclick=window.open('http://www.yunweipai.com/archives/5381.html')>无法找到环境监控数据，请确保正确配置了子系统的监控</div>";
					} else if (parseInt(workdata.env_warning) > 0) {
						status = "需处理";
						message = "测试环境异常";
						color = toDealColor;
					} else {
						status = "正常";
						message = "";
						color = default_color;
					}
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>测试环境管理</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + linkPre + userData + linkEnd + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'></td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + message + "</td></tr>";

				if (workdata.success_rate == undefined || workdata.success_rate == '') {
					message = "需正确配置自动化JOB子系统信息，且从前一日17:00开始有运行纪录";
					status = "异常";
					color = errorColor;
					userData = "无法获取";
				} else {
					var userData = workdata.success_rate + "%";
					if (userData < 100) {
						status = "需处理";
						color = toDealColor;
					} else {
						status = "正常";
						color = default_color;
					}
					message = "<a href='javascript:void(0);' onclick='autotest_detail(\"" + system_version + "\", \"" + currentDate + "\");'>查看详情</a>";
				}
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>自动化测试运行</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>100.00%</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + userData + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + message + "</td></tr>";

				if (workdata.performance == undefined) {
					message = "需正确配置性能测试JOB子系统信息，且前一日有运行纪录";
					status = "异常";
					color = errorColor;
					userData = "无法获取";
				} else {
					userData = workdata.performance.toPercent();
					if (userData == 0) {
						status = "";
						message = "无性能测试计划";
						color = default_color;
					} else {
						status = "需处理";
						message = "请及时采集分析性能测试结果";
						color = toDealColor;
					}
					;
				}
				;
				htmler += "<tr style='height: 30px;' name='datas'><td style='text-align:center;background-color: " + color + "'>性能测试执行</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'></td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'><div style='color:#08c; cursor:pointer;' href='javascript:void(0)' onclick='no_data();'>" + userData + "</div></td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + status + "</td>";
				htmler += "<td style='text-align:center;background-color: " + color + "'>" + message + "</td>";

				htmler += "</tr>";

				$("#main_table").append(htmler);
			}
		});
	};

	function no_data() {
		alert("waiting for MAOHAO411");
	};

	function clear_data(){
		var elements = $("tr[name='datas']");
		for (var i = 0; i < elements.length; i ++) {
			elements.eq(i).remove();
		}
	};

	function autotest_detail(verNo, viewDate){
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_autotest").height() - 60;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/auto_detail_query',
			data : {
				"version" : verNo,
				"work_date" : viewDate
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "该版本和子系统前日17点到今日17点未见自动化运行结果！";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='9' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						var success_rate = parseInt(jData.success_rate);
						var viewColor = "";
						if (success_rate < 100.00){
							viewColor = "background-color: gold;";
						}
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 60px; text-align: center;" + viewColor + "'>" + (i + 1) + " </td>";
						htmler += "<td style='width: 150px; text-align: center;" + viewColor + "'>" + jData.full_name + " </td>";
						htmler += "<td style='width: 200px; text-align: center;" + viewColor + "'>" + jData.system_version + " </td>";
						htmler += "<td style='width: 60px; text-align: center;" + viewColor + "'>" + jData.run_env + "</td>";
						htmler += "<td style='width: 160px; text-align: center;" + viewColor + "'>" + jData.complete_date + "</td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.total_no + "</td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.success_no + "</td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.success_rate + "%</td>";
						htmler += "<td style='text-align: center;" + viewColor + "'>" + jData.job_name + " </td>";
						htmler += "</tr>";
					}
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_autotest");
			}
		});
		float_autofit();
	};

	function bug_detail(verNo, check_or_deal){
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
				result = result[0];
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
						var viewColor = "";
						if (check_or_deal.indexOf("deal") > -1){
							if (jData.pro_status.indexOf('处理中') > -1 || jData.pro_status.indexOf('新建') > -1){
								viewColor = "background-color: gold;";
							} else {
								viewColor = "";
							}
						} else {
							if (jData.pro_status.indexOf('待验证') > -1){
								viewColor = "background-color: gold;";
							} else {
								viewColor = "";
							}
						}
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 110px; text-align: center;" + viewColor + "'>" + jData.pro_id + " </td>";
						htmler += "<td style='width: 60px; text-align: center;" + viewColor + "'>" + jData.pro_status + " </td>";
						htmler += "<td style='width: 60px; text-align: center;" + viewColor + "'>" + jData.pro_pri + " </td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.pro_level + "</td>";
						htmler += "<td style='width: 180px; text-align: center;" + viewColor + "'>" + jData.pro_found_person + "</td>";
						htmler += "<td style='width: 180px; text-align: center;" + viewColor + "'>" + jData.pro_deal_person + "</td>";
						htmler += "<td style='word-break:break-all;" + viewColor + "'>" + jData.pro_theme + "</td>";
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

	function test_schedule(verNo, planType) {
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_schedule").height() - 60;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/version_schedule',
			data : {
				"version" : verNo,
				"plan_type" : planType
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "该版本目前没有测试进度计划统计信息";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='5' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 150px; text-align: center;'>" + jData.need_code + " </td>";
						htmler += "<td style='width: 150px; text-align: center;'>" + jData.sr_code + " </td>";
						htmler += "<td style='width: 120px; text-align: center;'>" + jData.case_count + " </td>";
						htmler += "<td style='width: 120px; text-align: center;'>" + jData.execute_percent + "</td>";
						htmler += "<td style='width: 120px; text-align: center;'>" + jData.passed_percent + "</td>";
						htmler += "<td>" + jData.test_plan + " </td>";
						htmler += "</tr>";
					}
					;
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_schedule");
			}
		});
		float_autofit();
	};

	function sr_detail(verNo, viewType) {
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
						var viewDate = "";
						var viewColor = "";
						if (viewType.indexOf("complete") > -1){
							viewDate = jData.date_dev_complete;
						} else {
							viewDate = jData.date_add_to_rm;
						}

						if (jData.sr_code != '' && (viewDate == '' || Date.parse(viewDate) >= Date.parse($("#work_date").val()))){
							viewColor = "background-color: gold;";
						} else {
							viewColor = "";
						}
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 110px; text-align: center;" + viewColor + "'>" + jData.source_id + " </td>";
						htmler += "<td style='width: 180px; text-align: center;" + viewColor + "'>" + jData.submit_person + " </td>";
						htmler += "<td style='width: 110px; text-align: center;" + viewColor + "'>" + jData.benefit_name + " </td>";
						htmler += "<td style='width: 110px; text-align: center;" + viewColor + "'>" + jData.sr_code + "</td>";
						if (jData.man_power == null || jData.man_power == ''){
							htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'></td>";
						} else{
							htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.man_power + " 人日</td>";
						}
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.bug_num + "</td>";
						htmler += "<td style='word-break:break-all;" + viewColor + "'>" + jData.sr_name + "</td>";
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


	function bug_trend_gragh(system_version) {
		$("#float_div").show();
		$("#float_body").hide();
		$("#float_gragh").show();

		var myChart = echarts.init($("#float_gragh").get(0));

		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_by_version',
			data : {
				"version" : system_version
			},
			success : function(result) {
				result = result[0];
				var barLegend = [];
				$.each(result.listYdata, function() {
					barLegend.push(this.name);
				});
				myChart.setTheme(theme);
				myChart.setOption({
					tooltip : {
						trigger : 'axis'
					},

					legend : {
						orient : 'horizontal',
						x : 'left',
						y : 'top',
						itemGap : 10,
						padding : 5,
						textStyle : {
							color : 'auto'
						},
						data : barLegend
					},

					toolbox : {
						show : true,
						itemGap : 10,
						padding : 5,
						feature : {
		                    'mark':{'show':true},
		                    'dataView':{'show':true,'readOnly':false},
		                    'magicType':{'show':true,'type':['line','bar','stack','tiled']},
		                    'restore':{'show':true},
		                    'saveAsImage':{'show':true}
						}
					},

					grid : {
						'x' : 50,
						'x2' : 50,
						'y' : 100,
						'y2' : 80
					},

					calculable : true,

					xAxis : [ {
						axisLabel : {
							rotate : 30
						},
						type : 'category',
						data : result.listXdata,
						splitLine : {
							show : false
						}
					} ],

					yAxis : [ {
						type : 'value',
						name : '累计缺陷',
						axisLabel : {
							formatter : '{value} '
						}
					}, {
						type : 'value',
						name : '缺陷个数',
						axisLabel : {
							formatter : '{value} '
						},
						boundaryGap : [ 0, 0.5 ]
					} ],
					backgroundColor : 'rgb(250, 250, 210)',
					series : result.listYdata
				});
			}
		});

		$("#float_gragh").get(0).height($("#float_div").height() - 60);
	};

	function float_autofit() {
		var div_height = $("#float_div").height();
		$("#float_body").get(0).height(div_height - 60);
	};

	function show_only_current(father_id, id_to_show) {
		$("#" + father_id).show();
		$("#float_gragh").hide();

		var elements = $("#" + father_id + " > table");
		elements.each(function() {
			$(this).hide();
		});
		$("#" + id_to_show).show();
	};

	function get_user() {
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_if_leader',
			data : {
				"current_user" : 'CHENERXIU015'
			},
			success : function(result) {
				if (result.length == 0) {
					$("#main_head").val("您的UM帐户信息尚未维护，请通过本系统上报问题处理！");
				} else if (result.length == 1) {
					var jsonData = result[0];
					$("#role_name").text("测试负责人 " + jsonData.full_name);
					$("#role_who").html("您&nbsp;&nbsp;<input id='belongs' type='hidden' value='" + jsonData.um_no + "'></input>");
				} else {
					$("#role_name").text("测试经理 " + '<%=currentUser%>');
					$("#role_who").html("您的下属&nbsp;&nbsp;<select class='select' style='width: 10%; height: 27px;' id='belongs' onchange='get_version()'></select>");
					for ( var i = 0; i < result.length; i++) {
						var jsonData = result[i];
						$('#belongs').append("<option value=" + jsonData.um_no + ">" + jsonData.full_name + "</option>");
					}
				}
			}
		});
	};

	var get_version = function() {
		clear_data();
		$.ajax({
			async : true,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/user_current_version',
			data : {
				"current_date" : $("#work_date").val(),
				"current_user" : $("#belongs").val()
			},
			success : function(versions) {
				if (versions.length == 0) {
					var message = "您没有在测试的版本需要跟踪！";
					var htmler = "<tr style='height: 50px;' name='datas'>";
					htmler += "<td colspan='7' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
					$("#main_table").append(htmler);
				} else {
					for ( var i = 0; i < versions.length; i++) {
						var version = versions[i];
						list_versions(version);
					}
					;
				}
				$("#float_div").hide();
				show_transfer("#main_table a", "float_div");
			}
		});
	};

	$(function() {
		get_user();
		$("#work_date").val(new Date().format("yyyy-MM-dd"));
		get_version();
	});
</script>

<body>
	<div id="float_div" class="float_div">
		<div id="float_head" class="float_head">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
		<div id="float_body">
			<table class='main_table' id='float_table'>
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='110px'>编号</th>
					<th width='80px'>状态</th>
					<th width='90px'>严重程度</th>
					<th width='70px'>优先级</th>
					<th width='90px'>耗时(小时)</th>
					<th width='90px'>修复次数</th>
					<th>摘要</th>
				</tr>
			</table>

			<table class='main_table' id='float_schedule' style="display: none;">
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='150px'>NEED号</th>
					<th width='150px'>SR号</th>
					<th width='120px'>CASE总数</th>
					<th width='120px'>执行率</th>
					<th width='120px'>通过率</th>
					<th>计划类型</th>
				</tr>
			</table>

			<table class='main_table' id='float_defect' style="display: none;">
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

			<table class='main_table' id='float_srs' style="display: none;">
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

			<table class='main_table' id='float_autotest' style="display: none;">
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='60px'>序号</th>
					<th width='150px'>JOB类型</th>
					<th width='200px'>版本号</th>
					<th width='60px'>环境</th>
					<th width='160px'>结束时间</th>
					<th width='80px'>运行总数</th>
					<th width='80px'>通过数</th>
					<th width='80px'>通过率</th>
					<th>JOB名称</th>
				</tr>
			</table>
		</div>
		<div id="float_gragh" style="height: 100%; width: 100%;"></div>
		<div id="float_foot" class="float_foot">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
	</div>

	<div id="container" style="min-width: 100%;">
		<table class='main_table' id='main_table'>
			<tr style='height: 60px; font-size: 20px; font-weight: 600;'>
				<td colspan='6' class='thead' id='main_head'>尊敬的 <span id="role_name" style="font-family: 黑体;"></span>，欢迎您！<br>以下是&nbsp;&nbsp;<span
					id="role_who" style="font-family: 黑体;"></span> <input class="cal-editor" type="text" id="work_date" maxlength="10"
					onclick="new Calendar().show(this);" onchange="get_version();" readonly="readonly"> 当日的待办工作一览
				</td>
			</tr>
			<tr style='height: 35px; font-size: 16px; font-weight: 500;'>
				<th width='17%' sortType='string'>在测版本</th>
				<th width='13%' sortType='string'>工作跟踪项</th>
				<th width='18%' sortType='string'>计划</th>
				<th width='12%' sortType='string'>当前进度</th>
				<th width='10%' sortType='string'>状态</th>
				<th width='30%' sortType='string'>提示</th>
			</tr>
		</table>
	</div>
</body>
</html>