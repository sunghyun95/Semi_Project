<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginreceive</title>
<%
   String root=request.getContextPath();

	String randomsu="";
	for(int i=0; i<6; i++) {
        int nansu = (int)((Math.random()*10));
         randomsu += Integer.toString(nansu);   
     }
   
%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=root%>/css/loginform.css" type="text/css">
<script type="text/javascript">
function check(){
	var name = $("#name").val();
	var hp = $("#phone").val();
	var email = $("#email").val();
	if(name == null||name==""||name.trim().length==0){
		swal("아...", "이름을 입력해주세요!", "error");
		return false;
	}
	
	if(hp==""||hp.trim().length==0){
		swal("잠깐만요ㅠㅠ", "전화번호를 입력해주세요!", "error");
		return false;
	}
	
	
	
	return true;
		
}


function inputPhoneNumber(obj) {
    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}
</script>
</head>

<body>

<div id="back3"></div>
<div id="back"><img src="../images/company3.jpg" id="back"></div>
<div id="back2" align="center"></div>

<form id="frm" action="logincheck.jsp" method="post" onsubmit="return check()">
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
	      
	      <td id="t1-2">
		      <div id="text" >
		         <input type="text" id="name" name="name"
		         placeholder="NAME" maxlength="41" >
		         
		      <input type="text" id="PHONE" name="hp" placeholder="PHONE (xxx-xxxx-xxxx)" onKeyup="inputPhoneNumber(this);" maxlength="13"/>
		   
		         <input type="text" id="email" name="email"
		         placeholder="EMAIL (abcd@abcd.com)"  maxlength="41" >
		      </div>
	       </td>
	      </tr>
	      
	     <tr id="t2-r">
	     	<td id="t2-r2">
		      <div id="btn" >
		         <input type="submit" value="확인" class="btn-r" 
		         id="btn_re1">
		         <input type="reset" value="취소" class="btn-r" onclick="history.back()"
		         id="btn_re2">
		      </div>
		   </td>
		
		 </tr>
      
      </table>
      
      
   </div>
</form>
</body>
</html>


















