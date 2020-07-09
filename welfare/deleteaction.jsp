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
String num=request.getParameter("num");
%>  
<script type="text/javascript">
swal({
     title: "삭제하시겠습니까?",
     text: "한번 삭제된 제휴업체의 정보는 복원될수 없습니다.",
     icon: "error",
     buttons: true,
     dangerMode: true,
   })
   .then(function(willDelete) {
     if (willDelete) {
        
        location.href="deleteaction2.jsp?num=<%=num%>";
        
     } else{
        history.go(-1);
     }
        
    
   });

 
</script>
</body>   
    