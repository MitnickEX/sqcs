<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3.org/TR/html4/strict.dtd">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
<link href="images/favicon.ico" type="image/x-icon" rel="icon" />
<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
<title>问题明细及处理</title>
</head>

<%@ include file="problem_pub.jsp"%>
<%@ include file="../pub_root.jsp"%>

<script type="text/javascript">
	var pro_id = '<%=request.getParameter("pro_id")%>';
	var old_status;

	function submit_data(){
		$("#float_tr").remove();
		if (commit_check() == false){
			show_message('每次状态只能修改一个状态，待处理不能直接修改为已关闭！');
			return;
		}

		var pro_status = $.trim($("#pro_status").val());
		var to_be = "fix";
		if (pro_status == '已关闭'){
			to_be = "close";
		} else{
			to_be = "fix";
		}

		var real_fixer = $("#real_fixer").val();
		if (real_fixer == '' || real_fixer == 'undefined' || real_fixer == 'null'){
			real_fixer = '<%=userName%>';
		}
		if (real_fixer == 'undefined' || real_fixer == null || real_fixer == 'null') {
			real_fixer = '';
		}

		var fix_desc = $("#fix_desc").val();
		var pro_id = $("#pro_id").val();

		$.ajax({
			async : false,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/problem_fix',
			data : {
				"pro_status" : pro_status,
				"real_fixer" : real_fixer,
				"fix_desc" : fix_desc,
				"to_be" : to_be,
				"pro_id" : pro_id
			},
			success : function(result) {

				if (result == 'undefined' || result == 'false') {
					message = '新增记录失败，请检查数据！';
				} else {
					message = '修改记录成功！';
				}

				show_details(pro_id);
				old_status = $.trim($("#pro_status").val());
				show_message(message);
				end_edit();
			}
		});
	};

	var commit_check = function() {
		var current_status = $.trim($("#pro_status").val());
		if (old_status == '待处理' && current_status == '处理完成') {
			return true;
		} else if (old_status == '处理完成' && current_status == '已关闭') {
			return true;
		} else if (old_status == current_status) {
			return true;
		} else {
			return false;
		}
	};

	function show_message(message) {
		var htmler = "<tr style=\"width: 100%; font-size: 20px; height: 50px; display: table-row;\" id=\"float_tr\">";
		htmler += "<td style=\"text-align: center; color: red;\" colspan=\"2\">" + message + "</td></tr>";
		$("#info_table").append(htmler);
	}

	$(function() {
		show_details(pro_id);
		old_status = $.trim($("#pro_status").val());
		get_attach($("#oper_seq").val(), false);
	});
</script>

<body>
	<table border="1" cellpadding="3" cellspacing="0" class="main_table" id="info_table">
		<tr style="width: 100%; font-size: 22px; font-weight: 600;">
			<th align="center" colspan="2" height="35px">明细信息</th>
		</tr>
		<tr>
			<td align="right" class="keys">问题编号</td>
			<td style="width: 80%" id="pro_id_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">问题概述</td>
			<td style="width: 80%" id="pro_summary_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">问题来源</td>
			<td style="width: 80%" id="pro_source_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">上报人</td>
			<td style="width: 80%" id="pro_user_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">问题状态</td>
			<td style="width: 80%" id="pro_status_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">问题版本</td>
			<td style="width: 80%" id="sys_version_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">建议处理人</td>
			<td style="width: 80%" id="suggest_fixer_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">实际处理人</td>
			<td style="width: 80%" id="real_fixer_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">问题详细信息</td>
			<td style="width: 80%" id="pro_detail_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">修复说明</td>
			<td style="width: 80%" id="fix_desc_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">上报时间</td>
			<td style="width: 80%" id="create_date_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">解决时间</td>
			<td style="width: 80%" id="fix_date_td"></td>
		</tr>
		<tr>
			<td align="right" class="keys">关闭时间</td>
			<td style="width: 80%" id="close_date_td"></td>
		</tr>
		<tr id="float_tr" style="display: none;"></tr>
	</table>
	<br>

	<table border="1" cellpadding="3" cellspacing="0" class="main_table" id="attach_table">
	</table>
	<br>

	<div style="float: right; padding-bottom: 30px;">
		<input class="buttons" type="button" id="begin_edit" value="解决问题" onclick="begin_edit()">
		<input class="buttons" type="button" id="save_data" value="保存" disabled="disabled"
			onclick="submit_data();">
		<input class="buttons" type="button" value="返回" onclick="closeWindow();">
	</div>
</body>

</html>
