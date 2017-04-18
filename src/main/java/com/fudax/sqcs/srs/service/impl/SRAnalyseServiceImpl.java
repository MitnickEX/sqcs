package com.fudax.sqcs.srs.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.srs.dao.SRAnalyseDAO;
import com.fudax.sqcs.srs.service.SRAnalyseService;

@Service
@Transactional
public class SRAnalyseServiceImpl implements SRAnalyseService {
	@Autowired
	private SRAnalyseDAO srAnalyseDAO;

	public LinkedHashMap<String, LinkedHashMap<String, Integer>> sr_ana_data(String system_version) {
		List<Map<String, String>> sr_ana_rm_list = sr_ana_rm(system_version);
		List<String> query_rm_plan_list = query_rm_plan(system_version);
		LinkedHashMap<String, LinkedHashMap<String, Integer>> results = data_collect(sr_ana_rm_list, query_rm_plan_list);
		return results;
	}

	public List<Map<String, String>> sr_ana_rm(String system_version) {
		List<Map<String, String>> sr_ana_rm_list = srAnalyseDAO.sr_ana_rm(system_version);
		StringBufferUtils.jdbcTimeStampFormat(sr_ana_rm_list);
		return sr_ana_rm_list;
	}

	public List<String> query_rm_plan(String system_version) {
		List<Map<String, String>> query_rm_plan_list = srAnalyseDAO.query_rm_plan(system_version);
		StringBufferUtils.jdbcTimeStampFormat(query_rm_plan_list);
		List<String> plan = new ArrayList<String>();
		for (int i = 0; i < query_rm_plan_list.size(); i++) {
			plan.add(query_rm_plan_list.get(i).get("proc_date"));
		}
		return plan;
	}

	public List<Map<String, String>> sr_ana_dept(Map<String, String> dataMap) {
		List<Map<String, String>> query_rm_plan_list = srAnalyseDAO.sr_ana_dept(dataMap);
		StringBufferUtils.jdbcTimeStampFormat(query_rm_plan_list);
		return query_rm_plan_list;
	}

	private LinkedHashMap<String, LinkedHashMap<String, Integer>> data_collect(List<Map<String, String>> data, List<String> plan) {
		LinkedHashMap<String, Integer> result = new LinkedHashMap<String, Integer>();
		LinkedHashMap<String, LinkedHashMap<String, Integer>> results = new LinkedHashMap<String, LinkedHashMap<String, Integer>>();

		for (int i = 0; i < plan.size(); i++) {
			result = new LinkedHashMap<String, Integer>();
			for (Map<String, String> itemMap : data) {
				for (String date_key : itemMap.keySet()) {
					if (null == result.get(date_key)) {
						result.put(date_key, 0);
					}

					if (null != itemMap.get(date_key) && itemMap.get(date_key).equalsIgnoreCase(plan.get(i))) {
						int x = (null == result.get(date_key)) ? 0 : result.get(date_key);
						result.put(date_key, x + 1);
					}
				}
			}
			results.put(plan.get(i), result);
		}
		return results;
	}

}
