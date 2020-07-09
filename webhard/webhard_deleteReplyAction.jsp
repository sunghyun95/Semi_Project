<%@page import="intranet.dao.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String rnum = request.getParameter("rnum");
	
	ReplyDao rdao = new ReplyDao();
	
	rdao.deleteReply(rnum);
%>