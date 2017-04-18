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
		<b>版本预警级别分布</b>
	</div>
	<div id="container" style="min-width: 100%; height: 350px;"></div>
</body>

<script type="text/javascript">
	function list_data() {
		var myChart = echarts.init($('#container').get(0));
		var versionVal = $("#version").val();
		$.ajax({
			async : true,
			type : 'POST',
			dataType : 'JSON',
			url : '/sqcs/warn_grade_rm',
			data : {
				"system_version" : versionVal,
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
						trigger : 'item',
						formatter : "{a} <br/>{b} : {c} ({d}%)"
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
					calculable : true,
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