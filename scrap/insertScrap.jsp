<%@page import="intranet.dto.ScrapDto"%>
<%@page import="intranet.dao.ScrapDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String bnum = request.getParameter("bnum");
	String num = request.getParameter("num");
	
	ScrapDao sdao = new ScrapDao();
	ScrapDto sdto = new ScrapDto();

	sdao.insertScrap(bnum,num);
%>