package com.fudax.sqcs.warning.service;

import java.util.List;
import java.util.LinkedHashMap;

public interface WarningInfoService {
	public List<LinkedHashMap<String, String>> warnInfo(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> detailQuery(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_none_sr(String system_version);

	public List<LinkedHashMap<String, String>> bug_none_module(String system_version);

	public List<LinkedHashMap<String, String>> warn_type();

	public List<LinkedHashMap<String, String>> warningVersionList();
}
