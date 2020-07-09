<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
</head>
<body>
    
<%
   request.setCharacterEncoding("utf-8");
   String num=request.getParameter("num");
   String id=request.getParameter("id");
   String pw=request.getParameter("pw");
   String pw2=request.getParameter("pw2");
   
   
   if(pw.equals(pw2))
   {
      MemberDao dao=new MemberDao();
      MemberDto dto=new MemberDto();
      dto.setNum(num);
      dto.setId(id);
      dto.setPass(pw);
      dao.updateIdpass(dto);
      %>
      <script type="text/javascript">
      swal("비밀번호 설정 완료!","로그인 화면으로 넘어갑니다","success")
      .then(function(value){
        location.href="loginform.jsp";   
      });
         
      </script>
      
   <%}else{%>
     <script type="text/javascript">
      swal("설정 실패!","비밀번호가 서로 맞지 않습니다","info")
      .then(function(value){
         history.back();   
      });
         
      </script>
   <%}
%>