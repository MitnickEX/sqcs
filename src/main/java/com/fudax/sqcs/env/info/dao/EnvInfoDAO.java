package com.fudax.sqcs.env.info.dao;

import java.util.List;
import java.util.LinkedHashMap;

public interface EnvInfoDAO {

	public List<LinkedHashMap<String, String>> getLastInsertId();

	public List<LinkedHashMap<String, String>> detailQuery(String system_id);

	public List<LinkedHashMap<String, String>> queryEnvInfo(LinkedHashMap<String, String> paramMap);

	public int updateDeleted(LinkedHashMap<String, String> paramMap);

	public int updateDeletedExtraSetDelFlagWith1(String systemId);

	public int updateDeletedExtraSetDelFlagWith0(LinkedHashMap<String, String> paramMap);

	public void deleteRecordForUpdate(String systemId);

	public void deleteRecordForDelete(LinkedHashMap<String, String> paramMap);

	public int addSystemInfo(LinkedHashMap<String, String> paramMap);

	public int updateSystemInfo(LinkedHashMap<String, String> ParamMap);

	public List<LinkedHashMap<String, String>> queryDetailById(String system_id);

	public List<LinkedHashMap<String, String>> queryIdByBusiKey(LinkedHashMap<String, String> paramMap);

	public List<LinkedHashMap<String, String>> dataExistForAddAboutDelFlag(LinkedHashMap<String, String> infoMap);

	public List<LinkedHashMap<String, String>> dataExistForAddAboutCount(LinkedHashMap<String, String> infoMap);

	public List<LinkedHashMap<String, String>> dataExistForUpdateWhenChangePrimaryIsTrueAboutSelectDelFlag(LinkedHashMap<String, String> ParamMap);

	public List<LinkedHashMap<String, String>> dataExistForUpdateWhenChangePrimaryIsTrueAboutSelectCount(LinkedHashMap<String, String> ParamMap);

	public List<LinkedHashMap<String, String>> dataExistForUpdateWhenChangePrimaryIsFalseAboutSelectDelFlag(LinkedHashMap<String, String> ParamMap);

	public List<LinkedHashMap<String, String>> dataExistForUpdateWhenChangePrimaryIsFalseAboutSelectCount(LinkedHashMap<String, String> ParamMap);

	public List<LinkedHashMap<String, String>> dataExistForDelAboutDelFlag(LinkedHashMap<String, String> infoMap);

	public List<LinkedHashMap<String, String>> dataExistForDelAboutCount(LinkedHashMap<String, String> infoMap);

	public List<LinkedHashMap<String, String>> getSystemNameByIns(String instance_name);

	public List<LinkedHashMap<String, String>> getAllSystemInfo();

	public List<LinkedHashMap<String, String>> getJndiResultBySystem(LinkedHashMap<String, String> paramMap);

	public List<LinkedHashMap<String, String>> instanceOf(String target);
}
