<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3.org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<%@ include file="kb.jsp"%>
<%@ include file="env_pub.jsp"%>

<head>
<title>质量技术支持平台</title>
<script type="text/javascript">
	function list_data() {
		var group_name = "";
		if ($("#group_type").val() == "test_team") {
			group_name = decodeURIComponent($("#test_team").val(),true);
		} else {
			group_name = decodeURIComponent($("#dev_dept").val(),true);
		}

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/env_list_query',
			data : {
				"group_type" : decodeURIComponent($("#group_type").val(),true),
				"group_name" : group_name,
				"system_name" : $("#system").val()
			},
			success : function(result) {
				$("#table_body").remove();

				var htmler = "<div id='table_body' style='overflow:auto; height:200px;'><table class='main_table'>";

				for ( var i = 0; i < result.length; i++) {
					var system_id = result[i].system_id;
					var system_name = result[i].system_name;
					var instance_name = result[i].instance_name;
					var login_address = result[i].login_address;
					var system_version = result[i].system_version;
					var jdbc_tns = result[i].jdbc_tns;
					var urlArray = login_address.split(";");
					var real_url;
					var params = "system_id;" + system_id;
					var modifyUrl = "envinfo/showDetail.jsp";
					var deleteUrl = "delAction.action";
					var modifyTarget = "_blank";
					var deleteTarget = "_self";
					htmler += "<tr style='height: 25px;'>";
					htmler += "<td style='width: 180px; word-break:break-all'>" + system_name.toUpperCase() + "</td>";
					htmler += "<td style='width: 200px; word-break:break-all'>" + instance_name.toLowerCase() + "</td>";
					htmler += "<td style='width: 180px; word-break:break-all'><a href='javascript:void(0)' name='showDetail' onclick='showDetail(\""
						+ system_version + "\")'>" + system_version + "</a></td>";
					htmler += "<td style='width: 120px; word-break:break-all'>" + jdbc_tns + "</td>";
					htmler += "<td align='center' style='width: 110px; word-break:break-all'>";
					htmler += "<a href='javascript:void(0)' name = 'url_handle' onclick = 'url_handle(\"" + modifyUrl + "\",\"" + params + "\",\"" + modifyTarget + "\")'>明细/修改</a>";
					htmler += "<a href='javascript:void(0)' name = 'del_confirm' onclick ='del_confirm(\"" + deleteUrl + "\",\"" + params + "\",\"" + deleteTarget + "\")'>删除</a>";
					htmler += "</td>";

					if (urlArray.length == 1) {
						real_url = login_address.substring(login_address.indexOf("http"));
						htmler += "<td style='word-break:break-all;'><a href='" + real_url + "' target='_blank'>" + real_url + "</a></td>";
					} else {
						htmler += "<td>";
						htmler += "<table class='main_list'>";
						for ( var j = 0; j < urlArray.length; j++) {
							real_url = urlArray[j].substring(urlArray[j].indexOf("http"));
							htmler += "<tr>";
							htmler += "<td style='border: 0px; word-break:break-all;'><a href='" + real_url + "' target='_blank'>" + urlArray[j] + "</a></td>";
							htmler += "</tr>";
						}
						htmler += "</table>";
						htmler += "</td>";
					}
					htmler += "</tr>";
				}

				htmler += "</table></div>";
				$("#container").append(htmler);
				div_height("table_body");
				show_transfer("#table_body a[name=showDetail]", "float_div");
			}
		});
	};
	function del_confirm(url,params,target){
		if(window.confirm('确定要删除 【 " + system_name + " 】 吗?')==true){
			url_handle(url,params,target);
		}
	}
	function showDetail(verNo) {
		$("#float_div").show();
		var height = $("#float_div").height() - $("#float_table").height() - 60;

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/version_content',
			data : {
				"version" : verNo
			},
			success : function(result) {
				$("#float_tbody").remove();
				var htmler = "<div id='float_tbody' style='overflow:auto; height:" + height + "px;'><table class='main_table'>";
				if (result.length == 0) {
					var message = "该版本目前没有纳入任何需求";
					htmler += "<tr style='height: 50px;'>";
					htmler += "<td colspan='3' style='text-align:center; color:darkgreen; font-size: 18px;'>" + message + "</td>";
					htmler += "</tr>";
				} else {
					for ( var i = 0; i < result.length; i++) {
						var jData = result[i];
						htmler += "<tr style='height: 25px;'>";
						htmler += "<td style='width: 110px; text-align: center;'>" + jData.source_id + " </td>";
						htmler += "<td style='width: 180px; text-align: center;'>" + jData.submit_person + " </td>";
						htmler += "<td style='width: 110px; text-align: center;'>" + jData.benefit_name + " </td>";
						htmler += "<td style='width: 110px; text-align: center;'>" + jData.sr_code + "</td>";
						htmler += "<td style='width: 80px; text-align: center;'>" + jData.man_power + " 人日</td>";
						htmler += "<td style='width: 80px; text-align: center;'>" + jData.bug_num + "</td>";
						htmler += "<td style='word-break:break-all;'>" + jData.sr_name + "</td>";
						htmler += "</tr>";
					}
				}
				htmler += "</table></div>";
				$("#float_body").append(htmler);
			}
		});
		float_autofit();
	};

	function hide() {
		$("#float_div").hide();
	};

	function float_autofit(){
		var div_height = $("#float_div").height();
		$("#float_body").height(div_height - 60);
	};

	$(function() {
		get_test_team('养老险测试组');
		get_system();
		list_data();
	});
</script>
</head>

<body>
	<div class="title-div">
		<span class="label-text">查询组织</span>
		<select class="select" style="width:8%" id="group_type" onchange="query_org();check_obtain();">
			<option value="test_team">测试分组</option>
			<option value="dev_dept">开发部门</option>
		</select>

		<select class="select" style="width:15%; display:none;" id="dev_dept" onchange="check_obtain(); get_system();"></select>
		<select class="select" style="width:15%;" id="test_team" onchange="check_obtain(); get_system();"></select>
		<span class="label-text">子系统</span>
		<select class="select" id="system" style="width: 15%;" onchange="list_data()">
		</select> <input type="button" value="刷新" class="buttons" onClick="list_data()">
		<input type="button" value="添加" class="buttons" onClick="window.open('./envinfo/add.jsp')">
	</div>

	<div id="float_div" class="float_div">
		<div id="float_head" class="float_head">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
		<div id="float_body">
			<table class='main_table' id='float_table'>
				<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
					<th width='110px'>NEED号</th>
					<th width='180px'>需求提出人</th>
					<th width='110px'>受益人</th>
					<th width='110px'>SR号</th>
					<th width='80px'>预估人力</th>
					<th width='80px'>缺陷数</th>
					<th>需求摘要</th>
				</tr>
			</table>
		</div>
		<div id="float_foot" class="float_foot" onclick="hide();">
			<span><b>点击主页面</b>任意地方可以关闭弹出窗口</span>
		</div>
	</div>

	<div id="container" style="min-width: 100%; ">
		<table border=1 class='main_table' id='main_table'>
			<tr style='height: 40px; font-size: 18px; font-weight: 600;'>
				<td colspan='6' class='thead'>系统信息</td>
			</tr>
			<tr style='height: 30px; font-size: 16px; font-weight: 500;'>
				<th align='center' width='180px;'>系统名称</th>
				<th align='center' width='200px;'>部署环境名</th>
				<th align='center' width='180px;'>在测版本</th>
				<th align='center' width='120px;'>数据库SID</th>
				<th align='center' width='110px;'>操作</th>
				<th align='center'>登录地址</th>
			</tr>
		</table>
	</div>
</body>
</html>