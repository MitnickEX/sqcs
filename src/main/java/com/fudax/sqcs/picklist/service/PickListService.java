package com.fudax.sqcs.picklist.service;

import java.util.List;
import java.util.LinkedHashMap;

public interface PickListService {

	public List<String> creatDept();

	public List<String> creatOwner(String database);

	public List<String> creatSystems(LinkedHashMap<String, String> dataMap);

	public List<String> createProSource();

	public List<String> createProStatus();

	public List<String> queryTestTeam();

	public List<LinkedHashMap<String, String>> queryJopType();

	public List<String> userCurrentVersion(LinkedHashMap<String, String> dataMap);

	public List<String> getWarnDate(String version_name);

	public List<String> createInstance(String system_name);

	public List<String> createDevTeam(String deptName);

	public List<String> createTeam(String dev_dept);

	public List<String> queryVersionByDev(String dev_dept);

	public List<String> listSystemName(String dev_dept);

	public List<String> queryTesters(String test_team);

	public List<String> queryVersionByTeam(String test_team);

	public List<String> queryNeedDept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> queryNeedSubmit(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> queryUserByDept(String dept_name);

	public List<LinkedHashMap<String, String>> queryUserByTeam(String team_name);

	public List<LinkedHashMap<String, String>> queryIfLeader(String umNo);

	public List<LinkedHashMap<String, String>> queryUser(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> createVersion(LinkedHashMap<String, String> dataMap);

	public List<String> queryDevTeam(LinkedHashMap<String, String> dataMap);

	public LinkedHashMap<String, String> queryUserNameByUM(String userName);
}
