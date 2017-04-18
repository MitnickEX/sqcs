package com.fudax.sqcs.utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fudax.sqcs.picklist.controller.PickListAction;

public class AuthenticationFilter implements Filter {
	private static Map<String, Integer> infoMap = new HashMap<String, Integer>();
	static {
		infoMap.put("add.jsp", 2);
		infoMap.put("admin.jsp", 1);
		infoMap.put("file_upload.jsp", 2);
		infoMap.put("kb_auto_results.jsp", 3);
		infoMap.put("kb_bug_analysis.jsp", 3);
		infoMap.put("kb_bug_density.jsp", 3);
		infoMap.put("kb_bug_distribute.jsp", 3);
		infoMap.put("kb_bug_repairs_num.jsp", 3);
		infoMap.put("kb_defects_coder.jsp", 3);
		infoMap.put("kb_defects_fix.jsp", 3);
		infoMap.put("kb_defects_tester.jsp", 3);
		infoMap.put("kb_defects_verify.jsp", 3);
		infoMap.put("kb_env_list.jsp", 3);
		infoMap.put("kb_problem_list.jsp", 3);
		infoMap.put("kb_release_ana.jsp", 3);
		infoMap.put("kb_sut_list.jsp", 3);
		infoMap.put("kb_system_list.jsp", 3);
		infoMap.put("kb_version_list.jsp", 3);
		infoMap.put("kb_visitor_analysis.jsp", 2);
		infoMap.put("kb_visitor_trend.jsp", 2);
		infoMap.put("kb_warn_ana_dept.jsp", 3);
		infoMap.put("kb_warn_ana_system.jsp", 3);
		infoMap.put("kb_warn_ana_test.jsp", 3);
		infoMap.put("kb_warn_ana_version.jsp", 3);
		infoMap.put("kb_warning_list.jsp", 3);
		infoMap.put("kb_workbench.jsp", 3);
		infoMap.put("showDetail.jsp", 3);
		infoMap.put("system_info_detail.jsp", 3);
		infoMap.put("system_info_pub.jsp", 3);
		infoMap.put("tta.jsp", 2);
	}

	public void destroy() {

	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
		HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
		int userRank = 4;

		String domUser = httpServletRequest.getRemoteUser();
		String userName = (null == domUser || domUser.isEmpty()) ? "UNKNOWN" : domUser.substring(domUser.indexOf("\\") + 1).toUpperCase();
		Object rank = httpServletRequest.getSession().getAttribute("userRank");
		if (null == rank) {
			Map<String, String> users = new PickListAction().query_user_name(userName);
			if (null != users && !users.isEmpty() && null != users.get("user_rank") && !users.get("user_rank").isEmpty()) {
				userRank = Integer.parseInt(users.get("user_rank"));
			}
			httpServletRequest.getSession().setAttribute("userRank", userRank);
		} else {
			userRank = (Integer) rank;
		}

		String urlString = httpServletRequest.getRequestURI();
		String targetUrl = urlString.substring(urlString.lastIndexOf("/") + 1, urlString.length());
		int jspRank = (null == infoMap.get(targetUrl)) ? 4 : infoMap.get(targetUrl);

		if (userRank > jspRank) {
			httpServletResponse.sendRedirect("/sqcs/not_authorized.jsp");
		} else {
			filterChain.doFilter(httpServletRequest, httpServletResponse);
		}
	}

	public void init(FilterConfig arg0) throws ServletException {

	}
}
