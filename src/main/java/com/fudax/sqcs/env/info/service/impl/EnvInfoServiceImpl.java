package com.fudax.sqcs.env.info.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.env.info.dao.EnvInfoDAO;
import com.fudax.sqcs.env.info.model.RequestResult;
import com.fudax.sqcs.env.info.service.EnvInfoService;
import com.fudax.sqcs.utils.LoggerUtils;
import com.fudax.sqcs.utils.StringBufferUtils;

@Service
@Transactional
public class EnvInfoServiceImpl implements EnvInfoService {
	@Autowired
	EnvInfoDAO envInfoDAO;

	public int getLastInsertId() {
		List<LinkedHashMap<String, String>> insertIdList = envInfoDAO.getLastInsertId();
		StringBufferUtils.timeStampFormat(insertIdList);
		int index = insertIdList.size() - 1;
		String insertIdsString = insertIdList.get(index).get("id");
		int insertId = Integer.valueOf(insertIdsString);
		return insertId;
	}

	public List<LinkedHashMap<String, String>> detailQuery(String system_id) {
		List<LinkedHashMap<String, String>> detailQueryList = envInfoDAO.detailQuery(system_id);
		StringBufferUtils.timeStampFormat(detailQueryList);
		return detailQueryList;
	}

	public List<LinkedHashMap<String, String>> queryEnvInfo(LinkedHashMap<String, String> paramMap) {
		String system_name = paramMap.get("system");
		String group_type = paramMap.get("group_type");
		String condition = "";
		if (system_name.equals("all")) {
			condition = (group_type.toLowerCase().contains("test_team") ? "test_team" : "dev_dept");
		} else {
			condition = "system_alias";
		}
		paramMap.put("condition", condition);
		List<LinkedHashMap<String, String>> envInfoList = envInfoDAO.queryEnvInfo(paramMap);
		StringBufferUtils.timeStampFormat(envInfoList);
		return envInfoList;
	}

	public int updateDeleted(LinkedHashMap<String, String> paramMap) {
		int updateDeletedCount = envInfoDAO.updateDeleted(paramMap);
		return updateDeletedCount;
	}

	public int updateDeletedExtra(LinkedHashMap<String, String> paramMap) {
		String system_id = paramMap.get("system_id");
		envInfoDAO.updateDeletedExtraSetDelFlagWith1(system_id);
		int i = envInfoDAO.updateDeletedExtraSetDelFlagWith0(paramMap);
		return i;
	}

	public void deleteRecord(LinkedHashMap<String, String> paramMap) {
		String system_id = paramMap.get("system_id");
		envInfoDAO.deleteRecordForUpdate(system_id);
		envInfoDAO.deleteRecordForDelete(paramMap);
	}

	public int addSystemInfo(LinkedHashMap<String, String> paramMap) {
		envInfoDAO.addSystemInfo(paramMap);
		int newId = getLastInsertId();
		return newId;
	}

	public boolean updateSystemInfo(LinkedHashMap<String, String> ParamMap) {
		boolean flag = false;
		int updateSystemInfoCount = envInfoDAO.updateSystemInfo(ParamMap);
		if (updateSystemInfoCount > 0) {
			flag = true;
		}
		return flag;
	}

	public LinkedHashMap<String, String> queryDetailById(String system_id) {
		List<LinkedHashMap<String, String>> detailByIdList = envInfoDAO.queryDetailById(system_id);
		StringBufferUtils.timeStampFormat(detailByIdList);
		LinkedHashMap<String, String> detailByIdMap = detailByIdList.get(0);
		return detailByIdMap;
	}

	public String queryIdByBusiKey(LinkedHashMap<String, String> paramMap) {
		List<LinkedHashMap<String, String>> idlList = envInfoDAO.queryIdByBusiKey(paramMap);
		StringBufferUtils.timeStampFormat(idlList);
		String system_id = idlList.get(0).get("system_id");
		return system_id;
	}

	public String dataExistForAdd(LinkedHashMap<String, String> infoMap) {
		String dataExist = RequestResult.UNKNOWN_STATUS;
		String system_name = infoMap.get("system_name");
		String instance_name = infoMap.get("instance_name");
		List<LinkedHashMap<String, String>> dataList = envInfoDAO.dataExistForAddAboutCount(infoMap);
		StringBufferUtils.timeStampFormat(dataList);
		String countString = dataList.get(0).get("counter");
		int count = Integer.valueOf(countString);

		if (count == 0) {
			dataExist = RequestResult.TARGET_NOT_EXIST;
		} else if (count == 1) {
			List<LinkedHashMap<String, String>> dataListForAdd = envInfoDAO.dataExistForAddAboutDelFlag(infoMap);
			StringBufferUtils.timeStampFormat(dataListForAdd);
			String flagString = dataListForAdd.get(0).get("del_flag");
			int del_flag = Integer.valueOf(flagString);
			if (del_flag == 0) { // 如果已存在并且未删除
				dataExist = RequestResult.EXIST_NOT_DELETED;
			} else if (del_flag == 1) { // 如果已存在并且已删除
				dataExist = RequestResult.EXIST_DELETED;
			}
		} else if (count == 2) {
			dataExist = RequestResult.EXIST_BOTH;
		} else {
			LoggerUtils.getLogger().error("脏数据存在，程序无法处理: [ {},{} ]！", system_name, instance_name);
		}
		return dataExist;
	}

	public String dataExistForUpdate(LinkedHashMap<String, String> infoMap) {
		String flag = RequestResult.UNKNOWN_STATUS;
		String system_name = infoMap.get("system_name");
		String instance_name = infoMap.get("instance_name");
		Boolean change_primary = Boolean.parseBoolean(infoMap.get("change_primary"));
		if (change_primary) {
			List<LinkedHashMap<String, String>> dataList = envInfoDAO.dataExistForUpdateWhenChangePrimaryIsTrueAboutSelectCount(infoMap);
			StringBufferUtils.timeStampFormat(dataList);
			String countString = dataList.get(0).get("counter");
			int count = Integer.valueOf(countString);
			if (count == 0) {
				flag = RequestResult.TARGET_NOT_EXIST;
			} else if (count == 1) {
				List<LinkedHashMap<String, String>> dataListForUpdate = envInfoDAO.dataExistForUpdateWhenChangePrimaryIsTrueAboutSelectDelFlag(infoMap);
				StringBufferUtils.timeStampFormat(dataListForUpdate);
				String flagString = dataListForUpdate.get(0).get("del_flag");
				int del_flag = Integer.valueOf(flagString);
				if (del_flag == 0) { // 如果已存在并且未删除
					flag = RequestResult.EXIST_NOT_DELETED;
				} else if (del_flag == 1) { // 如果已存在并且已删除
					flag = RequestResult.EXIST_DELETED;
				}
			} else if (count == 2) {
				flag = RequestResult.EXIST_BOTH;
			} else {
				flag = RequestResult.EXIST_NOT_DELETED;
				LoggerUtils.getLogger().error("目标数据同时存在多条记录: [ {},{} ]！", system_name, instance_name);
			}
		} else {
			List<LinkedHashMap<String, String>> dataList = envInfoDAO.dataExistForUpdateWhenChangePrimaryIsFalseAboutSelectCount(infoMap);
			StringBufferUtils.timeStampFormat(dataList);
			String countString = dataList.get(0).get("counter");
			int count = Integer.valueOf(countString);
			if (count == 0) {
				flag = RequestResult.EXIST_ONLY_CURRENT;
			} else if (count == 1) {
				List<LinkedHashMap<String, String>> dataListForUpdate = envInfoDAO.dataExistForUpdateWhenChangePrimaryIsFalseAboutSelectDelFlag(infoMap);
				StringBufferUtils.timeStampFormat(dataListForUpdate);
				String flagString = dataListForUpdate.get(0).get("del_flag");
				int del_flag = Integer.valueOf(flagString);

				if (del_flag == 0) { // 如果已存在并且未删除
					flag = RequestResult.EXIST_NOT_DELETED;
				} else if (del_flag == 1) { // 如果已存在并且已删除
					flag = RequestResult.EXIST_DELETED;
				}
			} else if (count == 2) {
				flag = RequestResult.EXIST_BOTH;
			} else {
				LoggerUtils.getLogger().error("脏数据存在，程序无法处理: [ {},{} ]！", system_name, instance_name);
			}
		}
		return flag;
	}

	public String dataExistForDel(LinkedHashMap<String, String> infoMap) {
		String dataExist = RequestResult.UNKNOWN_STATUS;
		String system_name = infoMap.get("system_name");
		String instance_name = infoMap.get("instance_name");
		List<LinkedHashMap<String, String>> dataList = envInfoDAO.dataExistForDelAboutCount(infoMap);
		StringBufferUtils.timeStampFormat(dataList);
		String countString = dataList.get(0).get("counter");
		int count = Integer.valueOf(countString);
		if (count == 1) {
			List<LinkedHashMap<String, String>> dataListForDel = envInfoDAO.dataExistForDelAboutDelFlag(infoMap);
			StringBufferUtils.timeStampFormat(dataListForDel);
			String flagString = dataListForDel.get(0).get("del_flag");
			int del_flag = Integer.valueOf(flagString);
			if (del_flag == 0) { // 如果已存在并且未删除
				dataExist = RequestResult.EXIST_NOT_DELETED;
			} else if (del_flag == 1) { // 如果已存在并且已删除
				dataExist = RequestResult.EXIST_DELETED;
			}
		} else if (count == 0) {
			dataExist = RequestResult.EXIST_ONLY_CURRENT;
		} else {
			LoggerUtils.getLogger().error("脏数据存在，程序无法处理: [ {},{} ]！", system_name, instance_name);
		}
		return dataExist;
	}

	public String getSystemNameByIns(String instance_name) {
		String system_name = "";
		List<LinkedHashMap<String, String>> systemNameList = envInfoDAO.getSystemNameByIns(instance_name);
		StringBufferUtils.timeStampFormat(systemNameList);
		system_name = systemNameList.get(systemNameList.size() - 1).get("system_name");
		return system_name;
	}

	public List<LinkedHashMap<String, String>> getAllSystemInfo() {
		List<LinkedHashMap<String, String>> systemInfoList = envInfoDAO.getAllSystemInfo();
		StringBufferUtils.timeStampFormat(systemInfoList);
		return systemInfoList;
	}

	public boolean instanceOf(String target) {
		boolean ins = false;
		List<LinkedHashMap<String, String>> insList = envInfoDAO.instanceOf(target);
		StringBufferUtils.timeStampFormat(insList);
		if (insList.size() > 0) {
			ins = true;
		}
		return ins;
	}

}
