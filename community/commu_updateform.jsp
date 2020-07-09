<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dto.CommuDto"%>
<%@page import="intranet.dao.CommuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
function commusave(){
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
#commuimage{
   width: 100%;
   height: 450px;
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

  


</style>
</head>
<%
   String root=request.getContextPath();
   String mypage = request.getParameter("mypage");
   String pageNum = request.getParameter("pageNum");
   String bnum=request.getParameter("bnum");
   String num=(String)session.getAttribute("num");
   CommuDao cdao=new CommuDao();
   CommuDto cdto=cdao.getCommu(bnum);
   
   FileDao fdao=new FileDao();
   FileDto fdto=fdao.getBnumFile(bnum);
   
   MemberDao mdao=new MemberDao();
   MemberDto mdto=mdao.getMember(num);
%>
<body>
<div style="width:100%;">
   <div style="width:70%;">
<h1  id="commu">COMMUNITY_<span style="font-size: 13pt">UPDATE</span></h1>
     <hr id="commuhr">
<div class="img-wrapper" >
<form name="commuForm" action="<%=root %>/community/commu_updateaction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="bnum" value="<%=cdto.getBnum() %>">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
<img id="commuimage" src="<%=root %>/savecommu/<%=fdto.getFilename() %>" style="background-color: #F6F6F6"><br>
   <div class="commudiv" align="left" style="margin-left:1%; margin-top: 1%">
   <input type="file" id="photo" name="photo" onchange="readURL(this)" accept=".jpg, .png, .gif, .JPG, .PNG, .GIF" required="required">
   </div>
   <div class="commudiv">
      <span class="commuspan" ><b>분류</b>&nbsp;&nbsp;
         <select name="bcommu">
            <option value="<%=cdto.getBcommu() %>"><%=cdto.getBcommu() %></option>
            <option value="워크샵">워크샵</option>
            <option value="팁&노하우">팁&노하우</option>
            <option value="일반">일반</option>
         </select>
      </span>
      <span style='float:right; margin-right:1%; line-height:30px;'><b><%=mdto.getName()%></b></span>
   </div>
   <div class="commudiv">
      <span class="commuspan" ><b>제목</b>&nbsp;&nbsp;
      <input type="text" name="bsubject" id="bsubject" value="<%=cdto.getBsubject()%>">
      </span>
   </div>
   <div class="commudiv">
      <span class="commuspan"><b style="width:9%;">내용</b>&nbsp;&nbsp;
      </span>
   </div>
   <div class="commudiv" style="margin-bottom: 2%">
      <textarea style="width:80%; height:100px; margin-right: 1%" name="bcontent" id="bcontent"  autofocus="autofocus"><%=cdto.getBcontent() %></textarea>
      </span>
   </div>
</div>
<table  style="margin-top: 2%">
   <tr>
      <td style="font-size: 15pt;">
         <a style="color:black" href="#" onclick="commusave()">SAVE</a>&nbsp;
         <a style="color:black" href="#" onclick="history.back()">BACK</a>      
      </td>
   </tr>
</table>
</form>
</div>
</div>
</body>
</html>