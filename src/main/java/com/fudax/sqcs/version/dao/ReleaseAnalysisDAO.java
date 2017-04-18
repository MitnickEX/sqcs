package com.fudax.sqcs.version.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface ReleaseAnalysisDAO {
	public List<LinkedHashMap<String, String>> getPlusChartsWithSystemIsAllAndTimeTypeIsReleaseAndGroupTypeIsTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> getPlusChartsWithSystemIsAllAndTimeTypeIsReleaseAndGroupTypeIsNotTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> getPlusChartsWithSystemIsAllAndTimeTypeIsNotReleaseAndGroupTypeIsTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> getPlusChartsWithSystemIsAllAndTimeTypeIsNotReleaseAndGroupTypeIsNotTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> getPlusChartsWithSystemIsNotAllAndTimeTypeIsRelease(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> getPlusChartsWithSystemIsNotAllAndTimeTypeIsNotRelease(LinkedHashMap<String, String> dataMap);
}
