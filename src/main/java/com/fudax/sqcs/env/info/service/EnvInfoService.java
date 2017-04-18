package com.fudax.sqcs.env.info.service;

import java.util.List;
import java.util.LinkedHashMap;

public interface EnvInfoService {

	public int getLastInsertId();

	public List<LinkedHashMap<String, String>> detailQuery(String system_id);

	public List<LinkedHashMap<String, String>> queryEnvInfo(LinkedHashMap<String, String> paramMap);

	public int updateDeleted(LinkedHashMap<String, String> paramMap);

	public int updateDeletedExtra(LinkedHashMap<String, String> paramMap);

	public void deleteRecord(LinkedHashMap<String, String> paramMap);

	public int addSystemInfo(LinkedHashMap<String, String> paramMap);

	public boolean updateSystemInfo(LinkedHashMap<String, String> ParamMap);

	public LinkedHashMap<String, String> queryDetailById(String system_id);

	public String queryIdByBusiKey(LinkedHashMap<String, String> paramMap);

	public String dataExistForAdd(LinkedHashMap<String, String> infoMap);

	public String dataExistForUpdate(LinkedHashMap<String, String> infoMap);

	public String dataExistForDel(LinkedHashMap<String, String> infoMap);

	public String getSystemNameByIns(String instance_name);

	public List<LinkedHashMap<String, String>> getAllSystemInfo();

	public boolean instanceOf(String target);
}
