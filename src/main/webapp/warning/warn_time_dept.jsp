<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>质量技术支持平台</title>
</head>
<%@ include file="../pub_root.jsp"%>
<%@ include file="./warn_pub_dept.jsp"%>

<body>
	<div class="gragh-title">
		<b>部门预警时间分布</b>
	</div>
	<div id="container" style="min-width: 100%; height: 350px;"></div>
</body>

<script type="text/javascript">
	function list_data() {
		
		var myChart = echarts.init($('#container').get(0));
		$.ajax({
			async : true,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/warn_time_dept',
			data : {
				"dev_dept" : decodeURIComponent($("#dev_dept").val(), true),
				"start_date" : decodeURIComponent($("#start_date").val(), true),
				"end_date" : decodeURIComponent($("#end_date").val(), true)
			},

			success : function(result) {
				result = result[0];
				var barLegend = [];
				$.each(result.listYdata, function() {
					barLegend.push(this.name);
				});
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
									formatter : "{a} <br/>{b} : {c} ({d}%)"
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
						name : '预警数',
						axisLabel : {
							formatter : '{value}'
						}
					} ],
					series : y_series
				});
			}
		});
	};

	$(function() {
		get_dev_dept('养老险系统开发部');
		set_default_date();
		list_data();
	});
</script>

</html>