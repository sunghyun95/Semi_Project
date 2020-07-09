<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginpwfind</title>
<%
	request.setCharacterEncoding("utf-8");
	String root=request.getContextPath();
	String randomsu="";
	for(int i=0; i<6; i++) {
	    int nansu = (int)((Math.random()*10));
	     randomsu += Integer.toString(nansu);   
	 }
   
%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=root%>/css/loginform.css" type="text/css">
</head>
<body>

<div id="back3"></div>
<div id="back"><img src="../images/company3.jpg" id="back"></div>
<div id="back2" align="center"></div>

<form id="frm" action="loginpwfindck.jsp" method="post">
<input type="hidden" name="randomsu" value="<%=randomsu %>">   
   <div id="content" >
   
      <table>
   		<!-- ------------------logo -------------------------------  -->
	      <tr id="t1">
	      	<td id="t1-1" rowspan="2">
		      <div id="logo" >
		         <ul>
		         	<li style="color: #FF0058; margin-left: 30px;">int</li>
		         	<li style="color: white;">ranet=6;</li>
		         </ul>
		      </div>
		      </td>
			<!-- --------------------text ------------------------------ -->
			
			<td id="t1-2">			
			
		      <div id="text" >
		         <input type="text" id="id" required="required"
		         placeholder="사원번호"  maxlength="41" name="id">
		         <input type="text" id="name" required="required"
		         placeholder="NAME"  maxlength="41"  name="name">
		         <input type="text" id="phone" required="required"
		         placeholder="PHONE"  maxlength="41" name="hp">
		         <input type="text" id="email" required="required"
		         placeholder="EMAIL"  maxlength="41" name="email">
		      </div>
             </td>
          </tr>
         
         
         <!-------------------------- 버튼 ---------------------------->    
		     <tr id="t2-pwf">
		     
		     	<td id="t2-2">
          	              
		      <div id="btn">
		         <input type="submit" value="LOGIN" class="btn-pwf" 
		               id="btn_fi1">
		         <input type="button" value="BACK" class="btn-pwf" onclick="history.back()"
		         id="btn_fi2">
		      </div>
		      
		   </td>
      	</tr>
      </table>
   </div>
</form>
</body>
</html>

















