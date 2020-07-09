<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">
#listbtn {
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
#webh{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #005000;
}
#webhr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    margin-bottom: 2%;
}
#writebtn{
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
#bsubject, #bcontent {
  width: 500px;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
}

#bcontent {
	height:450px;
}
#webhardinserttable{
	margin-top:2%;
}


</style>
<%
	String webhard = request.getParameter("webhard");
%>
<script type="text/javascript">
$(function(){
	$("#chkopen").click(function(){
		var s =$("#chkopen").is(":checked");
		if(s){
			$("#bopen").val("1");
		}else{
			$("#bopen").val("0");
		}
	});
});



function webhard(){
    var webhardForm = document.webhardForm;
    var bsubject = webhardForm.bsubject.value;
    var bcontent = webhardForm.bcontent.value;
    if(!bsubject || !bcontent){
    	swal("실패!", "제목과 내용을 입력해주세요!", "error");
    }else{
    	webhardForm.submit();
    }
}

</script>
</head>
<body>
<div style="width:100%;">
	<div style="width:70%;">
<h1 id="webh">WEBHARD_<span style="font-size: 13pt;">INSERT</span></h1>
	<hr id="webhr">
<form name="webhardForm" action="webhard/webhard_insertaction.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="bopen" id="bopen" value="0">
	<table class="table table-bordered" id="webhardinserttable">
			
		<tr>
			<td>
				<input type="text" name="bsubject" id="bsubject" placeholder="제목을 입력하세요">
			</td>
		</tr>
		<tr>
			<td>
				<textarea name="bcontent" id="bcontent" placeholder="내용을 입력하세요"></textarea>
			</td>
		</tr>
		<tr>
			<td>
			<input multiple="multiple" type="file" name="file" placeholder="여러개의 파일을 등록해주세요">
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" id="chkopen">비공개
			</td>			
		</tr>
		<tr>
			<td>
				<button type="button" onclick="webhard()" id="writebtn">WRITE</button>&nbsp;
				
				<%
					if(webhard.equals("1")){%>
				<button type="button" onclick="location.href='startmain.jsp?content=webhard/webhard_private_list.jsp'" id="listbtn">LIST</button>						
					<%}else{%>
				<button type="button" onclick="location.href='startmain.jsp?content=webhard/webhard_publiclist.jsp'" id="listbtn">LIST</button>						
							
					<%}
				%>
			</td>
		</tr>
	</table>
</form>
	</div>
</div>
</body>
</html>