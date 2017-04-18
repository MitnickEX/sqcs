<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>质量技术支持平台</title>
</head>

<%@ include file="../pub_root.jsp"%>
<%@ include file="../gragh_pub_htnas.jsp"%>

<body>
	<div class="gragh-title">
		<b>缺陷发现趋势分析图</b>
	</div>
	<div id="container" style="min-width: 100%; height: 450px;" align="center"></div>
	<div style="height: 40px; line-height: 40px;" align="center">提示：拖动两端滑块可改变时间区间</div>
</body>

<script type="text/javascript">
	function list_data() {
		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(), true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(), true);
		}

		var myChart = echarts.init($('#container').get(0));
		var pro_date_begin = $("#pro_date_begin").val();
		var end_date = $("#pro_date_end").val();
		var pro_date_end = addDays(end_date, 1);
		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_by_system',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(), true),
				"group_name" : group_name,
				"system" : $("#system").val(),
				"pro_date_begin" : pro_date_begin,
				"pro_date_end" : pro_date_end
			},

			success : function(json) {
				result = json[0];
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
							mark : {
								show : true
							},
							dataView : {
								show : true,
								readOnly : false
							},
							magicType : {
								show : true,
								type : [ 'line', 'bar', 'stack', 'tiled' ]
							},
							restore : {
								show : true
							},
							saveAsImage : {
								show : true
							}
						}
					},
					grid : {
						'x' : 50,
						'x2' : 20,
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
						data : result.listXdata,

						axisLabel : {
							rotate : 30
						},
						type : 'category',
						boundaryGap : false,
						splitLine : {
							show : false
						}
					} ],

					yAxis : [ {
						type : 'value',
						name : '缺陷个数',
						axisLabel : {
							formatter : '{value}'
						}
					} ],

					series : result.listYdata
				});
			}
		});
	};

	$(function() {
		get_test_team('养老险测试组');
		get_system();
		list_data();
	});
</script>
</html>