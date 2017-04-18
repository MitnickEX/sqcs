package com.fudax.sqcs.picklist.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface PickListDAO {

	public List<LinkedHashMap<String, String>> creatDept();

	public List<LinkedHashMap<String, String>> creatOwner(String database);

	public List<LinkedHashMap<String, String>> creatSystemsByTestTeam(String group_name);

	public List<LinkedHashMap<String, String>> creatSystemsByDevDept(String group_name);

	public List<LinkedHashMap<String, String>> createProSource();

	public List<LinkedHashMap<String, String>> createProStatus();

	public List<LinkedHashMap<String, String>> queryTestTeam();

	public List<LinkedHashMap<String, String>> queryJopType();

	public List<LinkedHashMap<String, String>> userCurrentVersion(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> getWarnDate(String version_name);

	public List<LinkedHashMap<String, String>> createInstance(String system_name);

	public List<LinkedHashMap<String, String>> createDevTeam(String deptName);

	public List<LinkedHashMap<String, String>> createTeam(String dev_dept);

	public List<LinkedHashMap<String, String>> queryVersionByDev(String dev_dept);

	public List<LinkedHashMap<String, String>> listSystemName(String dev_dept);

	public List<LinkedHashMap<String, String>> queryTesters(String test_team);

	public List<LinkedHashMap<String, String>> queryVersionByTeam(String test_team);

	public List<LinkedHashMap<String, String>> queryUserByDept(String dept_name);

	public List<LinkedHashMap<String, String>> queryUserByTeam(String team_name);

	public List<LinkedHashMap<String, String>> queryIfLeader(String umNo);

	public List<LinkedHashMap<String, String>> queryNeedDept(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> queryNeedSubmit(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> queryDevTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> queryUser(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> createVersionWhenTimeTypeIsReleaseAndGroupTypeIsTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> createVersionWhenTimeTypeIsReleaseAndGroupTypeIsNotTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> createVersionWhenTimeTypeIsNotReleaseAndGroupTypeIsTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> createVersionWhenTimeTypeIsNotReleaseAndGroupTypeIsNotTestTeam(LinkedHashMap<String, String> dataMap);

	public List<LinkedHashMap<String, String>> queryUserNameByUM(String userName);
}
