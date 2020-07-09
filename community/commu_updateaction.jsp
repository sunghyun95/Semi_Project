<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dao.CommuDao"%>
<%@page import="intranet.dto.CommuDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
   String num = (String) session.getAttribute("num");
   String root = request.getContextPath();
   CommuDto dto = new CommuDto();
   CommuDao dao = new CommuDao();

   FileDao fdao = new FileDao();
   FileDto fdto = new FileDto();
   

   //저장경로 선언
   String uploadFolder = getServletContext().getRealPath("/savecommu");
   System.out.println(uploadFolder);
   //업로드 이미지 사이즈 지정
   int uploadSize = 1024 * 1024*10; //1mb
   //업로드에 필요한 multi 클래스 생성
   MultipartRequest multi = null;
   try {
      multi = new MultipartRequest(request, uploadFolder, uploadSize, "utf-8", new DefaultFileRenamePolicy());
      String bcommu=multi.getParameter("bcommu");
      String bsubject = multi.getParameter("bsubject");
      String bcontent = multi.getParameter("bcontent");
      String photo = multi.getFilesystemName("photo");
      String bnum=multi.getParameter("bnum");
      
      String pageNum = multi.getParameter("pageNum");
      //기존 업로드 이미지 삭제
      //기존 파일명
      String uploadFileName = fdao.getNumFiles(num).getFilename();
      File file = new File(uploadFolder + "\\" + uploadFileName);
      //삭제
      file.delete();
      
      dto.setBcommu(bcommu);
      dto.setBsubject(bsubject);
      dto.setBcontent(bcontent);
      dto.setBnum(bnum);
      
      dao.updateCommu(dto);
      
      fdto.setFilename(photo);
      fdto.setBnum(bnum);
      
      fdao.updateFiles(fdto);
      response.sendRedirect("commu_updateaction2.jsp?bnum="+bnum+"&pageNum="+pageNum);
   }catch(Exception e){
      
   }
      
      
   
%>