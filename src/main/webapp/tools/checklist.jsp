<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<!-- BEGIN HEAD -->

<head>
<title>探索测试检查单</title>
</head>

<%@ include file="../kb.jsp"%>

<style type="text/css">
* {
	-webkit-margin-before: 0px;
	-webkit-margin-after: 0px;
	-webkit-padding-start: 10px;
	text-shadow: none;
	margin: 0;
	padding: 0;
}

.menu-frame {
	z-index: 2;
	width: 16.50%;
	display: inline-block;
	vertical-align: top;
}

.menu-frame .topic-head {
	z-index: 2;
	background-color: rgba(100, 100, 150, 0.9);
	padding-left: 20px;
	padding-right: 20px;
	text-align: left;
	font-size: 20px;
	color: ghostwhite;
	font-weight: 500;
	font-family: 微软雅黑;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	border: 1px solid rgba(100, 100, 150, 0.9);
	text-align: center;
}

.topic-head:hover {
	color: orange;
}

.main-frame {
	z-index: 1;
	width: 82%;
	display: inline-block;
	position: absolute;
	right: 2px;
	left: auto;
	overflow: auto;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	border: 1px solid rgba(100, 100, 150, 0.9);
}

.topic-child-title {
	z-index: 1001;
	text-decoration: none;
	color: ghostwhite;
	font-weight: 600;
	font-size: 18px;
	font-family: "Vrinda", "微软雅黑";
}

.topic-child-title:hover {
	font-size: 20px;
	font-weight: 600;
	font-family: 微软雅黑;
	color: orange;
}

span {
	border: none;
}

body {
	padding-left: 1px;
	padding-right: 1px;
	padding-bottom: 10px;
}

.first-ul {
	font-size: 18px;
	margin-left: 25px;
	type: circle;
	font-weight: 500;
}

.second-ul {
	font-size: 16px;
	margin-left: 30px;
	type: circle;
}

li{
	line-height: 30px;
}
</style>

<script type="text/javascript">
	var auto_fit = function() {
		var div_height = $(document).height() - 120;
		var line_height = parseInt(div_height / 3.04);
		$("#menu-frame").height(div_height);
		$("#main-frame").height(div_height);

		var heads = $(".topic-head");

		for ( var i = 0; i < heads.length; i++) {
			heads.eq(i).css("line-height", line_height + "px");
			if (i != 0) {
				heads.eq(i).css("margin-top", "1px");
			}
		}
	};

	function hideAllContent() {
		$('#content1').hide();
		$('#content2').hide();
		$('#content3').hide();
	}

	$(function() {
		auto_fit();

		hideAllContent();
		$('#link1').click(function() {
			hideAllContent();
			$('#content1').show();
		});
		$('#link2').click(function() {
			hideAllContent();
			$('#content2').show();
		});
		$('#link3').click(function() {
			hideAllContent();
			$('#content3').show();
		});
	});
</script>

<body>
	<div class="menu-frame" id="menu-frame">
		<div class="topic-head">
			<a id="link1" class="topic-child-title" href="#">需求探索准备工作</a>
		</div>

		<div class="topic-head">
			<a id="link2" class="topic-child-title" href="#">需求探索检查单</a>
		</div>

		<div class="topic-head">
			<a id="link3" class="topic-child-title" href="#">系统测试探索检查单</a>
		</div>
	</div>
	<div class="main-frame" id="main-frame">
		<div id="content1" style="display: none;">
			<br>
			<ul class="first-ul">
				<li>向用户或者BA/SA索取原始需求文档；</li>
				<li>仔细阅读需求文档，大致估算系统改动；</li>
				<li>向开发人员了解预计的开发工作量，并且相互印证系统改动的估算；</li>
				<li>了解需求排期，预估测试所需人力，估算时需要考虑关联影响测试；</li>
				<li>了解相同和接近的版本周期内的其他需求和版本，预估测试环境和人力是否足够，如果有可能资源不足 则及时升级并且邀请测试经理参与需求评审会议。</li>
			</ul>
		</div>
		<div id="content2" style="display: none;">
			<br>
			<ul class="first-ul">
				<li>本需求提出的背景：现有功能有什么样的问题、由什么市场、行业的变化所导致？</li>
				<li>本需求所要实现的目标：操作流程简化、业务成本降低或者客户满意度提高等等？</li>
				<li>本需求是否有前置和后续需求排期？其优先级是否合理，实现情况分别是怎样的？</li>
				<li>本需求的内容是否会与现有业务逻辑或者系统逻辑的冲突？如果有，该如何解决？</li>
				<li>本需求所包含内容是否有冗余：与现有某些系统功能或流程重复，造成重复开发？</li>
				<li>本需求是否有足够的资源去实现，包括测试人力、开发人力或者测试环境等资源？</li>
				<li>本需求完成之后的效益是否足够抵消其在IT版本的成本投入？是否可能会出现在这个需求上“得不偿失”或者说“入不敷出”的情况？</li>
				<li>本需求用户验收测试有什么样的案例？对应的数据类型和数据量的需求是怎样的？</li>
				<li>本需求的UAT所需要的时间应该有多少？用户是否有足够的测试人力投入？IT应该保证的最短UAT时间需要多少天？</li>
				<li>UAT人员是否有就此需求测试的其他特殊要求或疑问？如果有，这些要求是否合理、是否有必要、是否需要IT同事支持或者是否有变通解决方法？</li>
				<li>考虑是否有关联系统，是否有相对应的版本支持？如果有关联版本，相关测试人员还要考虑系统间是如何交互的，避免漏测；</li>
				<li>考虑是否需要与外部平台联测，比如支付、新农合，考虑外部平台可以联测的时间点，联测之前需要保证本系统功能正确；</li>
			</ul>
		</div>
		<div id="content3" style="display: none;">
			<br>
			<ul class="first-ul">
				<li>用例描述、操作步骤、预期结果和数据使用等信息是否准确、完整、无歧义；</li>
				<li>用例是否包含了足够多的业务类型分支或数据场景分支；</li>
				<li>用例中是否设计了操作源表包含百、万、百万甚至亿级数据，结果集输出包含十、百、千等不同级别的数据场景，对其性能是否可接受是否有可行的验证方法；</li>
				<li>用例是否考虑了用户使用的频率，若使用非常频繁，那么是否需要做并发测试；</li>
				<li>被测功能是否为无操作界面的系统自动任务，若无操作界面，那么用例中是否考虑了用户测试的方法；若有界面，是否有界面规范性性检查测试用例；</li>
				<li>对于查询、报表类功能：
					<ul class="second-ul">
						<li>用例设计是否包含对查询结果完整性、显示格式、排序等方面的检查；</li>
						<li>用例是否包含足够的必输项和页面控制的检查，空值查询的数据库消耗是否正常；</li>
						<li>用例对不同查询条件的组合场景设计是否充分；</li>
						<li>用例是否检查了对于有导出EXCEL等文本的情况，导出查询是否同步修改；</li>
						<li>报表生成过程中是否涉及后台数据的变化，即：是否涉及中间表、临时表的使用，如有，那么用例是否包含对计算过程中的中间表、临时表的数据正确性检查；</li>
						<li>用例是否考虑了现有测试数据库的数据是否满足测试要求，是否需要造数据或者导生产数据，测试数据与用户验收测试是否可以共用等因素；</li>
					</ul>
				</li>
				<li>对于业务操作类功能：
					<ul class="second-ul">
						<li>被测功能中是否包含查询功能，如果包含则参见查询、报表类功能评审检查点；</li>
						<li>用例中对操作产生的数据状态的流转是否有清晰的说明；</li>
						<li>用例是否包含了对可逆数据的反复正向、逆向操作结果正确性的检查；</li>
						<li>对于可能发生的异常，是否设计了足够多的场景，对于发生异常之后的应用健康度是否有检查，在异常场景中，是否包含对产生脏数据的可能性的检查；</li>
						<li>对于涉及ETL等数据同步功能或涉及不同数据库或数据表之间数据交换的功能，是否有对不同数据库、数据表的字段和前后台字段类型、长度一致性的检查；</li>
						<li>针对本需求的修改点，是否设计了对其关联功能或潜在关联影响的测试用例，关联影响分析的依据是什么；</li>
						<li>对界面操作的后台日志记录是否有检查其完整性和正确性，是否有单独开发监控程序的必要；</li>
						<li>用例的优先级是怎样的，对应功能不可用的情况下，其他测试用例的执行是否受到影响，对于这种情况是否有规避的方法； 反之本测试用例是否受制于其他测试用例执行结果的正确性，如果是则又该如何解决；</li>
						<li>用例执行的前置条件是否清楚，如：测试执行时是否需要依赖特殊外设或者硬件资源、关联系统的版本进度和质量等；</li>
						<li>是否需要为本用例所对应的功能新建功能点或分支，用例是否需要加入到回归测试用例中，本测试用例是否可自动化，是否可以立即自动化， 自动化脚本开发预计需要多少时间；</li>
						<li>测试用例需要考虑是否存在历史数据，以及对历史数据的处理；</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>