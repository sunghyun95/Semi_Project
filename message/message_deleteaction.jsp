<%@page import="intranet.dto.MessageDto"%>
<%@page import="intranet.dao.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	String mnum = request.getParameter("mnum");
	
	MessageDao msdao = new MessageDao();
	
	MessageDto msdto = msdao.getMessage(mnum);
	
	if(num.equals(msdto.getMwriter())){
		
		if(msdto.getMreaderdel().equals("0")){
			msdao.updateWriterDel(mnum);
		}else{
			msdao.deleteMessage(mnum);
		}
		
		
	}else{
		
		if(msdto.getMwriterdel().equals("0")){
			
			msdao.updateReaderDel(mnum);
			
		}else{
			msdao.deleteMessage(mnum);
		}
		
	}
%>