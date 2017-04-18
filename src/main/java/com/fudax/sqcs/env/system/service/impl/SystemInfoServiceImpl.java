package com.fudax.sqcs.env.system.service.impl;

import java.util.List;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.env.system.dao.SystemInfoDAO;
import com.fudax.sqcs.env.system.service.SystemInfoService;
import com.fudax.sqcs.utils.StringBufferUtils;

@Service
@Transactional
public class SystemInfoServiceImpl implements SystemInfoService {
	@Autowired
	private SystemInfoDAO systemInfoDAO;

	public List<LinkedHashMap<String, String>> queryListWhenSystemIsNull(LinkedHashMap<String, String> paramMap) {
		List<LinkedHashMap<String, String>> queryList = systemInfoDAO.queryListWhenSystemIsNull(paramMap);
		StringBufferUtils.timeStampFormat(queryList);
		return queryList;
	}

	public List<LinkedHashMap<String, String>> queryListWhenSystemIsNotNull(LinkedHashMap<String, String> paramMap) {
		List<LinkedHashMap<String, String>> queryList = systemInfoDAO.queryListWhenSystemIsNotNull(paramMap);
		StringBufferUtils.timeStampFormat(queryList);
		return queryList;
	}

	public List<LinkedHashMap<String, String>> queryDetail(LinkedHashMap<String, String> paramMap) {
		List<LinkedHashMap<String, String>> queryDetailList = systemInfoDAO.queryDetail(paramMap);
		StringBufferUtils.timeStampFormat(queryDetailList);
		return queryDetailList;
	}

	public String queryModule(LinkedHashMap<String, String> paramMap) {
		String queryModuleList = systemInfoDAO.queryModule(paramMap);
		return queryModuleList;
	}

	public List<LinkedHashMap<String, String>> getIdByDeptName(String dept_name) {
		List<LinkedHashMap<String, String>> infoList = systemInfoDAO.getIdByDeptName(dept_name);
		StringBufferUtils.timeStampFormat(infoList);
		return infoList;
	}

	public int update(LinkedHashMap<String, String> paramMap) {
		int updateCount = systemInfoDAO.update(paramMap);
		return updateCount;
	}

	public int delete_module(LinkedHashMap<String, String> paramMap) {
		int deleteCount = systemInfoDAO.delete_module(paramMap);
		return deleteCount;
	}

	public int new_module(LinkedHashMap<String, String> paramMap) {
		int newCount = systemInfoDAO.new_module(paramMap);
		return newCount;
	}

}
