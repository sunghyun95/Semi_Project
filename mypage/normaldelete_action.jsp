<%@page import="java.io.File"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dao.MyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//num 읽기
	String bnum=request.getParameter("bnum");
	//저장 경로 선언
	String uploadFolder=getServletContext().getRealPath("/notice");
	//dao 선언
	MyPageDao dao = new MyPageDao();
	FileDao fdao = new FileDao();
	
	//업로드된 이미지 삭제
	//기존 업로드 이미지 삭제하기
	FileDto fdto = fdao.getBnumFile(bnum);
	
	fdao.deleteFile(fdto.getFnum());
	
	//File 객체 생성
	File file= new File(uploadFolder+"\\"+fdto.getFilename());
	//삭제
	file.delete();
	
	//delete 메소드 호출
	dao.deleteAdminBoard(bnum);
	
	String root=request.getContextPath();
	
	//목록으로 이동
	response.sendRedirect(root+"/startmain.jsp?content=mypage/normalboard.jsp");
	
%>