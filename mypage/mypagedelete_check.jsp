<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String num=request.getParameter("num");
   String pageNum=request.getParameter("pageNum");
   MemberDao dao=new MemberDao();
   
   dao.memberDelete(num);
   
   response.sendRedirect("../startmain.jsp?content=mypage/mypage_member_list.jsp?pageNum="+pageNum);
%>