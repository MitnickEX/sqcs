package com.fudax.sqcs.version.controller;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.version.service.VersionInfoService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class VersionInfoAction {

	@Resource
	private VersionInfoService versionInfoService;

	@RequestMapping(value = "/version_bug_list", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray versionBugList(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		List<LinkedHashMap<String, String>> list = versionInfoService.versionBugList(version);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}

		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/version_content", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray versionContent(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		List<LinkedHashMap<String, String>> list = versionInfoService.versionContent(version);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/version_info", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray versionInfo(HttpServletRequest request) throws Exception {
		String system = request.getParameter("system");
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system", system);
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		List<LinkedHashMap<String, String>> list = versionInfoService.versionInfo(dataMap);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/version_schedule", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray versionSchedule(HttpServletRequest request) throws Exception {
		String system_verion = request.getParameter("version");
		String plan_type = request.getParameter("plan_type");
		String flag = "";
		if (plan_type.toLowerCase().contains("st")) {
			flag = "st";
		} else if (plan_type.toLowerCase().contains("uat")) {
			flag = "uat";
		}
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_verion", system_verion);
		dataMap.put("plan_type", plan_type);
		dataMap.put("flag", flag);
		List<LinkedHashMap<String, String>> list = versionInfoService.versionSchedule(dataMap);

		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/version_list", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray versionList(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String begin_date = request.getParameter("date_begin");
		String end_date = request.getParameter("date_end");
		String time_type = request.getParameter("time_type");
		String system = request.getParameter("system");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("begin_date", begin_date);
		dataMap.put("end_date", end_date);
		dataMap.put("time_type", time_type);
		dataMap.put("system", system);
		List<LinkedHashMap<String, String>> list = versionInfoService.versionList(dataMap);

		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/version_under_test", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray versionUnderTest(String test_team) {
		List<LinkedHashMap<String, String>> dataList = versionInfoService.versionUnderTest(test_team);
		return JSONArray.fromObject(dataList);
	}
}
