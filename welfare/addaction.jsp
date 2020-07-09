<%@page import="intranet.dto.JehyuDto"%>
<%@page import="intranet.dao.JehyuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
   String root = request.getContextPath();
   String jhname= request.getParameter("sample6_jehyuname");
   String jhpost= request.getParameter("sample6_postcode");
   String jhaddr= request.getParameter("sample6_address");
   String jhcont= request.getParameter("sample6_jehyucontent");
   String wido= request.getParameter("sample6_wido");
   String gyungdo= request.getParameter("sample6_gyungdo");
   
   String addr = jhpost+jhaddr;
   
   JehyuDto dto = new JehyuDto();
   dto.setJhname(jhname);
   dto.setJhaddr(jhpost+ " "+ jhaddr);
   dto.setJhcontent(jhcont);
   dto.setWido(wido);
   dto.setGyungdo(gyungdo);
   
   

   JehyuDao dao = new JehyuDao();
   
   dao.insertJehyu(dto);
   
   response.sendRedirect("addaction2.jsp");


%>