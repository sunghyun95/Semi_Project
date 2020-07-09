<%@page import="intranet.dto.ReplyDto"%>
<%@page import="intranet.dao.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String rnum = request.getParameter("rnum");
	System.out.println("rnum="+rnum);
	String rcontent = request.getParameter("rcontent");
	
	ReplyDao rdao = new ReplyDao();
	ReplyDto rdto = new ReplyDto();
	
	rdto.setRnum(rnum);
	rdto.setRcontent(rcontent);
	
	rdao.updateReply(rdto);
%>