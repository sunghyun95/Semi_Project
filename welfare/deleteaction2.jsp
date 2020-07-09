<%@page import="intranet.dao.JehyuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String root=request.getContextPath();
   String num = request.getParameter("num");
   
   JehyuDao dao=new JehyuDao();
   
   dao.deleteJehyu(num);
   
   response.sendRedirect(root+"/startmain.jsp?content=welfare/jehyulist.jsp");

%>