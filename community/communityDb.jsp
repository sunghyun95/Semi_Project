<%@page import="intranet.dao.LikesDao"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="intranet.dto.CommuDto"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dao.CommuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String category = request.getParameter("category");
	String searchtxt = request.getParameter("searchtxt");
	String pageNum = request.getParameter("pageNum");
	CommuDao dao = new CommuDao();
	LikesDao ldao=new LikesDao();

	
	//페이지 영역
	   int perPage = 9; //한페이지당 보여질 방명록 수 : 3개
	   int perBlock = 5; //한 블럭당 보여질 페이지 수 : 5개
	   int totalCount=0; //총 글의 갯수
	   int currentPage; //현재페이지
	   int totalPage; // 총페이지수
	   int startPage;  // 각 블럭당 보여질 시작페이지
	   int endPage; //각블럭당 보여질 끝 페이지
	   
	   
	   int start; //각페이지당 보여질 시작 글번호(오라클은1부터, mysql은 0부터)
	   int end; // 각 페이지당 보여질 끝 글번호
		
	   try{
	   if(pageNum==null)
		   currentPage = 1;
	   else
		   currentPage = Integer.parseInt(pageNum);
	   
	   }catch(NumberFormatException e)
	   {
		   currentPage = 1;
	   }
	   //총 글의 개수 구하기
	   totalCount = dao.getCommuTotalCount(category, searchtxt);
	   
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

	
	   int likes;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	List<CommuDto> list = dao.commuList(category,searchtxt,start,end);
	JSONArray array = new JSONArray();
	for (CommuDto dto : list) {
		JSONObject ob = new JSONObject();
		
		MemberDao mdao=new MemberDao();
		MemberDto mdto = mdao.getMember(dto.getNum());
		likes=ldao.likesList(dto.getBnum());
		FileDao fdao=new FileDao();
		FileDto fdto = fdao.getBnumFile(dto.getBnum());
		
		ob.put("bnum", dto.getBnum());
		ob.put("bcommu",dto.getBcommu());
		ob.put("boardtype",dto.getBoardtype());
		ob.put("num",dto.getNum());
		ob.put("name",mdto.getName());
		ob.put("bsubject", dto.getBsubject());
		ob.put("bcontent",dto.getBcontent());
		ob.put("fnum",fdto.getFnum());
		ob.put("filename",fdto.getFilename());
		ob.put("breadcount", dto.getBreadcount());
		ob.put("likes", likes);
		ob.put("bwriteday", sdf.format(dto.getBwriteday()));
		ob.put("startPage",startPage);
		ob.put("endPage",endPage);
		ob.put("currentPage",currentPage);
		ob.put("totalPage",totalPage);
		ob.put("pageNum",pageNum);
		array.add(ob);
	}
%>
<%=array.toString()%>
