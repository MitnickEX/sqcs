package com.fudax.sqcs.env.system.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface SystemInfoDAO {

	public List<LinkedHashMap<String, String>> queryListWhenSystemIsNull(LinkedHashMap<String, String> paramMap);

	public List<LinkedHashMap<String, String>> queryListWhenSystemIsNotNull(LinkedHashMap<String, String> paramMap);

	public List<LinkedHashMap<String, String>> queryDetail(LinkedHashMap<String, String> paramMap);

	public String queryModule(LinkedHashMap<String, String> paramMap);

	public List<LinkedHashMap<String, String>> getIdByDeptName(String dept_name);

	public int update(LinkedHashMap<String, String> paramMap);

	public int delete_module(LinkedHashMap<String, String> paramMap);

	public int new_module(LinkedHashMap<String, String> paramMap);
}
