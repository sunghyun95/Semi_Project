<%@page import="intranet.sms.SMSManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mdto_hp = request.getParameter("mdto_hp");
	String randomsu = request.getParameter("randomsu");
	String memberHp = request.getParameter("memberHp");
	String adminhp = request.getParameter("adminhp");
	String hp = request.getParameter("hp");
	
	if(mdto_hp.equals(hp)){
	      
	      SMSManager sms = new SMSManager();
	      SMSManager.sendSms(randomsu,memberHp,adminhp);      

	   }else{%>
		<script type="text/javascript">
			alert("입력하신 번호가 맞지않습니다");
			history.back();
		</script>
		   
	<% } 
	
%>