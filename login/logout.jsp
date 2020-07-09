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
swal({
     title: "로그아웃 하시겠습니까?",
     text: "",
     icon: "info",
     buttons: true,
     dangerMode: true,
   })
   .then(function(willDelete) {
     if (willDelete) {
        
        location.href="logout2.jsp";
        
     } else{
        history.go(-1);
     }
        
    
   });

 
</script>
</body>   
    