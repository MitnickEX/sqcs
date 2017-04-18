package com.fudax.sqcs.visitor.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.visitor.dao.KBVisitorAnaDAO;
import com.fudax.sqcs.visitor.service.KBVisitorAnaService;

@Service
public class KBVisitorAnaServiceImpl implements KBVisitorAnaService {

	@Autowired
	private KBVisitorAnaDAO kbVisitorAnaDAO;

	public List<LinkedHashMap<String, String>> queryGraghNameByGraghType(String gragh_type) {
		List<LinkedHashMap<String, String>> graghNameList = kbVisitorAnaDAO.queryGraghNameByGraghType(gragh_type);
		StringBufferUtils.timeStampFormat(graghNameList);
		return graghNameList;
	}

	public List<LinkedHashMap<String, String>> queryVdateList(LinkedHashMap<String, String> map) {
		List<LinkedHashMap<String, String>> queryVdateList = kbVisitorAnaDAO.queryVdateList(map);
		StringBufferUtils.timeStampFormat(queryVdateList);
		return queryVdateList;
	}

	public List<LinkedHashMap<String, String>> queryTeamVisitorAna() {
		return kbVisitorAnaDAO.queryTeamVisitorAna();
	}

	public List<LinkedHashMap<String, String>> queryDeptVisitorAna() {
		return kbVisitorAnaDAO.queryDeptVisitorAna();
	}
}
