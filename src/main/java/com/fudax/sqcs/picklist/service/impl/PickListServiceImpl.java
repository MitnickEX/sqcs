package com.fudax.sqcs.picklist.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fudax.sqcs.picklist.dao.PickListDAO;
import com.fudax.sqcs.picklist.service.PickListService;
import com.fudax.sqcs.utils.StringBufferUtils;

@Service
public class PickListServiceImpl implements PickListService {
	@Autowired
	private PickListDAO pickListAnalysisDAO;

	public List<String> creatDept() {
		ArrayList<String> listData = new ArrayList<String>();
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.creatDept();
		StringBufferUtils.timeStampFormat(dataMapList);
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("dept_name"));
		}
		return listData;
	}

	public List<String> creatOwner(String database) {
		ArrayList<String> listData = new ArrayList<String>();
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.creatOwner(database);
		StringBufferUtils.timeStampFormat(dataMapList);
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("owner"));
		}
		return listData;
	}

	public List<String> creatSystems(LinkedHashMap<String, String> dataMap) {
		String group_type = dataMap.get("group_type");
		String group_name = dataMap.get("group_name");
		List<LinkedHashMap<String, String>> dataMapList;
		if (group_type.equalsIgnoreCase("test_team")) {
			dataMapList = pickListAnalysisDAO.creatSystemsByTestTeam(group_name);
		} else {
			dataMapList = pickListAnalysisDAO.creatSystemsByDevDept(group_name);
		}
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("system_alias"));
		}
		return listData;
	}

	public List<String> createProSource() {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.createProSource();
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("source_desc"));
		}
		return listData;
	}

	public List<String> createProStatus() {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.createProStatus();
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("status_desc"));
		}
		return listData;
	}

	public List<String> queryTestTeam() {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryTestTeam();
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("test_team"));
		}
		return listData;
	}

	public List<LinkedHashMap<String, String>> queryJopType() {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryJopType();
		StringBufferUtils.timeStampFormat(dataMapList);
		return dataMapList;
	}

	public List<String> userCurrentVersion(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.userCurrentVersion(dataMap);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("system_version"));
		}
		return listData;
	}

	public List<String> getWarnDate(String version_name) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.getWarnDate(version_name);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("warning_date"));
		}
		return listData;
	}

	public List<String> createInstance(String system_name) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.createInstance(system_name);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("instance_name"));
		}
		return listData;
	}

	public List<String> createDevTeam(String deptName) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.createDevTeam(deptName);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("team_name"));
		}
		return listData;
	}

	public List<String> createTeam(String dev_dept) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.createTeam(dev_dept);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("test_team"));
		}
		return listData;
	}

	public List<String> queryVersionByDev(String dev_dept) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryVersionByDev(dev_dept);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("system_version"));
		}
		return listData;
	}

	public List<String> listSystemName(String dev_dept) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.listSystemName(dev_dept);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("system_name"));
		}
		return listData;
	}

	public List<String> queryTesters(String test_team) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryTesters(test_team);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("tester"));
		}
		return listData;
	}

	public List<String> queryVersionByTeam(String test_team) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryVersionByTeam(test_team);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("system_version"));
		}
		return listData;
	}

	public List<String> queryNeedDept(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryNeedDept(dataMap);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("submit_dept"));
		}
		return listData;
	}

	public List<String> queryDevTeam(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryDevTeam(dataMap);
		StringBufferUtils.timeStampFormat(dataMapList);
		ArrayList<String> listData = new ArrayList<String>();
		for (int i = 0; i < dataMapList.size(); i++) {
			listData.add(dataMapList.get(i).get("dev_team"));
		}
		return listData;
	}

	public List<LinkedHashMap<String, String>> queryNeedSubmit(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryNeedSubmit(dataMap);
		StringBufferUtils.timeStampFormat(dataMapList);
		return dataMapList;
	}

	public List<LinkedHashMap<String, String>> queryUser(LinkedHashMap<String, String> dataMap) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryUser(dataMap);
		StringBufferUtils.timeStampFormat(dataMapList);
		return dataMapList;
	}

	public List<LinkedHashMap<String, String>> queryUserByDept(String dept_name) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryUserByDept(dept_name);
		StringBufferUtils.timeStampFormat(dataMapList);
		return dataMapList;
	}

	public List<LinkedHashMap<String, String>> queryUserByTeam(String team_name) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryUserByTeam(team_name);
		StringBufferUtils.timeStampFormat(dataMapList);
		return dataMapList;
	}

	public List<LinkedHashMap<String, String>> queryIfLeader(String umNo) {
		List<LinkedHashMap<String, String>> dataMapList = pickListAnalysisDAO.queryIfLeader(umNo);
		StringBufferUtils.timeStampFormat(dataMapList);
		return dataMapList;
	}

	public List<LinkedHashMap<String, String>> createVersion(LinkedHashMap<String, String> dataMap) {
		String time_type = dataMap.get("time_type");
		String group_type = dataMap.get("group_type");
		List<LinkedHashMap<String, String>> dataMapList;
		if (time_type.equalsIgnoreCase("release")) {
			if (group_type.equalsIgnoreCase("test_team")) {
				dataMapList = pickListAnalysisDAO.createVersionWhenTimeTypeIsReleaseAndGroupTypeIsTestTeam(dataMap);
			} else {
				dataMapList = pickListAnalysisDAO.createVersionWhenTimeTypeIsReleaseAndGroupTypeIsNotTestTeam(dataMap);
			}
		} else {
			if (group_type.equalsIgnoreCase("test_team")) {
				dataMapList = pickListAnalysisDAO.createVersionWhenTimeTypeIsNotReleaseAndGroupTypeIsTestTeam(dataMap);
			} else {
				dataMapList = pickListAnalysisDAO.createVersionWhenTimeTypeIsNotReleaseAndGroupTypeIsNotTestTeam(dataMap);
			}
		}
		StringBufferUtils.timeStampFormat(dataMapList);
		return dataMapList;
	}

	public LinkedHashMap<String, String> queryUserNameByUM(String userName) {
		LinkedHashMap<String, String> user = null;
		List<LinkedHashMap<String, String>> userNameList = pickListAnalysisDAO.queryUserNameByUM(userName);
		StringBufferUtils.timeStampFormat(userNameList);
		if (userNameList.size() > 0) {
			user = userNameList.get(userNameList.size() - 1);
		}
		return user;

	}
}
