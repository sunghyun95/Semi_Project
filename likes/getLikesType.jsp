<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="intranet.dao.LikesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String bnum = request.getParameter("bnum");
	String num = request.getParameter("num");
	
	LikesDao ldao=new LikesDao();
	int getLikesType=ldao.getLikes(bnum,num);
	
	JSONArray array = new JSONArray();
	
	JSONObject ob = new JSONObject();
	
	ob.put("likes",getLikesType);
	array.add(ob);
%>
<%=array.toString() %>