<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.fudax.sqcs.env.info.model.RequestResult"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">

<html>
<head>
<title>环境信息详情</title>
</head>

<%@ include file="../env_pub.jsp"%>
<%@ include file="../pub_root.jsp"%>

<body>
	<table border="1" cellpadding="5" cellspacing="0" class="detail-list" id="info_table">
		<tr style="width: 100%; font-size: 22px; font-weight: 600;">
			<th align="center" colspan="2" height="35px" style="border-top-right-radius: 4px;border-top-left-radius: 4px;">明细信息</th>
		</tr>
		<tr>
			<td align="right" class="keys">系统名称<font class="fontRed">*</font></td>
			<td style="width: 80%" id="system_name_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">部署环境名<font class="fontRed">*</font></td>
			<td style="width: 80%" id="instance_name_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">部门<font class="fontRed">*</font></td>
			<td style="width: 80%" id="dept_name_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">测试组<font class="fontRed">*</font></td>
			<td style="width: 80%" id="test_team_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">开发组<font class="fontRed">*</font></td>
			<td style="width: 80%" id="dev_team_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">登录地址</td>
			<td style="width: 80%" id="login_address_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">T3地址</td>
			<td style="width: 80%" id="t3_uri_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">数据库连接串</td>
			<td style="width: 80%" id="jdbc_tns_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">常用用户</td>
			<td style="width: 80%" id="test_users_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys" style="border-bottom-left-radius: 4px;">环境用途</td>
			<td style="width: 80%; border-bottom-right-radius: 4px;" id="description_td"></td>
		</tr>
		<tr id="float_tr" style="display: none;"></tr>
	</table>
	<br>

	<div style="float: right;">
		<input class="buttons" type="button" id="begin_edit" value="修改" onclick="beginEdit()">
		<input class="buttons" type="button" id="save_data" value="保存" disabled="disabled" onclick="return commitCheck();">
		<input class="buttons" type="button" value="返回" onclick="closeWindow();">
	</div>
</body>

<script type="text/javascript">
	var system_id = '<%=request.getParameter("system_id")%>';
	var system_name;
	var instance_name;
	var changed = false;

	var submit_data = function () {
		if ($("#system_name").val() != system_name || $("#instance_name").val() != instance_name){
			changed = true;
		}
		$.ajax( {
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/env_detail',
			data : {
				system_name : $("#system_name").val().toUpperCase(),
				system_id : $("#system_id").val(),
				instance_name : $("#instance_name").val().toLowerCase(),
				dept_name : decodeURIComponent($("#dev_dept").val(),true),
				test_team : decodeURIComponent($("#test_team").val(),true),
				dev_team : decodeURIComponent($("#dev_team").val(),true),
				login_address : $("#login_address").val(),
				t3_uri : $("#t3_uri").val(),
				jdbc_tns : $("#jdbc_tns").val(),
				test_users : $("#test_users").val(),
				description : decodeURIComponent($("#description").val(),true),
				change_primary : changed
			},
			success : function(result) {
				var jsonData = result.resultMap;
				var newId = result.new_system_id;
				var doResult = '<%=RequestResult.OPERATION_RESULT%>';
				var dataStatus = '<%=RequestResult.DATA_STATUS%>';

				if ('<%=RequestResult.OPERATION_FAILED%>' == jsonData.doResult) {
					message = '当前记录修改失败，请检查数据！';
				} else if ('<%=RequestResult.OPERATION_SUCCESS%>' == jsonData.doResult) {
					message = '当前记录修改成功！';
					if (jsonData.dataStatus == '<%=RequestResult.EXIST_DELETED%>'){
						message = "存在相同的失效环境信息记录，已为您恢复并展示该失效环境信息，请继续修改！";
					}
				} else if ('<%=RequestResult.OPERATION_FORBIDDEN%>' == jsonData.doResult) {
					message = '存在相同的有效环境信息记录，不允许重复！';
				} else {
					message = '未知状况，除了看垃圾代码……估计您只能请别人看代码了！';
				}

				var htmler = "<tr style=\"width: 100%; font-size: 20px; height: 50px; display: table-row;\" id=\"float_tr\">";
				htmler += "<td style=\"text-align: center; color: red;border-bottom-left-radius: 4px;border-bottom-right-radius: 4px;\" colspan=\"2\">" + message + "</td></tr>";
				endEdit();
				show_details(newId);
				$("#info_table").append(htmler);
				return true;
			}
		});
	};

	$(function() {
		show_details(system_id);
	});
</script>
</html>