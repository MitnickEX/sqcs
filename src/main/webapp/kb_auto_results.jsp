<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title>质量技术支持平台</title>

<%@ include file="kb.jsp"%>
<%@ include file="list_style.jsp"%>
</head>
<script type="text/javascript">
	function show_gragh(){

		var myChart = echarts.init($('#div_gragh').get(0));

		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(),true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(),true);
		}

		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/auto_res_query',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(),true),
				"group_name" : group_name,
				"system" : $("#system").val(),
				"job_type" : $("#job_type").val(),
				"date_begin" : $("#date_begin").val(),
				"date_end" : addDays($("#date_end").val(), 1)
			},
			success : function(result) {
				result  = result[0];
				var barLegend = [];
				$.each(result.listYdata, function() {
					barLegend.push(this.name);
				});

				var y_axis, y_series;
				if (result.listYdata.length == 0 || result.listXdata.length == 0) {
					y_axis = [ {
						type : "no data",
						name : "no data",
						axisLabel : {
							formatter : '{value} '
						}
					}];
					y_series = result.listYdata;
				} else {
					y_axis = [ {
						type : result.listYdata[0].type,
						name : result.listYdata[0].name,
						axisLabel : {
							formatter : '{value} '
						}
					}, {
						type : result.listYdata[1].type,
						name : result.listYdata[1].name,
						axisLabel : {
							formatter : '{value} '
						}
					}, {
						type : result.listYdata[2].type,
						name : result.listYdata[2].name,
						min : 0,
						max : 100,
						splitNumber : 10,
						axisLabel : {
							formatter : '{value} %'
						}
					} ];
					y_series = [ {
						data : result.listYdata[0].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{c}"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[0].name,
						type : result.listYdata[0].type,
						yAxis : result.listYdata[0].yAxis
					},{
						data : result.listYdata[1].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{c}"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[1].name,
						type : result.listYdata[1].type,
						yAxis : result.listYdata[1].yAxis
					},{
						data : result.listYdata[2].data,
			            yAxisIndex: 1,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{c}%"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[2].name,
						type : result.listYdata[2].type,
						yAxis : result.listYdata[2].yAxis
					} ];
				}

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
						padding : 0,
						textStyle : {
							color : 'auto'
						},
						data : barLegend
					},

					toolbox : {
						show : true,
						itemGap : 10,
						padding : 0,
						orient : 'horizontal',
						x : 'right',
						y : 'top',
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
						'y' : 60,
						'y2' : 100
					},
					calculable : true,
					dataZoom : {
						show : true,
						realtime : true,
						start : 0,
						end : 100,
						backgroundColor : '#C4C4C4',
						dataBackgroundColor : '#C4C4C4',
						fillerColor : '#6390A8',
						handleColor : '#708090'
					},
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

					yAxis : y_axis,
					series : y_series
				});
			}
		});
	};

	function show_table(){
		var system_name = $("#system").val();
		var job_type = $("#job_type").find("option:selected").text();
		var date_begin = $("#date_begin").val();
		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(),true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(),true);
		}

		$("#table_body").remove();
		var htmler = "<div id='table_body' style='overflow:auto; height:200px;'><table class='main_table'>";

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/auto_group_query',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(),true),
				"group_name" : group_name,
				"system" : $("#system").val(),
				"job_type" : $("#job_type").val(),
				"date_begin" : date_begin,
				"date_end" : addDays($("#date_end").val(), 1)
			},
			success : function(result) {
				if (result.length == 0) {
					var message = "没有查询到满足条件的数据！";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='9' style='text-align:center; color:darkgreen; font-size: 20px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 80px; text-align: center;'>" + (i + 1) + " </td>";
						htmler += "<td style='width: 200px; text-align: center;'>" + jData.system_name + " </td>";
						htmler += "<td style='width: 200px; text-align: center;'>" + job_type + " </td>";
						htmler += "<td style='width: 120px; text-align: center;'>" + jData.start_date + "</td>";
						htmler += "<td style='width: 100px; text-align: center;'>" + jData.method_total + "</td>";
						htmler += "<td style='width: 100px; text-align: center;'>" + jData.method_pass_total + "</td>";
						htmler += "<td style='width: 100px; text-align: center;'><a href='javascript:void(0)' onclick='autotest_detail(\"" + jData.system_name
								+ "\",\"" + jData.start_date + "\",\"" + $("#job_type").val() + "\")'>" + jData.method_pass_rate + "%</a></td>";
						htmler += "<td style='width: 200px; text-align: center;'>" + jData.system_version + "</td>";
						htmler += "<td style='text-align: center;'>" + jData.run_env + " </td>";
						htmler += "</tr>";
					}
				}
			},
			failure : function(result){
				htmler += "<tr style='height: 50px;'>";
				htmler += "<td colspan='9' style='text-align:center; color: red; font-size: 20px;'>查询出错</td>";
				htmler += "</tr>";
			}
		});
		htmler += "</table></div>";
		$("#container").append(htmler);
		div_height("table_body");
		$("#float_div").hide();
		show_transfer("#table_body a", "float_div");
	};

	function autotest_detail(system_name, run_date, job_type){
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_autotest").height() - 60;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/auto_detail_query',
			data : {
				"system_name" : decodeURIComponent(system_name, true),
				"work_date" : decodeURIComponent(run_date, true),
				"job_type" : decodeURIComponent(job_type, true)
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "未查询到自动化运行明细结果！";
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
						htmler += "<td style='width: 160px; text-align: center;" + viewColor + "'>" + jData.complete_date + "</td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.total_no + "</td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.success_no + "</td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.success_rate + "%</td>";
						htmler += "<td style='width: 80px; text-align: center;" + viewColor + "'>" + jData.run_env + "</td>";
						htmler += "<td style='width: 200px; text-align: center;" + viewColor + "'>" + jData.system_version + " </td>";
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

	function get_dev_dept(defaults) {
		$('#dev_dept').get(0).options.length = 0;

		$.ajax({
			async : false,
			type : 'POST',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_dept',
			dataType : 'JSON',
			success : function(teamResult) {
				teams = teamResult.listdata;

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
				$('#system').append("<option value='all'>===全部系统===</option>");
				for ( var y = 0; y < systems.length; y++) {
					var system = systems[y];
					$('#system').append("<option value=" + system + ">" + system + "</option>");
				}
			}
		});
	};

	function get_job_type(){
		$('#job_type').get(0).options.length = 0;

		$.ajax({
			async: false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/query_job_type',
			success : function(json) {
				data = eval(json);
				for ( var y = 0; y < data.length; y++) {
					var jobType = data[y];
					$('#job_type').append("<option value=" + jobType.job_type + ">" + jobType.full_name + "</option>");
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

		$("#date_begin").val(begin_date);
		$("#date_end").val(end_date);
	};

	function check_obtain() {
		if ($("#test_team").val().indexOf("无分组归属") > -1) {
			$("#table_body").remove();
			alert("不支持无分组归属的系统信息查询!");
			return false;
		} else {
			get_system();
			get_job_type();
			list_data();
		}
	};

	function query_org(){
		if ($("#group_type").val() == 'test_team') {
			$("#test_team").show();
			$("#dev_dept").hide();
			get_test_team();
			get_system();
			get_job_type();
		} else {
			$("#dev_dept").show();
			$("#test_team").hide();
			get_dev_dept();
			get_system();
			get_job_type();
		}
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


	function list_data() {
		if ($("#show_type").val() == "gragh"){
			$("#show_gragh").show();
			$("#container").hide();
			show_gragh();
		} else {
			$("#container").show();
			$("#show_gragh").hide();
			show_table();
		}
	};

	$(function() {
		set_default_date();
		get_test_team('养老险测试组');
		get_system();
		get_job_type();
		list_data();
	});
</script>

<body>
	<div class="title-div">
		<span class="label-text">查询组织</span>
		<select class="select" style="width:8%" id="group_type" onchange="query_org();check_obtain();">
			<option value="test_team">测试分组</option>
			<option value="dev_dept">开发部门</option>
		</select>

		<select class="select" style="width:15%; display:none;" id="dev_dept" onchange="check_obtain();"></select>
		<select class="select" style="width:15%;" id="test_team" onchange="check_obtain();"></select>
		<select class="select" style="width:15%" id="system" onchange="list_data();"></select>
		<select class="select" style="width:200px;" id="job_type" onchange="list_data();"></select>
		<select class="select" style="width:150px;" id="show_type" onchange="list_data();">
			<option value="gragh" selected="selected">图形化展示</option>
			<option value="table">数据表展示</option>
		</select>
		<span class="label-text">起</span>
		<input class="cal-editor" type="text" id="date_begin" maxlength="10"
				onclick="new Calendar().show(this);" onchange="list_data();" readonly="readonly">
		<span class="label-text">止</span>
		<input class="cal-editor" type="text" id="date_end" maxlength="10"
				onclick="new Calendar().show(this);" onchange="list_data();" readonly="readonly">
	</div>

	<div id="show_gragh" style="display:block;">
		<div class="gragh-title">
			<b>自动化测试结果趋势图</b>
		</div>
		<div id="div_gragh" style="min-width: 100%; height: 550px;" align="center"></div>
		<div class="tips">提示：左侧Y轴对应柱状图数据显示，右侧Y轴对应线状图数据显示</div>
	</div>

	<div id="container" style="display:none;">
		<table class='main_table' id='main_table'>
			<tr style='height: 40px; font-size: 18px; font-weight: 600;'>
				<th colspan='9' class='thead'>自动化测试运行结果</th>
			</tr>
			<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
				<th width='80px' sortType='num'>序号</th>
				<th width='200px' sortType='string'>子系统</th>
				<th width='200px' sortType='string'>JOB类型</th>
				<th width='120px' sortType='date'>运行日期</th>
				<th width='100px' sortType='num'>运行总数</th>
				<th width='100px' sortType='num'>运行通过数</th>
				<th width='100px' sortType='string'>运行通过率</th>
				<th width='200px' sortType='string'>运行版本号</th>
				<th sortType='string'>运行环境</th>
			</tr>
		</table>
	</div>

	<div id="float_div" class="float_div">
		<div id="float_head" class="float_head">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
		<div id="float_body">
			<table class='main_table' id='float_autotest'>
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='60px'>序号</th>
					<th width='150px'>JOB类型</th>
					<th width='160px'>结束时间</th>
					<th width='80px'>运行总数</th>
					<th width='80px'>通过数</th>
					<th width='80px'>通过率</th>
					<th width='80px'>环境</th>
					<th width='200px'>版本号</th>
					<th>JOB名称</th>
				</tr>
			</table>
		</div>
		<div id="float_foot" class="float_foot">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
	</div>
</body>
</html>
