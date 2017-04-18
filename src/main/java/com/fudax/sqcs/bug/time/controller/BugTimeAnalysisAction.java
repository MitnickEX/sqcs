package com.fudax.sqcs.bug.time.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.fudax.sqcs.bug.modle.Histogram;
import com.fudax.sqcs.bug.time.service.BugTimeAnalysisService;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class BugTimeAnalysisAction {
	@Resource
	private BugTimeAnalysisService bugTimeAnalysisService;

	/**
	 * 按测试组查询缺陷修复超时的版本分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_repair_test_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_repair_test_rm(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String test_team = request.getParameter("test_team");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("test_team", test_team);

		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_repair_test_rm(dataMap);
		return createHistgram(infoList, "system_version", cols);
	}

	/**
	 * 按部门查询缺陷修复超时的版本分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_repair_dept_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_repair_dept_rm(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String dev_dept = request.getParameter("dev_dept");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("dev_dept", dev_dept);
		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_repair_dept_rm(dataMap);

		return createHistgram(infoList, "system_version", cols);
	}

	/**
	 * 按测试组查询缺陷修复超时的子系统分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_repair_test_sys", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_repair_test_sys(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String test_team = request.getParameter("test_team");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("test_team", test_team);
		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_repair_test_sys(dataMap);

		return createHistgram(infoList, "system_alias", cols);
	}

	/**
	 * 按部门查询缺陷修复超时的子系统分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_repair_dept_sys", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_repair_dept_sys(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String dev_dept = request.getParameter("dev_dept");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("dev_dept", dev_dept);
		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_repair_dept_sys(dataMap);

		return createHistgram(infoList, "system_alias", cols);
	}

	/**
	 * 按测试组查询缺陷验证超时的版本分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_verify_test_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_verify_test_rm(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String test_team = request.getParameter("test_team");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("test_team", test_team);
		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_verify_test_rm(dataMap);

		return createHistgram(infoList, "system_version", cols);
	}

	/**
	 * 按开发部门查询缺陷验证超时的版本分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_verify_dept_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_verify_dept_rm(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String dev_dept = request.getParameter("dev_dept");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("dev_dept", dev_dept);
		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_verify_dept_rm(dataMap);

		return createHistgram(infoList, "system_version", cols);
	}

	/**
	 * 按测试组查询缺陷验证超时的子系统分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_verify_test_sys", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_verify_test_sys(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String test_team = request.getParameter("test_team");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("test_team", test_team);
		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_verify_test_sys(dataMap);

		return createHistgram(infoList, "system_alias", cols);
	}

	/**
	 * 按开发部门查询缺陷验证超时的子系统分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/bug_verify_dept_sys", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray bug_verify_dept_sys(HttpServletRequest request) throws Exception {
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String dev_dept = request.getParameter("dev_dept");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		dataMap.put("dev_dept", dev_dept);
		String[] cols = new String[] { "no_overtime", "overtime", "one_day", "two_day", "more_than_two_day" };
		List<LinkedHashMap<String, String>> infoList = bugTimeAnalysisService.bug_verify_dept_sys(dataMap);

		return createHistgram(infoList, "system_alias", cols);
	}

	/**
	 * 生成缺陷时效分析的柱状图——共用方法
	 * 
	 * @param infoList
	 * @param keyName
	 * @param hists
	 */
	@SuppressWarnings("unchecked")
	private JSONArray createHistgram(List<LinkedHashMap<String, String>> infoList, String keyName, String[] hists) {

		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();

		List<String> xList = new ArrayList<String>();
		int levels = hists.length;

		List<Double> arr[] = new ArrayList[levels];

		for (int i = 0; i < levels; i++) {
			arr[i] = new ArrayList<Double>();
		}

		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			xList.add(tempMap.get(keyName));
			for (int j = 0; j < levels; j++) {
				arr[j].add(Double.parseDouble(tempMap.get(hists[j])));
			}
		}

		Histogram[] charts = new Histogram[levels];
		for (int i = 0; i < levels; i++) {
			charts[i] = new Histogram();
			charts[i].setData(arr[i]);
		}

		charts[0].setName("未超时");
		charts[0].setType("bar");
		charts[0].setStack("缺陷数目");
		charts[1].setName("超时4小时");
		charts[1].setType("bar");
		charts[1].setStack("缺陷数目");
		charts[2].setName("超时8小时");
		charts[2].setType("bar");
		charts[2].setStack("缺陷数目");
		charts[3].setName("超时16小时");
		charts[3].setType("bar");
		charts[3].setStack("缺陷数目");
		charts[4].setName("超时3天及以上");
		charts[4].setType("bar");
		charts[4].setStack("缺陷数目");

		for (int i = 0; i < levels; i++) {
			dataList.add(charts[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return JSONArray.fromObject(jsonData);
	}
}
