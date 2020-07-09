<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.sms.SMSManager"%>
<%@page import="intranet.sms.SendSMS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
	//이름, 번호, 이메일 받기
   String name = request.getParameter("name");
   System.out.println(name);
   String hp = request.getParameter("hp");
   System.out.println(hp);
   String email = request.getParameter("email");
   System.out.println(email);
   String randomsu=request.getParameter("randomsu");
   System.out.println(randomsu);
   
   MemberDao mdao = new MemberDao();
   MemberDto mdto = mdao.getInfoCheckMember(name, hp, email);
   
   String memberid = mdto.getId();
      
   JSONArray array=new JSONArray();
   JSONObject ob=new JSONObject();
   ob.put("name",name);
   ob.put("hp",hp);
   ob.put("email",email);
   ob.put("randomsu",randomsu);
   array.add(ob);
   

 %>

<%=array.toString()%>