<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="java.io.File"%>
<%@page import="intranet.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //num 읽기
   String bnum=request.getParameter("bnum");
   String pageNum = request.getParameter("pageNum");
   //저장 경로 선언
   String uploadFolder=getServletContext().getRealPath("/notice");
   
   //dao 선언
   NoticeDao dao = new NoticeDao();
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
   dao.deleteNotice(bnum);
   
   String root=request.getContextPath();
   
   //목록으로 이동
   response.sendRedirect("../startmain.jsp?content=notice/noticeform.jsp?pageNum="+pageNum);
   



%>