package com.fudax.sqcs.file.controller;

import java.io.File;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fudax.sqcs.file.service.FileInfoService;
import com.fudax.sqcs.utils.ClassURLUtil;
import com.fudax.sqcs.utils.ReadProperties;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class FileHandleAction {
	@Resource
	private FileInfoService fileInfoService;

	private String fileName;
	
	private String config = ClassURLUtil.getClassPath(ClassURLUtil.class) + File.separator + "common.properties";
	private String parent = new ReadProperties(config).readValue("file_upload");

	private String getWholeName(String fileName, String oper_seq) {
		int index = fileName.lastIndexOf(".");
		String pref = fileName.substring(0, index);
		fileName = pref + oper_seq + fileName.substring(index);
		return fileName;
	}

	@RequestMapping(value = "/upload_attach", method = { RequestMethod.POST, RequestMethod.GET })
	public String file_upload(HttpServletRequest request, @RequestParam("file") MultipartFile[] files) throws IOException {
		String oper_seq = request.getParameter("oper_seq");
		parent = (parent.endsWith("\\") || parent.endsWith("/")) ? parent : parent + File.separator;

		String result = "";
		if (null != files && files.length > 0){
			for (int i = 0; i < files.length; i ++){
				MultipartFile file = files[i];
				String oldName = file.getOriginalFilename();
				fileName = getWholeName(oldName, oper_seq);
				file.transferTo(new File(parent, fileName));
				LinkedHashMap<String, String> params = new LinkedHashMap<String, String>();
				params.put("fileName", oldName);
				params.put("oper_seq", oper_seq);
				params.put("storedName", parent + fileName);
				fileInfoService.addAttach(params);
			}
			result = "success";
		} else {
			result = "failed";
		}
		return "<h2 style='padding-top: 50px; padding-left: 50px;'>" + result + "</h2>";
	}

	@RequestMapping(value = "/download_attach", method = { RequestMethod.POST, RequestMethod.GET })
	public String download_attach(HttpServletRequest request) throws Exception {
		String fileId = request.getParameter("fileId");
		fileName = fileInfoService.getNameById(fileId);
		return "<h2 style='padding-top: 50px; padding-left: 50px;'>SUCCESS</h2>";
	}

	@RequestMapping(value = "/list_attach", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray list_attach(HttpServletRequest request) throws Exception {
		String oper_seq = request.getParameter("oper_seq");
		List<LinkedHashMap<String, String>> list = fileInfoService.getAttach(oper_seq);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}

		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/delete_attach", method = { RequestMethod.POST, RequestMethod.GET })
	public String delete_attach(HttpServletRequest request) throws Exception {
		String file_id = request.getParameter("file_id");
		String file_path = fileInfoService.getStoreById(file_id);
		int deleted = fileInfoService.delAttach(file_id);
		if (null != file_path && "" != file_path && deleted > 0) {
			new File(file_path).delete();
			return "file delete successfully!";
		}
		return "file delete failed!";
	}
}