package com.fudax.sqcs.version.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface MyWorkBenchDAO {
	public List<LinkedHashMap<String, String>> need_add_to_rm_fact(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> add_to_rm_fact_lastday(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> need_deploy_stg_schedule(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> execute_percent(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> st_actual_execute_percent(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> gompertz_define(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> problem_list(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> version_environment(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> auto_case_results(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> version_plantime(LinkedHashMap<String, String> dataMap);
}
