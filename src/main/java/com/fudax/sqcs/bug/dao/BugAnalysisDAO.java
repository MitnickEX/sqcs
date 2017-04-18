package com.fudax.sqcs.bug.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface BugAnalysisDAO {
	public List<LinkedHashMap<String, String>> bug_density_complex(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_distribute_system(String system);

	public List<LinkedHashMap<String, String>> bug_distribute_version(String version);

	public List<LinkedHashMap<String, String>> bug_sr_distribute(String system_version);

	public List<LinkedHashMap<String, String>> bug_sr_density(String version);

	public List<LinkedHashMap<String, String>> bug_finder_system_by_test_team(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_finder_system_by_dev_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_finder_version(String version);

	public List<LinkedHashMap<String, String>> bug_fix_system_by_test_team(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_fix_system_by_dev_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_fix_system_by_system(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_fix_version(String version);

	public List<LinkedHashMap<String, String>> bug_producer_system_by_test_team(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_producer_system_by_dev_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_producer_version(String version);

	public List<LinkedHashMap<String, String>> bug_repairs_num_system_by_test_team(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_repairs_num_system_by_dev_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_repairs_num_system_by_system(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_repairs_num_version(String version);

	public List<LinkedHashMap<String, String>> bug_by_system_by_test_team(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_by_system_by_dev_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_by_system_by_system(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_by_version_query_gompertz_defineList(String version);

	public List<LinkedHashMap<String, String>> bug_by_version_query_bug_found_trend(String version);

	public List<LinkedHashMap<String, String>> bug_by_version_query_bug_found_trend_left_join_gompertz_define(String version);

	public List<LinkedHashMap<String, String>> bug_verify_system_by_test_team(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_verify_system_by_dev_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_verify_system_by_system(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_verify_version(String version);
}
