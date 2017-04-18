package com.fudax.sqcs.bug.time.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface BugTimeAnalysisDAO {

	public List<LinkedHashMap<String, String>> bug_repair_test_rm(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_repair_dept_rm(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_verify_test_rm(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_verify_dept_rm(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_repair_test_sys(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_repair_dept_sys(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_verify_test_sys(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_verify_dept_sys(LinkedHashMap<String, String> dataMap);
}
