package com.fudax.sqcs.problem.service;

import java.util.List;
import java.util.LinkedHashMap;

public interface ProblemInfoService {

	/**
	 * @param pro_id
	 * @return
	 * @throws Exception
	 */
	public List<LinkedHashMap<String, String>> detailQuery(String pro_id);

	/**
	 * @param LinkedHashMap
	 * @return
	 * @throws Exception
	 */
	public List<LinkedHashMap<String, String>> query(LinkedHashMap<String, String> LinkedHashMap);

	/**
	 * @param LinkedHashMap
	 * @return
	 */
	public int add(LinkedHashMap<String, String> LinkedHashMap);

	/**
	 * @param LinkedHashMap
	 * @return
	 */
	public int updateWhenToBeContainsClose(LinkedHashMap<String, String> LinkedHashMap);

	/**
	 * @param LinkedHashMap
	 * @return
	 */
	public int updateWhenToBeNotContainsClose(LinkedHashMap<String, String> LinkedHashMap);

	/**
	 * @param source_desc
	 * @return
	 */
	public List<LinkedHashMap<String, String>> querySourceCode(String source_desc);

	/**
	 * @param status_desc
	 * @return
	 */
	public List<LinkedHashMap<String, String>> queryStatusCode(String status_desc);
}
