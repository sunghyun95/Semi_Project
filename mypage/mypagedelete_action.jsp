<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <head>
   <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>    
    </head>
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
   String pageNum=request.getParameter("pageNum");
   
   System.out.println("kjj"+pageNum);
%>        
<script type="text/javascript">
swal({
     title: "삭제하시겠습니까?",
     text: "계정 삭제가 이루어지면 관련된 파일 및 정보가 삭제됩니다",
     icon: "error",
     buttons: true,
     dangerMode: true,
   })
   .then(function(willDelete) {
     if (willDelete) {
        location.href="mypagedelete_check.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
        
     } else{
        location.href="../startmain.jsp?content=mypage/mypage_member_list.jsp?pageNum=<%=pageNum%>";
     }
        
    
   });

 
</script>
</body>   
    