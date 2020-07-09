<%@page import="intranet.dao.MessageDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root=request.getContextPath();
	String num = (String)session.getAttribute("num");
	MemberDao dao = new MemberDao();
	MemberDto dto = dao.getMember(num);
	
	String content2 = request.getParameter("content");
	if(content2==null) //처음 start1 실행 시 null값 나옴(아무것도 안누른 상태이기 떄문에)
	   content2="layout/content2.jsp";
	
	MessageDao msdao = new MessageDao();
	
	int count = msdao.getMainCount(num);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- -------------css 링크 ----------------------------------  -->
<link rel="stylesheet" href="<%=root%>/css/startmain2.css" />

<title>:::WELCOME INT RANET=6;:::</title>
<script type="text/javascript">
$(function() {
	/* ------------------title-----------------------------  */
	 $(".subnav").hide();
	
	$("#mainnotice").mouseover(function(){
		$("#subnotice").show();
		$("#subcommu, #subweb, #subwel").hide();
	});
	
	$("#maincommu").mouseover(function(){
		$("#subcommu").show();
		$("#subnotice, #subweb, #subwel").hide();
	});
	
	$("#mainweb").mouseover(function(){
		$("#subweb").show();
		$("#subnotice, #subcommu, #subwel").hide();
	});
	
	$("#mainwel").mouseover(function(){
		$("#subwel").show();
		$("#subnotice, #subcommu, #subweb").hide();
	});
	
	$("#home").mouseover(function() {
		$(".subnav").hide();
	});
	
	$(".subnav").mouseleave(function() {
		$(".subnav").hide();
	});
	
	/*---------------mypage----------------------------  */
	$("#mylist").hide();
	
 	$("#mypage").click(function(e) {
		$("#mylist").show();
	}); 
 	
 	$("#mypage").mouseleave(function() {
 		$("#mylist").hide();
	}); 
	
	
});
</script>
<script type="text/javascript">
function logoutck(){
	location.href="logout.jsp";
}
</script>
</head>
<body>

<div id="top">
	<div id="back"><img src="<%=root%>/image/company3.jpg"></div>
	<div id="back2"></div>
	<div id="content">
		
		<!-------------------- mypage --------------------->
		<div id="mypage">
			<a id="mypage2" style="color:white;"><img src="<%=root%>/images/mypage2.png"><%=dto.getBuseo() %>&nbsp;&nbsp;<%=dto.getName() %>님</a>
			<div id="mylist">
			<table id="mylist2" style="border: 0;">
         <%
            if(dto.getName().equals("관리자"))
            {%>
               <tr><th style="text-align: center;"><a style="color:black;" href="<%=root%>/startmain.jsp?content=mypage/mypage_member_list.jsp" >사원 정보</a></th></tr>
            <%}else{%>
               <tr><th style="text-align: center;"><a style="color:black;" href="<%=root%>/startmain.jsp?content=mypage/mypageupdateform.jsp?num=<%=dto.getNum()%>">마이 페이지</a></th></tr>
            <%}
         %>
            <tr><td><a style="color:black;" href="<%=root%>/startmain.jsp?content=scrap/myscraplist.jsp">스크랩</a></td></tr>
            <tr><td><a style="color:black;" href="<%=root%>/startmain.jsp?content=message/message_fromlist.jsp">쪽지함(<%=count %>)</a></td></tr>
            <%
            	if(dto.getName().equals("관리자")){%>
            <tr><td><a style="color:black;" href="<%=root %>/startmain.jsp?content=mypage/adminboard_form.jsp">게시글 관리</a></td></tr>
            		
            	<%}else{%>
            <tr><td><a style="color:black;" href="<%=root %>/startmain.jsp?content=mypage/normalboard.jsp">내가 쓴 글</a></td></tr>            		
            	<%}
            %>
            <tr><td><a style="color:black;" href="<%=root %>/login/logout.jsp" onclick="return logoutck();">로그아웃</a></td></tr>
         </table>
		</div>
		
		</div>
		
		
		
		
		
		<!-- Logo -->
		<div id="logo">
			<ul style="padding: 0; text-align: center;">
				<li style="color: #FF0058;">int</li>
				<li style="color: white;">ranet=6;</li>
			</ul>
			<span>Design by six</span>
		</div>
		
		<nav id="nav" style="font-size:25pt;">
			<ul>
				<li class="active" id="home"><a style="color:white; " href="<%=root%>/startmain.jsp">HOME</a></li>					
				<li id="mainnotice"><a style="color:white;" id="not" href="startmain.jsp?content=notice/noticeform.jsp" >NOTICE</a></li>
				<li id="maincommu"><a style="color:white;" id="bor" href="startmain.jsp?content=community/community.jsp" >COMMUNITY</a></li>
				<li id="mainweb">WEBHARD</a></li>
				<li id="mainwel"><a href="startmain.jsp?content=welfare/jehyulist.jsp" style="color:white;">WELFARE</a></li>
			</ul>
		</nav>
		
		<nav id="nav2">
			<ul class="subnav" id="subweb">
				<li><a href="startmain.jsp?content=webhard/webhard_publiclist.jsp" style="color: white;">PUBLIC FOLDER</a></li>
				<li><a href="startmain.jsp?content=webhard/webhard_private_list.jsp" style="color: white;">PRIVATE FOLDER</a></li>
			</ul>	
		</nav>
		
	</div>
</div>

<div id="main">
	<div id="line"></div>
	<div id="content2" align="center">
		<div>
			
			<div>
        		 <jsp:include page="<%=content2 %>"></jsp:include>
      		</div>	
      		
		</div>
	</div>
	
	<div class="main-block"></div>
	
	<div id="foot">
			<div id="content4">
				<p>
					<font size="4px;">made by int ranet=6;</font>
				</p>
				<p>
					<font size="2px ">Copyright by jemok</font>
				</p>
			</div>
		</div>
	</div>

</body>
</html>



























