<%@page import="intranet.dto.LikesDto"%>
<%@page import="intranet.dao.LikesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String bnum = request.getParameter("bnum");
	String num = request.getParameter("num");
	
	LikesDao ldao=new LikesDao();
	LikesDto ldto=new LikesDto();

	ldao.deleteLikes(bnum,num);
%>