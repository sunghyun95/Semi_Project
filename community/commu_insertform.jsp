<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function readURL(input) {
    if(input.files && input.files[0]){
        var reader=new FileReader();

        reader.onload=function(e){
            $('#commuimage').attr('src',e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function commu(){
    var commuForm = document.commuForm;
    var bsubject = commuForm.bsubject.value;
    var bcontent = commuForm.bcontent.value;
    var bphoto = commuForm.photo.value;
    if(!bsubject || !bcontent){
       swal("실패!", "제목과 내용을 입력해주세요!", "error");
    }else if(!bphoto){
       swal("실패!", "사진파일을 등록해주세요!", "error");
    }else{
       commuForm.submit();
    }
}

</script>
<style type="text/css">
#commuhr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    margin-bottom: 2%;
}
#commu{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: orange;
}
.img-wrapper{
   border:1px solid gray; 
   display:inline-block;
   width:45%;
   height: auto;
   box-shadow: 0 1px 10px rgba(0,0,0,0.5);
   margin-top: 2%;
}
.commudiv{
   display: inline-block; 
   width:100%;
}
.commuspan{
   margin-left:1%; 
   line-height:30px; 
   float:left;
}
#commuimage{
   width: 100%;
   height:450px;
}
</style>
</head>
<%
   String root=request.getContextPath();
   String num=(String)session.getAttribute("num");
   MemberDao dao=new MemberDao();
   MemberDto dto=dao.getMember(num);
   String pageNum = request.getParameter("pageNum");
%>
<body>
<div style="width:100%;">
   <div style="width:70%;">
<h1  id="commu">COMMUNITY_<span style="font-size: 13pt">INSERT</span></h1>
     <hr id="commuhr">
<form name="commuForm" action="<%=root %>/community/commu_insertaction.jsp" method="post" enctype="multipart/form-data">
<div class="img-wrapper" >
   <img id="commuimage" src="http://placehold.it/180" style="background-color: #F6F6F6"><br>
   <div class="commudiv" align="left" style="margin-left:1%; margin-top: 1%">
   <input type="file" id="photo" name="photo" onchange="readURL(this)" accept=".jpg, .png, .gif, .JPG, .PNG, .GIF" required="required">
   </div>
   <div class="commudiv">
      <span class="commuspan" ><b>분류</b>&nbsp;&nbsp;
         <select name="bcommu">
            <option value="워크샵">워크샵</option>
            <option value="팁&노하우">팁&노하우</option>
            <option value="일반">일반</option>
         </select>
      </span>
      <span style='float:right; margin-right:1%; line-height:30px;'><b><%=dto.getName() %></b></span>
   </div>
   <div class="commudiv">
      <span class="commuspan" ><b>제목</b>&nbsp;&nbsp;
      <input type="text" name="bsubject" id="bsubject">
      </span>
   </div>
   <div class="commudiv">
      <span class="commuspan"><b style="width:9%;">내용</b>&nbsp;&nbsp;
      </span>
   </div>
   <div class="commudiv" style="margin-bottom: 2%">
      <textarea style="width:80%; height:100px; margin-right: 1%" name="bcontent" id="bcontent"></textarea>
      </span>
   </div>


</div>
<table style="margin-top: 2%">
<tr>
<td style="font-size: 15pt;">
      <a style="color:black" href="#" onclick="commu()">INSERT</a>&nbsp;
      <a style="color:black" href="#" onclick="location.href='startmain.jsp?content=community/community.jsp'">LIST</a>
</td>
</tr>
</table>
</form>
</div>
</div>
</body>
</html>