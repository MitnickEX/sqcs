package com.fudax.sqcs.picklist.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.picklist.service.PickListService;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;

@RestController
@ResponseBody
public class PickListAction {
	@Resource
	private PickListService pickListService;

	@RequestMapping(value = "/query_dept", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_dept() throws Exception {
		return JSONArray.fromObject(pickListService.creatDept());
	}

	@RequestMapping(value = "/query_adev_team", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_adev_team(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.createDevTeam(request.getParameter("dev_dept")));
	}

	@RequestMapping(value = "/query_tdev_team", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_tdev_team(HttpServletRequest request) throws Exception {
		String dev_dept = request.getParameter("dev_dept");
		String test_team = request.getParameter("test_team");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("dev_dept", dev_dept);

		return JSONArray.fromObject(pickListService.queryDevTeam(dataMap));
	}

	@RequestMapping(value = "/query_all_team", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray createTeam(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.createTeam(request.getParameter("dev_dept")));
	}

	@RequestMapping(value = "/query_owner", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_owner(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.creatOwner(request.getParameter("database")));
	}

	@RequestMapping(value = "/query_systems", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_systems(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		return JSONArray.fromObject(pickListService.creatSystems(dataMap));
	}

	@RequestMapping(value = "/query_pro_source", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_pro_source() throws Exception {
		return JSONArray.fromObject(pickListService.createProSource());
	}

	@RequestMapping(value = "/query_pro_status", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_pro_status() throws Exception {
		return JSONArray.fromObject(pickListService.createProStatus());
	}

	@RequestMapping(value = "/query_test_team", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_test_team() throws Exception {
		return JSONArray.fromObject(pickListService.queryTestTeam());
	}

	@RequestMapping(value = "/query_job_type", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_job_type() throws Exception {
		return JSONArray.fromObject(pickListService.queryJopType());
	}

	@RequestMapping(value = "/user_current_version", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray user_current_version(HttpServletRequest request) throws Exception {
		String current_date = request.getParameter("current_date");
		String current_user = request.getParameter("current_user");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("current_date", current_date);
		dataMap.put("current_user", current_user);
		return JSONArray.fromObject(pickListService.userCurrentVersion(dataMap));
	}

	@RequestMapping(value = "/query_warn_date", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray getWarnDate(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.getWarnDate(request.getParameter("version")));
	}

	@RequestMapping(value = "/query_instances", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_instances(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.createInstance(request.getParameter("system_name")));
	}

	@RequestMapping(value = "/query_need_dept", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_need_dept(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String starttime = request.getParameter("pro_date_begin");
		String endtime = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("starttime", starttime);
		dataMap.put("endtime", endtime);
		return JSONArray.fromObject(pickListService.queryNeedDept(dataMap));
	}

	@RequestMapping(value = "/query_need_submit", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_need_submit(HttpServletRequest request) throws Exception {
		String test_team = request.getParameter("test_team");
		String starttime = request.getParameter("pro_date_begin");
		String endtime = request.getParameter("pro_date_end");
		String need_dept = request.getParameter("need_dept");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("test_team", test_team);
		dataMap.put("starttime", starttime);
		dataMap.put("endtime", endtime);
		dataMap.put("need_dept", need_dept);
		List<LinkedHashMap<String, String>> list = pickListService.queryNeedSubmit(dataMap);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/query_testers", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_testers(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.queryTesters(request.getParameter("test_team")));
	}

	@RequestMapping(value = "/query_tteam_versions", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_team_versions(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.queryVersionByTeam(request.getParameter("test_team")));
	}

	@RequestMapping(value = "/query_dteam_versions", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_dteam_versions(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.queryVersionByDev(request.getParameter("dev_dept")));
	}

	@RequestMapping(value = "/query_system_name", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_system_name(HttpServletRequest request) throws Exception {
		return JSONArray.fromObject(pickListService.listSystemName(request.getParameter("dev_dept")));
	}

	@RequestMapping(value = "/query_users", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_users(HttpServletRequest request) throws Exception {
		String dept_name = request.getParameter("dept_name");
		String team_name = request.getParameter("team_name");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("dept_name", dept_name);
		dataMap.put("team_name", team_name);
		List<LinkedHashMap<String, String>> list = pickListService.queryUser(dataMap);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/query_dept_users", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_dept_users(HttpServletRequest request) throws Exception {
		String dept_name = request.getParameter("dept_name");
		List<LinkedHashMap<String, String>> list = pickListService.queryUserByDept(dept_name);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/query_team_users", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_team_users(HttpServletRequest request) throws Exception {
		String team_name = request.getParameter("team_name");
		List<LinkedHashMap<String, String>> list = pickListService.queryUserByTeam(team_name);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/query_if_leader", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_if_leader(HttpServletRequest request) throws Exception {
		String umNo = request.getParameter("current_user");
		List<LinkedHashMap<String, String>> list = pickListService.queryIfLeader(umNo);
		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			list.remove(i);
			list.add(i, tempMap);
		}
		return JSONArray.fromObject(list);
	}

	@RequestMapping(value = "/query_versions", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray query_versions(HttpServletRequest request) throws Exception {
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		String time_type = request.getParameter("time_type");
		String starttime = request.getParameter("pro_date_begin");
		String endtime = request.getParameter("pro_date_end");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		dataMap.put("time_type", time_type);
		dataMap.put("starttime", starttime);
		dataMap.put("endtime", endtime);
		List<String> listData = new ArrayList<String>();
		List<?> chartedlist = pickListService.createVersion(dataMap);
		for (int i = 0; i < chartedlist.size(); i++) {
			String[] temp = chartedlist.get(i).toString().split("=|}");
			listData.add(temp[1].toString());
		}
		return JSONArray.fromObject(listData);
	}

	@RequestMapping(value = "/query_user_name", method = { RequestMethod.POST, RequestMethod.GET })
	public LinkedHashMap<String, String> query_user_name(String userName) {
		return pickListService.queryUserNameByUM(userName);
	}
}
