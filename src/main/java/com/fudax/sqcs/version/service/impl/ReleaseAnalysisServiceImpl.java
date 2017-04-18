package com.fudax.sqcs.version.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.fudax.sqcs.bug.modle.Data;
import com.fudax.sqcs.bug.modle.PieCharts;
import com.fudax.sqcs.version.dao.ReleaseAnalysisDAO;
import com.fudax.sqcs.version.service.ReleaseAnalysisService;

@Service
@Transactional
public class ReleaseAnalysisServiceImpl implements ReleaseAnalysisService {
	@Autowired
	private ReleaseAnalysisDAO releaseAnalysisDAO;

	public JSONObject getPlusCharts(LinkedHashMap<String, String> dataMap) {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();

		List<String> xList = new ArrayList<String>();
		xList.add("未延期");
		xList.add("已延期");
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		String time_type = dataMap.get("time_type");
		List<LinkedHashMap<String, String>> chartList;
		if (system.equals("all")) {
			if (time_type.equalsIgnoreCase("release")) {
				if (group_type.equalsIgnoreCase("test_team")) {
					chartList = releaseAnalysisDAO.getPlusChartsWithSystemIsAllAndTimeTypeIsReleaseAndGroupTypeIsTestTeam(dataMap);
				} else {
					chartList = releaseAnalysisDAO.getPlusChartsWithSystemIsAllAndTimeTypeIsReleaseAndGroupTypeIsNotTestTeam(dataMap);
				}
			} else {
				if (group_type.equalsIgnoreCase("test_team")) {
					chartList = releaseAnalysisDAO.getPlusChartsWithSystemIsAllAndTimeTypeIsNotReleaseAndGroupTypeIsTestTeam(dataMap);
				} else {
					chartList = releaseAnalysisDAO.getPlusChartsWithSystemIsAllAndTimeTypeIsNotReleaseAndGroupTypeIsNotTestTeam(dataMap);
				}
			}
		} else {
			if (time_type.equalsIgnoreCase("release")) {
				chartList = releaseAnalysisDAO.getPlusChartsWithSystemIsNotAllAndTimeTypeIsRelease(dataMap);
			} else {
				chartList = releaseAnalysisDAO.getPlusChartsWithSystemIsNotAllAndTimeTypeIsNotRelease(dataMap);
			}
		}
		// 饼图数据
		ArrayList<Double> tempList = new ArrayList<Double>();

		// data数据
		for (int i = 0; i < chartList.size(); i++) {
			String[] temp = chartList.get(i).toString().split(",|=|}");
			tempList.add(Double.parseDouble(temp[1]));
		}
		List<?> piedata1 = piedata(tempList, xList);

		// 创建Pie
		PieCharts pie = new PieCharts();

		pie.setName("系统延期分布");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);
		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	// piedata 处理函数
	public List<?> piedata(List<Double> list1, List<String> list2) {
		List<Data> dataList = new ArrayList<Data>();
		for (int i = 0; i < list1.size(); i++) {
			Data seriesdata = new Data();
			seriesdata.setValue(list1.get(i));
			seriesdata.setName(list2.get(i));
			dataList.add(seriesdata);
		}
		return dataList;
	}

}
