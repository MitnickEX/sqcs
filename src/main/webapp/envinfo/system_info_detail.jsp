<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.fudax.sqcs.utils.StringBufferUtils"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">

<html>
<head>
<title>环境信息详情</title>
</head>

<%@ include file="./system_info_pub.jsp"%>
<%@ include file="../pub_root.jsp"%>

<body>
	<table border="1" cellpadding="5" cellspacing="0" class="detail-list" id="info_table">
		<tr style="width: 100%; font-size: 22px; font-weight: 600;">
			<th align="center" colspan="2" height="35px" style="border-top-right-radius: 4px; border-top-left-radius: 4px;">明细信息</th>
		</tr>
		<tr>
			<td align="right" class="keys">开发部门<font class="fontRed">*</font></td>
			<td style="width: 80%" id="dev_dept_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">开发分组<font class="fontRed">*</font></td>
			<td style="width: 80%" id="dev_team_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">测试部门<font class="fontRed">*</font></td>
			<td style="width: 80%" id="test_dept_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">测试分组<font class="fontRed">*</font></td>
			<td style="width: 80%" id="test_team_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">子系统简称</td>
			<td style="width: 80%" id="system_alias_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">子系统全称</td>
			<td style="width: 80%" id="system_name_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">开发负责人<font class="fontRed">*</font></td>
			<td style="width: 80%" id="dever_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">测试人员<font class="fontRed">*</font></td>
			<td style="width: 80%" id="tester_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">辅助开发、测试<font class="fontRed">*</font></td>
			<td style="width: 80%" id="assistants_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">系统模块定义<font class="fontRed">*</font></td>
			<td style="width: 80%" id="module_define_td">
				<span id="module_li" style="padding-left: 5px;"></span>
			</td>
		</tr>
		<tr>
			<td align="right" class="keys">预警规则定义<font class="fontRed">*</font></td>
			<td style="width: 80%" id="warning_rule_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">用例管理平台</td>
			<td style="width: 80%" id="case_source_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">是否有效</td>
			<td style="width: 80%" id="is_valid_td"></td>
		</tr>
		<tr id="float_tr" style="display: none;">
		</tr>
	</table>
	<br>

	<div style="float: right;">
		<input type='hidden' value='' id='old_test_dept' />
		<input type='hidden' value='' id='old_test_team' />
		<input type='hidden' value='' id='old_dev_dept' />
		<input type='hidden' value='' id='old_dev_team' />
		<input type='hidden' value='' id='old_dever' />
		<input type='hidden' value='' id='old_tester' />
		<input class="buttons" type="button" id="begin_edit" value="修改" onclick="beginEdit()">
		<input class="buttons" type="button" id="save_data" value="保存" disabled="disabled" onclick="return commitCheck();">
		<input class="buttons" type="button" value="返回" onclick="closeWindow();">
	</div>
</body>

<script type="text/javascript">
	var system_alias = '<%=request.getParameter("system_alias")%>';
	var dept_name = '<%=request.getParameter("dev_dept")%>';

	function submit_data() {
		var element = $("[name='wanrings']");
		var warning_define = "";

		for ( var i = 0; i < element.length; i++) {
			warning_define = warning_define + element.eq(i).val() + ":";
			if (element.eq(i).attr("checked") == "checked") {
				warning_define = warning_define + "Y;";
			} else {
				warning_define = warning_define + "N;";
			}
		}
		warning_define = warning_define.substring(0, warning_define.length - 1);

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : 'application/x-www-form-urlencoded',
			url : 'UpdateSystemAction.action',
			data : {
				"system_alias" : decodeURIComponent(system_alias),
				"dev_dept" : decodeURIComponent($("#dev_dept").val()),
				"dev_team" : decodeURIComponent($("#dev_team").val()),
				"test_dept" : decodeURIComponent($("#test_dept").val()),
				"test_team" : decodeURIComponent($("#test_team").val()),
				"old_dev_dept" : decodeURIComponent($("#old_dev_dept").val()),
				"old_dev_team" : decodeURIComponent($("#old_dev_team").val()),
				"old_test_dept" : decodeURIComponent($("#old_test_dept").val()),
				"old_test_team" : decodeURIComponent($("#old_test_team").val()),
				"tester" : decodeURIComponent($("#tester").val(), true),
				"dever" : decodeURIComponent($("#dever").val(), true),
				"assistants" : decodeURIComponent($("#assistants").val(), true),
				"case_source" : decodeURIComponent($("#case_source").val(), true),
				"warning_define_info" : warning_define,
				"is_valid" : $("#is_valid").val()
			},
			success : function(result) {
				var jsonData = result.success;

				if (jsonData.indexOf("Y") > -1) {
					message = '当前记录修改成功！';
				} else {
					message = '当前记录修改失败，请检查数据！';
				}

				var htmler = "<tr style='width: 100%; font-size: 20px; height: 50px; display: table-row;' id='float_tr'>";
				htmler += "<td style='text-align: center; color: red;border-bottom-left-radius: 4px;border-bottom-right-radius: 4px;' colspan='2'>" + message + "</td></tr>";
				endEdit();
				show_details($("#dev_dept").val(), system_alias);
				$("#info_table").append(htmler);
				record_original();
				return true;
			}
		});
	};

	function record_original() {
		$("#old_test_dept").val($("#test_dept").val());
		$("#old_test_team").val($("#test_team").val());
		$("#old_dev_dept").val($("#dev_dept").val());
		$("#old_dev_team").val($("#dev_team").val());
		$("#old_dever").val($("#dever").val());
		$("#old_tester").val($("#tester").val());
	};

	$(function() {
		show_details(dept_name, system_alias);
		record_original();
	});
</script>
</html>