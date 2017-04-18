package com.fudax.sqcs.visitor.dao;

import java.util.LinkedHashMap;
import java.util.List;

public interface KBVisitorAnaDAO {

	public List<LinkedHashMap<String, String>> queryGraghNameByGraghType(String gragh_type);

	public List<LinkedHashMap<String, String>> queryVdateList(LinkedHashMap<String, String> map);

	public List<LinkedHashMap<String, String>> queryTeamVisitorAna();

	public List<LinkedHashMap<String, String>> queryDeptVisitorAna();

}
