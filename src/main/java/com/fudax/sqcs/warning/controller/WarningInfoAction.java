package com.fudax.sqcs.warning.controller;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.warning.service.WarningInfoService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class WarningInfoAction {
	@Resource
	private WarningInfoService warningInfoService;
	
	@RequestMapping(value = "/warning_info", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warnInfo(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		String warning_date = request.getParameter("warning_date");
		warning_date = (null == warning_date || "" == warning_date) ? "all" : warning_date;
		String warning_grade = request.getParameter("warning_grade");
		warning_grade = (null == warning_grade || "" == warning_grade) ? "all" : warning_grade;
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("version", version);
		dataMap.put("warning_date", warning_date);
		dataMap.put("warning_grade", warning_grade);

		List<LinkedHashMap<String, String>> list = warningInfoService.warnInfo(dataMap);
		String jsonArray = JSONArray.fromObject(list).toString();
		return JSONArray.fromObject(jsonArray);
	}

	@RequestMapping(value = "/pro_detail", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray pro_detail(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		String warning_date = request.getParameter("warning_date");
		String warning_type = request.getParameter("warning_type");
		String warning_grade = request.getParameter("warning_grade");
		// warning_date = "2016-1-07'";
		String flag = "false";
		if (Integer.parseInt(warning_grade) > 2) {
			flag = "true";
		}
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_version", system_version);
		dataMap.put("warning_date", warning_date);
		dataMap.put("warning_grade", warning_grade);
		dataMap.put("warning_type", warning_type);
		dataMap.put("flag", flag);

		List<LinkedHashMap<String, String>> infoList = warningInfoService.detailQuery(dataMap);
		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			infoList.remove(i);
			infoList.add(i, tempMap);
		}
		String jsonArray = JSONArray.fromObject(infoList).toString();
		return JSONArray.fromObject(jsonArray);
	}

	@RequestMapping(value = "/bug_none_sr", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_none_sr(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		List<LinkedHashMap<String, String>> infoList = warningInfoService.bug_none_sr(system_version);

		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			infoList.remove(i);
			infoList.add(i, tempMap);
		}

		String jsonArray = JSONArray.fromObject(infoList).toString();
		return JSONArray.fromObject(jsonArray);
	}

	@RequestMapping(value = "/bug_none_module", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_none_module(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		List<LinkedHashMap<String, String>> infoList = warningInfoService.bug_none_module(system_version);
		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			infoList.remove(i);
			infoList.add(i, tempMap);
		}
		String jsonArray = JSONArray.fromObject(infoList).toString();
		return JSONArray.fromObject(jsonArray);
	}

	/**
	 * 查询所有信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/query_warn_type", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_warn_type() throws Exception {
		return JSONArray.fromObject(warningInfoService.warn_type());
	}

	/**
	 * 查询所有信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/query_warn_list", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_warn_list() throws Exception {

		List<LinkedHashMap<String, String>> list = warningInfoService.warningVersionList();

		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}

		return JSONArray.fromObject(list);
	}
}
