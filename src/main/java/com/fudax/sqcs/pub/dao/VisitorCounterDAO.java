package com.fudax.sqcs.pub.dao;

import java.util.List;
import java.util.Map;

public interface VisitorCounterDAO {
	public List<Map<String, String>> getVisitorCount(Map<String, String> paraMap);

	public List<Map<String, String>> getVisitorCountTotal();

	public List<Map<String, String>> isLastVisitURL(String ip);

	public List<Map<String, String>> getVisitorCountByIP(String ip);

	public List<Map<String, String>> getVisitorCountByURL(String url);

	public List<Map<String, String>> getVisitorCountByIPandURL(Map<String, String> paraMap);

	public int recordVisitor(Map<String, String> paraMap);
}
