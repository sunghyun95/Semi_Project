<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
#noticetable{
	margin-top:2%;
}
#bsubject, #bcontent {
  width: 500px;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
}

#bcontent {
	height:600px;
}

#insertbtn{
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
$(function(){
	$("#blah_form").hide();
});
	function readURL(input) {
		$("#blah_form").show();
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
	String root = request.getServletPath();
%>
<body>
<div style="width:100%;">
	<div style="width:70%;">
<h1  id="noti">NOTICE</h1>	
 <hr id="notihr">	
	<div id="blah_form">
<img id="blah" src="http://placehold.it/180" />
	</div>
<form name="noticeForm" action="notice/noticeaddaction.jsp" method="post" enctype="multipart/form-data">
<table id="noticetable">
<tr>
	<td><input type="text" id="bsubject" name="bsubject" placeholder="제목을 입력해주세요"></td>
</tr>
<tr>
	<td><textarea name="bcontent" id="bcontent" placeholder="내용을 입력해주세요"></textarea></td>
</tr>
<tr>
	<td><input type="file" name="photo" style="width: 250px;" required="required" onchange="readURL(this)" ></td>
</tr>
<tr>
	<td>
		<button type="button" onclick="notice()" id="insertbtn">INSERT</button>&nbsp;
		<button type="button" onclick="location.href='startmain.jsp?content=notice/noticeform.jsp'" id="listbtn">LIST</button>
		
	</td>
</tr>
</table>
</form>
	</div>
</div>
</body>
</html>