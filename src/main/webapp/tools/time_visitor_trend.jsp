<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>质量技术支持平台</title>
</head>
<%@ include file="../pub_root.jsp"%>
<%@ include file="../gragh_pub.jsp"%>

<body>
	<div class="title-div">
		<div style="float: right">
			<span class="label-text">统计时间起</span> <input class="cal-editor" type="text" id="pro_date_begin" maxlength="10"
				onclick="new Calendar().show(this);" onchange="list_data();" readonly="readonly"> <span class="label-text">止</span>
			<input class="cal-editor" type="text" id="pro_date_end" maxlength="10" onclick="new Calendar().show(this);"
				onchange="list_data();" readonly="readonly">
		</div>
	</div>
	<div class="gragh-title">
		<b>访问量趋势分析</b>
	</div>
	<div id="container" style="min-width: 100%; height: 450px;" align="center"></div>
	<div style="height: 40px; line-height: 40px;" align="center">提示拖动两端滑块可改变时间区间</div>
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
			url : '/sqcs/visitor_trend',
			data : {
				"pro_date_begin" : pro_date_begin,
				"pro_date_end" : pro_date_end
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
							dataZoom : {
								show : true,
								realtime : true,
								start : 10,
								end : 100
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
						'y' : 40,
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
						name : '访问量',
						axisLabel : {
							formatter : '{value}'
						}
					} ],

					series : result.listYdata
				});
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

	$(function() {
		set_default_date();
		list_data();
	});
</script>
</html>