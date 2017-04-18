package com.fudax.sqcs.version.controller;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.utils.StringBufferUtils;
import com.fudax.sqcs.version.service.MyWorkBenchService;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class MyWorkBenchAction {
	@Resource
	private MyWorkBenchService myWorkBenchService;

	@RequestMapping(value = "/my_work", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray my_work(HttpServletRequest request) throws Exception {
		String system_version = request.getParameter("system_version");
		String work_date = request.getParameter("work_date");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_version", system_version);
		dataMap.put("work_date", work_date);
		List<LinkedHashMap<String, String>> list = myWorkBenchService.getWorkdata(dataMap);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}

		return JSONArray.fromObject(list);
	}
}
