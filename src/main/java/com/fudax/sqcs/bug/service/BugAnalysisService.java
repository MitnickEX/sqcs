package com.fudax.sqcs.bug.service;

import java.util.LinkedHashMap;

import com.alibaba.fastjson.JSONObject;

public interface BugAnalysisService {
	public JSONObject bug_density_complex(LinkedHashMap<String, String> dataMap);

	public JSONObject bug_distribute_system(String system);

	public JSONObject bug_distribute_version(String version);

	public JSONObject bug_sr_distribute(String system_version);

	public JSONObject bug_sr_density(String version);

	public JSONObject bug_finder_system(LinkedHashMap<String, String> dataMap);

	public JSONObject bug_finder_version(String version);

	public JSONObject bug_fix_system(LinkedHashMap<String, String> dataMap);

	public JSONObject bug_fix_version(String version);

	public JSONObject bug_producer_system(LinkedHashMap<String, String> dataMap);

	public JSONObject bug_producer_version(String version);

	public JSONObject bug_repairs_num_system(LinkedHashMap<String, String> dataMap);

	public JSONObject bug_repairs_num_version(String version);

	public JSONObject bug_by_system(LinkedHashMap<String, String> dataMap);

	public JSONObject bug_by_version(String version);

	public JSONObject bug_verify_system(LinkedHashMap<String, String> dataMap);

	public JSONObject bug_verify_version(String version);
}
