package com.fudax.sqcs.bug.time.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.bug.time.dao.BugTimeAnalysisDAO;
import com.fudax.sqcs.bug.time.service.BugTimeAnalysisService;
import com.fudax.sqcs.utils.StringBufferUtils;

@Service
@Transactional
public class BugTimeAnalysisServiceImpl implements BugTimeAnalysisService {
	@Autowired
	private BugTimeAnalysisDAO bugTimeAnalysisDAO;

	public List<LinkedHashMap<String, String>> bug_repair_test_rm(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_repair_test_rm = bugTimeAnalysisDAO.bug_repair_test_rm(dataMap);
		StringBufferUtils.timeStampFormat(bug_repair_test_rm);
		return bug_repair_test_rm;
	}

	public List<LinkedHashMap<String, String>> bug_repair_dept_rm(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_repair_dept_rm = bugTimeAnalysisDAO.bug_repair_dept_rm(dataMap);
		StringBufferUtils.timeStampFormat(bug_repair_dept_rm);
		return bug_repair_dept_rm;
	}

	public List<LinkedHashMap<String, String>> bug_verify_test_rm(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_verify_test_rm = bugTimeAnalysisDAO.bug_verify_test_rm(dataMap);
		StringBufferUtils.timeStampFormat(bug_verify_test_rm);
		return bug_verify_test_rm;
	}

	public List<LinkedHashMap<String, String>> bug_verify_dept_rm(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_verify_dept_rm = bugTimeAnalysisDAO.bug_verify_dept_rm(dataMap);
		StringBufferUtils.timeStampFormat(bug_verify_dept_rm);
		return bug_verify_dept_rm;
	}

	public List<LinkedHashMap<String, String>> bug_repair_test_sys(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_repair_test_sys = bugTimeAnalysisDAO.bug_repair_test_sys(dataMap);
		StringBufferUtils.timeStampFormat(bug_repair_test_sys);
		return bug_repair_test_sys;
	}

	public List<LinkedHashMap<String, String>> bug_repair_dept_sys(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_repair_dept_sys = bugTimeAnalysisDAO.bug_repair_dept_sys(dataMap);
		StringBufferUtils.timeStampFormat(bug_repair_dept_sys);
		return bug_repair_dept_sys;
	}

	public List<LinkedHashMap<String, String>> bug_verify_test_sys(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_verify_test_sys = bugTimeAnalysisDAO.bug_verify_test_sys(dataMap);
		StringBufferUtils.timeStampFormat(bug_verify_test_sys);
		return bug_verify_test_sys;
	}

	public List<LinkedHashMap<String, String>> bug_verify_dept_sys(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> bug_verify_dept_sys = bugTimeAnalysisDAO.bug_verify_dept_sys(dataMap);
		StringBufferUtils.timeStampFormat(bug_verify_dept_sys);
		return bug_verify_dept_sys;
	}

}
