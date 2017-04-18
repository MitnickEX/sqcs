package com.fudax.sqcs.visitor.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.fudax.sqcs.bug.modle.LineCharts;
import com.fudax.sqcs.bug.modle.PieCharts;
import com.fudax.sqcs.pub.model.GraghDataTrans;
import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.visitor.service.KBVisitorAnaService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class KBVisitorAnaAction {

	@Resource
	private KBVisitorAnaService kbVisitorAnaService;

	@RequestMapping(value = "/visitor_trend", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray visitorTrend(HttpServletRequest request) throws Exception {
		JSONObject jsonData = new JSONObject();
		List<LineCharts> dataList = new ArrayList<LineCharts>();
		String pro_date_begin = request.getParameter("pro_date_begin");
		String pro_date_end = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> paramMap = new LinkedHashMap<String, String>();
		paramMap.put("pro_date_begin", pro_date_begin);
		paramMap.put("pro_date_end", pro_date_end);
		List<LinkedHashMap<String, String>> chartList = kbVisitorAnaService.queryVdateList(paramMap);
		LineCharts echarter_SumL = new LineCharts();

		List<String> xList = new ArrayList<String>();
		ArrayList<Long> count = new ArrayList<Long>();

		GraghDataTrans.createLineGragh(chartList, xList, "times", count);

		echarter_SumL.setName("访问次数");
		echarter_SumL.setType("line");
		echarter_SumL.setData(count);

		dataList.add(echarter_SumL);

		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return JSONArray.fromObject(jsonData);
	}

	@RequestMapping(value = "/visitor_ana", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray visitorAna(HttpServletRequest request) throws Exception {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		String gragh_type = "";
		// 用于区分调用哪条SQL
		String sqlflag = request.getParameter("sqlflag");
		if (sqlflag != null) {
			if (sqlflag.equals("ciat_jsp")) {
				gragh_type = "CI&AT";
			} else if (sqlflag.equals("sqa_jsp")) {
				gragh_type = "SQA";
			} else if (sqlflag.equals("tools_jsp")) {
				gragh_type = "TOOLS";
			}
		}
		List<LinkedHashMap<String, String>> chartList = kbVisitorAnaService.queryGraghNameByGraghType(gragh_type);
		ArrayList<Double> tempList = new ArrayList<Double>();
		ArrayList<String> xList = new ArrayList<String>();
		for (int i = 0; i < chartList.size(); i++) {
			Map<String, String> tempMap = StringBufferUtils.dropNullElement(chartList.get(i));
			xList.add(tempMap.get("gragh_name"));

			Iterator<Entry<String, String>> it = tempMap.entrySet().iterator();
			while (it.hasNext()) {
				Entry<String, String> element = it.next();
				if (!element.getKey().equalsIgnoreCase("gragh_name")) {
					tempList.add(Double.parseDouble(element.getValue()));
				}
			}
		}
		List<?> piedata = GraghDataTrans.piedata(tempList, xList);
		PieCharts pie = new PieCharts();
		pie.setName("看板访问量分析");
		pie.setType("pie");
		pie.setData(piedata);
		dataList.add(pie);
		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);

		return JSONArray.fromObject(jsonData);
	}

	@RequestMapping(value = "/visitor_team_ana", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray visitorTeamAna() throws Exception {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<LinkedHashMap<String, String>> chartList = kbVisitorAnaService.queryTeamVisitorAna();
		ArrayList<String> xList = new ArrayList<String>();
		ArrayList<Double> tempList = new ArrayList<Double>();

		for (int i = 0; i < chartList.size(); i++) {
			String teamName = chartList.get(i).get("user_team_name");
			String visitorCount = chartList.get(i).get("visitor_count");
			xList.add(teamName);// 添加x轴数据
			tempList.add(Double.parseDouble(visitorCount));
		}

		List<?> piedata = GraghDataTrans.piedata(tempList, xList);

		PieCharts pie = new PieCharts();
		pie.setName("看板访问量分析");
		pie.setType("pie");
		pie.setData(piedata);
		dataList.add(pie);
		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);
		return JSONArray.fromObject(jsonData);
	}

	@RequestMapping(value = "/visitor_dept_ana", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray visitorDeptAna() throws Exception {
		JSONObject jsonData = new JSONObject();
		List<PieCharts> dataList = new ArrayList<PieCharts>();
		List<LinkedHashMap<String, String>> chartList = kbVisitorAnaService.queryDeptVisitorAna();
		ArrayList<String> xList = new ArrayList<String>();
		ArrayList<Double> tempList = new ArrayList<Double>();

		for (int i = 0; i < chartList.size(); i++) {
			String teamName = chartList.get(i).get("user_team_name");
			String visitorCount = chartList.get(i).get("visitor_count");
			xList.add(teamName);// 添加x轴数据
			tempList.add(Double.parseDouble(visitorCount));
		}

		List<?> piedata = GraghDataTrans.piedata(tempList, xList);

		PieCharts pie = new PieCharts();
		pie.setName("看板访问量分析");
		pie.setType("pie");
		pie.setData(piedata);
		dataList.add(pie);
		jsonData.put("listXdata", xList);
		jsonData.put("listYdata", dataList);

		return JSONArray.fromObject(jsonData);
	}
}
