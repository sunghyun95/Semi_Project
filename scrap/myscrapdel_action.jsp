<%@page import="intranet.dto.ScrapDto"%>
<%@page import="intranet.dao.ScrapDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//num 읽기
	String[] bnum=request.getParameter("bnum").split(",");
	for(int i=0;i<bnum.length;i++)
	{
		System.out.println("체크박스"+bnum[0]);
	}
	
	ScrapDao sdao=new ScrapDao();
	
	//스크랩 삭제
	for(int i=0;i<bnum.length;i++){
		ScrapDto sdto_i=sdao.getScrapdto(bnum[i]);
		sdao.deleteScraps(sdto_i.getBnum());
	}
	String root=request.getContextPath();
	
	//목록으로 이동
	response.sendRedirect(root+"/startmain.jsp?content=scrap/myscraplist.jsp");
	
%>