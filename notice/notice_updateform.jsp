<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dto.NoticeDto"%>
<%@page import="intranet.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<title>Insert title here</title>
<style type="text/css">
#noticetable{
	margin-top:2%;
}
#bsubject, #bcontent {
  width: 700px;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
}

#bcontent {
	height:450px;
}

#updatebtn{
	background-color: #008CBA; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
}
#listbtn{
	background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
}
  #notihr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    margin-bottom: 2%;
}
#noti{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #000054;
}
</style>
<script type="text/javascript">
   function readURL(input) {
       if (input.files && input.files[0]) {
           var reader = new FileReader();

           reader.onload = function (e) {
               $('#blah')
                   .attr('src', e.target.result);
           };
           reader.readAsDataURL(input.files[0]);
       }
   }
   
	function notice(){
	    var noticeForm = document.noticeForm;
	    var bsubject = noticeForm.bsubject.value;
	    var bcontent = noticeForm.bcontent.value;
	    if(!bsubject || !bcontent){
	    	swal("실패!", "제목과 내용을 입력해주세요!", "error");
	    }else{
	    	noticeForm.submit();
	    }
	}
   
</script>

</head>
<%
   String bnum = request.getParameter("bnum");
   String pageNum = request.getParameter("pageNum");
   NoticeDao dao= new NoticeDao();
   NoticeDto dto = dao.getData(bnum);
   FileDao fdao = new FileDao();
   FileDto fdto = fdao.getBnumFile(bnum);
%>
<body>
<div style="width:100%;">
	<div style="width:70%;">
	<h1  id="noti">NOTICE</h1>	
 <hr id="notihr">
<form name="noticeForm" action="notice/notice_updateaction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
<input type="hidden" name="num" value="<%=dto.getNum()%>">
<table id="noticetable">
<tr>
   <td rowspan="4"><img id="blah" src="notice/<%=fdto.getFilename()%>" style="max-width: 200px;" /></td>

   <td><input type="text" id="bsubject" name="bsubject" value="<%=dto.getBsubject()%>"></td>
</tr>
<tr>

   <td><textarea name="bcontent" id="bcontent"><%=dto.getBcontent()%></textarea></td>
</tr>
<tr>
   
   <td><input type="file" name="photo" style="width: 250px;"
       onchange="readURL(this)" ></td>
</tr>
<tr>
   <td colspan="2">
      <!-- hidden -->
      <input type="hidden" name="bnum" value="<%=dto.getBnum()%>">
      <button type="button" onclick="notice()" id="updatebtn">UPDATE</button>
      &nbsp;
      <button type="button" onclick="location.href='startmain.jsp?content=notice/noticeform.jsp?pageNum=<%=pageNum%>'" id="listbtn">LIST</button>
   </td>
</tr>
</table>
</form>

	</div>
</div>
</body>
</html>