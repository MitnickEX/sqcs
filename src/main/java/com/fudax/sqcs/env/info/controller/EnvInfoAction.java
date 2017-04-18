package com.fudax.sqcs.env.info.controller;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fudax.sqcs.env.info.model.RequestResult;
import com.fudax.sqcs.env.info.service.EnvInfoService;
import com.fudax.sqcs.utils.StringBufferUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@ResponseBody
public class EnvInfoAction {
	private StringBufferUtils str = new StringBufferUtils();
	@Resource
	private EnvInfoService envInfoService;

	/**
	 * 查询所有信息(未删除的，降序排序)
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/env_list_query", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray env_list_query(HttpServletRequest request) throws Exception {

		String system_name = request.getParameter("system_name");
		String group_type = request.getParameter("group_type");
		String group_name = request.getParameter("group_name");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system", system_name);
		dataMap.put("group_type", group_type);
		dataMap.put("group_name", group_name);
		List<LinkedHashMap<String, String>> list = envInfoService.queryEnvInfo(dataMap);

		for (int i = 0; i < list.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(list.get(i));
			String tns = tempMap.get("jdbc_tns");
			tempMap.put("jdbc_tns", str.parseSidFromTns(tns));
			list.remove(i);
			list.add(i, tempMap);
		}
		
		return JSONArray.fromObject(list);
	}

	/**
	 * 显示详细
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/env_detail", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONArray env_detail(HttpServletRequest request) throws Exception {
		String system_id = request.getParameter("system_id");
		List<LinkedHashMap<String, String>> infoList = envInfoService.detailQuery(system_id);

		for (int i = 0; i < infoList.size(); i++) {
			LinkedHashMap<String, String> tempMap = StringBufferUtils.dropNullElement(infoList.get(i));
			infoList.remove(i);
			infoList.add(i, tempMap);
		}

		return JSONArray.fromObject(infoList);
	}

	/**
	 * 添加信息
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/env_info_add", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONObject env_info_add(HttpServletRequest request) throws Exception {
		String new_system_id = "";
		String systemName = request.getParameter("system_name");
		String deptName = request.getParameter("dept_name");
		String testTeam = request.getParameter("test_team");
		String devTeam = request.getParameter("dev_team");
		String instanceName = request.getParameter("instance_name");
		String loginAddress = request.getParameter("login_address");
		String t3Uri = request.getParameter("t3_uri");
		String jdbcTns = request.getParameter("jdbc_tns");
		String testUsers = request.getParameter("test_users");
		String description = request.getParameter("description");

		loginAddress = str.trimLastReturn(loginAddress);
		jdbcTns = str.trimLastReturn(jdbcTns);

		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_name", systemName);
		dataMap.put("dept_name", deptName);
		dataMap.put("test_team", testTeam);
		dataMap.put("dev_team", devTeam);
		dataMap.put("instance_name", instanceName);
		dataMap.put("login_address", loginAddress);
		dataMap.put("t3_uri", t3Uri);
		dataMap.put("jdbc_tns", jdbcTns);
		dataMap.put("test_users", testUsers);
		dataMap.put("description", description);

		JSONObject jsonData = new JSONObject();
		LinkedHashMap<String, String> resultMap = new LinkedHashMap<String, String>();

		String selFlag = envInfoService.dataExistForAdd(dataMap);
		if (selFlag == RequestResult.EXIST_NOT_DELETED || selFlag == RequestResult.EXIST_BOTH) {// 如果已存在并且未删除，提示数据已存在
			resultMap.put(RequestResult.DATA_STATUS, RequestResult.EXIST_NOT_DELETED);
			resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_FORBIDDEN);
			new_system_id = envInfoService.queryIdByBusiKey(dataMap);
		} else if (selFlag == RequestResult.EXIST_DELETED) { // 如果存在相同失效记录，将失效记录修改为有效展示给用户
			envInfoService.updateDeleted(dataMap);
			new_system_id = envInfoService.queryIdByBusiKey(dataMap);
			resultMap.put(RequestResult.DATA_STATUS, RequestResult.EXIST_DELETED);
			resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_SUCCESS);
		} else if (selFlag == RequestResult.TARGET_NOT_EXIST) { // 如果未存在，执行添加操作。
			int id = envInfoService.addSystemInfo(dataMap);
			if (id > 0) { // 添加成功
				new_system_id = String.valueOf(id);
				resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_SUCCESS);
			} else { // 添加失败
				resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_FAILED);
			}
			resultMap.put(RequestResult.DATA_STATUS, RequestResult.TARGET_NOT_EXIST);
		}

		jsonData.put("resultMap", resultMap);
		jsonData.put("new_system_id", new_system_id);
		return JSONObject.fromObject(jsonData);
	}

	/**
	 * 修改信息
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/env_info_update", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONObject env_info_update(HttpServletRequest request) throws Exception {
		String systemId = request.getParameter("system_id");
		String new_system_id = systemId;
		String systemName = request.getParameter("system_name");
		String deptName = request.getParameter("dept_name");
		String testTeam = request.getParameter("test_team");
		String devTeam = request.getParameter("dev_team");
		String instanceName = request.getParameter("instance_name");
		String loginAddress = request.getParameter("login_address");
		String t3Uri = request.getParameter("t3_uri");
		String jdbcTns = request.getParameter("jdbc_tns");
		String testUsers = request.getParameter("test_users");
		String description = request.getParameter("description");
		String change_primary = request.getParameter("change_primary");

		loginAddress = str.trimLastReturn(loginAddress);
		jdbcTns = str.trimLastReturn(jdbcTns);

		LinkedHashMap<String, String> resultMap = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_id", systemId);
		dataMap.put("system_name", systemName);
		dataMap.put("dept_name", deptName);
		dataMap.put("test_team", testTeam);
		dataMap.put("dev_team", devTeam);
		dataMap.put("instance_name", instanceName);
		dataMap.put("login_address", loginAddress);
		dataMap.put("t3_uri", t3Uri);
		dataMap.put("jdbc_tns", jdbcTns);
		dataMap.put("test_users", testUsers);
		dataMap.put("description", description);
		dataMap.put("change_primary", change_primary);

		JSONObject jsonData = new JSONObject();
		String selFlag = envInfoService.dataExistForUpdate(dataMap);
		if (selFlag == RequestResult.EXIST_NOT_DELETED || selFlag == RequestResult.EXIST_BOTH) { // 如果已存在并且未删除，禁止操作
			resultMap.put(RequestResult.DATA_STATUS, RequestResult.OPERATION_FORBIDDEN);
			resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_FORBIDDEN);
		} else if (selFlag == RequestResult.EXIST_ONLY_CURRENT || selFlag == RequestResult.TARGET_NOT_EXIST) {
			resultMap.put(RequestResult.DATA_STATUS, RequestResult.EXIST_ONLY_CURRENT);
			if (envInfoService.updateSystemInfo(dataMap)) {// 修改成功
				resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_SUCCESS);
			} else { // 修改失败
				resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_FAILED);
			}
		} else if (selFlag == RequestResult.EXIST_DELETED) {// 存在已删除，修改为未删除（del_flag改为0），将当前数据置为删除
			envInfoService.updateDeletedExtra(dataMap);
			new_system_id = envInfoService.queryIdByBusiKey(dataMap);

			resultMap.put(RequestResult.DATA_STATUS, RequestResult.EXIST_DELETED);
			resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_SUCCESS);
		} else {
			resultMap.put(RequestResult.DATA_STATUS, RequestResult.UNKNOWN_STATUS);
			resultMap.put(RequestResult.OPERATION_RESULT, RequestResult.OPERATION_FAILED);
		}

		jsonData.put("resultMap", resultMap);
		jsonData.put("new_system_id", new_system_id);
		return JSONObject.fromObject(jsonData);
	}

	/**
	 * 删除
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/env_info_delete", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONObject env_info_delete(HttpServletRequest request) throws Exception {
		String system_id = request.getParameter("system_id");
		LinkedHashMap<String, String> infoMap = envInfoService.queryDetailById(system_id);
		String system_name = infoMap.get("system_name");
		String instance_name = infoMap.get("instance_name");
		LinkedHashMap<String, String> dataMap = new LinkedHashMap<String, String>();
		dataMap.put("system_id", system_id);
		dataMap.put("system_name", system_name);
		dataMap.put("instance_name", instance_name);
		envInfoService.deleteRecord(dataMap);
		return JSONObject.fromObject("deleted");
	}

	@RequestMapping(value = "/is_instance_of", method = { RequestMethod.POST, RequestMethod.GET })
	public JSONObject is_instance_of(HttpServletRequest request) throws Exception {
		String target_Name = request.getParameter("target_name");
		JSONObject jsonData = new JSONObject();
		boolean insOf = envInfoService.instanceOf(target_Name);

		jsonData.put("result", String.valueOf(insOf));
		return JSONObject.fromObject(jsonData);
	}
}
