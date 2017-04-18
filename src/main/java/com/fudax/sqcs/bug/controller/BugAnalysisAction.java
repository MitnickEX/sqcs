package com.fudax.sqcs.bug.controller;

import java.util.LinkedHashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.fudax.sqcs.bug.service.BugAnalysisService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class BugAnalysisAction {
	@Resource
	private BugAnalysisService bugAnalysisService;

	@RequestMapping(value = "/bug_density_complex", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_density_complex(HttpServletRequest request) throws Exception {
		String system = request.getParameter("system");
		String pro_date_begin = request.getParameter("pro_date_begin");
		String pro_date_end = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("pro_date_begin", pro_date_begin);
		dataMap.put("pro_date_end", pro_date_end);
		dataMap.put("system", system);
		JSONObject jsonObject = bugAnalysisService.bug_density_complex(dataMap);

		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_distribute_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_distribute_system(HttpServletRequest request) throws Exception {
		String system = request.getParameter("system");
		JSONObject jsonObject = bugAnalysisService.bug_distribute_system(system);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_distribute_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_distribute_version(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_distribute_version(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_sr_distribute", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_sr_distribute(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_sr_distribute(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_sr_density", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_sr_density(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_sr_density(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_finder_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_finder_system(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		JSONObject jsonObject = bugAnalysisService.bug_finder_system(dataMap);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_finder_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_finder_version(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_finder_version(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_fix_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_fix_system(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		String start_time = request.getParameter("pro_date_begin");
		String end_time = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		dataMap.put("start_time", start_time);
		dataMap.put("end_time", end_time);
		JSONObject jsonObject = bugAnalysisService.bug_fix_system(dataMap);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_fix_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_fix_version(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_fix_version(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_producer_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_producer_system(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		JSONObject jsonObject = bugAnalysisService.bug_producer_system(dataMap);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_producer_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_producer_version(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_producer_version(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_repairs_num_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_repairs_num_system(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		String start_time = request.getParameter("pro_date_begin");
		String end_time = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		dataMap.put("start_time", start_time);
		dataMap.put("end_time", end_time);
		JSONObject jsonObject = bugAnalysisService.bug_repairs_num_system(dataMap);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_repairs_num_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_repairs_num_version(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_repairs_num_version(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_by_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_by_system(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		String start_time = request.getParameter("pro_date_begin");
		String end_time = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		dataMap.put("start_time", start_time);
		dataMap.put("end_time", end_time);
		JSONObject jsonObject = bugAnalysisService.bug_by_system(dataMap);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_by_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_by_version(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_by_version(version);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_verify_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_verify_system(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		String start_time = request.getParameter("pro_date_begin");
		String end_time = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		dataMap.put("start_time", start_time);
		dataMap.put("end_time", end_time);
		JSONObject jsonObject = bugAnalysisService.bug_verify_system(dataMap);
		return JSONArray.fromObject(jsonObject);
	}

	@RequestMapping(value = "/bug_verify_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_verify_version(HttpServletRequest request) throws Exception {
		String version = request.getParameter("version");
		JSONObject jsonObject = bugAnalysisService.bug_verify_version(version);
		return JSONArray.fromObject(jsonObject);
	}
}
