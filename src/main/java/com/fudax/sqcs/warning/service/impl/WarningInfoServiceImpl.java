package com.fudax.sqcs.warning.service.impl;

import java.util.List;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.warning.dao.WarningInfoDAO;
import com.fudax.sqcs.warning.service.WarningInfoService;

@Service
@Transactional
public class WarningInfoServiceImpl implements WarningInfoService {
	@Autowired
	private WarningInfoDAO warningInfoDAO;

	public List<LinkedHashMap<String, String>> warnInfo(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> list;
		String warning_date = dataMap.get("warning_date");
		String warning_grade = dataMap.get("warning_grade");
		if ("all".equalsIgnoreCase(warning_date) && "all".equalsIgnoreCase(warning_grade)) {
			list = warningInfoDAO.warnInfoWhenDateIsAllAndGradeIsAll(dataMap);
		} else if ("all".equalsIgnoreCase(warning_date) && !"all".equalsIgnoreCase(warning_grade)) {
			list = warningInfoDAO.warnInfoWhenDateIsAllAndGradeIsNotAll(dataMap);
		} else if (!"all".equalsIgnoreCase(warning_date) && "all".equalsIgnoreCase(warning_grade)) {
			list = warningInfoDAO.warnInfoWhenDateIsNotAllAndGradeIsAll(dataMap);
		} else {
			list = warningInfoDAO.warnInfoWhenDateIsNotAllAndGradeIsNotAll(dataMap);
		}
		StringBufferUtils.timeStampFormat(list);
		return list;
	}

	public List<LinkedHashMap<String, String>> detailQuery(LinkedHashMap<String, String> dataMap) {
		String warning_type = dataMap.get("warning_type");
		List<LinkedHashMap<String, String>> infoList;
		if ("04".equals(warning_type)) {
			infoList = warningInfoDAO.detailQueryWhenTypeIs04(dataMap);
		} else if ("03".equals(warning_type)) {
			infoList = warningInfoDAO.detailQueryWhenTypeIs03(dataMap);
		} else if ("06".equals(warning_type)) {
			infoList = warningInfoDAO.detailQueryWhenTypeIs06(dataMap);
		} else {
			infoList = warningInfoDAO.detailQueryWhenTypeIsOther(dataMap);
		}

		StringBufferUtils.timeStampFormat(infoList);
		return infoList;
	}

	public List<LinkedHashMap<String, String>> bug_none_sr(String system_version) {
		List<LinkedHashMap<String, String>> infoList = warningInfoDAO.bug_none_sr(system_version);
		StringBufferUtils.timeStampFormat(infoList);
		return infoList;
	}

	public List<LinkedHashMap<String, String>> bug_none_module(String system_version) {
		List<LinkedHashMap<String, String>> infoList = warningInfoDAO.bug_none_module(system_version);
		StringBufferUtils.timeStampFormat(infoList);
		return infoList;
	}

	public List<LinkedHashMap<String, String>> warningVersionList() {
		List<LinkedHashMap<String, String>> warningVersionList = warningInfoDAO.warningVersionList();
		StringBufferUtils.timeStampFormat(warningVersionList);
		return warningVersionList;
	}

	public List<LinkedHashMap<String, String>> warn_type() {
		List<LinkedHashMap<String, String>> warnTypeList = warningInfoDAO.warn_type();
		StringBufferUtils.timeStampFormat(warnTypeList);
		return warnTypeList;
	}

}
