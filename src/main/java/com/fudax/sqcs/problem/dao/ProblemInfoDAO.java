package com.fudax.sqcs.problem.dao;

import java.util.LinkedHashMap;
import java.util.List;

public interface ProblemInfoDAO {

	/**
	 * @param pro_id
	 * @return
	 */
	public List<LinkedHashMap<String, String>> detailQuery(String pro_id);

	/**
	 * @param LinkedHashMap
	 * @return
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
