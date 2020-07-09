<%@page import="java.io.File"%>
<%@page import="java.util.Vector"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String bnum = request.getParameter("bnum");
	String pageNum = request.getParameter("pageNum");
	String root = request.getContextPath();
	BoardDao bdao = new BoardDao();
	FileDao fdao = new FileDao();
	
	bdao.deleteCommu(bnum);
	
	List<FileDto> flist = new Vector<FileDto>();
	
	flist = fdao.getCommuGetFilelist(bnum);
	
	for(int i=0; i<flist.size(); i++){
		
		fdao.deleteCommuGetFilelist(bnum);
	}
	
	
	//폴더 삭제
	String path = getServletContext().getRealPath("/webhard/"+bnum);
	File folder = new File(path);
	try {
	    while(folder.exists()) {
		File[] folder_list = folder.listFiles(); //파일리스트 얻어오기
				
			for (int j = 0; j < folder_list.length; j++) {
				folder_list[j].delete(); //파일 삭제 
				System.out.println("파일이 삭제되었습니다.");
						
			}
					
			if(folder_list.length == 0 && folder.isDirectory()){ 
				folder.delete(); //대상폴더 삭제
				System.out.println("폴더가 삭제되었습니다.");
			}else{
				
			}
        }
	    
	} catch (Exception e) {
		e.getStackTrace();
	}
%>