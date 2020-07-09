<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginok</title>
<%
   String root=request.getContextPath();

	request.setCharacterEncoding("utf-8");
	String num=request.getParameter("num");
	MemberDao dao=new MemberDao();
	MemberDto dto=dao.getMember(num);
	System.out.println("buseo="+dto.getBuseo());
	
	String buseoNum="";
	if(dto.getBuseo().equals("인사팀"))
	{
		buseoNum="7";
	}else if(dto.getBuseo().trim().equals("디자인팀")){
		buseoNum="9";
	}else{
		buseoNum="8";
	}
	System.out.println(dto.getBuseo()+","+buseoNum);
	
	
	String rdNum="";
	for(int i=0;i<4;i++)
	{
		int random=(int)(Math.random()*10);
		rdNum+=Integer.toString(random);
	}
	String id=buseoNum+rdNum;
   
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

<form id="frm" action="loginokpw.jsp?num=<%=num %>" method="post">
	<input type=hidden name="id" value="<%=id%>">
   
   <div id="content" >
   	
   		<table>
   		<!-- ------------------logo -------------------------------  -->
	      <tr id="t1" >
	      	<td id="t1-1" rowspan="2">
   
		      <div id="logo" >
		         <ul>
		         	<li style="color: #FF0058; margin-left: 30px;">int</li>
		         	<li style="color: white;">ranet=6;</li>
		         </ul>
		      </div>
		      
		      </td>
       
       	 <!-- --------------------text ------------------------------ -->
			<td id="t1-2" style="height: 60%" >			
       
		      <div id="text_cl" align="right"  >
		         <p id="cl1" style="font-size: 20pt;margin-right: 5%; "><b style="color:orange">귀하의 입사를 축하합니다!</b></p>
		         <p ><b id="cl2" style="font-size: 20pt; margin-right: 5%; color:#FF0058">사원번호: <%=id %></b></p>
		      </div>
         	
         	</td>
			
			</tr>
			
		 <!-------------------------- 버튼 ---------------------------->  
		 
		 	 <tr id="t2-ok" >
		     
		     	<td id="t2-ok2"  >
		     	
			      <div id="btn">
			         <input type="submit" value="확인" class="btn-ok" 
			         id="btn_ok" style="top:65%">
			      </div>
      
     	 		</td>
		      
	      	</tr>
   
   
      </table>
      
   </div>
</form>
</body>
</html>




















