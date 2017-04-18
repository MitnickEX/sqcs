package com.fudax.sqcs.version.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.version.dao.MyWorkBenchDAO;
import com.fudax.sqcs.version.service.MyWorkBenchService;

@Service
@Transactional
public class MyWorkBenchServiceImpl implements MyWorkBenchService {
	@Autowired
	private MyWorkBenchDAO myWorkBenchDAO;

	public List<LinkedHashMap<String, String>> getWorkdata(LinkedHashMap<String, String> dataMap) {
		LinkedHashMap<String, String> LinkedHashMap = new LinkedHashMap<String, String>();
		LinkedHashMap.clear();

		List<LinkedHashMap<String, String>> dataList = new ArrayList<LinkedHashMap<String, String>>();
		dataList.clear();
		List<LinkedHashMap<String, String>> need_add_to_rm_fact_list = myWorkBenchDAO.need_add_to_rm_fact(dataMap);
		StringBufferUtils.timeStampFormat(need_add_to_rm_fact_list);
		if (need_add_to_rm_fact_list.size() > 0) {
			LinkedHashMap.put("need_add_to_rm_fact", need_add_to_rm_fact_list.get(0).get("need_add_to_rm_fact"));
		} else {
			LinkedHashMap.put("need_add_to_rm_fact", "0");
		}
		List<LinkedHashMap<String, String>> add_to_rm_fact_lastday_list = myWorkBenchDAO.add_to_rm_fact_lastday(dataMap);
		StringBufferUtils.timeStampFormat(add_to_rm_fact_lastday_list);
		if (add_to_rm_fact_lastday_list.size() > 0) {
			LinkedHashMap.put("add_to_rm_fact_lastday", add_to_rm_fact_lastday_list.get(0).get("add_to_rm_fact_lastday"));
		} else {
			LinkedHashMap.put("add_to_rm_fact_lastday", "0");
		}
		List<LinkedHashMap<String, String>> need_deploy_stg_schedule_list = myWorkBenchDAO.need_deploy_stg_schedule(dataMap);
		StringBufferUtils.timeStampFormat(need_deploy_stg_schedule_list);
		if (need_deploy_stg_schedule_list.size() > 0) {
			LinkedHashMap.put("need_deploy_stg_fact", need_deploy_stg_schedule_list.get(0).get("need_deploy_stg_fact"));
		} else {
			LinkedHashMap.put("need_deploy_stg_fact", "0");
		}
		List<LinkedHashMap<String, String>> execute_percent_list = myWorkBenchDAO.execute_percent(dataMap);
		StringBufferUtils.timeStampFormat(execute_percent_list);
		if (execute_percent_list.size() > 0) {
			LinkedHashMap.put("st_plan_execute_percent", execute_percent_list.get(0).get("st_plan_execute_percent"));
		} else {
			LinkedHashMap.put("st_plan_execute_percent", "0");
		}
		List<LinkedHashMap<String, String>> st_actual_execute_percent_list = myWorkBenchDAO.st_actual_execute_percent(dataMap);
		StringBufferUtils.timeStampFormat(st_actual_execute_percent_list);
		if (st_actual_execute_percent_list.size() > 0) {
			LinkedHashMap.put("st_actual_execute_percent", st_actual_execute_percent_list.get(0).get("st_actual_execute_percent"));
			LinkedHashMap.put("uat_actual_execute_percent", st_actual_execute_percent_list.get(0).get("uat_actual_execute_percent"));
		} else {
			LinkedHashMap.put("st_actual_execute_percent", "0");
			LinkedHashMap.put("uat_actual_execute_percent", "0");
		}
		List<LinkedHashMap<String, String>> gompertz_define_list = myWorkBenchDAO.gompertz_define(dataMap);
		StringBufferUtils.timeStampFormat(gompertz_define_list);
		if (gompertz_define_list.size() > 0) {
			LinkedHashMap.put("bug_found_plan", gompertz_define_list.get(0).get("bug_found_plan"));
		} else {
			LinkedHashMap.put("bug_found_plan", "0");
		}
		List<LinkedHashMap<String, String>> problem_list = myWorkBenchDAO.problem_list(dataMap);
		StringBufferUtils.timeStampFormat(problem_list);
		LinkedHashMap<String, String> defectMap = new LinkedHashMap<String, String>();
		for (int i = 0; i < problem_list.size(); i++) {
			defectMap.put(problem_list.get(i).get("pro_status"), problem_list.get(i).get("bug_num"));
		}
		String toDeal = (defectMap.containsKey("处理中")) ? defectMap.get("处理中") : "0";
		String toCheck = (defectMap.containsKey("待验证")) ? defectMap.get("待验证") : "0";
		String closed = (defectMap.containsKey("已关闭")) ? defectMap.get("已关闭") : "0";
		String bug_found_actual = String.valueOf(Integer.parseInt(toDeal) + Integer.parseInt(toCheck) + Integer.parseInt(closed));
		String bug_deal_actual = String.valueOf(Integer.parseInt(toCheck) + Integer.parseInt(closed));

		LinkedHashMap.put("bug_found_actual", bug_found_actual);
		LinkedHashMap.put("bug_deal_plan", bug_found_actual);
		LinkedHashMap.put("bug_deal_actual", bug_deal_actual);
		LinkedHashMap.put("bug_close_plan", bug_deal_actual);
		LinkedHashMap.put("bug_close_actual", closed);
		List<LinkedHashMap<String, String>> version_environment_list = myWorkBenchDAO.version_environment(dataMap);
		StringBufferUtils.timeStampFormat(version_environment_list);
		if (version_environment_list.size() > 0) {
			LinkedHashMap.put("environment", version_environment_list.get(0).get("environment"));
		} else {
			LinkedHashMap.put("environment", "");
		}
		List<LinkedHashMap<String, String>> version_plantime_list = myWorkBenchDAO.version_plantime(dataMap);
		StringBufferUtils.timeStampFormat(version_plantime_list);
		String systemName = null;
		if (version_plantime_list.size() > 0) {
			systemName = version_plantime_list.get(0).get("system_name");
		}
		dataMap.put("systemName", systemName);
		List<LinkedHashMap<String, String>> auto_case_results_list = myWorkBenchDAO.auto_case_results(dataMap);
		StringBufferUtils.timeStampFormat(auto_case_results_list);
		if (auto_case_results_list.size() > 0) {
			LinkedHashMap.put("success_rate", auto_case_results_list.get(0).get("success_rate"));
		} else {
			LinkedHashMap.put("success_rate", "");
		}
		dataList.add(LinkedHashMap);

		return dataList;
	}
}
