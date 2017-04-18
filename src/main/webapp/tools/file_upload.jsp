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
<title>上传附件</title>
</head>
<%@ include file="../list_style.jsp"%>
<%@ include file="../pub_root.jsp"%>
<style>
td {
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 16px;
	background-color: rgb(250, 250, 210);
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	border-radius: 0;
}

tr {
	border: 1px solid #CCC;
}

span {
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 15px;
}

.file {
	font-family: 微软雅黑;
	font-weight: 500;
	font-size: 16px;
}
</style>
<body>
	<form action="/sqcs/upload_attach" method="post" id="uploadFileForm" name="uploadFileForm"  enctype="multipart/form-data" >
		<div id="show_annex" style="width:100%;">
			<span style="height:25px; line-height:25px; font-size:20px; padding-bottom: 5px; ">上传附件</span>
			<br>
			<div style="padding-right: 25px; border: 1px solid #CCC;">
				<input type="submit" class="buttons" style="float:right; margin-top: 5px;" id="uploadBtn" onclick="return uploadFile();" value="开始上传" />
				<input type="button" class="buttons" style="float:right; margin-top: 5px;" id="addAnnexBtn" onclick="addMoreAnnex();" value="更多附件" />
			</div>
			<br>
			<div style="padding-left: 25px; padding-right: 25px;">
				<span>
					1、所有附件大小总和不能超过5M;<br>
					2、附件名不超过30个字符;<br>
					3、一次最多能上传5个附件，其中附件1不能为空。<br>
					4、文件名不能包含以下任何字符: \ / : * ? " &lt; &gt; | # { } % ~ &amp;<br>
					5、允许上传的文件类型包含：jpg; png; jpeg; txt; doc; xls; docx; xlsx; zip; rar; pdf
				</span>
			</div>
			<br>
			<div style="padding-left: 25px; padding-right: 25px;">
				<table id="addAnnexTable" style="width:100%; border-collapse:collapse;">
					<tr>
						<td style="text-align:right; width:150px;">请选择附件 1：</td>
						<td ><input type="file" class="file" id="myImg1" name="file"/></td>
						<td style="display:none; width:100px;"></td>
					</tr>
				</table>
			</div>
		</div>
	</form>

	<script type="text/javascript">
		var oper_seq = '<%=request.getParameter("oper_seq")%>';
		var allow_type = 'jpg;png;jpeg;txt;doc;xls;docx;xlsx;zip;rar;pdf';

		function addMoreAnnex() {
			var addAnnexTable = document.getElementById("addAnnexTable");
			var index = addAnnexTable.rows.length;
			if (index >= '5') {
				alert("一次最多只能上传5个附件！");
				return false;
			}
			var addAnnextr = addAnnexTable.insertRow(index);
			addAnnextr.id = "tr" + index;
			var addAnnextd = addAnnextr.insertCell(0);
			var addAnnextd1 = addAnnextr.insertCell(1);
			var addAnnextd2 = addAnnextr.insertCell(2);
			addAnnextd.align = "right";
			addAnnextd.innerHTML = "请选择附件 " + (index + 1) + "：";
			addAnnextd1.innerHTML = "<input type='file' class='file' id='myImg" +  (index + 1) + "' name='file'/>";
			addAnnextd2.innerHTML = "<input type='button' id='delBtn' class='buttons' value='删除' onclick='delMoreAnnex(this);'/>";

			if (index > 1) {
				var delBtntr = document.getElementById("tr" + (index - 1));
				delBtntr.deleteCell(2);
			}
		}

		function delMoreAnnex(ele) {
			var addAnnexTable = document.getElementById("addAnnexTable");
			addAnnexTable.deleteRow(ele.parentNode.parentNode.rowIndex);
			var index = addAnnexTable.rows.length;

			if (index > 1) {
				var addBtntr = document.getElementById("tr" + (index - 1));
				addBtntr.insertCell(2).innerHTML = "<input type='button' id='delBtn' class='buttons' value='删除' onclick='delMoreAnnex(this);'/>";
			}
		}

		var uploadFile = function() {
			var type_arr = allow_type.split(";");
			var files = $("input[name='file']");
			var type_error = true;
			for ( var i = 0; i < files.length; i++) {
				var index = i + 1;
				var element = files.eq(i);
				var file_name = element.val();
				if (file_name == '' || file_name == null){
					alert("附件 " + index + " 不能为空，请选择文件！");
					return false;
				} else{
					for(var j = 0; j < type_arr.length; j++){
						var type = type_arr[j];
						if (file_name.toLowerCase().lastIndexOf(type) > 0){
							type_error = false;
						}
					}
					if (type_error){
						alert("附件 " + index + " 类型错误，只能上传：" + allow_type + "类型的文件！");
						return false;
					}
				}
			}
			$("#addAnnexTable").append("<input type='hidden' id='oper_seq' name='oper_seq' value='" + oper_seq + "'>");
		};
	</script>
</body>
</html>
