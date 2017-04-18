package com.fudax.sqcs.bug.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.fudax.sqcs.bug.dao.BugAnalysisDAO;
import com.fudax.sqcs.bug.modle.Data;
import com.fudax.sqcs.bug.modle.Histogram;
import com.fudax.sqcs.bug.modle.LineCharts;
import com.fudax.sqcs.bug.modle.PieCharts;
import com.fudax.sqcs.bug.service.BugAnalysisService;
import com.fudax.sqcs.pub.model.GraghDataTrans;

@Service
@Transactional
public class BugAnalysisServiceImpl implements BugAnalysisService {
	@Autowired
	private BugAnalysisDAO bugAnalysisDAO;

	@SuppressWarnings("unchecked")
	public JSONObject bug_density_complex(LinkedHashMap<String, String> dataMap) {

		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();
		List<String> xList = new ArrayList<String>();
		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_density_complex(dataMap);
		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);

			return jsonData;
		}

		int listnum = chartList.get(0).keySet().size() - 1;
		ArrayList<Double>[] arr = new ArrayList[listnum];

		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}

		GraghDataTrans.createHistogramGragh(chartList, xList, "system_version", arr);
		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]); // 单个higchart赋值
		}

		echarter[0].setName("缺陷密度");
		echarter[0].setType("line");
		echarter[0].setYAxisIndex(1);
		echarter[1].setName("人力（人日）");
		echarter[1].setType("line");
		echarter[1].setYAxisIndex(0);
		echarter[2].setName("生产缺陷");
		echarter[2].setType("line");
		echarter[2].setYAxisIndex(0);
		echarter[3].setName("SR数");
		echarter[3].setType("line");
		echarter[3].setYAxisIndex(0);

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return jsonData;
	}

	public JSONObject bug_distribute_system(String system) {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();

		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_distribute_system(system);

		ArrayList<Double> tempList = new ArrayList<Double>();
		ArrayList<String> xList = new ArrayList<String>();

		for (int i = 0; i < chartList.size(); i++) {
			String moduleName = chartList.get(i).get("modual_name");
			String bugCount = chartList.get(i).get("bug_num");
			if (moduleName.contains(system)) {
				moduleName = "无SR缺陷";
			}
			xList.add(moduleName);
			tempList.add(Double.parseDouble(bugCount));
		}
		List<?> piedata1 = piedata(tempList, xList);

		PieCharts pie = new PieCharts();

		pie.setName("系统缺陷模块分布");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);

		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	public JSONObject bug_distribute_version(String version) {

		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_distribute_version(version);
		ArrayList<Double> tempList = new ArrayList<Double>();
		ArrayList<String> xList = new ArrayList<String>();
		for (int i = 0; i < chartList.size(); i++) {
			String moduleName = chartList.get(i).get("modual_name");
			String bugCount = chartList.get(i).get("bug_num");
			if (moduleName.contains(version.split("-")[0])) {
				moduleName = "无SR缺陷";
			}
			xList.add(moduleName);
			tempList.add(Double.parseDouble(bugCount));
		}
		List<?> piedata1 = piedata(tempList, xList);

		PieCharts pie = new PieCharts();

		pie.setName("版本缺陷模块分布");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);

		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	public JSONObject bug_sr_distribute(String system_version) {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_sr_distribute(system_version);

		ArrayList<Double> tempList = new ArrayList<Double>();
		ArrayList<String> xList = new ArrayList<String>();

		for (int i = 0; i < chartList.size(); i++) {
			String srCode = chartList.get(i).get("sr_code");
			String bugCount = chartList.get(i).get("bug_num");
			if (srCode.contains(system_version.split("-")[0])) {
				srCode = "无SR缺陷";
			}
			xList.add(srCode);// 添加x轴数据
			tempList.add(Double.parseDouble(bugCount));
		}

		List<?> piedata1 = GraghDataTrans.piedata(tempList, xList);

		PieCharts pie = new PieCharts();

		pie.setName("系统缺陷需求分布");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);

		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	@SuppressWarnings("unchecked")
	public JSONObject bug_sr_density(String version) {
		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();
		List<String> xList = new ArrayList<String>();
		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_sr_density(version);

		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);

			return jsonData;
		}

		int listnum = chartList.get(0).keySet().size() - 1;

		ArrayList<Double>[] arr = new ArrayList[listnum];

		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}
		GraghDataTrans.createHistogramGragh(chartList, xList, "sr_code", arr);

		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]); // 单个higchart赋值
		}

		echarter[0].setName("密度");
		echarter[0].setType("bar");

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return jsonData;
	}

	@SuppressWarnings("unchecked")
	public JSONObject bug_finder_system(LinkedHashMap<String, String> dataMap) {
		String group_type = dataMap.get("group_type");
		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();
		List<String> xList = new ArrayList<String>();
		List<LinkedHashMap<String, String>> chartList;
		if (group_type.toLowerCase().contains("test_team")) {
			chartList = bugAnalysisDAO.bug_finder_system_by_test_team(dataMap);
		} else {
			chartList = bugAnalysisDAO.bug_finder_system_by_dev_dept(dataMap);
		}

		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}
		int listnum = chartList.get(0).keySet().size() - 1;
		ArrayList<Double>[] arr = new ArrayList[listnum];

		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}

		GraghDataTrans.createHistogramGragh(chartList, xList, "person_name", arr);

		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]); // 单个higchart赋值
		}

		echarter[0].setName("L1 BUG");
		echarter[0].setType("bar");
		echarter[0].setStack("缺陷数目");
		echarter[1].setName("L2 BUG");
		echarter[1].setType("bar");
		echarter[1].setStack("缺陷数目");
		echarter[2].setName("L3 BUG");
		echarter[2].setType("bar");
		echarter[2].setStack("缺陷数目");
		echarter[3].setName("L4 BUG");
		echarter[3].setType("bar");
		echarter[3].setStack("缺陷数目");

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);
		return jsonData;
	}

	@SuppressWarnings("unchecked")
	public JSONObject bug_finder_version(String version) {

		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();
		List<String> xList = new ArrayList<String>();

		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_finder_version(version);

		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}

		int listnum = chartList.get(0).keySet().size() - 1;

		ArrayList<Double>[] arr = new ArrayList[listnum];

		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}

		GraghDataTrans.createHistogramGragh(chartList, xList, "person_name", arr);

		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]);
		}

		echarter[0].setName("L1 BUG");
		echarter[0].setType("bar");
		echarter[0].setStack("缺陷数目");
		echarter[1].setName("L2 BUG");
		echarter[1].setType("bar");
		echarter[1].setStack("缺陷数目");
		echarter[2].setName("L3 BUG");
		echarter[2].setType("bar");
		echarter[2].setStack("缺陷数目");
		echarter[3].setName("L4 BUG");
		echarter[3].setType("bar");
		echarter[3].setStack("缺陷数目");

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return jsonData;
	}

	public JSONObject bug_fix_system(LinkedHashMap<String, String> dataMap) {
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		JSONObject jsonData = new JSONObject();
		// 用于接收echarter的数据
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<String> xList = new ArrayList<String>();
		xList.add("未超时");
		xList.add("超时4小时");
		xList.add("超时8小时");
		xList.add("超时16小时");
		xList.add("超时三天及以上");

		List<LinkedHashMap<String, String>> chartList;
		// sql查询语句
		if (system.equals("all")) {
			if (group_type.toLowerCase().contains("test_team")) {
				chartList = bugAnalysisDAO.bug_fix_system_by_test_team(dataMap);
			} else {
				chartList = bugAnalysisDAO.bug_fix_system_by_dev_dept(dataMap);
			}
		} else {
			chartList = bugAnalysisDAO.bug_fix_system_by_system(dataMap);
		}

		List<?> piedata1 = GraghDataTrans.piedata(GraghDataTrans.createPieGragh(chartList), xList);

		PieCharts pie = new PieCharts();
		pie.setName("缺陷修复时效");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);
		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	public JSONObject bug_fix_version(String version) {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();

		List<String> xList = new ArrayList<String>();
		xList.add("未超时");
		xList.add("超时4小时");
		xList.add("超时8小时");
		xList.add("超时16小时");
		xList.add("超时三天及以上");

		List<LinkedHashMap<String, String>> chartList = null;
		try {
			chartList = bugAnalysisDAO.bug_fix_version(version);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.getMessage();
			e.printStackTrace();
		}

		List<?> piedata1 = GraghDataTrans.piedata(GraghDataTrans.createPieGragh(chartList), xList);

		PieCharts pie = new PieCharts();

		pie.setName("缺陷验证实效分布");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);

		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	@SuppressWarnings("unchecked")
	public JSONObject bug_producer_system(LinkedHashMap<String, String> dataMap) {
		String group_type = dataMap.get("group_type");
		JSONObject jsonData = new JSONObject();
		// 用于接收echarter的数据
		List<Histogram> dataList = new ArrayList<Histogram>();

		// x轴显示list:日期
		List<String> xList = new ArrayList<String>();

		// sql查询语句
		List<LinkedHashMap<String, String>> chartList;
		if (group_type.toLowerCase().contains("test_team")) {
			chartList = bugAnalysisDAO.bug_producer_system_by_test_team(dataMap);
		} else {
			chartList = bugAnalysisDAO.bug_producer_system_by_dev_dept(dataMap);
		}
		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}

		int listnum = chartList.get(0).keySet().size() - 1;
		ArrayList<Double>[] arr = new ArrayList[listnum];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}

		GraghDataTrans.createHistogramGragh(chartList, xList, "person_name", arr);
		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]); // 单个higchart赋值
		}

		echarter[0].setName("L1 BUG");
		echarter[0].setType("bar");
		echarter[0].setStack("缺陷数目");
		echarter[1].setName("L2 BUG");
		echarter[1].setType("bar");
		echarter[1].setStack("缺陷数目");
		echarter[2].setName("L3 BUG");
		echarter[2].setType("bar");
		echarter[2].setStack("缺陷数目");
		echarter[3].setName("L4 BUG");
		echarter[3].setType("bar");
		echarter[3].setStack("缺陷数目");

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return jsonData;
	}

	@SuppressWarnings("unchecked")
	public JSONObject bug_producer_version(String version) {

		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();
		List<String> xList = new ArrayList<String>();

		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_producer_version(version);

		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}

		int listnum = chartList.get(0).keySet().size() - 1;
		ArrayList<Double>[] arr = new ArrayList[listnum];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}
		GraghDataTrans.createHistogramGragh(chartList, xList, "person_name", arr);
		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]); // 单个higchart赋值
		}

		echarter[0].setName("L1 BUG");
		echarter[0].setType("bar");
		echarter[0].setStack("缺陷数目");
		echarter[1].setName("L2 BUG");
		echarter[1].setType("bar");
		echarter[1].setStack("缺陷数目");
		echarter[2].setName("L3 BUG");
		echarter[2].setType("bar");
		echarter[2].setStack("缺陷数目");
		echarter[3].setName("L4 BUG");
		echarter[3].setType("bar");
		echarter[3].setStack("缺陷数目");

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return jsonData;
	}

	public JSONObject bug_repairs_num_system(LinkedHashMap<String, String> dataMap) {
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<String> xList = new ArrayList<String>();
		xList.add("修复1次");
		xList.add("修复2次");
		xList.add("修复3次");
		xList.add("修复4次及以上");
		List<LinkedHashMap<String, String>> chartList;
		if (system.equals("all")) {
			if (group_type.toLowerCase().contains("test_team")) {
				chartList = bugAnalysisDAO.bug_repairs_num_system_by_test_team(dataMap);
			} else {
				chartList = bugAnalysisDAO.bug_repairs_num_system_by_dev_dept(dataMap);
			}
		} else {
			chartList = bugAnalysisDAO.bug_repairs_num_system_by_system(dataMap);
		}
		List<?> piedata1 = GraghDataTrans.piedata(GraghDataTrans.createPieGragh(chartList), xList);
		PieCharts pie = new PieCharts();
		pie.setName("缺陷修复次数");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);
		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	public JSONObject bug_repairs_num_version(String version) {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();

		List<String> xList = new ArrayList<String>();
		xList.add("修复1次");
		xList.add("修复2次");
		xList.add("修复3次");
		xList.add("修复4次及以上");

		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_repairs_num_version(version);

		List<?> piedata1 = GraghDataTrans.piedata(GraghDataTrans.createPieGragh(chartList), xList);
		PieCharts pie = new PieCharts();

		pie.setName("缺陷修复次数");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);

		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	public JSONObject bug_by_system(LinkedHashMap<String, String> dataMap) {
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		JSONObject jsonData = new JSONObject();
		// 用于接收echarter的数据
		List<LineCharts> dataList = new ArrayList<LineCharts>();
		List<LinkedHashMap<String, String>> chartList;
		if (system.equals("all")) {
			if (group_type.toLowerCase().contains("test_team")) {
				chartList = bugAnalysisDAO.bug_by_system_by_test_team(dataMap);
			} else {
				chartList = bugAnalysisDAO.bug_by_system_by_dev_dept(dataMap);
			}
		} else {
			chartList = bugAnalysisDAO.bug_by_system_by_system(dataMap);
		}

		// 声明图表，一个data对应一个echarters
		LineCharts echarter_SumL1 = new LineCharts();
		LineCharts echarter_SumL2 = new LineCharts();
		LineCharts echarter_SumFound = new LineCharts();
		LineCharts echarter_SumDel = new LineCharts();
		LineCharts echarter_SumClose = new LineCharts();
		// 声明接收list数据类型的数据
		List<String> xdataList = new ArrayList<String>();// x轴显示list:日期
		List<String> xList = new ArrayList<String>();

		List<String> sumlevel1 = new ArrayList<String>();
		ArrayList<Float> SumL1 = new ArrayList<Float>();// 累计L1总数

		List<String> sumlevel2 = new ArrayList<String>();
		ArrayList<Float> SumL2 = new ArrayList<Float>();// 累计L2总数

		List<String> sumfound = new ArrayList<String>();
		ArrayList<Float> SumFd = new ArrayList<Float>();// 累计发现总数

		List<String> sumdel = new ArrayList<String>();
		ArrayList<Float> SumDL = new ArrayList<Float>();// 累计解决总数

		List<String> sumclose = new ArrayList<String>();
		ArrayList<Float> SumCS = new ArrayList<Float>(); // 累计关闭总数

		// 数据处理，去除，和：
		for (int i = 0; i < chartList.size(); i++) {
			String[] temp = chartList.get(i).toString().split(",");
			xdataList.add(temp[0].toString());
			sumlevel1.add(temp[4].toString());
			sumlevel2.add(temp[5].toString());
			sumfound.add(temp[6].toString());
			sumdel.add(temp[7].toString());
			sumclose.add(temp[8].toString());
		}

		// 将x轴取得的date数据转化为毫秒型
		for (int j = 0; j < xdataList.size(); j++) {
			String[] tempX = xdataList.get(j).toString().split("=");
			xList.add(tempX[1]);
		}

		// 图表的数据处理,及合成data
		for (int j = 0; j < sumlevel1.size(); j++) {
			String[] temp_sumleve1 = sumlevel1.get(j).toString().split("=");
			SumL1.add(Float.parseFloat(temp_sumleve1[1]));
		}

		for (int j = 0; j < sumlevel2.size(); j++) {
			String[] temp_sumleve2 = sumlevel2.get(j).toString().split("=");
			SumL2.add(Float.parseFloat(temp_sumleve2[1]));
		}

		for (int j = 0; j < sumfound.size(); j++) {
			String[] temp_sumfound = sumfound.get(j).toString().split("=");
			SumFd.add(Float.parseFloat(temp_sumfound[1]));
		}

		for (int j = 0; j < sumdel.size(); j++) {
			String[] temp_sumdel = sumdel.get(j).toString().split("=");
			SumDL.add(Float.parseFloat(temp_sumdel[1]));
		}

		for (int j = 0; j < sumclose.size(); j++) {
			String[] temp_sumclose = sumclose.get(j).toString().split("=|}");
			SumCS.add(Float.parseFloat(temp_sumclose[1]));
		}

		// / 给echarter赋值,Type:column,spline
		echarter_SumL1.setName("累计发现L1缺陷");
		echarter_SumL1.setType("line");
		echarter_SumL1.setData(SumL1);

		echarter_SumL2.setName("累计发现L2缺陷");
		echarter_SumL2.setType("line");
		echarter_SumL2.setData(SumL2);

		echarter_SumFound.setName("累计发现总数");
		echarter_SumFound.setType("line");
		echarter_SumFound.setData(SumFd);

		echarter_SumDel.setName("累计解决总数");
		echarter_SumDel.setType("line");
		echarter_SumDel.setData(SumDL);

		echarter_SumClose.setName("累计关闭总数");
		echarter_SumClose.setType("line");
		echarter_SumClose.setData(SumCS);
		// add data数据

		dataList.add(echarter_SumL1);
		dataList.add(echarter_SumL2);
		dataList.add(echarter_SumFound);
		dataList.add(echarter_SumDel);
		dataList.add(echarter_SumClose);

		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);
		return jsonData;
	}

	// data处理
	public Float[][] getydata(List<Float> list1, List<Float> list2) {
		int x = list1.size();
		Float attr[][] = new Float[x][2];
		for (int i = 0; i < x; i++) {
			attr[i][0] = list1.get(i);
			attr[i][1] = list2.get(i);
		}
		return attr;
	}

	// date类型转化为13位毫秒型
	public Long Date2Simple(String xdate) throws ParseException {
		Calendar calender = Calendar.getInstance();
		calender.clear();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		calender.setTime(sdf.parse(xdate));
		Long millionSeconds = calender.getTimeInMillis();
		return millionSeconds;
	}

	@SuppressWarnings("unchecked")
	public JSONObject bug_by_version(String version) {
		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();
		List<String> xList = new ArrayList<String>();
		List<?> gchartList = bugAnalysisDAO.bug_by_version_query_gompertz_defineList(version);
		List<LinkedHashMap<String, String>> chartList;
		if (null == gchartList || gchartList.isEmpty()) {
			chartList = bugAnalysisDAO.bug_by_version_query_bug_found_trend(version);
		} else {
			chartList = bugAnalysisDAO.bug_by_version_query_bug_found_trend_left_join_gompertz_define(version);
		}

		if (chartList.size() == 0) {
			Histogram echarter = new Histogram();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}

		int listnum = chartList.get(0).keySet().size() - 1;
		ArrayList<Double>[] arr = new ArrayList[listnum];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = new ArrayList<Double>();
		}

		GraghDataTrans.createHistogramGragh(chartList, xList, "test_date", arr);
		Histogram[] echarter = new Histogram[listnum];
		for (int i = 0; i < listnum; i++) {
			echarter[i] = new Histogram();
			echarter[i].setData(arr[i]); // 单个higchart赋值
		}

		echarter[0].setName("L1级别缺陷");
		echarter[0].setType("bar");
		echarter[0].setYAxisIndex(1);
		echarter[0].setStack("缺陷个数");

		echarter[1].setName("L2级别缺陷");
		echarter[1].setType("bar");
		echarter[1].setYAxisIndex(1);
		echarter[1].setStack("缺陷个数");

		echarter[2].setName("L3级别缺陷");
		echarter[2].setType("bar");
		echarter[2].setYAxisIndex(1);
		echarter[2].setStack("缺陷个数");

		echarter[3].setName("累计发现L1缺陷");
		echarter[3].setType("line");
		echarter[3].setYAxisIndex(0);

		echarter[4].setName("累计发现L2缺陷");
		echarter[4].setType("line");
		echarter[4].setYAxisIndex(0);

		echarter[5].setName("累计发现总数");
		echarter[5].setType("line");
		echarter[5].setYAxisIndex(0);

		echarter[6].setName("累计解决总数");
		echarter[6].setType("line");
		echarter[6].setYAxisIndex(0);

		echarter[7].setName("累计关闭总数");
		echarter[7].setType("line");
		echarter[7].setYAxisIndex(0);

		if (!gchartList.isEmpty()) {
			echarter[8].setName("理想趋势");
			echarter[8].setType("line");
			echarter[8].setYAxisIndex(0);
		}

		for (int i = 0; i < listnum; i++) {
			dataList.add(echarter[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return jsonData;
	}

	public JSONObject bug_verify_system(LinkedHashMap<String, String> dataMap) {
		String system = dataMap.get("system");
		String group_type = dataMap.get("group_type");
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<String> xList = new ArrayList<String>();
		xList.add("未超时");
		xList.add("超时4小时");
		xList.add("超时8小时");
		xList.add("超时16小时");
		xList.add("超时三天及以上");
		List<LinkedHashMap<String, String>> chartList;
		if (system.equals("all")) {
			if (group_type.toLowerCase().contains("test_team")) {
				chartList = bugAnalysisDAO.bug_verify_system_by_test_team(dataMap);
			} else {
				chartList = bugAnalysisDAO.bug_verify_system_by_dev_dept(dataMap);
			}
		} else {
			chartList = bugAnalysisDAO.bug_verify_system_by_system(dataMap);
		}

		if (chartList.size() == 0) {
			PieCharts echarter = new PieCharts();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}

		List<?> piedata1 = GraghDataTrans.piedata(GraghDataTrans.createPieGragh(chartList), xList);

		PieCharts pie = new PieCharts();
		pie.setName("缺陷验证时效");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);
		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return jsonData;
	}

	public JSONObject bug_verify_version(String version) {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<String> xList = new ArrayList<String>();

		xList.add("未超时");
		xList.add("超时4小时");
		xList.add("超时8小时");
		xList.add("超时16小时");
		xList.add("超时三天及以上");

		List<LinkedHashMap<String, String>> chartList = bugAnalysisDAO.bug_verify_version(version);

		if (chartList.size() == 0) {
			PieCharts echarter = new PieCharts();
			echarter.setName("no data");
			echarter.setType("line");
			echarter.setData(null);
			dataList.add(echarter);
			jsonData.put("listYdata", dataList);
			jsonData.put("listXdata", xList);
			return jsonData;
		}

		List<?> piedata1 = GraghDataTrans.piedata(GraghDataTrans.createPieGragh(chartList), xList);
		PieCharts pie = new PieCharts();

		pie.setName("缺陷验证实效分布");
		pie.setType("pie");
		pie.setData(piedata1);
		dataList.add(pie);

		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);

		return jsonData;
	}

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
