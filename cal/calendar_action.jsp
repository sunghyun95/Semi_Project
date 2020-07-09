<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dto.DiaryDto"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dao.DiaryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String num = (String)session.getAttribute("num");

MemberDao mdao = new MemberDao();
MemberDto mdto = mdao.getMember(num);



DiaryDao ddao = new DiaryDao();
List<DiaryDto> dlist = ddao.getDiarylist();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
JSONArray array = new JSONArray();
for(DiaryDto dto : dlist){
	JSONObject ob = new JSONObject();
	
	ob.put("dnum",dto.getDnum());
	ob.put("num",dto.getNum());
	ob.put("startdate",dto.getStartdate());
	ob.put("enddate",dto.getEnddate());
	ob.put("dsubject",dto.getDsubject());
	ob.put("dcontent",dto.getDcontent());
	ob.put("diarytype",dto.getDiarytype());
	
	ob.put("buseo",mdto.getBuseo());
	
	
	array.add(ob);
}
%>
<%=array.toString()%>