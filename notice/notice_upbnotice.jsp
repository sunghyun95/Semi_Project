<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="intranet.dto.NoticeDto"%>
<%@page import="intranet.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String bnum=request.getParameter("bnum");
	NoticeDao dao = new NoticeDao();
	dao.upBnotice(bnum);
	
%>