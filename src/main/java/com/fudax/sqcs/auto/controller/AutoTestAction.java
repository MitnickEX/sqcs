package com.fudax.sqcs.auto.controller;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.auto.service.AutoTestService;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@ResponseBody
public class AutoTestAction {
	@Resource
	private AutoTestService autoTestService;

	@RequestMapping(value = "/auto_res_query", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray autoCaseResultsQry(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		String date_begin = request.getParameter("date_begin");
		String date_end = request.getParameter("date_end");
		String job_type = request.getParameter("job_type");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		dataMap.put("date_begin", date_begin);
		dataMap.put("date_end", date_end);
		dataMap.put("job_type", job_type);
		return JSONArray.fromObject("[" + autoTestService.autoCaseResultsQry(dataMap).toString() + "]");
	}

	@RequestMapping(value = "/auto_res_record", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONObject autoCaseResultsRecord(HttpServletRequest request) throws Exception {
		String case_result = request.getParameter("case_result");
		return JSONObject.fromObject(autoTestService.autoCaseResultsRecord(case_result));
	}

	@RequestMapping(value = "/auto_total_record", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONObject autoCaseTotalRecord(HttpServletRequest request, @RequestBody String case_total_result) throws Exception {
		return JSONObject.fromObject(autoTestService.autoCaseTotalRecord(case_total_result));
	}

	@RequestMapping(value = "/auto_email_receiver", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray autoTestEmailReceiver(HttpServletRequest request) throws Exception {
		String system = request.getParameter("system_name");
		String dev_dept = request.getParameter("dev_dept");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system", system);
		dataMap.put("dev_dept", dev_dept);
		return JSONArray.fromObject(autoTestService.autoTestEmailReceiver(dataMap));
	}

	@RequestMapping(value = "/auto_detail_query", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray detailQuery(HttpServletRequest request) throws Exception {
		String system = request.getParameter("version");
		String view_date = request.getParameter("work_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system", system);
		dataMap.put("view_date", view_date);
		List<LinkedHashMap<String, String>> list = autoTestService.autotestDetail(dataMap);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}

		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/auto_summary_query", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray summaryQuery(HttpServletRequest request) throws Exception {
		String job_type = request.getParameter("job_type");
		String system = request.getParameter("system_name");
		String run_date = request.getParameter("run_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("job_type", job_type);
		dataMap.put("system", system);
		dataMap.put("run_date", run_date);
		List<LinkedHashMap<String, String>> list = autoTestService.summaryQuery(dataMap);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/auto_group_query", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray autotestGroupQry(HttpServletRequest request) throws Exception {
		String job_type = request.getParameter("job_type");
		String system = request.getParameter("system");
		String date_begin = request.getParameter("date_begin");
		String date_dnd = request.getParameter("date_end");
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("job_type", job_type);
		dataMap.put("system", system);
		dataMap.put("date_begin", date_begin);
		dataMap.put("date_end", date_dnd);
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		List<LinkedHashMap<String, String>> list = autoTestService.autotestGroupQry(dataMap);
		
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}

		return JSONArray.fromObject(list);
	}
}
