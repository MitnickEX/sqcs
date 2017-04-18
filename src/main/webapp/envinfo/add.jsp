<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.fudax.sqcs.env.info.model.RequestResult"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html>
<head>
<link href="images/favicon.ico" type="image/x-icon" rel="icon" />
<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
<title>新增环境信息</title>
</head>

<%@ include file="../env_pub.jsp"%>
<%@ include file="../pub_root.jsp"%>

<body>
	<table border="1" cellpadding="5" cellspacing="0" class="detail-list" id="info_table">
		<tr style="width: 100%; font-size: 22px; font-weight: 600;">
			<th align="center" colspan="2" style="border-top-right-radius: 4px;border-top-left-radius: 4px;">新增信息</th>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">子系统简称<font class="fontRed">*</font></td>
			<td style="width: 80%" id="system_name_td"><input class="editor" type="text" name="system_name" id="system_name"
				value=""></td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">部署实例名<font class="fontRed">*</font></td>
			<td style="width: 80%" id="instance_name_td"><input class="editor" type="text" name="instance_name"
				id="instance_name" value=""></td>
		</tr>
		<tr>
			<td align="right" class="keys">部门<font class="fontRed">*</font></td>
			<td style="width: 80%" id="dept_name_td"><select class="select" style="width:99.8% !important;" name="dept_name" id="dev_dept" onchange="get_test_team();getDevTeam();">
			</select></td>
		</tr>
		<tr>
			<td align="right" class="keys">测试组<font class="fontRed">*</font></td>
			<td style="width: 80%" id="test_team_td"><select class="select" style="width:99.8% !important;" name="test_team" id="test_team" onchange="getDevTeam()">
			</select></td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">开发组<font class="fontRed">*</font></td>
			<td style="width: 80%" id="dev_team_td"><select class="select" style="width:99.8% !important;" name="dev_team" id="dev_team">
			</select></td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">登录地址</td>
			<td style="width: 80%" id="login_address_td"><textarea class="editor" style="height:100px !important;" name="login_address" id="login_address"></textarea></td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">T3地址</td>
			<td style="width: 80%" id="t3_uri_td"><input class="editor" type="text" name="t3_uri" id="t3_uri" value=""></td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">数据库连接串</td>
			<td style="width: 80%" id="jdbc_tns_td"><textarea class="editor" style="height:80px !important;" name="jdbc_tns" id="jdbc_tns"></textarea></td>
		</tr>
		<tr>
			<td align="right" class="keys" align="right">常用用户</td>
			<td style="width: 80%" id="test_users_td"><input class="editor" type="text" name="test_users" id="test_users"
				value=""></td>
		</tr>

		<tr>
			<td align="right" class="keys" align="right" style="border-bottom-left-radius: 4px;">用途</td>
			<td style="width: 80%;border-bottom-right-radius: 4px;" id="description_td"><input class="editor" type="text" name="description" id="description"
				value=""></td>
		</tr>
		<tr id="float_tr" style="display: none;"></tr>
	</table>
	<br>

	<div style="float: right;">
		<input class="buttons" type="button" id="reset" value="重置" onclick="reset();">
		<input class="buttons" type="button" id="save_data" value="保存" onclick="return commitCheck();">
		<input class="buttons" type="button" value="返回" onclick="closeWindow();">
	</div>
</body>

<script type="text/javascript">
	var system_name;
	var instance_name;
	var change_primary = false;

	var submit_data = function () {
		$.ajax( {
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/env_info_add',
			data : {
				"system_name" : $("#system_name").val().toUpperCase(),
				"system_id" : $("#system_id").val(),
				"instance_name" : $("#instance_name").val().toLowerCase(),
				"dept_name" : $("#dev_dept").val(),
				"test_team" : $("#test_team").val(),
				"dev_team" : $("#dev_team").val(),
				"login_address" : $("#login_address").val(),
				"t3_uri" : $("#t3_uri").val(),
				"jdbc_tns" : $("#jdbc_tns").val(),
				"test_users" : $("#test_users").val(),
				"description" : $("#description").val()
			},
			success : function(result) {
				var jsonData = result.resultMap;
				var newId = result.new_system_id;
				var doResult = '<%=RequestResult.OPERATION_RESULT%>';
				var dataStatus = '<%=RequestResult.DATA_STATUS%>';

				if ('<%=RequestResult.OPERATION_FAILED%>' == jsonData.doResult) {
					message = '新增记录失败，请检查数据！';
				} else if ('<%=RequestResult.OPERATION_SUCCESS%>' == jsonData.doResult) {
					message = '新增记录成功！';
					if (jsonData.dataStatus == '<%=RequestResult.EXIST_DELETED%>'){
						message = "存在相同的失效环境信息记录，已恢复失效环境信息记录为有效，请返回主页修改！";
					}
				} else if ('<%=RequestResult.OPERATION_FORBIDDEN%>' == jsonData.doResult) {
					message = '存在相同的有效环境信息记录，不允许重复！';
				} else {
					message = '未知状况，除了看垃圾代码……估计您只能请别人看代码了！';
				}

				var htmler = "<tr style=\"width: 100%; font-size: 20px; height: 50px; display: table-row;\" id=\"float_tr\">";
				htmler += "<td style=\"text-align: center; color: red;border-bottom-left-radius: 4px;border-bottom-right-radius: 4px;\" colspan=\"2\">"
						+ message + "</td></tr>";
				show_details(newId);
				$("#info_table").append(htmler);
				redirect();
				return true;
			}
		});
	};

	function redirect() {
		$("#reset").attr('value', "继续");
		$("#reset").removeAttr('onclick');
		$("#reset").attr('onclick', "window.location.reload();");
	}

	$(function() {
		get_dev_dept('养老险系统开发部');
		get_test_team('养老险测试组');
		getDevTeam();
	});
</script>
</html>
