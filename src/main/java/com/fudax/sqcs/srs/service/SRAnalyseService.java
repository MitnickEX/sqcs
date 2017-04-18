package com.fudax.sqcs.srs.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface SRAnalyseService {
	public LinkedHashMap<String, LinkedHashMap<String, Integer>> sr_ana_data(String system_version);

	public List<Map<String, String>> sr_ana_rm(String system_version);

	public List<String> query_rm_plan(String system_version);

	public List<Map<String, String>> sr_ana_dept(Map<String, String> dataMap);
}
