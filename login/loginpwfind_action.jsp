<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="intranet.sms.SMSManager"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id=request.getParameter("id");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
    String email = request.getParameter("email");
	String randomsu=request.getParameter("randomsu");
	   
	JSONArray array=new JSONArray();
	JSONObject ob=new JSONObject();
	ob.put("id",id);
	ob.put("name",name);
	ob.put("hp",hp);
	ob.put("email",email);
	ob.put("randomsu",randomsu);
	array.add(ob);
%>
<%=array.toString()%>