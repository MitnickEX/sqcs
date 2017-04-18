<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>质量技术支持平台</title>
</head>

<%@ include file="../pub_root.jsp"%>
<%@ include file="../gragh_pub_htas.jsp"%>

<body>
	<div class="gragh-title">
		<b>版本发布延期分析</b>
	</div>
	<div id="container" style="min-width: 100%; height: 500px; background-color: rgb(250, 250, 210)"></div>
</body>

<script type="text/javascript">
	function list_data() {
		var myChart = echarts.init($('#container').get(0));
		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(), true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(), true);
		}
		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/release_ana',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(), true),
				"group_name" : group_name,
				"system" : $("#system").val(),
				"pro_date_begin" : $("#pro_date_begin").val(),
				"pro_date_end" : addDays($("#pro_date_end").val(), 1),
				"time_type" : decodeURIComponent($("#time_type").val(), true)
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

	$(function() {
		get_test_team('养老险测试组');
		get_system();
		list_data();
	});
</script>
</html>
