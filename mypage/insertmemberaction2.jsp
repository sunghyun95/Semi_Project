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
swal("추가 완료!","입력하신 정보로 계정이 추가되었습니다","success")
.then(function(value){
   location.href="../startmain.jsp?content=mypage/mypage_member_list.jsp";
});

 
</script>
</body>   
    