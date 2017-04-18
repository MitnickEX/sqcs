package com.fudax.sqcs.pub.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.fudax.sqcs.pub.service.VisitorCounterService;
import com.fudax.sqcs.utils.SQAException;
import com.fudax.sqcs.utils.StringBufferUtils;

public class VisitorCounter {
	private final String DATE_FORMATTER = "yyyy-MM-dd";
	private final String TIME_FORMATTER = "yyyy-MM-dd HH:mm:ss";

	@Resource
	VisitorCounterService visitorCounterService;

	/**
	 * @param date
	 * @param dateFormat
	 * @param interval
	 * @return total visitor count from one date to another day by interval.
	 */
	public long getVisitorCount(String date, String dateFormat, int interval) throws SQLException, SQAException {
		Map<String, String> dataMap = new HashMap<String, String>();
		String currentDay = StringBufferUtils.formatedTime(DATE_FORMATTER);
		String nextDay = StringBufferUtils.addDaysByFormatter(currentDay, interval, dateFormat);
		dataMap.put("currentDay", currentDay);
		dataMap.put("nextDay", nextDay);
		long counter = visitorCounterService.getVisitorCount(dataMap);
		return counter;
	}

	/**
	 * @param beginDate
	 * @param endDate
	 * @return total visitor count between to date.
	 */
	public long getVisitorCountBetween(String beginDate, String endDate) throws SQLException, SQAException {
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("beginDate", beginDate);
		dataMap.put("endDate", endDate);
		long counter = visitorCounterService.getVisitorCount(dataMap);
		return counter;
	}

	/**
	 * @return total visitor count of current day
	 */
	public long getVisitorCountOfToday() throws SQLException, SQAException {
		String today = StringBufferUtils.formatedTime(DATE_FORMATTER);
		return getVisitorCount(today, DATE_FORMATTER, 1);
	}

	/**
	 * @return total visitor count
	 */
	public long getVisitorCountTotal() throws SQLException, SQAException {
		long counter = visitorCounterService.getVisitorCountTotal();
		return counter;
	}

	public boolean isLastVisitURL(String ip, String url) throws SQLException, SQAException {
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("ip", ip);
		dataMap.put("url", url);
		boolean flag = visitorCounterService.isLastVisitURL(dataMap);
		return flag;
	}

	/**
	 * @param request
	 *            HttpServletRequest
	 */
	public void recordVisitor(HttpServletRequest request) throws Exception {
		String date = StringBufferUtils.formatedTime(TIME_FORMATTER);
		String ip = getVisitorAddress(request);
		String url = request.getRequestURL().toString();
		String server = request.getServerName().toLowerCase();

		String domainName = null;
		String userName = null;
		userName = (null == userName || userName.isEmpty()) ? "" : userName.toUpperCase();
		String user = (null == domainName || domainName.isEmpty()) ? userName : domainName.toUpperCase() + "\\" + userName;

		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("ip", ip);
		dataMap.put("url", url);
		dataMap.put("vdate", date);
		dataMap.put("user", user);
		if (url.endsWith(request.getContextPath() + "/") || server.contains("iqsh-") || ip.startsWith("127.0.0.1")) {
			return;
		} else {
			visitorCounterService.recordVisitor(dataMap);
		}
	}

	/**
	 * @param request
	 *            HttpServletRequest
	 * @return visitor request ip
	 */
	public String getVisitorAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if (ip.startsWith("0:0:0:0:0:0:0:1")) {
			return "127.0.0.1";
		}
		return ip;
	}

	/**
	 * @param ip
	 * @return total visitor count from an ip
	 */
	public long getVisitorCountByIP(String ip) throws SQLException, SQAException {
		return visitorCounterService.getVisitorCountByIP(ip);
	}

	/**
	 * @param url
	 * @return total visitor count from one url
	 */
	public long getVisitorCountByURL(String url) throws SQLException, SQAException {
		return visitorCounterService.getVisitorCountByURL(url);
	}

	/**
	 * @param url
	 * @param ip
	 * @return total visitor count from an ip and sort by one url
	 */
	public long getVisitorCountByIPandURL(String url, String ip) throws SQLException, SQAException {
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("ip", ip);
		dataMap.put("url", url);
		return visitorCounterService.getVisitorCountByIPandURL(dataMap);
	}
}
