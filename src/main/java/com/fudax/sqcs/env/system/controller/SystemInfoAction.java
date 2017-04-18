package com.fudax.sqcs.env.system.controller;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.env.system.service.SystemInfoService;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class SystemInfoAction {
	@Resource
	private SystemInfoService systemInfoService;

	/**
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys_info_query", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray sys_info_query(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String dev_dept = request.getParameter("dev_dept");
		String system = request.getParameter("system");
		String is_valid = request.getParameter("is_valid");
		LinkedHashMap<String, String> paramMap = new LinkedHashMap<String, String>();
		paramMap.put("test_team", test_team);
		paramMap.put("dev_dept", dev_dept);
		paramMap.put("system", system);
		paramMap.put("is_valid", is_valid);
		List<LinkedHashMap<String, String>> infoList;

		if (null != system && !system.isEmpty()) {
			infoList = systemInfoService.queryListWhenSystemIsNotNull(paramMap);
		} else {
			infoList = systemInfoService.queryListWhenSystemIsNull(paramMap);
		}
		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			infoList.remove(i);
			infoList.add(i, tempMap);
		}

		return JSONArray.fromObject(infoList);
	}

	/**
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys_info_detail", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray sys_info_detail(HttpServletRequest request) throws Exception {
		String system_alias = request.getParameter("system_alias");
		String dev_dept = request.getParameter("dev_dept");

		dev_dept = (null == dev_dept || dev_dept.equalsIgnoreCase("null")) ? "" : StringBufferUtils.unescapeAll(request.getParameter("dev_dept"));
		LinkedHashMap<String, String> paramMap = new LinkedHashMap<String, String>();
		paramMap.put("system_alias", system_alias);
		paramMap.put("dev_dept", dev_dept);
		List<LinkedHashMap<String, String>> infoList = systemInfoService.queryDetail(paramMap);

		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			infoList.remove(i);
			infoList.add(i, tempMap);
		}

		return JSONArray.fromObject(infoList);
	}

	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys_info_update", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray sys_info_update(HttpServletRequest request) throws Exception {
		String dev_dept = request.getParameter("dev_dept");
		String dev_team = request.getParameter("dev_team");
		String tester = request.getParameter("tester");
		String dever = request.getParameter("dever");
		String assistants = request.getParameter("assistants");
		String test_dept = request.getParameter("test_dept");
		String test_team = request.getParameter("test_team");
		String system_alias = request.getParameter("system_alias");
		String case_source = request.getParameter("case_source");
		String old_test_dept = request.getParameter("old_test_dept");
		String old_test_team = request.getParameter("old_test_team");
		String old_dev_dept = request.getParameter("old_dev_dept");
		old_dev_dept = (null == old_dev_dept || old_dev_dept.isEmpty()) ? dev_dept : old_dev_dept;
		String old_dev_team = request.getParameter("old_dev_team");
		String warning_define = request.getParameter("warning_define_info");
		String is_valid = request.getParameter("is_valid");
		List<LinkedHashMap<String, String>> infoList = systemInfoService.getIdByDeptName(old_dev_dept);
		String dept_code = infoList.isEmpty() ? "" : infoList.get(0).get("dept_code");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("dev_dept", dev_dept);
		dataMap.put("dev_team", dev_team);
		dataMap.put("dever", dever);
		dataMap.put("tester", tester);
		dataMap.put("assistants", assistants);
		dataMap.put("test_dept", test_dept);
		dataMap.put("test_team", test_team);
		dataMap.put("system_alias", system_alias);
		dataMap.put("case_source", case_source);
		dataMap.put("old_test_dept", old_test_dept);
		dataMap.put("old_test_team", old_test_team);
		dataMap.put("old_dev_dept", old_dev_dept);
		dataMap.put("old_dev_team", old_dev_team);
		dataMap.put("warning_define", warning_define);
		dataMap.put("is_valid", is_valid);
		dataMap.put("dept_code", dept_code);
		int updateCount = systemInfoService.update(dataMap);

		return JSONArray.fromObject(updateCount > 0 ? "Y" : "N");
	}

	@RequestMapping(value = "/sys_module_query", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray sys_module_query(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String system_alias = request.getParameter("system_alias");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("system_alias", system_alias);

		return JSONArray.fromObject(systemInfoService.queryModule(dataMap));
	}
}
