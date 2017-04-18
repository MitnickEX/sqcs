package com.fudax.sqcs.warning.service.impl;

import java.util.List;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.warning.dao.WarningAnalyseDAO;
import com.fudax.sqcs.warning.service.WarningAnalyseService;

@Service
@Transactional
public class WarningAnalyseServiceImpl implements WarningAnalyseService {
	@Autowired
	private WarningAnalyseDAO warningAnalyseDAO;

	public List<LinkedHashMap<String, String>> warn_type_version(String version) {
		List<LinkedHashMap<String, String>> warn_type_version = warningAnalyseDAO.warn_type_version(version);
		StringBufferUtils.timeStampFormat(warn_type_version);
		return warn_type_version;
	}

	public List<LinkedHashMap<String, String>> warn_grade_version(String version) {
		List<LinkedHashMap<String, String>> warn_grade_version = warningAnalyseDAO.warn_grade_version(version);
		StringBufferUtils.timeStampFormat(warn_grade_version);
		return warn_grade_version;
	}

	public List<LinkedHashMap<String, String>> warn_time_version(String version) {
		List<LinkedHashMap<String, String>> warn_time_version = warningAnalyseDAO.warn_time_version(version);
		StringBufferUtils.timeStampFormat(warn_time_version);
		return warn_time_version;
	}

	public List<LinkedHashMap<String, String>> warn_time_dept(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_time_dept = warningAnalyseDAO.warn_time_dept(dataMap);
		StringBufferUtils.timeStampFormat(warn_time_dept);
		return warn_time_dept;
	}

	public List<LinkedHashMap<String, String>> warn_type_time_dept(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_type_time_dept = warningAnalyseDAO.warn_type_time_dept(dataMap);
		StringBufferUtils.timeStampFormat(warn_type_time_dept);
		return warn_type_time_dept;
	}

	public List<LinkedHashMap<String, String>> warn_grade_time_dept(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_grade_time_dept = warningAnalyseDAO.warn_grade_time_dept(dataMap);
		StringBufferUtils.timeStampFormat(warn_grade_time_dept);
		return warn_grade_time_dept;
	}

	public List<LinkedHashMap<String, String>> warn_system_time_dept(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_system_time_dept = warningAnalyseDAO.warn_system_time_dept(dataMap);
		StringBufferUtils.timeStampFormat(warn_system_time_dept);
		return warn_system_time_dept;
	}

	public List<LinkedHashMap<String, String>> warn_rm_time_dept(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_rm_time_dept = warningAnalyseDAO.warn_rm_time_dept(dataMap);
		StringBufferUtils.timeStampFormat(warn_rm_time_dept);
		return warn_rm_time_dept;
	}

	public List<LinkedHashMap<String, String>> warn_time_test(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_time_test = warningAnalyseDAO.warn_time_test(dataMap);
		StringBufferUtils.timeStampFormat(warn_time_test);
		return warn_time_test;
	}

	public List<LinkedHashMap<String, String>> warn_type_time_test(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_type_time_test = warningAnalyseDAO.warn_type_time_test(dataMap);
		StringBufferUtils.timeStampFormat(warn_type_time_test);
		return warn_type_time_test;
	}

	public List<LinkedHashMap<String, String>> warn_grade_time_test(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_grade_time_test = warningAnalyseDAO.warn_grade_time_test(dataMap);
		StringBufferUtils.timeStampFormat(warn_grade_time_test);
		return warn_grade_time_test;
	}

	public List<LinkedHashMap<String, String>> warn_system_time_test(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_system_time_test = warningAnalyseDAO.warn_system_time_test(dataMap);
		StringBufferUtils.timeStampFormat(warn_system_time_test);
		return warn_system_time_test;
	}

	public List<LinkedHashMap<String, String>> warn_rm_time_test(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_rm_time_test = warningAnalyseDAO.warn_rm_time_test(dataMap);
		StringBufferUtils.timeStampFormat(warn_rm_time_test);
		return warn_rm_time_test;
	}

	public List<LinkedHashMap<String, String>> warn_time_system(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_time_system = warningAnalyseDAO.warn_time_system(dataMap);
		StringBufferUtils.timeStampFormat(warn_time_system);
		return warn_time_system;
	}

	public List<LinkedHashMap<String, String>> warn_type_time_system(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_type_time_system = warningAnalyseDAO.warn_type_time_system(dataMap);
		return warn_type_time_system;
	}

	public List<LinkedHashMap<String, String>> warn_grade_time_system(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_grade_time_system = warningAnalyseDAO.warn_grade_time_system(dataMap);
		StringBufferUtils.timeStampFormat(warn_grade_time_system);
		return warn_grade_time_system;
	}

	public List<LinkedHashMap<String, String>> warn_rm_time_system(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> warn_rm_time_system = warningAnalyseDAO.warn_rm_time_system(dataMap);
		StringBufferUtils.timeStampFormat(warn_rm_time_system);
		return warn_rm_time_system;
	}

}
