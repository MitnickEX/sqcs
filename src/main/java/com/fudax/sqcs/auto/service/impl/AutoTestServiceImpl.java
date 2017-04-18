package com.fudax.sqcs.auto.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.fudax.sqcs.auto.dao.AutoTestDAO;
import com.fudax.sqcs.auto.service.AutoTestService;
import com.fudax.sqcs.bug.modle.Histogram;
import com.fudax.sqcs.pub.model.GraghDataTrans;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;

@Service
@Transactional
public class AutoTestServiceImpl implements AutoTestService {
	@Autowired
	private AutoTestDAO autotestDAO;

	@SuppressWarnings("unchecked")
	public JSONObject autoCaseResultsQry(LinkedHashMap<String, String> dataMap) {
		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();

		List<String> xList = new ArrayList<String>();
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		List<LinkedHashMap<String, String>> chartList;
		if (system.equals("all")) {
			if (group_type.equalsIgnoreCase("test_team")) {
				chartList = autotestDAO.autoCaseResultsQryWithTestTeam(dataMap);
			} else {
				chartList = autotestDAO.autoCaseResultsQryWithDevDept(dataMap);
			}
		} else {
			chartList = autotestDAO.autoCaseResultsQryWithSystem(dataMap);
		}
		StringBufferUtils.timeStampFormat(chartList);
		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}
		int listnum = chartList.get(0).keySet().size() - 1;

		ArrayList<Double>[] arr = new ArrayList[listnum];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}
		GraghDataTrans.createHistogramGragh(chartList, xList, "start_date", arr);

		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]);
		}

		echarter[0].setName("测试用例数");
		echarter[0].setType("bar");
		echarter[0].setYAxisIndex(0);

		echarter[1].setName("运行通过数");
		echarter[1].setType("bar");
		echarter[1].setYAxisIndex(0);

		echarter[2].setName("运行通过率");
		echarter[2].setType("line");
		echarter[2].setYAxisIndex(1);

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return jsonData;
	}

	public JSONObject autoCaseResultsRecord(String case_result) {

		net.sf.json.JSONObject inputData = StringBufferUtils.strToJsonObject(case_result);
		JSONObject resultData = new JSONObject();

		String job_name = inputData.getString("job_name");
		String job_type = inputData.getString("job_type"); // 01: Auto Case
															// Results; 02:
															// Interface
															// Results; 03:
															// Algorithm Results
		String system_name = inputData.getString("system_name").toUpperCase();
		String system_version = inputData.containsKey("system_version") ? inputData.getString("system_version") : "";
		String run_env = inputData.containsKey("run_env") ? inputData.getString("run_env") : "";
		String class_total = inputData.containsKey("class_total") ? inputData.getString("class_total") : "0";
		String class_success_no = inputData.containsKey("class_success_no") ? inputData.getString("class_success_no") : "0";
		String class_fail_no = inputData.containsKey("class_fail_no") ? inputData.getString("class_fail_no") : "0";
		String class_success_rate = (inputData.containsKey("class_success_rate") && inputData.getString("class_success_rate") != null)
				? inputData.getString("class_success_rate").replaceAll("%", "") : "0.00";
		String method_total = inputData.containsKey("method_total") ? inputData.getString("method_total") : "0";
		String success_no = inputData.containsKey("success_no") ? inputData.getString("success_no") : "0";
		String fail_no = inputData.containsKey("fail_no") ? inputData.getString("fail_no") : "0";
		String success_rate = (inputData.containsKey("success_rate") && inputData.getString("success_rate") != null)
				? inputData.getString("success_rate").replaceAll("%", "") : "0.00";
		String complete_date = inputData.containsKey("complete_date") ? inputData.getString("complete_date") : "";
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_name", system_name);
		dataMap.put("system_version", system_version);
		dataMap.put("run_env", run_env);
		dataMap.put("class_total", class_total);
		dataMap.put("class_success_no", class_success_no);
		dataMap.put("class_fail_no", class_fail_no);
		dataMap.put("class_success_rate", class_success_rate);
		dataMap.put("method_total", method_total);
		dataMap.put("success_no", success_no);
		dataMap.put("fail_no", fail_no);
		dataMap.put("success_rate", success_rate);
		dataMap.put("complete_date", complete_date);
		dataMap.put("job_name", job_name);
		dataMap.put("job_type", job_type);
		try {
			autotestDAO.autoCaseResultsRecord(dataMap);
			resultData.put("state", "1");
			resultData.put("result", "success");

		} catch (Exception e) {
			resultData.put("state", "0");
			resultData.put("result", "failed");
			resultData.put("ErroMsg", e.getMessage());
		}
		return resultData;
	}

	public JSONObject autoCaseTotalRecord(String case_total_result) {
		JSONArray inputData = JSONArray.fromObject(case_total_result);
		JSONObject resultData = new JSONObject();

		try {
			LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
			for (int index = 0; index < inputData.size(); index++) {
				String system_name = inputData.getJSONObject(index).getString("system_name").toUpperCase();
				String class_total_no = inputData.getJSONObject(index).containsKey("class_total_no")
						? inputData.getJSONObject(index).getString("class_total_no") : "0";
				String total_no = inputData.getJSONObject(index).containsKey("total_no") ? inputData.getJSONObject(index).getString("total_no") : "0";
				String analyze_date = inputData.getJSONObject(index).containsKey("analyze_date")
						? inputData.getJSONObject(index).getString("analyze_date") : "";
				dataMap.put("system_name", system_name);
				dataMap.put("class_total_no", class_total_no);
				dataMap.put("total_no", total_no);
				dataMap.put("analyze_date", analyze_date);
				autotestDAO.autoCaseTotalRecord(dataMap);
				dataMap.remove("system_name");
				dataMap.remove("class_total_no");
				dataMap.remove("total_no");
				dataMap.remove("analyze_date");
			}
			resultData.put("state", "1");
			resultData.put("result", "success");
		} catch (Exception e) {
			resultData.put("state", "0");
			resultData.put("result", "failed");
			resultData.put("ErroMsg", e.getMessage());
		}

		return resultData;
	}

	public List<LinkedHashMap<String, String>> autoTestEmailReceiver(LinkedHashMap<String, String> dataMap) {
		String dev_dept = dataMap.get("dev_dept");
		List<LinkedHashMap<String, String>> dataList;
		if (null == dev_dept || dev_dept.isEmpty()) {
			dataList = autotestDAO.autoTestEmailReceiverWhenDevDeptIsNull(dataMap);
		} else {
			dataList = autotestDAO.autoTestEmailReceiverWhenDevDeptIsNotNull(dataMap);
		}
		StringBufferUtils.timeStampFormat(dataList);
		return dataList;
	}

	public List<LinkedHashMap<String, String>> autotestDetail(LinkedHashMap<String, String> dataMap) {
		String systemName = "";
		List<LinkedHashMap<String, String>> systemNameList = autotestDAO.autotestDetailName(dataMap);
		StringBufferUtils.timeStampFormat(systemNameList);
		if (systemNameList.size() > 0) {
			systemName = systemNameList.get(0).get("system_name");
		}
		dataMap.put("systemName", systemName);
		List<LinkedHashMap<String, String>> dataList = autotestDAO.autotestDetailList(dataMap);
		StringBufferUtils.timeStampFormat(dataList);
		return dataList;
	}

	public List<LinkedHashMap<String, String>> summaryQuery(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> dataList = autotestDAO.summaryQuery(dataMap);
		StringBufferUtils.timeStampFormat(dataList);
		return dataList;
	}

	public List<LinkedHashMap<String, String>> autotestGroupQry(LinkedHashMap<String, String> dataMap) {
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		List<LinkedHashMap<String, String>> dataList;
		if (system.equals("all")) {
			if (group_type.equalsIgnoreCase("test_team")) {
				dataList = autotestDAO.autotestGroupQryWithTestTeam(dataMap);
			} else {
				dataList = autotestDAO.autotestGroupQryWithDevDept(dataMap);
			}

		} else {
			dataList = autotestDAO.autotestGroupQryWithSystem(dataMap);
		}
		return dataList;
	}
}
