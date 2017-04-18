<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>质量技术支持平台</title>
</head>

<%@ include file="../pub_root.jsp"%>
<%@ include file="../gragh_pub_ntnas.jsp"%>

<body>
	<div class="gragh-title">
		<b>系统BUG模块分布</b>
	</div>
	<div id="container" style="min-width: 100%; height: 400px;"></div>
</body>

<script type="text/javascript">
	function list_data() {
		var myChart = echarts.init($('#container').get(0));
		var systemVal = $("#system").val();

		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_distribute_system',
			data : {
				"system" : systemVal
			},
			success : function(json) {
				result = json[0];
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
	}

	$(function() {
		get_test_team('养老险测试组');
		get_system();
		list_data();
	});
</script>
</html>