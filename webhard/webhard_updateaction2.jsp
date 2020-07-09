<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
<%
String pageNum = request.getParameter("pageNum");
String bnum=request.getParameter("bnum");
%>
</head>

<body>
<script type="text/javascript">
swal("수정 완료!","자료의 수정이 완료되었습니다","success")
.then(function(value){
   location.href="../startmain.jsp?content=webhard/webhard_getData.jsp?bnum=<%=bnum%>&pageNum=<%=pageNum%>";
});

</script>
</body>
</html>