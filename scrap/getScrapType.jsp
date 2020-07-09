<%@page import="intranet.dao.ScrapDao"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String bnum = request.getParameter("bnum");
	String num = request.getParameter("num");
	
	ScrapDao sdao = new ScrapDao();
	
	int getScapType = sdao.getScrapType(bnum,num);
	
	JSONArray array = new JSONArray();
	
	JSONObject ob = new JSONObject();
	
	ob.put("scrap",getScapType);
	array.add(ob);
%>
<%=array.toString() %>