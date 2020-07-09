<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.NoticeDto"%>
<%@page import="intranet.dao.NoticeDao"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	NoticeDao dao =new NoticeDao();
	NoticeDto dto = new NoticeDto();
	
	String num =(String)session.getAttribute("num");
	String uploadFolder=getServletContext().getRealPath("/notice");
	System.out.println(uploadFolder);
	
	int uploadSize=1024*1024*10;
	MultipartRequest multi=null;
	
	try{
		multi = new MultipartRequest(request,uploadFolder,uploadSize,"utf-8",new DefaultFileRenamePolicy());
	
		String bsubject = multi.getParameter("bsubject");
		String bcontent = multi.getParameter("bcontent");
		
		String fileName = multi.getFilesystemName("photo");		
		String originName = multi.getOriginalFileName("photo");
		
		
		dto.setBsubject(bsubject);
		dto.setBcontent(bcontent);
		dto.setNum(num);
		
		dao.insertNotice(dto);
		
		String maxbnum = dao.getMaxBnum();
		
		FileDao fdao = new FileDao();
		FileDto fdto = new FileDto();
		
		fdto.setBnum(maxbnum);
		fdto.setNum(num);
		fdto.setFilename(fileName);
		
		fdao.insertFiles(fdto);
		
		
		String root=request.getContextPath();
	
		response.sendRedirect(root+"/startmain.jsp?content=notice/noticeform.jsp");
		
	}catch(Exception e){
		System.out.println("추가 오류:"+e.getMessage());	
	}
%>