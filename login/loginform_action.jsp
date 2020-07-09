<%@page import="intranet.dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<%
   request.setCharacterEncoding("UTF-8");

   MemberDao dao = new MemberDao();
   boolean login = false;
   String id = request.getParameter("myid");
   String pw = request.getParameter("pass");
   
   List<Object> list = dao.isLogin(id,pw);
   // 맞으면 2 틀리면 0
   
   if(list.size()!=2){
      %>
       <script type="text/javascript">
       swal("로그인 실패","아이디 또는 비밀번호를 확인하세요","info")
       .then(function(value){
          history.back();
       });
          
       </script>
      <%
   }else{
      String num = (String)list.get(1);
      session.setAttribute("login", id);
      session.setAttribute("num",num);
      
      response.sendRedirect("../startmain.jsp?content=layout/content2.jsp");
   }
%>

</body>
</html>