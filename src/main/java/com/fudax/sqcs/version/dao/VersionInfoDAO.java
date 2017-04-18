package com.fudax.sqcs.version.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface VersionInfoDAO {
	public List<LinkedHashMap<String, String>> versionBugList(String version);

	public List<LinkedHashMap<String, String>> versionContent(String version);

	public List<LinkedHashMap<String, String>> versionInfoDataSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionInfoBugSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionInfoSrSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionInfoWarnSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionListDataSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionListBugSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionListSrSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionListWarnSql(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionSchedule(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> versionUnderTest(String test_team);

}
