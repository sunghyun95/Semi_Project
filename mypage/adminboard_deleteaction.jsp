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
        
<script type="text/javascript">
<%
String bnum=request.getParameter("bnum");

%>
swal({
     title: "삭제하시겠습니까?",
     text: "한번 삭제된 게시글의 내용은 복원할 수 없습니다",
     icon: "error",
     buttons: true,
     dangerMode: true,
   })
   .then(function(willDelete) {
     if (willDelete) {
        
        location.href="admin_delete_check.jsp?bnum=<%=bnum%>";
        
     } else{
        history.go(-1);
     }
        
    
   });

 
</script>
</body>   
    