<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //login세션 삭제
   session.removeAttribute("login");
   session.removeAttribute("num");
   
   response.sendRedirect("loginform.jsp");
%>