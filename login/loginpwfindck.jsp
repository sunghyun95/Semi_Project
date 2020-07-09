<%@page import="intranet.sms.SMSManager"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginpwfindck</title>
<%
   String root=request.getContextPath();
   
%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=root%>/css/loginform.css" type="text/css">

<%

	request.setCharacterEncoding("utf-8");
	String randomsu=request.getParameter("randomsu");
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String hp=request.getParameter("hp");
	String email=request.getParameter("email");
	
	MemberDao mdao = new MemberDao();
	MemberDto mdto = mdao.getInfoCheckMember(name, hp, email);
	
	String memberHp = mdto.getHp1()+mdto.getHp2()+mdto.getHp3();
	System.out.println("**번호**"+memberHp);   
	System.out.println("**회원번호**"+mdto.getNum());
	String mdto_hp = mdto.getHp1()+"-"+mdto.getHp2()+"-"+mdto.getHp3();
	String mdto_email = mdto.getEmail1()+"@"+mdto.getEmail2();
	
	MemberDto admin = mdao.getAdmin();
	String adminhp = admin.getHp1()+"-"+admin.getHp2()+"-"+admin.getHp3();
	System.out.println("password member num="+mdto.getNum());
%>
<script type="text/javascript">
$(function() {
	var id="<%=id%>";
	var name= "<%=name%>";
	var hp= "<%=hp%>";
	var email= "<%=email%>";
	var randomsu= "<%=randomsu%>";
	$.ajax({
		type:"get",
		url:"loginpwfind_action.jsp",
		dataType:"json",
		data:{"id":id,"name":name,"hp":hp,"email":email,"randomsu":randomsu},
		success:function(data){
			var str="";
			//alert(name);
			str+="<table id='rnd-t'>";
			str+="<tr><th>이름</th><td>"+name+"</td></tr>";
			str+="<tr><th>사원번호</th><td>"+id+"</td></tr>";
			str+="<tr><th>핸드폰</th><td>"+hp+"</td></tr>";
			str+="<tr><th>이메일</th><td>"+email+"</td></tr>";
			str+="<tr><td colspan='2'><button type='button' class='sendrd'>인증번호 발송</button></td></tr>";
			str+="</table>";
			
			$(".rnd").html(str);
		}
		
	});
	$(document).on("click",".sendrnd",function(){
		<%
		if(mdto_hp.equals(hp)){
		      
		      SMSManager sms = new SMSManager();
		      SMSManager.sendSms(randomsu,memberHp,adminhp);      

		   }else{
		      %>
		            alert("문자전송 실패");
		            history.back();
		       	
		 <%}%> 
	});
	
});
</script>
</head>
<body>

<div id="back3"></div>
<div id="back"><img src="../images/company3.jpg" id="back"></div>
<div id="back2" align="center"></div>
<div class="rnd"></div>	

<form id="frm" action="loginpwfindck_action.jsp" method="post">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="num" value="<%=mdto.getNum()%>">
<input type="hidden" name="random" value="<%=randomsu %>">  
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
				       	<input type="text" id="check" required="required" name="text_ch"
				        placeholder="인증번호 입력"  maxlength="41" >
					</div>
				      
			      </td>
			
			</tr>
			
	 <!-------------------------- 버튼 ---------------------------->    
		     <tr id="t2-pwfick">
		     
		     	<td id="t2-pwfick2">
			
			       <div id="btn" >
			          <input type="submit" value="확인" class="btn-pwfick" 
			          id="btn_ch1">
			          <input type="reset" value="취소" class="btn-pwfick" onclick="history.back()"
			          id="btn_ch2">
			    	</div>
    			</td>
		      
	      	</tr>
   
      </table>
    	
	</div>
</form>
</body>
</html>
