package com.fudax.sqcs.auto.service;

import java.util.LinkedHashMap;
import java.util.List;

import com.alibaba.fastjson.JSONObject;

public interface AutoTestService {
	public JSONObject autoCaseResultsQry(LinkedHashMap<String, String> dataMap);

	public JSONObject autoCaseResultsRecord(String case_result);

	public JSONObject autoCaseTotalRecord(String case_total_result);

	public List<LinkedHashMap<String, String>> autoTestEmailReceiver(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autotestDetail(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> summaryQuery(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autotestGroupQry(LinkedHashMap<String, String> dataMap);
}
