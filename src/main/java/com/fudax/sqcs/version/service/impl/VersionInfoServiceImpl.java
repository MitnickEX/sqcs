package com.fudax.sqcs.version.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.version.dao.VersionInfoDAO;
import com.fudax.sqcs.version.service.VersionInfoService;

@Service
@Transactional
public class VersionInfoServiceImpl implements VersionInfoService {
	@Autowired
	private VersionInfoDAO versionInfoDAO;

	public List<LinkedHashMap<String, String>> versionBugList(String version) {
		List<LinkedHashMap<String, String>> dataList = versionInfoDAO.versionBugList(version);
		StringBufferUtils.timeStampFormat(dataList);
		return dataList;
	}

	public List<LinkedHashMap<String, String>> versionContent(String version) {
		List<LinkedHashMap<String, String>> dataList = versionInfoDAO.versionContent(version);
		StringBufferUtils.timeStampFormat(dataList);
		return dataList;
	}

	public List<LinkedHashMap<String, String>> versionInfo(LinkedHashMap<String, String> dataMap) {
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		String condition = "";
		if (system.toLowerCase().equals("all")) {
			condition = (group_type.toLowerCase().contains("test_team") ? "test_team" : "dev_dept");
		} else {
			condition = "system_alias";
		}
		dataMap.put("condition", condition);
		List<LinkedHashMap<String, String>> dataList = versionInfoDAO.versionInfoDataSql(dataMap);
		List<LinkedHashMap<String, String>> bugList = versionInfoDAO.versionInfoBugSql(dataMap);
		List<LinkedHashMap<String, String>> srList = versionInfoDAO.versionInfoSrSql(dataMap);
		List<LinkedHashMap<String, String>> warnList = versionInfoDAO.versionInfoWarnSql(dataMap);
		StringBufferUtils.timeStampFormat(dataList);
		StringBufferUtils.timeStampFormat(bugList);
		StringBufferUtils.timeStampFormat(srList);
		StringBufferUtils.timeStampFormat(warnList);
		LinkedHashMap<String, String> bugs = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> srs = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> warns = new LinkedHashMap<String, String>();
		for (LinkedHashMap<String, String> bug : bugList) {
			bugs.put(bug.get("pro_version"), bug.get("bug_count"));
		}
		for (LinkedHashMap<String, String> sr : srList) {
			srs.put(sr.get("system_version"), sr.get("sr_count"));
		}
		for (LinkedHashMap<String, String> warn : warnList) {
			warns.put(warn.get("system_version"), warn.get("warn_count"));
		}
		for (LinkedHashMap<String, String> data : dataList) {
			String bugCount = bugs.get(data.get("system_version"));
			String srCount = srs.get(data.get("system_version"));
			String warnCount = warns.get(data.get("system_version"));
			data.put("bug_count", (null == bugCount || bugCount.isEmpty()) ? "0" : bugCount);
			data.put("sr_count", (null == srCount || srCount.isEmpty()) ? "0" : srCount);
			data.put("warn_count", (null == warnCount || warnCount.isEmpty()) ? "0" : warnCount);
		}

		return dataList;
	}

	public List<LinkedHashMap<String, String>> versionSchedule(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> dataList = versionInfoDAO.versionSchedule(dataMap);
		StringBufferUtils.timeStampFormat(dataList);
		return dataList;
	}

	public List<LinkedHashMap<String, String>> versionList(LinkedHashMap<String, String> dataMap) {
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		String time_type = dataMap.get("time_type");
		String condition_1 = null;
		String condition_2 = null;
		if (system.equals("all")) {
			condition_1 = (group_type.toLowerCase().contains("test_team") ? "test_team" : "dev_dept");
		} else {
			condition_1 = "system_alias";
		}
		if (time_type.equalsIgnoreCase("release")) {
			condition_2 = "reviewtest_end_date";
		} else {
			condition_2 = "first_handover_test_time";
		}
		dataMap.put("condition1", condition_1);
		dataMap.put("condition2", condition_2);
		List<LinkedHashMap<String, String>> dataList = versionInfoDAO.versionListDataSql(dataMap);
		List<LinkedHashMap<String, String>> bugList = versionInfoDAO.versionListBugSql(dataMap);
		List<LinkedHashMap<String, String>> srList = versionInfoDAO.versionListSrSql(dataMap);
		List<LinkedHashMap<String, String>> warnList = versionInfoDAO.versionListWarnSql(dataMap);
		StringBufferUtils.timeStampFormat(dataList);
		StringBufferUtils.timeStampFormat(bugList);
		StringBufferUtils.timeStampFormat(srList);
		StringBufferUtils.timeStampFormat(warnList);

		LinkedHashMap<String, String> bugs = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> srs = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> warns = new LinkedHashMap<String, String>();
		for (LinkedHashMap<String, String> bug : bugList) {
			bugs.put(bug.get("pro_version"), bug.get("bug_count"));
		}
		for (LinkedHashMap<String, String> sr : srList) {
			srs.put(sr.get("system_version"), sr.get("sr_count"));
		}
		for (LinkedHashMap<String, String> warn : warnList) {
			warns.put(warn.get("system_version"), warn.get("warn_count"));
		}
		for (LinkedHashMap<String, String> data : dataList) {
			String bugCount = bugs.get(data.get("system_version"));
			String srCount = srs.get(data.get("system_version"));
			String warnCount = warns.get(data.get("system_version"));
			data.put("bug_count", (null == bugCount || bugCount.isEmpty()) ? "0" : bugCount);
			data.put("sr_count", (null == srCount || srCount.isEmpty()) ? "0" : srCount);
			data.put("warn_count", (null == warnCount || warnCount.isEmpty()) ? "0" : warnCount);
		}

		return dataList;
	}

	public List<LinkedHashMap<String, String>> versionUnderTest(String test_team) {
		List<LinkedHashMap<String, String>> dataList = versionInfoDAO.versionUnderTest(test_team);
		StringBufferUtils.timeStampFormat(dataList);
		return dataList;
	}

}
