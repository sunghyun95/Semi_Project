<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
  #mlisthr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    margin-bottom: 2%;
}
#mlist{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #8C8C8C;
}
#insert{
   float: right;
   margin-right: 2%;
   font-size: 15pt;
   color: #8C8C8C;
}
.msub{
   font-size: 15pt;
   height: 40px;
   text-align: left
}
.subbtn{
   background-color: #F6F6F6;
   font-size: 13pt;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function readURL(input) {
    if(input.files && input.files[0]){
        var reader=new FileReader();

        reader.onload=function(e){
            $('#profile').attr('src',e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").value='';
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
</script>
</head>
<%
   String root=request.getContextPath();
   request.setCharacterEncoding("utf-8");
   String num=request.getParameter("num");
   MemberDao dao=new MemberDao();
   MemberDto dto=dao.getMember(num);
   
   String mnum=(String)session.getAttribute("num");
   MemberDto mdto =dao.getMember(mnum);
   
   
   String addr=dto.getAddr1()+" "+dto.getAddr2();
   String hp=dto.getHp1()+"-"+dto.getHp2()+"-"+dto.getHp3();
%>
<body>
<div style="width:100%;">
	<div style="width:70%;">

<%
   if(mdto.getName().equals("관리자"))
   {%>
<h1  id="mlist">MEMBER LIST_<span style="font-size: 13pt;">UPDATE</span></h1>
<%}else{%>
<h1  id="mlist">MYPAGE</h1>
<%}%>
  <br><br>
   <hr id="mlisthr">
<form action="<%=root %>/mypage/mypageupdate_action.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num %>">
<%-- <input type="hidden" name="email2" value="<%=dto.getEmail2() %>">
<input type="hidden" name="hp1" value="<%=dto.getHp1() %>">
<input type="hidden" name="buseo" value="<%=dto.getBuseo() %>">
<input type="hidden" name="grade" value="<%=dto.getGrade() %>"> --%>
   <table style="width: 80%; background-color: #F6F6F6;">
      <tr>
         <td rowspan="9" style="width: 30%"><img id="profile" src="<%=root %>/saveimage/<%=dto.getImage() %>" style="width:95%; height: 380px"/></td>
         <th class="msub" style="width: 15%; font-size: 10pt;">사원번호</th>
         <td style="width: 55%"><input type="text" name="id" style="font-size: 10pt; width: 400px;" value="<%=dto.getId() %>" readonly="readonly"></td>
      </tr>
      <tr>
         <th class="msub" >이름</th>
         <td >
            <%
            if(mdto.getName().equals("관리자"))
            {%>
            <input type="text" name="name" style="width: 400px; height: 30px;"  value="<%=dto.getName() %>">
            <%}else{%>
            <input type="text" name="name" style="width: 400px; height: 30px;"  value="<%=dto.getName() %>" readonly="readonly">
            <%}%>
         </td>
      </tr>
      <tr>
         <th class="msub">부서</th>
         <td>
         <%
            if(mdto.getName().equals("관리자"))
            {%>
            <select name="buseo" style="width: 400px; height: 30px">
               <option><%=dto.getBuseo() %></option>
               <option value="인사팀">인사팀</option>
               <option value="개발팀">개발팀</option>
               <option value="디자인팀">디자인팀</option>
            </select>
            <%}else{%>
               <input type="text" name="buseo" style="width: 400px; height: 30px;" value="<%=dto.getBuseo()%>" readonly="readonly">
            <%}%>
         </td>
      </tr>
      <tr>
         <th class="msub">직급</th>
         <td>
         <%
            if(mdto.getName().equals("관리자"))
            {%>
            <select name="grade" style="width: 400px; height: 30px">
               <option><%=dto.getGrade()%></option>
               <option value="부장">부장</option>
               <option value="팀장">팀장</option>
               <option value="사원">사원</option>
            </select>
            <%}else{%>
               <input type="text" name="grade" style="width: 400px; height: 30px;" value="<%=dto.getGrade()%>" readonly="readonly">
            <%}%>
         </td>
      </tr>
      <tr>
         <th class="msub">입사일</th>
         <td>
         <%
            if(mdto.getName().equals("관리자"))
            {%>
         <input type="date" name="ipsaday" style="width: 400px; height: 30px" value="<%=dto.getIpsaday().substring(0, 10) %>">
         <%}else{%>
               <input type="date" name="ipsaday" style="width: 400px; height: 30px;" value="<%=dto.getIpsaday().substring(0, 10) %>">
            <%}%>
         </td>
      </tr>
      <tr>
         <th class="msub">핸드폰</th>
         <td><select name="hp1" style="height: 30px; width: 120px">
               <option><%=dto.getHp1() %></option>
               <option value="010">010</option>
               <option value="011">011</option>
               <option value="019">019</option>
            </select> -
               <input type="text" name="hp2" style="height: 30px; width: 122px" value="<%=dto.getHp2() %>"> -
               <input type="text" name="hp3" style="height: 30px; width: 123px" value="<%=dto.getHp3() %>">
         </td>
      </tr>
      <tr>
         <th class="msub">이메일</th>
         <td><input type="text" name="email1" style="height: 30px; width: 189px;" value="<%=dto.getEmail1() %>"> @
            <select name="email2" style="height: 30px; width: 188px;">
               <option><%=dto.getEmail2() %></option>
               <option value="gmail.com">gmail.com</option>
               <option value="naver.com">naver.com</option>
               <option value="daum.net">daum.net</option>
            </select>
         </td>
      </tr>
      <tr>
         <th class="msub">생일</th>
         <td><input type="date" name="birth" style="height: 30px; width: 400px" value="<%=dto.getBirth()%>"></td>
      </tr>
      <tr>
         <th class="msub">주소</th>
         <td>
            <input type="hidden" id="sample6_postcode" placeholder="우편번호">
            <input type="text" id="sample6_address" name="addr1" readonly="readonly" style="height: 30px; width:296px" value="<%=dto.getAddr1()%>">  <input type="button" style="width:100px; height:30px" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="sample6_detailAddress" name="addr2" style="height: 30px; width: 400px" value="<%=dto.getAddr2()%>">
            <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
            </td>
      </tr>

   </table>
         <span style="float:left; margin-top: 1%; margin-left: 10%"><input type="file" name="image" class="subbtn" value="<%=dto.getImage() %>" onchange="readURL(this)" style="background-color: white; "></span>
         <span style="float:right; margin-right: 10%; margin-top: 1%"><button type="submit" class="subbtn">UPDATE</button>
         <%
            if(mdto.getName().equals("관리자"))
            {%>
         <button type="button" class="subbtn" onclick="history.back()">BACK</button>
         <%}%>
         </span>
</form>   
	</div>
</div>
</body>
</html>