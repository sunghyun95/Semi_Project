<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bnum = request.getParameter("bnum");
	String filename = request.getParameter("getfilename");
	String path = getServletContext().getRealPath("/webhard/"+bnum);
	
	response.reset();
	
	if(request.getHeader("User-Agent").indexOf("MSIE5.0") > -1){
		
		//IE아닐경우
		response.setHeader("Content-Type","doesn/matter;");
	}else{
		//IE일 경우
		response.setHeader("Content-Disposition","attachment;filename=\""+filename+"\"");
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");

	filename = new String(filename.getBytes("UTF-8"), "UTF-8");
	//파일 다운로드
	File fp = new File(path+filename);
	
	System.out.println(path+filename);
	
	int read = 0;
	byte[] b = new byte[(int)fp.length()];
	
	if(fp.isFile()){
		BufferedInputStream fin = new BufferedInputStream(new FileInputStream(fp));
		BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
		
		//파일을 읽어서 브라우저로 출력하기
		try{
			while((read=fin.read(b)) != -1){
				outs.write(b,0,read);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(outs != null) {out.close();}
			if(fin != null) {fin.close();}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
%>
	