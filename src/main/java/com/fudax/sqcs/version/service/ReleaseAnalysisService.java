package com.fudax.sqcs.version.service;

import java.util.LinkedHashMap;

import com.alibaba.fastjson.JSONObject;

public interface ReleaseAnalysisService {
	public JSONObject getPlusCharts(LinkedHashMap<String, String> dataMap);
}
