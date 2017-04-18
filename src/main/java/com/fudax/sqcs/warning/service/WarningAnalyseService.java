package com.fudax.sqcs.warning.service;

import java.util.List;
import java.util.LinkedHashMap;

public interface WarningAnalyseService {
	public List<LinkedHashMap<String, String>> warn_type_version(String version);

	public List<LinkedHashMap<String, String>> warn_grade_version(String version);

	public List<LinkedHashMap<String, String>> warn_time_version(String version);

	public List<LinkedHashMap<String, String>> warn_time_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_type_time_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_grade_time_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_system_time_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_rm_time_dept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_time_test(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_type_time_test(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_grade_time_test(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_system_time_test(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_rm_time_test(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_time_system(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_type_time_system(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_grade_time_system(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warn_rm_time_system(LinkedHashMap<String, String> dataMap);
}
