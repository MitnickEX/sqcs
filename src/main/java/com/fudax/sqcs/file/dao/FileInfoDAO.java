package com.fudax.sqcs.file.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface FileInfoDAO {

	/**
	 * @param oper_seq
	 * @return
	 * @throws Exception
	 */
	public List<LinkedHashMap<String, String>> getAttach(String oper_seq);

	/**
	 * @param file_name
	 * @param oper_seq
	 * @param file_path
	 * @return
	 * @throws Exception
	 */
	public int addAttach(LinkedHashMap<String, String> LinkedHashMap);

	/**
	 * @param file_id
	 * @return
	 * @throws Exception
	 */
	public int delAttach(String file_id);

	/**
	 * @param file_id
	 * @return
	 * @throws Exception
	 */
	public String getStoreById(String file_id);

	/**
	 * @param file_id
	 * @return
	 * @throws Exception
	 */
	public String getNameById(String file_id);
}
