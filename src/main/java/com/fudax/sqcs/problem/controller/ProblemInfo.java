package com.fudax.sqcs.problem.controller;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.problem.service.ProblemInfoService;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class ProblemInfo {
	@Autowired
	private ProblemInfoService problemInfoService;

	/**
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/problem_list", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray problem_list(HttpServletRequest request) throws Exception {
		String pro_source = request.getParameter("pro_source").trim();
		String pro_status = request.getParameter("pro_status").trim();
		String pro_date_begin = request.getParameter("pro_date_begin").trim();
		String pro_date_end = request.getParameter("pro_date_end").trim();
		LinkedHashMap<String, String> params = new LinkedHashMap<String, String>();
		params.put("pro_source", pro_source);
		params.put("Pro_status", pro_status);
		params.put("pro_date_begin", pro_date_begin);
		params.put("pro_date_end", pro_date_end);
		List<LinkedHashMap<String, String>> list = problemInfoService.query(params);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}

		return JSONArray.fromObject(list);
	}

	/**
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/problem_add", method = { RequestMethod.POST, RequestMethod.GET })
	public String problem_add(HttpServletRequest request) throws Exception {
		String pro_summary = request.getParameter("pro_summary");
		String pro_source = request.getParameter("pro_source");
		String pro_version = request.getParameter("pro_version");
		String pro_suggest = request.getParameter("pro_owner");
		String pro_detail = request.getParameter("pro_detail");
		String pro_user = request.getParameter("pro_finder");
		String pro_attach = request.getParameter("pro_attach");
		pro_user = (null == pro_user || "null" == pro_user || "undefined" == pro_user) ? "" : pro_user;
		String source_code = source_code_query(pro_source);
		LinkedHashMap<String, String> params = new LinkedHashMap<String, String>();
		params.put("pro_summary", pro_summary);
		params.put("source_code", source_code);
		params.put("pro_user", pro_user);
		params.put("pro_version", pro_version);
		params.put("pro_suggest", pro_suggest);
		params.put("pro_attach", pro_attach);
		params.put("pro_detail", pro_detail);
		problemInfoService.add(params);

		return params.get("pro_id");
	}

	/**
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/problem_fix", method = { RequestMethod.POST, RequestMethod.GET })
	public boolean problem_fix(HttpServletRequest request) throws Exception {
		String pro_status = request.getParameter("pro_status");
		String real_fixer = request.getParameter("real_fixer");
		String fix_desc = request.getParameter("fix_desc");
		String to_be = request.getParameter("to_be");
		String pro_id = request.getParameter("pro_id");
		real_fixer = (null == real_fixer || "null" == real_fixer) ? "" : real_fixer;
		LinkedHashMap<String, String> params = new LinkedHashMap<String, String>();
		int result;
		String status_code = status_code_query(pro_status);
		String current_time = StringBufferUtils.formatedTime("yyyy-MM-dd HH:mm:ss");
		params.put("status_code", status_code);
		params.put("real_fixer", real_fixer);
		params.put("fix_desc", fix_desc);
		params.put("current_time", current_time);
		params.put("pro_id", pro_id);
		if (to_be.contains("close")) {
			result = problemInfoService.updateWhenToBeContainsClose(params);
		} else {
			result = problemInfoService.updateWhenToBeNotContainsClose(params);
		}
		return (result > 0) ? true : false;
	}

	/**
	 * 显示详细
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/problem_detail", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray problem_detail(HttpServletRequest request) throws Exception {
		String pro_id = request.getParameter("pro_id");
		List<LinkedHashMap<String, String>> infoList = problemInfoService.detailQuery(pro_id);
		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			infoList.remove(i);
			infoList.add(i, tempMap);
		}

		return JSONArray.fromObject(infoList);
	}

	@RequestMapping(value = "/source_code_query", method = { RequestMethod.POST, RequestMethod.GET })
	private String source_code_query(String pro_source) {
		String source_code = "0";
		List<LinkedHashMap<String, String>> list = problemInfoService.querySourceCode(pro_source);
		if (list != null && list.size() > 0) {
			LinkedHashMap<String, String> source_code_Map = list.get(list.size() - 1);
			source_code = source_code_Map.get("source_code");
		}
		return source_code;
	}

	@RequestMapping(value = "/status_code_query", method = { RequestMethod.POST, RequestMethod.GET })
	private String status_code_query(String pro_status) {
		String status_code = "0";
		List<LinkedHashMap<String, String>> list = null;
		;
		list = problemInfoService.queryStatusCode(pro_status);
		if (list != null && list.size() > 0) {
			LinkedHashMap<String, String> source_code_Map = list.get(list.size() - 1);
			status_code = source_code_Map.get("status_code");
		}
		return status_code;
	}
}
