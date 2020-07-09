<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.my{
	width: 90%;
	height: 500px;
	border: 0px solid gray;
	display: inline-block;
}
.mypage{
	width: 15%;
	height: 30%;
	font-size:18pt;
	border: 1px solid gray;
	margin-right: 5%;
	margin-left: 5%;
	margin-top: 10%;
	float: left;
	display: inline-block;
}
</style>
</head>
<%
	String num=(String)session.getAttribute("num");
	MemberDao dao=new MemberDao();
	MemberDto dto =dao.getMember(num);
	
	
%>
<body>
<div class="my">
	<%
		if(dto.getName().equals("관리자"))
		{%>
			<div class="mypage" style="margin-left: 20%;"><b><a href="startmain.jsp?content=mypage/mypagescrap.jsp">스크랩</a></b></div>
			<div class="mypage"><b><a href="startmain.jsp?content=mypage/mypageletter.jsp">쪽지함</a></b></div>
			<div class="mypage end" style="margin-right: 0%;"><b><a href="startmain.jsp?content=mypage/adminboard_form.jsp">게시글 관리</a></b></div>
		<%}else{%>
			<div class="mypage" style="margin-left: 20%;"><b><a href="startmain.jsp?content=mypage/mypagescrap.jsp">스크랩</a></b></div>
			<div class="mypage"><b><a href="startmain.jsp?content=mypage/mypageletter.jsp">쪽지함</a></b></div>
			<div class="mypage end" style="margin-right: 0%;"><b><a href="startmain.jsp?content=mypage/normalboard.jsp">내가 쓴 글</a></b></div>
		<%}%>
</div>
</body>
</html>