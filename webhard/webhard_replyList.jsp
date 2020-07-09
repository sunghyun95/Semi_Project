<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dto.ReplyDto"%>
<%@page import="intranet.dao.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String bnum = request.getParameter("bnum");
	ReplyDao rdao = new ReplyDao();
	List<ReplyDto> rlist = rdao.getReplyAllData(bnum);
	
	JSONArray array = new JSONArray();
	
	for(ReplyDto rdto : rlist){
		JSONObject ob = new JSONObject();
		MemberDao mdao = new MemberDao();
		MemberDto mdto = mdao.getMember(rdto.getNum());
		ob.put("rnum", rdto.getRnum());
		ob.put("bnum",rdto.getBnum());
		ob.put("num",rdto.getNum());
		ob.put("name",mdto.getName());
		ob.put("rcontent",rdto.getRcontent());
		ob.put("rwriteday",rdto.getRwriteday().toString());
		
		array.add(ob);
	}
%>
<%=array.toString()%>