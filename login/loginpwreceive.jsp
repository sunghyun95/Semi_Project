<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginpwreceive</title>
<%
   String root=request.getContextPath();
 
%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=root%>/css/loginform.css" type="text/css">

</head>
<%
	String num=request.getParameter("num");
	String id=request.getParameter("id");
%>
<body>
<div id="back3"></div>
<div id="back"><img src="../images/company3.jpg" id="back"></div>
<div id="back2" align="center"></div>


<form id="frm" action="loginidpass.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="id" value="<%=id %>">
   
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
				         <input type="password"	required="required" name="pw"
							placeholder="비밀번호를 입력하세요."  maxlength="41" 
							>
							<input type="password" required="required" name="pw2"
							placeholder="비밀번호 확인" class="int" maxlength="16"
							> 
				      </div>
			
					</td>
			
			</tr>
			
	 <!-------------------------- 버튼 ---------------------------->    
		     <tr id="t2-pwre">
		     
		     	<td id="t2-pwre2">				
			
					<div id="btn" >
						<input type="submit" value="확인" class="btn-pwre" 
						id="btn_pw3">
						<input type="reset" value="취소" class="btn-pwre" onclick="history.back()"
						id="btn_pw4">
					</div>
		
					</td>
		      
	      	</tr>
   
      </table>
		
	</div>
</form>
</body>
</html>

















