package com.fudax.sqcs.srs.controller;

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
import com.fudax.sqcs.bug.modle.Histogram;
import com.fudax.sqcs.srs.service.SRAnalyseService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class SRAnalysisAction {
	@Resource
	private SRAnalyseService srAnalyseService;

	/**
	 * 按测试组查询缺陷修复超时的版本分布情况——柱状图
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/sr_ana_rm", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray sr_ana_rm(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		LinkedHashMap<String, LinkedHashMap<String, Integer>> info = srAnalyseService.sr_ana_data(system_version);
		return createHistgram(info);
	}

	/**
	 * 生成缺陷时效分析的柱状图——共用方法
	 * 
	 * @param infoList
	 * @param keyName
	 * @param hists
	 */
	@SuppressWarnings("unchecked")
	private JSONArray createHistgram(LinkedHashMap<String, LinkedHashMap<String, Integer>> info) {

		JSONObject jsonData = new JSONObject();
		List<Histogram> dataList = new ArrayList<Histogram>();
		List<String> xList = new ArrayList<String>();

		if (info.isEmpty()) {
			Histogram charts = new Histogram();
			charts.setName("no data");
			charts.setType("bar");
			charts.setData(null);
			dataList.add(charts);
			return null;
		}

		List<Double> arr[] = new ArrayList[4];

		for (int i = 0; i < 4; i++) {
			arr[i] = new ArrayList<Double>();
		}

		Iterator<Entry<String, LinkedHashMap<String, Integer>>> it = info.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, LinkedHashMap<String, Integer>> items = it.next();
			xList.add(items.getKey());

			Iterator<Entry<String, Integer>> counts = items.getValue().entrySet().iterator();
			int n = 0;
			while (counts.hasNext()) {
				Map.Entry<String, Integer> me = counts.next();
				int x = (null == me.getValue()) ? 0 : me.getValue();
				if (n < 4) {
					arr[n].add(Double.parseDouble(String.valueOf(x)));
				}
				n++;
			}
		}

		Histogram[] charts = new Histogram[4];
		for (int i = 0; i < 4; i++) {
			charts[i] = new Histogram();
			charts[i].setData(arr[i]);
			charts[i].setType("bar");
		}

		charts[0].setName("需求拆分");
		charts[1].setName("纳入版本");
		charts[2].setName("开发完成");
		charts[3].setName("测试通过");

		for (int i = 0; i < 4; i++) {
			dataList.add(charts[i]);
		}
		jsonData.put("listYdata", dataList);
		jsonData.put("listXdata", xList);

		return JSONArray.fromObject(jsonData);
	}
}
