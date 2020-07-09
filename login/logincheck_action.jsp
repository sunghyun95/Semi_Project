<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String random=request.getParameter("random");
	System.out.println(random);
	String check=request.getParameter("text_ch");
	String num=request.getParameter("num");
	
	if(random.equals(check))
	{
		response.sendRedirect("loginok.jsp?num="+num);
	}else{
	%>
		<script type="text/javascript">
		alert("인증번호가 틀렸습니다.");
		history.back();
		</script>
	<%}
%>