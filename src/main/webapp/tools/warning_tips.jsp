<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3.org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<%@ include file="../list_style.jsp"%>

<head>
<title>质量技术支持平台</title>

<style>
td {
	border: 1px solid #CCC;
	font-family: Arial, 华文细黑;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	background-color: floralwhite;
	font-size: 16px;
}

th {
	border: 1px solid #CCC;
	background-color: rgba(190, 190, 190, 0.8);
	font-family: 微软雅黑;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	font-size: 20px;
}

.warning_tips {
	border: 1px solid #CCC;
	font-family: Arial, 华文细黑;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	background-color: floralwhite;
	font-size: 16px;
	font-style: italic;
}

.warning_type{
	border: 1px solid #CCC;
	font-family: Arial, 华文细黑;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	background-color: floralwhite;
	font-size: 16px;
	font-weight: 600;
	text-align: left;
}

.warning_grade{
	border: 1px solid #CCC;
	font-family: Arial, 华文细黑;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	background-color: floralwhite;
	font-size: 16px;
	font-weight: 600;
	text-align: center;
}

.head {
	text-align: center;
	border: 1px solid #CCC;
	background-color: rgba(150, 145, 180, 0.8);
	color: white;
	height: 40px;
}
</style>
</head>


<body>
	<div id="container" style="min-width: 100%;">
		<table class='main_table'>
			<tr>
				<th class='head' colspan=5>软件开发过程质量风险指示规则说明</th>
			</tr>
			<tr>
				<th colspan=2 style='width:25%;'>预警内容</th>
				<th style='width:10%;'>预警级别</th>
				<th style='width:25%;'>预警规则</th>
				<th style='width:40%;'>举例说明</th>
			</tr>
			<tr>
				<td rowspan=3 colspan=2 class='warning_type'>缺陷发现效率异常</td>
				<td class='warning_grade'>一般</td>
				<td>实际发现缺陷数与预期应发现缺陷数偏差达20%</td>
				<td rowspan=3 class='warning_tips'>例如，2015-7-27号预期应累积发现10个缺陷，但实际累积发现了5个缺陷，那实际发现缺陷数与预期应发现缺陷数偏差50%<br>
				&nbsp;&nbsp;&nbsp;&nbsp;预期应发现缺陷数计算方法参见 <a href='https://en.wikipedia.org/wiki/Gompertz_distribution' target='_blank' style='gold;'>[Gompertz模型]</a></td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>实际发现缺陷数与预期应发现缺陷数偏差达50%</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>实际发现缺陷数与预期应发现缺陷数偏差达80%</td>
			</tr>
			<tr>
				<td colspan=2 class='warning_type'>缺陷修复效率异常</td>
				<td class='warning_grade'>一般</td>
				<td>已修复缺陷与已发现缺陷数量偏差值大于20%</td>
				<td class='warning_tips'>例如，2015-7-27号累积发现10个缺陷，开发仅修复了7个缺陷，那已修复缺陷数与发现缺陷数偏差30%，如果缺陷在7月27号晚些时间发现，会存在一定的误差</td>
			</tr>
			<tr>
				<td colspan=2 class='warning_type'>缺陷验证效率异常</td>
				<td class='warning_grade'>一般</td>
				<td>已验证缺陷与已修复缺陷数量偏差值大于20%</td>
				<td class='warning_tips'>例如，2015-7-27号累积修复10个缺陷，测试仅验证了7个缺陷，那已验证缺陷数与修复缺陷数偏差30%，如果缺陷在7月27号晚些时间修复，会存在一定的误差</td>
			</tr>
			<tr>
				<td rowspan=12 class='warning_type'>缺陷分布异常</td>
				<td rowspan=3 class='warning_type'>未关联SR缺陷异常</td>
				<td class='warning_grade'>一般</td>
				<td>未关联SR的缺陷占比达到20%</td>
				<td rowspan=3 class='warning_tips'>例如，一个版本共发现10个缺陷（不包含部署、开发、UAT上报缺陷），有3个缺陷未关联SR，未关联SR缺陷比例为30%</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>未关联SR的缺陷占比达到50%</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>未关联SR的缺陷占比达到80%</td>
			</tr>
			<tr>
				<td rowspan=3 class='warning_type'>未关联模块缺陷异常</td>
				<td class='warning_grade'>一般</td>
				<td>未关联模块的缺陷占比达到20%</td>
				<td rowspan=3 class='warning_tips'>例如，一个版本共发现10个缺陷（不包含部署、开发、UAT上报缺陷），有3个缺陷未关联模块，未关联模块的缺陷比例为30%</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>未关联模块的缺陷占比达到50%</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>未关联模块的缺陷占比达到80%</td>
			</tr>
			<tr>
				<td rowspan=3 class='warning_type'>单个SR缺陷占比超出均值异常</td>
				<td class='warning_grade'>一般</td>
				<td>单个SR缺陷占比超出均值达20%</td>
				<td rowspan=3 class='warning_tips'>例如，一个版本有2个SR,共发现10个缺陷（不包含部署、开发、UAT上报缺陷），每个SR发现缺陷均值为5个，其中一个SR发现了8个缺陷，则超出均值30%=(8/10-5/10)*100%</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>单个SR缺陷占比超出均值达50%</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>单个SR缺陷占比超出均值达80%</td>
			</tr>
			<tr>
				<td rowspan=3 class='warning_type'>单个模块缺陷占比超出均值异常</td>
				<td class='warning_grade'>一般</td>
				<td>单个模块缺陷占比超出均值达20%</td>
				<td rowspan=3 class='warning_tips'>例如，一个版本共发现10个缺陷（不包含部署、开发、UAT上报缺陷），分布在2个模块，每个模块发现缺陷均值为5个，其中一个模块发现了8个缺陷，则超出均值30%=(8/10-5/10)*100%</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>单个模块缺陷占比超出均值达50%</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>单个模块缺陷占比超出均值达80%</td>
			</tr>
			<tr>
				<td rowspan=3 colspan=2 class='warning_type'>缺陷修复时效异常</td>
				<td class='warning_grade'>一般</td>
				<td>L1缺陷修复时间超过4个工作时；L2、L3缺陷修复时间超过8个工作时</td>
				<td rowspan=3 class='warning_tips'>8个工作时 &lt;= 一个L3的缺陷修复时间 &lt; 16个工作时，那么预警级别为一般
				<br>8个工作时 &lt;= 一个L1的缺陷修复时间 &lt; 16个工作时，那么预警级别为严重
				<br>任意缺陷修复时间 >= 24个工作时，那么预警级别为非常严重
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;——其他级别计算方法类同</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>L1缺陷修复时间超过8个工作时；L2、L3缺陷修复时间超过16个工作时</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>缺陷修复时间超过24个工作时</td>
			</tr>
			<tr>
				<td rowspan=3 colspan=2 class='warning_type'>缺陷验证时效异常</td>
				<td class='warning_grade'>一般</td>
				<td>缺陷验证时间超过4个工作时</td>
				<td rowspan=3 class='warning_tips'>4个工作时 &lt;= 任意缺陷的验证时间 &lt;= 8个工作时，那么预警级别为一般
				<br>8个工作时 &lt;= 任意缺陷的验证时间 &lt;= 24个工作时，那么预警级别为严重
				<br>任意缺陷修复时间 >= 24个工作时，那么预警级别为非常严重</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>缺陷验证时间超过8个工作时</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>缺陷验证时间超过24个工作时</td>
			</tr>
			<tr>
				<td rowspan=3 colspan=2 class='warning_type'>缺陷反复修复异常</td>
				<td class='warning_grade'>一般</td>
				<td>缺陷修改2次</td>
				<td rowspan=3 class='warning_tips'>例如：一个缺陷修改次数为2次，那么预警级别为一般</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>缺陷修改3次</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>缺陷修改4次及以上</td>
			</tr>
			<tr>
				<td rowspan=3 colspan=2 class='warning_type'>ST测试进度异常</td>
				<td class='warning_grade'>一般</td>
				<td>ST执行率滞后达到20%</td>
				<td rowspan=3 class='warning_tips'>例如，某个版本截至预警时间当天ST计划执行率为60%，如果实际执行了35%，则滞后25%</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>ST执行率滞后达到50%</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>ST执行率滞后达到80%</td>
			</tr>
			<tr>
				<td rowspan=3 colspan=2 class='warning_type'>UAT测试进度异常</td>
				<td class='warning_grade'>一般</td>
				<td>UAT执行率滞后达到20%</td>
				<td rowspan=3 class='warning_tips'>例如，某个版本截至预警时间当天UAT计划执行率为60%，如果实际执行了35%，则滞后25%</td>
			</tr>
			<tr>
				<td class='warning_grade'>严重</td>
				<td>UAT执行率滞后达到50%</td>
			</tr>
			<tr>
				<td class='warning_grade'>特别严重</td>
				<td>UAT执行率滞后达到80%</td>
			</tr>
		</table>
	</div>
</body>
</html>