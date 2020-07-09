<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dto.CommuDto"%>
<%@page import="intranet.dao.CommuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

   String bnum=request.getParameter("bnum");
   String pageNum=request.getParameter("pageNum");
   CommuDao cdao=new CommuDao();
   cdao.deleteCommu(bnum);
   
   FileDao fdao=new FileDao();
   fdao.deleteFiles(bnum);
   
   response.sendRedirect("../startmain.jsp?content=community/community.jsp?pageNum="+pageNum);

     
   
   
%>