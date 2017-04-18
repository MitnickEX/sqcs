<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String basePathWithNoProt = request.getScheme() + "://" + request.getServerName() + request.getContextPath();

	String domUser = request.getRemoteUser();
	String domainName = (null == domUser || domUser.isEmpty()) ? "LOCALHOST" : domUser.substring(0, domUser.indexOf("\\"));
	domainName = (null == domainName || domainName.isEmpty()) ? "LOCALHOST" : domainName.toUpperCase();
	String userName = (null == domUser || domUser.isEmpty()) ? "UNKNOWN" : domUser.substring(domUser.indexOf("\\") + 1).toUpperCase();
	String currentUser = (null == domUser || domUser.isEmpty()) ? "LOCALHOST\\UNKNOWN" : domUser;
%>

<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/calendar.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/echarts.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/macarons.js"></script>
