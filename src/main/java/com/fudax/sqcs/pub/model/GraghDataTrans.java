package com.fudax.sqcs.pub.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.collections.MapUtils;

import com.fudax.sqcs.bug.modle.Data;
import com.fudax.sqcs.utils.StringBufferUtils;

public class GraghDataTrans {

	public static List<?> piedata(List<Double> list1, List<String> list2) {
		List<Data> dataList = new ArrayList<Data>();
		for (int i = 0; i < list1.size(); i++) {
			Data seriesdata = new Data();
			seriesdata.setValue(list1.get(i));
			seriesdata.setName(list2.get(i));
			dataList.add(seriesdata);
		}
		return dataList;
	}

	public static void createHistogramGragh(List<LinkedHashMap<String, String>> infoList, List<String> xList, String xKey, ArrayList<Double>[] arr) {

		for (int i = 0; i < infoList.size(); i++) {
			Map<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			if (tempMap.isEmpty()){
				break;
			}
			xList.add(tempMap.get(xKey));

			Iterator<Entry<String, String>> it = tempMap.entrySet().iterator();
			int j = 0;
			while (it.hasNext()) {
				Entry<String, String> element = it.next();
				if (!element.getKey().equalsIgnoreCase(xKey)) {
					arr[j].add(Double.parseDouble(element.getValue()));
					j++;
				}
			}
		}
	}

	public static ArrayList<Double> createPieGragh(List<LinkedHashMap<String, String>> infoList) {
		ArrayList<Double> dataList = new ArrayList<Double>();

		for (int i = 0; i < infoList.size(); i++) {
			Map<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			if (MapUtils.isEmpty(tempMap)){
				break;
			}

			Iterator<Entry<String, String>> it = tempMap.entrySet().iterator();
			while (it.hasNext()) {
				dataList.add(Double.parseDouble(it.next().getValue()));
			}
		}
		return dataList;
	}

	public static void createLineGragh(List<LinkedHashMap<String, String>> infoList, List<String> xList, String xKey, ArrayList<Long> yList) {

		for (int i = 0; i < infoList.size(); i++) {
			Map<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			if (tempMap.isEmpty()){
				break;
			}
			xList.add(tempMap.get(xKey));

			Iterator<Entry<String, String>> it = tempMap.entrySet().iterator();
			while (it.hasNext()) {
				Entry<String, String> element = it.next();
				if (!element.getKey().equalsIgnoreCase(xKey)) {
					yList.add(Long.parseLong(element.getValue()));
				}
			}
		}
	}
}
