<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dao.LikesDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="intranet.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	BoardDao bdao = new BoardDao();
	String category = request.getParameter("category");
	String searchtxt = request.getParameter("searchtxt");
	String sort = request.getParameter("sort");
	String pageNum = request.getParameter("pageNum");
	String bopen=request.getParameter("bopen");
	
	System.out.println("pageNum="+pageNum);
	System.out.println("searchtxt="+searchtxt);
	System.out.println("sort="+sort);
	
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
	   totalCount = bdao.getCommuTotalCount(bopen,category,searchtxt);
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
	   
	int likes;
	LikesDao ldao = new LikesDao();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	System.out.println("start="+start+",end="+end);
	
	List<BoardDto> b = bdao.getAllboard();
	for(BoardDto s : b){
	likes=ldao.likesList(s.getBnum());
	bdao.updateLikes(s.getBnum(),likes);
	}
	
	List<BoardDto> blist = bdao.getWebhardDatas(bopen,category, searchtxt, sort, start, end);
	
	MemberDao mdao = new MemberDao();
	JSONArray array = new JSONArray();
	FileDao fdao = new FileDao();
	int flistcount = 0;
	
	for(BoardDto bdto : blist){
	JSONObject ob = new JSONObject();
	MemberDto mdto = mdao.getMember(bdto.getNum());
	
	List<FileDto> flist = fdao.getCommuGetFilelist(bdto.getBnum());
	for(int i=0; i<flist.size(); i++){
		flistcount++;
	}
	
	if(bdto.getBopen().equals("0")){
	ob.put("bnum", bdto.getBnum());	
	ob.put("subject",bdto.getBsubject());
	ob.put("writernum",bdto.getNum());
	ob.put("writer", mdto.getName());
	ob.put("writeday", bdto.getBwriteday().toString().substring(0,10));
	ob.put("readcount", bdto.getBreadcount());	
	ob.put("pageNum",pageNum);
	ob.put("startPage",startPage);
	ob.put("endPage",endPage);
	ob.put("totalPage",totalPage);
	ob.put("currentPage",currentPage);
	ob.put("likes", bdto.getBlike());
	ob.put("flistcount",flistcount);
	}
	array.add(ob);
	}
%>
<%=array.toString() %>