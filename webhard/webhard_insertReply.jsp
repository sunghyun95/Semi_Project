<%@page import="intranet.dto.ReplyDto"%>
<%@page import="intranet.dao.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String rcontent = request.getParameter("rcontent");
	String num = (String) session.getAttribute("num");
	String bnum = request.getParameter("bnum");
	System.out.println("rcontent:"+rcontent);
	System.out.println("bnum:"+bnum);
	
	ReplyDao rdao = new ReplyDao();
	ReplyDto rdto = new ReplyDto();

	rdto.setBnum(bnum);
	rdto.setNum(num);
	rdto.setRcontent(rcontent);

	rdao.insertReply(rdto);
%>