package com.fudax.sqcs.auto.dao;

import java.util.LinkedHashMap;
import java.util.List;

public interface AutoTestDAO {

	public List<LinkedHashMap<String, String>> autoCaseResultsQryWithTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autoCaseResultsQryWithDevDept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autoCaseResultsQryWithSystem(LinkedHashMap<String, String> dataMap);

	public int autoCaseResultsRecord(LinkedHashMap<String, String> dataMap);

	public int autoCaseTotalRecord(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autoTestEmailReceiverWhenDevDeptIsNull(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autoTestEmailReceiverWhenDevDeptIsNotNull(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autotestDetailName(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autotestDetailList(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> summaryQuery(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autotestGroupQryWithTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autotestGroupQryWithDevDept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> autotestGroupQryWithSystem(LinkedHashMap<String, String> dataMap);
}