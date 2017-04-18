package com.fudax.sqcs.version.service;

import java.util.LinkedHashMap;

import java.util.List;

public interface VersionInfoService {
	public List<LinkedHashMap<String, String>> versionBugList(String version);

	public List<LinkedHashMap<String, String>> versionContent(String version);

	public List<LinkedHashMap<String, String>> versionInfo(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionSchedule(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionList(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionUnderTest(String test_team);
}
