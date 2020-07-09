<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
$(function(){
	$("#juso").click(function(){
		window.open("jehyuaddr.jsp","","width=600px,height=600px,left=800px,top=100px");

	});
	
});



</script>
<title>Insert title here</title>
</head>
<body>
<form action="#">
	<p> 주소검색 : <button type="button" id="juso">주소검색</button>
</form>
</body>
</html>