<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>质量技术支持平台</title>
</head>
<%@ include file="../pub_root.jsp"%>
<%@ include file="../gragh_pub_version.jsp"%>

<body>
	<div class="gragh-title">
		<b>SR缺陷密度（缺陷数/人日）</b>
	</div>
	<div id="container" style="min-width: 100%; height: 450px;"></div>
</body>

<script type="text/javascript">
	function list_data() {
		
		var myChart = echarts.init($('#container').get(0));
		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_sr_density',
			data : {
				"version" : $("#version").val()
			},
			success : function(json) {
				result = json[0];
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
							dataView : {
								show : true,
								readOnly : false
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
						'y' : 60,
						'y2' : 100
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

					yAxis : [ {
						type : 'value',
						name : 'BUG密度',
						boundaryGap : [ 0, 0.5 ]
					} ],
					series : y_series
				});
			}
		});
	}

	$(function() {
		get_test_team('养老险测试组');
		get_version();
		list_data();
	});
</script>
</html>
