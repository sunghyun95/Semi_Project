<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Enumeration"%>
<%@page import="intranet.dao.BoardDao"%>
<%@page import="intranet.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	BoardDto dto = new BoardDto();
	BoardDao dao = new BoardDao();
	String num = (String)session.getAttribute("num");
	
	
	dto.setNum(num);
	dto.setBsubject(" ");
	dto.setBcontent(" ");
	dto.setBcommu("웹하드");
	
	dao.insertWebhard(dto);
	
	String bnum = Integer.toString(dao.getWebhardMaxBnum());
	
	

	String realPath = getServletContext().getRealPath("/webhard/"+bnum);
	System.out.println(realPath);
	
	File Folder = new File(realPath);  // 폴더 없다면 생성하기
	if(!Folder.exists()){
		 try{
			 Folder.mkdir();
		 }catch(Exception e){
			 e.printStackTrace();
		 }
	}else{
		System.out.println("이미 폴더가 생성되어 있습니다.");
	}
	
	
	
	int uploadSize = 1024 * 1024 * 10;
	
	MultipartRequest multi = null;
	
	try {
		multi = new MultipartRequest(request, realPath, uploadSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String bsubject = multi.getParameter("bsubject");
		String bcontent = multi.getParameter("bcontent");
		String bopen = multi.getParameter("bopen");
		System.out.println("bopen="+bopen);
		
		String oriname = multi.getOriginalFileName("file");
		String upname = multi.getFilesystemName("file");
		
		dto.setBopen(bopen);
		dto.setBnum(bnum);
		dto.setBsubject(bsubject);
		dto.setBcontent(bcontent);
		
		dao.updateWebhard(dto);
		
		
		//파일추가를 위한 bnum 구하기
		String bnum2 =bnum;
		FileDao fdao = new FileDao();
	
		//넣은 파일의 이름 구하기
		File dirFile = new File(realPath);//저장된 폴더 파일 객체 
		
		File[] fileList = dirFile.listFiles(); //저장된 폴더의 파일들
		
		for (File tempFile : fileList) { // 저장된 폴더의 파일들의 이름 구하기
			if (tempFile.isFile()) {//파일이 있다면
				String tempPath = tempFile.getParent(); //저장된 폴더
				
				String tempFileName = tempFile.getName();
				System.out.println("Path=" + tempPath);
				System.out.println("FileName=" + tempFileName);
				
				FileDto fdto = new FileDto();
				fdto.setNum(num);
				fdto.setBnum(bnum2);
				fdto.setFilename(tempFileName);
				fdao.insertFiles(fdto);
			}
		
		}
		response.sendRedirect(root+"/startmain.jsp?content=webhard/webhard_publiclist.jsp");
%>
<%
	} catch (Exception e) {
		System.out.println("file upload 에러 : " + e.getMessage());
		e.printStackTrace();
	}
%>