package com.fudax.sqcs.warning.controller;

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
import com.fudax.sqcs.bug.modle.Data;
import com.fudax.sqcs.bug.modle.LineCharts;
import com.fudax.sqcs.bug.modle.PieCharts;
import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.warning.service.WarningAnalyseService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class WarningAnalyseAction {
	@Resource
	private WarningAnalyseService warningAnalyseService;

	/**
	 * 按版本观察预警类型分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_type_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_type_rm(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_type_version(system_version);
		return createPieGragh(infoList, "rule_name", "warn_count", "版本预警类型分布");
	}

	/**
	 * 按版本观察预警级别分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_grade_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_grade_rm(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_grade_version(system_version);

		return createPieGragh(infoList, "warning_grade", "warn_count", "版本预警级别分布");
	}

	/**
	 * 按版本查看预警时间分布分析--曲线图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_time_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_time_rm(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_time_version(system_version);

		return createLineGragh(infoList, "warning_date", "warn_count", "版本预警时间分布");
	}

	/**
	 * 按部门和时间段查看预警随时间分布分析--曲线图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_time_dept", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_time_dept(HttpServletRequest request) throws Exception {
		String dev_dept = request.getParameter("dev_dept");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("dev_dept", dev_dept);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_time_dept(dataMap);

		return createLineGragh(infoList, "warning_date", "warn_count", "部门预警时间分布");
	}

	/**
	 * 按部门和时间段观察预警类型分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_type_time_dept", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_type_time_dept(HttpServletRequest request) throws Exception {
		String dev_dept = request.getParameter("dev_dept");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("dev_dept", dev_dept);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_type_time_dept(dataMap);

		return createPieGragh(infoList, "rule_name", "warn_count", "部门预警类型分布");
	}

	/**
	 * 按部门和时间段观察预警级别分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_grade_time_dept", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_grade_time_dept(HttpServletRequest request) throws Exception {
		String dev_dept = request.getParameter("dev_dept");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("dev_dept", dev_dept);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_grade_time_dept(dataMap);

		return createPieGragh(infoList, "warning_grade", "warn_count", "部门预警级别分布");
	}

	/**
	 * 按部门和时间段观察预警随子系统分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_system_time_dept", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_system_time_dept(HttpServletRequest request) throws Exception {
		String dev_dept = request.getParameter("dev_dept");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("dev_dept", dev_dept);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_system_time_dept(dataMap);

		return createPieGragh(infoList, "system_alias", "warn_count", "部门预警子系统分布");
	}

	/**
	 * 按部门和时间段观察预警随版本分布分析--饼图------维度特异，暂不支持
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_rm_time_dept", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_rm_time_dept(HttpServletRequest request) throws Exception {
		String dev_dept = request.getParameter("dev_dept");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("dev_dept", dev_dept);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_rm_time_dept(dataMap);

		return createPieGragh(infoList, "system_version", "warn_count", "部门预警版本分布");
	}

	/**
	 * 按测试组和时间段查看预警随时间分布分析--曲线图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_time_test", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_time_test(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_time_test(dataMap);

		return createLineGragh(infoList, "warning_date", "warn_count", "测试组预警时间分布");
	}

	/**
	 * 按测试组和时间段观察预警类型分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_type_time_test", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_type_time_test(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_type_time_test(dataMap);

		return createPieGragh(infoList, "rule_name", "warn_count", "测试组预警类型分布");
	}

	/**
	 * 按测试组和时间段观察预警级别分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_grade_time_test", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_grade_time_test(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_grade_time_test(dataMap);

		return createPieGragh(infoList, "warning_grade", "warn_count", "测试组预警级别分布");
	}

	/**
	 * 按测试组和时间段观察预警随子系统分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_system_time_test", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_system_time_test(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_system_time_test(dataMap);

		return createPieGragh(infoList, "system_alias", "warn_count", "测试组预警子系统分布");
	}

	/**
	 * 按测试组和时间段观察预警随版本分布分析--饼图------维度特异，暂不支持
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_rm_time_test", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_rm_time_test(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_rm_time_test(dataMap);

		return createPieGragh(infoList, "system_version", "warn_count", "测试组预警版本分布");
	}

	/**
	 * 按子系统和时间段查看预警随时间分布分析--曲线图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_time_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_time_system(HttpServletRequest request) throws Exception {
		String system_name = request.getParameter("system_name");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_name", system_name);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_time_system(dataMap);

		return createLineGragh(infoList, "warning_date", "warn_count", "子系统预警时间分布");
	}

	/**
	 * 按子系统和时间段观察预警类型分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_type_time_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_type_time_system(HttpServletRequest request) throws Exception {
		String system_name = request.getParameter("system_name");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_name", system_name);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_type_time_system(dataMap);

		return createPieGragh(infoList, "rule_name", "warn_count", "子系统预警类型分布");
	}

	/**
	 * 按子系统和时间段观察预警级别分布分析--饼图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_grade_time_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_grade_time_system(HttpServletRequest request) throws Exception {
		String system_name = request.getParameter("system_name");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_name", system_name);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_grade_time_system(dataMap);

		return createPieGragh(infoList, "warning_grade", "warn_count", "子系统预警级别分布");
	}

	/**
	 * 按子系统和时间段观察预警随版本分布分析--曲线图
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warn_rm_time_system", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray warn_rm_time_system(HttpServletRequest request) throws Exception {
		String system_name = request.getParameter("system_name");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_name", system_name);
		dataMap.put("start_date", start_date);
		dataMap.put("end_date", end_date);
		List<LinkedHashMap<String, String>> infoList = warningAnalyseService.warn_rm_time_system(dataMap);

		return createLineGragh(infoList, "system_version", "warn_count", "子系统预警版本分布");
	}

	// pieData 处理函数
	private List<?> pieData(List<Double> list1, List<String> list2) {
		List<Data> dataList = new ArrayList<Data>();
		for (int i = 0; i < list1.size(); i++) {
			Data seriesdata = new Data();
			seriesdata.setValue(list1.get(i));
			seriesdata.setName(list2.get(i));
			dataList.add(seriesdata);
		}
		return dataList;
	}

	private JSONArray createPieGragh(List<LinkedHashMap<String, String>> infoList, String xKey, String yKey, String graghName) {
		JSONObject jsonData = new JSONObject();
		List<String> xList = new ArrayList<String>();
		List<Double> dataList = new ArrayList<Double>();
		List<PieCharts> pieList = new ArrayList<PieCharts>();

		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			xList.add(tempMap.get(xKey));
			dataList.add(Double.parseDouble(tempMap.get(yKey)));
		}

		List<?> piedata = pieData(dataList, xList);

		PieCharts pie = new PieCharts();

		pie.setName(graghName);
		pie.setType("pie");
		pie.setData(piedata);
		pieList.add(pie);

		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", pieList);

		return JSONArray.fromObject(jsonData);
	}

	private JSONArray createLineGragh(List<LinkedHashMap<String, String>> infoList, String xKey, String yKey, String graghName) {

		List<LineCharts> dataList = new ArrayList<LineCharts>();
		List<String> xList = new ArrayList<String>();
		ArrayList<Long> yList = new ArrayList<Long>();
		LineCharts charts = new LineCharts();

		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			xList.add(tempMap.get(xKey));
			yList.add(Long.parseLong(tempMap.get(yKey)));
		}

		charts.setName(graghName);
		charts.setType("line");
		charts.setData(yList);

		dataList.add(charts);

		JSONObject jsonData = new JSONObject();

		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return JSONArray.fromObject(jsonData);
	}
}
