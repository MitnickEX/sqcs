<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>质量技术支持平台</title>
</head>

<%@ include file="../pub_root.jsp"%>
<%@ include file="../warning/warn_pub_dept.jsp"%>

<body>
	<div class="gragh-title">
		<b>按版本缺陷修复时效汇总</b>
	</div>
	<div id="container" style="min-width: 100%; height: 400px;" align="center"></div>
</body>

<script type="text/javascript">
	function list_data() {
		
		var myChart = echarts.init($('#container').get(0));
		var Msg = '';
		$.ajax({
			async : true,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/bug_repair_dept_rm',
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
						'y' : 40,
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
						name : '缺陷数',
						boundaryGap : [ 0, 0.5 ]
					} ],

					series : result.listYdata
				});
			}
		});
	}

	$(function() {
		get_dev_dept('养老险系统开发部');
		set_default_date();
		list_data();
	});
</script>
</html>