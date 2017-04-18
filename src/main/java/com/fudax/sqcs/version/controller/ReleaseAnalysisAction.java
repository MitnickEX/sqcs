package com.fudax.sqcs.version.controller;

import java.util.LinkedHashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.version.service.ReleaseAnalysisService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class ReleaseAnalysisAction {
	@Resource
	private ReleaseAnalysisService releaseAnalysisService;

	@RequestMapping(value = "/release_ana", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray release_ana(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String system = request.getParameter("system");
		String begin = request.getParameter("pro_date_begin");
		String end = request.getParameter("pro_date_end");
		String time_type = request.getParameter("time_type");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("system", system);
		dataMap.put("begin", begin);
		dataMap.put("end", end);
		dataMap.put("time_type", time_type);

		return JSONArray.fromObject(releaseAnalysisService.getPlusCharts(dataMap));
	}
}
