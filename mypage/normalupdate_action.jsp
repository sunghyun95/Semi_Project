<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="intranet.dto.NoticeDto"%>
<%@page import="intranet.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String uploadFolder=getServletContext().getRealPath("/notice");
	System.out.println(uploadFolder);
	FileDao fdao = new FileDao();

	NoticeDao dao = new NoticeDao();
	NoticeDto dto = new NoticeDto();
	
	int uploadSize = 1024*1024;
	MultipartRequest multi=null;
	
	try{
		multi=new MultipartRequest(request,uploadFolder,uploadSize,
				"utf-8",new DefaultFileRenamePolicy());
		
		String bnum=multi.getParameter("bnum");
		String num = multi.getParameter("num");
		
		FileDto fdto = fdao.getBnumFile(bnum);
		File file= new File(uploadFolder+"\\"+fdto.getFilename());
		file.delete();
		///////////폴더안에 있는 파일은 수정완료
		
		
		
		String bsubject = multi.getParameter("bsubject");
		String bcontent = multi.getParameter("bcontent");
		
		dto.setBnum(bnum);
		dto.setBsubject(bsubject);
		dto.setBcontent(bcontent);
		dao.updateNotice(dto);
		
		fdao.deleteFile(bnum);
		
		String photo=multi.getFilesystemName("photo");
		
		
		fdto.setBnum(bnum);
		fdto.setFilename(photo);
		fdto.setNum(num);
		fdao.updateFiles(fdto);
		
		String root=request.getContextPath();
		
		response.sendRedirect(root+"/startmain.jsp?content=mypage/normalboard.jsp");
		
	}catch(Exception e)
	{
		System.out.println("수정 오류:"+e.getMessage());
	}

%>