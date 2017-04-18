package com.fudax.sqcs.pub.service;

import java.util.Map;

public interface VisitorCounterService {
	public long getVisitorCount(Map<String, String> dataMap);

	public long getVisitorCountTotal();

	public long getVisitorCountByIP(String ip);

	public long getVisitorCountByURL(String url);

	public long getVisitorCountByIPandURL(Map<String, String> paraMap);

	public int recordVisitor(Map<String, String> paraMap);

	public boolean isLastVisitURL(Map<String, String> dataMap);
}
