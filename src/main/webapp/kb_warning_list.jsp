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
	function list_data() {
		var system_version = $("#system_version").val();
		if (system_version == null || system_version == undefined || system_version == '' || system_version == 'null') {
			if ($("#test_team").val().indexOf("无分组归属") > -1) {
				$("#table_body").remove();
				alert("不支持无分组归属的系统信息查询!");
				return false;
			}
		}

		$.ajax({
			async : true,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/warning_info',
			data : {
				"version" : $("#version").val(),
				"warning_date" : $("#warning_date").val(),
				"warning_grade" : $("#warning_grade").val()
			},
			success : function(result) {
				$("#table_body").remove();
				var htmler = "<div id='table_body' style='overflow:auto; height:200px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "恭喜您，版本进度正常！";
					htmler += "<tr style='height: 30px;'>";
					htmler += "<td colspan='5' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						var system_version = $("#version").val();
						var warning_date = jData.warning_date;
						var rule_name = jData.rule_name;
						var warning_info = jData.warning_info;
						var warning_type = jData.warning_type;
						var warning_grade = jData.warning_grade;
						var rule_no = jData.rule_no;
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='text-align:center; width: 210px;'>" + warning_date + "</td>";
						htmler += "<td style='text-align:center; width: 200px;'>" + rule_name + "</td>";

						if (warning_grade == 1) {
							htmler += "<td style='text-align:center; width: 180px; background-color: goldenrod;'>一般</td>";
						} else if (warning_grade == 2) {
							htmler += "<td style='text-align:center; width: 180px; background-color: salmon;'>严重</td>";
						} else if (warning_grade == 3) {
							htmler += "<td style='text-align:center; width: 180px; background-color: red;'>非常严重</td>";
						} else {
							htmler += "<td style='text-align:center; width: 180px; background-color: yellowgreen;'>提示</td>";
						}
						htmler += "<td style='text-align:center; width: 120px;'>" + jData.owner + "</td>";

						if (warning_type == '03') {
							htmler += "<td><a href='javascript:void(0)' onclick='warning_detail(\"" + system_version + "\", \"" + warning_date + "\", \"" + warning_type + "\", \"" + warning_grade + "\")'>缺陷修复超时，点击查看缺陷清单及超时明细</a></td>";
						} else if (warning_type == '04') {
							htmler += "<td><a href='javascript:void(0)' onclick='warning_detail(\"" + system_version + "\", \"" + warning_date + "\", \"" + warning_type + "\", \"" + warning_grade + "\")'>缺陷验证超时，点击查看缺陷清单及超时明细</a></td>";
						} else if (warning_type == '06') {
							htmler += "<td><a href='javascript:void(0)' onclick='warning_detail(\"" + system_version + "\", \"" + warning_date + "\", \"" + warning_type + "\", \"" + warning_grade + "\")'>" + warning_info + "，点击查看缺陷清单</a></td>";
						} else if (warning_type == '07') {
							if (warning_info.toUpperCase().indexOf("ST") > -1) {
								htmler += "<td><a href='javascript:void(0)' onclick='test_schedule(\"" + system_version + "\",\"ST\")'>" + warning_info + "</a></td>";
							} else if (warning_info.toUpperCase().indexOf("UAT") > -1) {
								htmler += "<td><a href='javascript:void(0)' onclick='test_schedule(\"" + system_version + "\",\"UAT\")'>" + warning_info + "</a></td>";
							} else {
								htmler += "<td><a href='javascript:void(0)' onclick='test_schedule(\"" + system_version + "\",\"all\")'>" + warning_info + "</a></td>";
							}
						} else if (warning_type == '02') {
							if (rule_no == '1') {
								htmler += "<td><a href='javascript:void(0)' onclick='bug_none_target(\"" + system_version + "\",\"1\")'>" + warning_info + "，点击查看缺陷清单</a></td>";
							} else if (rule_no == '2') {
								htmler += "<td><a href='javascript:void(0)' onclick='bug_none_target(\"" + system_version + "\",\"2\")'>" + warning_info + "，点击查看缺陷清单</a></td>";
							} else if (rule_no == '3') {
								htmler += "<td><a href='javascript:void(0)' onclick='warning_gragh(\"" + system_version + "\",\"1\")'>" + warning_info + "，点击查看缺陷分布情况</a></td>";
							} else if (rule_no == '4') {
								htmler += "<td><a href='javascript:void(0)' onclick='warning_gragh(\"" + system_version + "\",\"2\")'>" + warning_info + "，点击查看缺陷分布情况</a></td>";
							}
						} else if (warning_type == '01') {
							htmler += "<td><a href='javascript:void(0)' onclick='warning_gragh(\"" + system_version + "\",\"3\")'>" + warning_info + "，点击查看缺陷趋势情况</a></td>";
						} else {
							htmler += "<td>" + warning_info + "</td>";
						}
						htmler += "</tr>";
					}
				}

				htmler += "</table></div>";
				$("#container").append(htmler);
				div_height("table_body");
				$("#float_div").hide();
				show_transfer("#table_body a", "float_div");
			}
		});
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

	function get_version() {
		$('#version').get(0).options.length = 0;

		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(), true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(), true);
		}

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_versions',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(), true),
				"group_name" : group_name,
				"time_type" : decodeURIComponent($("#time_type").val(), true),
				"pro_date_begin" : decodeURIComponent($("#pro_date_begin").val(), true),
				"pro_date_end" : decodeURIComponent($("#pro_date_end").val(), true)
			},
			success : function(result) {
				versions = eval(result);
				for ( var y = 0; y < versions.length; y++) {
					var version = versions[y];
					$('#version').append("<option value=" + version + ">" + version + "</option>");
				}
			}
		});
	};

	function get_warn_date() {
		$('#warning_date').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_warn_date',
			data : {
				"version" : $("#version").val()
			},
			success : function(result) {
				warns = eval(result);
				$('#warning_date').append("<option selected=\"selected\" value='all'>全部</option>");
				for ( var x = 0; x < warns.length; x++) {
					$('#warning_date').append("<option value=" + warns[x] + ">" + warns[x] + "</option>");
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

	function set_system_version() {
		var system_version = $("#system_version").val();
		var warning_date = $("#sp_warn_date").val();
		if (system_version != null && system_version != undefined && system_version != '' && system_version != 'null') {
			$('#title-div').hide();
			$('#link').show();
			$('#version').append("<option value=" + system_version + " selected='selected'>" + system_version + "</option>");
			get_warn_date();

			if (warning_date != null && warning_date != undefined && warning_date != '' && warning_date != 'null') {
				$("#warning_date option[value='" + warning_date + "']").remove();
				$('#warning_date').append("<option value=" + warning_date + " selected='selected'>" + warning_date + "</option>");
			}
		} else {
			get_test_team('养老险测试组');
			set_default_date();
			get_version();
			get_warn_date();
		}
		list_data();
	};

	function warning_detail(system_version, warning_date, warning_type, warning_grade) {
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_table").height() - 60;
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/pro_detail',
			data : {
				"system_version" : system_version,
				"warning_date" : warning_date,
				"warning_type" : warning_type,
				"warning_grade" : warning_grade
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				for ( var i = 0; i < result.length; i++) {
					htmler += "<tr style='height: 25px;'>";
					var pro_id = result[i].pro_id;
					var pro_theme = result[i].pro_theme;
					var pro_status = result[i].pro_status;
					var pro_level = result[i].pro_level;
					var pro_pri = result[i].pro_pri;
					var hour_1 = result[i].hour_1;
					var bug_repare_no = parseInt(result[i].pro_nopass_num) + 1;

					htmler += "<td style='text-align:center; width: 110px;'>" + pro_id + "</td>";
					htmler += "<td style='text-align:center; width: 80px;'>" + pro_status + "</td>";
					htmler += "<td style='text-align:center; width: 90px;'>" + pro_level + "</td>";
					htmler += "<td style='text-align:center; width: 70px;'>" + pro_pri + "</td>";
					htmler += "<td style='text-align:center; width: 90px;'>" + hour_1 + "</td>";
					htmler += "<td style='text-align:center; width: 90px;'>" + bug_repare_no + "</td>";
					htmler += "<td>" + pro_theme + "</td>";
					htmler += "</tr>";
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_table");
			}
		});
		float_autofit();
	};

	function bug_none_target(system_version, rule_no) {
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_table").height() - 60;

		var req_url = "";
		if (rule_no == "1") {
			url = '/sqcs/bug_none_sr'
		} else if (rule_no == "2") {
			url = '/sqcs/bug_none_module'
		}
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : req_url,
			data : {
				"system_version" : system_version,
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				for ( var i = 0; i < result.length; i++) {
					var jsonData = result[i];
					var bug_repare_no = parseInt(jsonData.pro_nopass_num) + 1;

					htmler += "<tr style='height: 25px;'>";
					htmler += "<td style='text-align:center; width: 110px;'>" + jsonData.pro_id + "</td>";
					htmler += "<td style='text-align:center; width: 80px;'>" + jsonData.pro_status + "</td>";
					htmler += "<td style='text-align:center; width: 90px;'>" + jsonData.pro_level + "</td>";
					htmler += "<td style='text-align:center; width: 70px;'>" + jsonData.pro_pri + "</td>";
					htmler += "<td style='text-align:center; width: 90px;'>" + jsonData.hour_1 + "</td>";
					htmler += "<td style='text-align:center; width: 90px;'>" + bug_repare_no + "</td>";
					htmler += "<td>" + jsonData.pro_theme + "</td>";
					htmler += "</tr>";
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_table");
			}
		});
		float_autofit();
	};

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
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
				show_only_current("float_body", "float_schedule");
			}
		});
		float_autofit();
	};

	function bug_sr_gragh(system_version) {
		var myChart = echarts.init($("#float_gragh").get(0));
		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_sr_distribute',
			data : {
				"version" : system_version,
			},
			success : function(result) {
				result = result[0];
				var y_series;
				if (result.listYdata.length == 0 || result.listXdata.length == 0) {
					y_series = result.listYdata;
				} else {
					y_series = [ {
						data : result.listYdata[0].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{b} : {c} ({d}%)"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[0].name,
						type : result.listYdata[0].type,
						yAxis : result.listYdata[0].yAxis
					} ];
				}
				myChart.setTheme(theme);
				myChart.setOption({
					tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						itemGap : 10,
						padding : 0,
						orient : 'vertical',
						x : 'left',
						data : result.listXdata
					},
					toolbox : {
						show : true,
						itemGap : 10,
						padding : 0,
						orient : 'horizontal',
						x : 'right',
						y : 'top',
						feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {
				                show: true,
				                type: ['pie', 'funnel'],
				                option: {
				                    funnel: {
				                        x: '25%',
				                        width: '50%',
				                        funnelAlign: 'left',
				                        max: 1548
				                    }
				                }
				            },
				            restore : {show: true},
				            saveAsImage : {show: true}
						}
					},
					calculable : true,
					series : y_series
				});
			}
		});
	};

	function bug_module_gragh(system_version) {
		var myChart = echarts.init($("#float_gragh").get(0));
		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_distribute_version',
			data : {
				"version" : system_version
			},
			success : function(result) {
				result = result[0];
				var y_series;
				if (result.listYdata.length == 0 || result.listXdata.length == 0) {
					y_series = result.listYdata;
				} else {
					y_series = [ {
						data : result.listYdata[0].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{b} : {c} ({d}%)"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[0].name,
						type : result.listYdata[0].type,
						yAxis : result.listYdata[0].yAxis
					} ];
				}
				myChart.setTheme(theme);
				myChart.setOption({
					tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						itemGap : 10,
						padding : 0,
						orient : 'vertical',
						x : 'left',
						data : result.listXdata
					},
					toolbox : {
						show : true,
						itemGap : 10,
						padding : 0,
						orient : 'horizontal',
						x : 'right',
						y : 'top',
						feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {
				                show: true,
				                type: ['pie', 'funnel'],
				                option: {
				                    funnel: {
				                        x: '25%',
				                        width: '50%',
				                        funnelAlign: 'left',
				                        max: 1548
				                    }
				                }
				            },
				            restore : {show: true},
				            saveAsImage : {show: true}
						}
					},
					calculable : true,
					series : y_series
				});
			}
		});
	};

	function bug_trend_gragh(system_version) {

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
	};

	function warning_gragh(verNo, rule_type) {
		$("#float_div").show();
		$("#float_body").hide();
		$("#float_gragh").show();

		if (rule_type == "1") {
			bug_sr_gragh(verNo);
		} else if (rule_type == "2") {
			bug_module_gragh(verNo);
		} else if (rule_type == "3") {
			bug_trend_gragh(verNo);
		}
		$("#float_gragh").height($("#float_div").height() - 60);
	};

	function float_autofit() {
		var div_height = $("#float_div").height();
		$("#float_body").height(div_height - 60);
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

	function query_org() {
		if ($("#group_type").val() == 'test_team') {
			$("#test_team").show();
			$("#dev_dept").hide();
			get_test_team();
			get_version();
			list_data();
		} else {
			$("#dev_dept").show();
			$("#test_team").hide();
			get_dev_dept();
			get_version();
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
		set_system_version();
	});
</script>

<body>
	<%
		String system_version = request.getParameter("system_version");
		String warning_date = request.getParameter("warning_date");
	%>
	<input type="hidden" id="system_version" value="<%=system_version%>" />
	<input type="hidden" id="sp_warn_date" value="<%=warning_date%>" />
	<div id="float_div" class="float_div">
		<div id="float_head" class="float_head">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
		<div id="float_body">
			<table class='main_table' id='float_table' >
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

			<table class='main_table' id='float_schedule' style="display:none;">
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='150px'>NEED号</th>
					<th width='150px'>SR号</th>
					<th width='120px'>CASE总数</th>
					<th width='120px'>执行率</th>
					<th width='120px'>通过率</th>
					<th>计划类型</th>
				</tr>
			</table>
		</div>
		<div id="float_gragh" style="height:100%; width:100%;"></div>
		<div id="float_foot" class="float_foot">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
	</div>

	<div class="title-div" id="title-div">
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
			onchange="get_version();get_warn_date(); list_data();" readonly="readonly">
		<span class="label-text">止</span>
		<input class="cal-editor" type="text" id="pro_date_end" maxlength="10" onclick="new Calendar().show(this);"
			onchange="get_version();get_warn_date(); list_data();" readonly="readonly">
		<span class="label-text">版本</span>
		<select class="select" style="width:15%" id="version" onchange="get_warn_date(); list_data();"></select>
	</div>
    <div id="link" style="display:none; margin-bottom:10px;">
    	<a href="<%=basePath%>/kb_warning_list.jsp" onclick="$('#link').hide();"style="font-size:18px;">查看其他版本预警信息</a>
    </div>
	<div id="container" style="min-width: 100%;">
		<table class='main_table' id='main_table'>
			<tr style='height: 40px; font-size: 20px; font-weight: 600;'>
				<td colspan='5' class='thead'>预警信息——<a href="tools/warning_tips.jsp" target='_blank' style="font-size:20px;color:gold">点击这里查看风险预警规则说明</a></td>
			</tr>
			<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
				<th width='210px' sortType='date'>预警日期 <select class='select-mini' style='width: 120px;' id='warning_date' onchange='list_data();'></select>
				</th>
				<th width='200px' sortType='string'>预警类型</th>
				<th width='180px' sortType='string'>预警级别 <select class='select-mini' style='width: 95px;' id='warning_grade' onchange='list_data();'>
						<option value='all' selected='selected'>全部</option>
						<option value='0'>提示</option>
						<option value='1'>一般</option>
						<option value='2'>严重</option>
						<option value='3'>非常严重</option>
				</select>
				</th>
				<th width='120px' sortType='string'>责任人</th>
				<th>预警内容</th>
			</tr>
		</table>
	</div>
</body>
</html>