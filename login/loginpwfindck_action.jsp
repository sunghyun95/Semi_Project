<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String random=request.getParameter("random");
	String check=request.getParameter("text_ch");
	String num=request.getParameter("num");
	String id=request.getParameter("id");
	
	if(random.equals(check))
	{
		response.sendRedirect("loginpwreceive.jsp?num="+num+"&id="+id);
	}else{
	%>
		<script type="text/javascript">
		alert("인증번호가 틀렸습니다.");
		history.back();
		</script>
	<%}
%>