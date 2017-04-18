package com.fudax.sqcs.pub.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fudax.sqcs.pub.dao.VisitorCounterDAO;
import com.fudax.sqcs.pub.service.VisitorCounterService;
import com.fudax.sqcs.utils.StringBufferUtils;

@Service
public class VisitorCounterServiceImpl implements VisitorCounterService {
	
	@Autowired
	private VisitorCounterDAO visitorCounterDAO;

	public long getVisitorCount(Map<String, String> dataMap) {
		long counter = 0;
		List<Map<String, String>> getVisitorCountList = visitorCounterDAO.getVisitorCount(dataMap);
		StringBufferUtils.jdbcTimeStampFormat(getVisitorCountList);
		if (getVisitorCountList.size() > 0) {
			counter = Long.valueOf(getVisitorCountList.get(0).get("counter"));
		}
		return counter;
	}

	public long getVisitorCountTotal() {
		long counter = 0;
		List<Map<String, String>> getVisitorCountTotalList = visitorCounterDAO.getVisitorCountTotal();
		StringBufferUtils.jdbcTimeStampFormat(getVisitorCountTotalList);
		if (getVisitorCountTotalList.size() > 0) {
			counter = Long.valueOf(getVisitorCountTotalList.get(0).get("counter"));
		}
		return counter;
	}

	public long getVisitorCountByIP(String ip) {
		long counter = 0;
		List<Map<String, String>> getVisitorCountByIPList = visitorCounterDAO.getVisitorCountByIP(ip);
		StringBufferUtils.jdbcTimeStampFormat(getVisitorCountByIPList);
		if (getVisitorCountByIPList.size() > 0) {
			counter = Long.valueOf(getVisitorCountByIPList.get(0).get("counter"));
		}
		return counter;
	}

	public long getVisitorCountByURL(String url) {
		long counter = 0;
		List<Map<String, String>> getVisitorCountByURLList = visitorCounterDAO.getVisitorCountByURL(url);
		StringBufferUtils.jdbcTimeStampFormat(getVisitorCountByURLList);
		if (getVisitorCountByURLList.size() > 0) {
			counter = Long.valueOf(getVisitorCountByURLList.get(0).get("counter"));
		}
		return counter;
	}

	public long getVisitorCountByIPandURL(Map<String, String> dataMap) {
		long counter = 0;
		List<Map<String, String>> getVisitorCountByIPandURLList = visitorCounterDAO.getVisitorCountByIPandURL(dataMap);
		StringBufferUtils.jdbcTimeStampFormat(getVisitorCountByIPandURLList);
		if (getVisitorCountByIPandURLList.size() > 0) {
			counter = Long.valueOf(getVisitorCountByIPandURLList.get(0).get("counter"));
		}
		return counter;
	}

	public int recordVisitor(Map<String, String> dataMap) {
		int insertCount = visitorCounterDAO.recordVisitor(dataMap);
		return insertCount;
	}

	public boolean isLastVisitURL(Map<String, String> dataMap) {
		boolean flag = false;
		String url = dataMap.get("url");
		String ip = dataMap.get("ip");
		List<Map<String, String>> getVisitorCountList = visitorCounterDAO.isLastVisitURL(ip);
		StringBufferUtils.jdbcTimeStampFormat(getVisitorCountList);
		if (getVisitorCountList != null && getVisitorCountList.size() > 0) {
			String urlQuery = getVisitorCountList.get(0).get("url");
			if (urlQuery != null && url.equalsIgnoreCase(urlQuery)) {
				flag = true;
			}
		}
		return flag;
	}
}
