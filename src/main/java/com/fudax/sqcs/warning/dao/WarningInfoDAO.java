package com.fudax.sqcs.warning.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface WarningInfoDAO {
	public List<LinkedHashMap<String, String>> warnInfoWhenDateIsAllAndGradeIsAll(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warnInfoWhenDateIsAllAndGradeIsNotAll(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warnInfoWhenDateIsNotAllAndGradeIsAll(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> warnInfoWhenDateIsNotAllAndGradeIsNotAll(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> detailQueryWhenTypeIs03(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> detailQueryWhenTypeIs04(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> detailQueryWhenTypeIs06(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> detailQueryWhenTypeIsOther(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> bug_none_sr(String system_version);

	public List<LinkedHashMap<String, String>> bug_none_module(String system_version);

	public List<LinkedHashMap<String, String>> warn_type();

	public List<LinkedHashMap<String, String>> warningVersionList();
}
