package com.fudax.sqcs.problem.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.problem.dao.ProblemInfoDAO;
import com.fudax.sqcs.problem.service.ProblemInfoService;
import com.fudax.sqcs.utils.StringBufferUtils;

@Service
@Transactional
public class ProblemInfoServiceImpl implements ProblemInfoService {

	@Autowired
	private ProblemInfoDAO problemInfoDAO;

	/**
	 * @param pro_id
	 * @return
	 */
	public List<LinkedHashMap<String, String>> detailQuery(String pro_id) {
		List<LinkedHashMap<String, String>> detailQueryListById = problemInfoDAO.detailQuery(pro_id);
		StringBufferUtils.timeStampFormat(detailQueryListById);
		return detailQueryListById;
	}

	/**
	 * @param LinkedHashMap
	 * @return
	 */
	public List<LinkedHashMap<String, String>> query(LinkedHashMap<String, String> LinkedHashMap) {
		List<LinkedHashMap<String, String>> query = problemInfoDAO.query(LinkedHashMap);
		StringBufferUtils.timeStampFormat(query);
		return query;
	}

	/**
	 * @param LinkedHashMap
	 * @return
	 */
	public int add(LinkedHashMap<String, String> LinkedHashMap) {
		int newProId = problemInfoDAO.add(LinkedHashMap);
		return newProId;
	}

	/**
	 * @param LinkedHashMap
	 * @return
	 */
	public int updateWhenToBeContainsClose(LinkedHashMap<String, String> LinkedHashMap) {
		int updateCount = problemInfoDAO.updateWhenToBeContainsClose(LinkedHashMap);
		return updateCount;
	}

	/**
	 * @param LinkedHashMap
	 * @return
	 */
	public int updateWhenToBeNotContainsClose(LinkedHashMap<String, String> LinkedHashMap) {
		int updateCount = problemInfoDAO.updateWhenToBeNotContainsClose(LinkedHashMap);
		return updateCount;
	}

	/**
	 * @param source_desc
	 * @return
	 */
	public List<LinkedHashMap<String, String>> querySourceCode(String source_desc) {
		List<LinkedHashMap<String, String>> sourceCodeList = problemInfoDAO.querySourceCode(source_desc);
		StringBufferUtils.timeStampFormat(sourceCodeList);
		return sourceCodeList;
	}

	/**
	 * @param status_desc
	 * @return
	 */
	public List<LinkedHashMap<String, String>> queryStatusCode(String status_desc) {
		List<LinkedHashMap<String, String>> statusCodeList = problemInfoDAO.queryStatusCode(status_desc);
		StringBufferUtils.timeStampFormat(statusCodeList);
		return statusCodeList;
	}
}
