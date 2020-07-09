<%@page import="java.io.PrintWriter"%>
<%@page import="intranet.sms.SMSManager"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>logincheck</title>
<%
   String root=request.getContextPath();
   
%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=root%>/css/loginform.css" type="text/css">

<%
   request.setCharacterEncoding("utf-8");

	String random=request.getParameter("random");
	
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String email = request.getParameter("email");
	 String randomsu=request.getParameter("randomsu");
	 
	 
	 System.out.println("random="+randomsu);
	 MemberDao mdao = new MemberDao();
	 MemberDto mdto = mdao.getInfoCheckMember(name, hp, email);
	 
	 
	   String memberHp = mdto.getHp1()+mdto.getHp2()+mdto.getHp3(); //01012341234
	   
	   System.out.println("**번호**"+memberHp);   
	   
	   
	   System.out.println("**회원번호**"+mdto.getNum());
	   
	   String mdto_hp = mdto.getHp1()+"-"+mdto.getHp2()+"-"+mdto.getHp3();
	   
	   String mdto_email = mdto.getEmail1()+"@"+mdto.getEmail2();
	   
	   MemberDto admin=mdao.getAdmin();
	   
	   String adminhp=admin.getHp1()+"-"+admin.getHp2()+"-"+admin.getHp3();
	   
	   System.out.println("member num="+mdto.getNum());
%>

</head>


<script type="text/javascript">
$(function(){
	var name= "<%=name%>";
	var hp= "<%=hp%>";
	var email= "<%=email%>";
	var randomsu= "<%=randomsu%>";
	//alert(name);
	//alert(randomsu);
	$.ajax({
		type:"get",
		url:"loginreceive_action.jsp",
		dataType:"json",
		data:{"name":name,"hp":hp,"email":email,"randomsu":randomsu},
		success:function(data){
			var str="";
			//alert(name);
			str+="<table id='rnd-t' style='width: 350px; height: 180px;'>";
			str+="<tr><th>NAME</th><td colspan='2'>"+name+"</td></tr>";
			str+="<tr><th>PHONE</th><td>"+hp+"</td><td><button type='button' style='cursor:pointer;' class='sendrd' align='right'>문자 발송</button></td></tr>";
			str+="<tr><th>EMAIL</th><td colspan='2'>"+email+"</td></tr>";
			str+="</table>";
			
			$(".rnd").html(str);
		}
		
	});
	
	$(document).on("click",".sendrd",function(){
		
		var random = "<%=randomsu%>";
		var memberHp = "<%=memberHp%>";
		var adminhp = "<%=adminhp%>";
		var mdto_hp = "<%=mdto_hp%>";
		
		$.ajax({
			type:"post",
			url:"login_phone.jsp",
			dataType:"html",
			data:{"randomsu":random,"memberHp":memberHp,"adminhp":adminhp,"mdto_hp":mdto_hp,"hp":hp},
			success:function(){
				swal("전송 완료!", "등록한 번호로 전송이 완료되었습니다", "success");
			},
			error:function(data){
				console.log("error:function");
				console.log(data);
			}
		});
	});
});
</script>
<body>

<div id="back3"></div>
<div id="back"><img src="../images/company3.jpg" id="back"></div>
<div id="back2" align="center"></div>

<!-- ------------인증 번호 창 ---------------------------------  -->


<form id="frm" action="logincheck_action.jsp" method="post">
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
	      	<div class="rnd"></div>		
	         <input type="text" id="check" name="text_ch"
	         placeholder="인증번호 입력"  maxlength="41" >
	      </div>
        </td>
     </tr>
     
      <!-------------------------- 버튼 ---------------------------->    
	<tr id="t2-ch">
			     
		<td id="t2-ch2">
            
		      	<div id="btn" name="btn" class="btn" >
		      	
		         <input type="submit" value="확인" class="btn-ch" 
		            id="btn_ch3">
		         <input type="reset" value="취소" class="btn-ch" onclick="history.back()"
		         id="btn_ch4">
	    	 </div>
     
     		</td>
     	
     	</tr>
     </table>
   </div>
</form>

</body>
</html>


















