<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dto" class="intranet.dto.MemberDto"></jsp:useBean>
<jsp:useBean id="dao" class="intranet.dao.MemberDao"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>
<%
   dao.insertMember(dto);
   response.sendRedirect("insertmemberaction2.jsp");
%>