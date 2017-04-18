package com.fudax.sqcs.srs.dao;

import java.util.List;
import java.util.Map;

public interface SRAnalyseDAO {

	public List<Map<String, String>> sr_ana_rm(String system_version);

	public List<Map<String, String>> query_rm_plan(String system_version);

	public List<Map<String, String>> sr_ana_dept(Map<String, String> dataMap);
}
