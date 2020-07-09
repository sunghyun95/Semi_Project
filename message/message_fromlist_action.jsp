<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Vector"%>
<%@page import="intranet.dto.MessageDto"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dao.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String num = (String)session.getAttribute("num");
	String pageNum = request.getParameter("pageNum");
	MessageDao msdao = new MessageDao();
	String category = request.getParameter("category");
	String searchtxt = request.getParameter("searchtxt");
	String mwriter = request.getParameter("mwriter");
	String mwriterdel = "mwriterdel";
	System.out.println(searchtxt+","+category);
	
	//페이지 영역
	   int perPage = 10; //한페이지당 보여질 방명록 수 : 3개
	   int perBlock = 5; //한 블럭당 보여질 페이지 수 : 5개
	   int totalCount; //총 글의 갯수
	   int currentPage; //현재페이지
	   int totalPage; // 총페이지수
	   int startPage;  // 각 블럭당 보여질 시작페이지
	   int endPage; //각블럭당 보여질 끝 페이지
	   
	   
	   int start; //각페이지당 보여질 시작 글번호(오라클은1부터, mysql은 0부터)
	   int end; // 각 페이지당 보여질 끝 글번호
		
	   try{
	   if(pageNum==null&&pageNum.equals(""))
		   currentPage = 1;
	   else
		   currentPage = Integer.parseInt(pageNum);
	   
	   }catch(NumberFormatException e)
	   {
		   currentPage = 1;
	   }
	   //총 글의 개수 구하기
	   totalCount = msdao.getFromMessageCount(mwriterdel, mwriter,category,searchtxt,num);
	   System.out.println("totalCount="+totalCount);
	   
	   
	   totalPage = (totalCount/perPage)+(totalCount%perPage>0?1:0);
	   
	   if(currentPage > totalPage)
		   currentPage = totalPage;
	   
	   startPage = ((currentPage-1)/perBlock)*perBlock+1;
	   
	   endPage = (startPage+perBlock)-1;
	   
	   
	   if(endPage > totalPage)
		   endPage = totalPage;
	   
	   start = (currentPage-1)*perPage+1;
	   end = start+perPage-1;
	   
	   if(end>totalCount)
		   end = totalCount;
	
	
	List<MessageDto> mslist = msdao.getFromMessageList(mwriter,category,searchtxt,start,end,num);
	JSONArray array = new JSONArray();
	MemberDao mdao = new MemberDao();
	
	for(MessageDto msdto : mslist){
	JSONObject ob = new JSONObject();
		ob.put("totalcount",totalCount);
		ob.put("mnum",msdto.getMnum());

		MemberDto mdto = mdao.getMember(msdto.getMwriter());
		
		ob.put("writer",mdto.getName());
		ob.put("writerid",mdto.getId());

		mdto = mdao.getMember(msdto.getMreader());
		ob.put("reader",mdto.getName());
		ob.put("readerid",mdto.getId());

		ob.put("mcontent",msdto.getMcontent());
		ob.put("mwriteday",msdto.getMwriteday().toString().substring(0,10));
		ob.put("mwriterdel",msdto.getMwriterdel());
		ob.put("mreaderdel",msdto.getMreaderdel());
		
		ob.put("checks",msdto.getChecks());
		
		ob.put("pageNum",pageNum);
		ob.put("startPage",startPage);
		ob.put("endPage",endPage);
		ob.put("totalPage",totalPage);
		ob.put("currentPage",currentPage);
		array.add(ob);		
	}
	
%>
<%=array.toString()%>