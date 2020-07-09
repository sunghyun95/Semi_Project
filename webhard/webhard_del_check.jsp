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
String pageNum = request.getParameter("pageNum");
System.out.println("webhard_del_check"+pageNum);
String root = request.getContextPath();
%>
<script type="text/javascript">

swal({
     title: "삭제 완료!",
     text: "선택하신 자료의 삭제가 완료되었습니다",
     icon: "success",
     buttons: true,
     dangerMode: true,
   })
   .then(function(willDelete) {
     if (willDelete) {
        
        location.href="../startmain.jsp?content=webhard/webhard_publiclist.jsp?pageNum=<%=pageNum%>";
        
     } else{
        history.go(-1);
     }
        
    
   });
 
</script>
</body>   
    