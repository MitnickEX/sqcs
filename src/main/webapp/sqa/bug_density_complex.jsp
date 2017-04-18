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
		<b>缺陷密度综合分析图</b>
	</div>
	<div id="container" style="min-width: 100%; height: 400px;"></div>
	<div style="height: 40px; line-height: 40px;" align="center">提示：左侧Y轴对应人力、生产缺陷、SR数的数据显示，右侧Y轴对应缺陷密度数据显示</div>
</body>

<script type="text/javascript">
	function list_data() {

		var myChart = echarts.init($('#container').get(0));
		var pro_date_begin = $("#pro_date_begin").val();
		var end_date = $("#pro_date_end").val();
		var pro_date_end = addDays(end_date, 1);
		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_density_complex',
			data : {
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
								type : [ 'line', 'bar' ]
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
						'x2' : 50,
						'y' : 60,
						'y2' : 120
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

					yAxis : [ {
						type : 'value',
						name : '累计缺陷',
						axisLabel : {
							formatter : '{value} '
						}
					}, {
						type : 'value',
						name : '缺陷密度',
						axisLabel : {
							formatter : '{value} '
						},
						boundaryGap : [ 0, 0.5 ]
					} ],
					series : result.listYdata
				});
			}
		});
	}
	$(function() {
		get_test_team('养老险测试组');
		get_system();
		$("#system option[value='all']").remove();
		list_data();
	});
</script>
</html>