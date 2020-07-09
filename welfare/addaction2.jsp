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
     title: "추가가 완료되었습니다",
     text: "추가된 제휴업체는 지도에 바로 업로드됩니다",
     icon: "success",
     buttons: true,
     dangerMode: true,
   })
   .then(function(willDelete) {
     if (willDelete) {
        
        location.href="../startmain.jsp?content=welfare/jehyulist.jsp";
        
     } else{
        history.go(-1);
     }
        
    
   });

 
</script>
</body>   
    