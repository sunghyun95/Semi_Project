<%@page import="java.util.List"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dao.BoardDao"%>
<%@page import="intranet.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">


#cancelbtn {
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
#bsubject, #bcontent {
  width: 500px;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
}

#bcontent {
	height:450px;
}
#webhardupdatetable{
	margin-top:2%;
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

</style>
<script type="text/javascript">
$(function(){
	
	
	$("a.filedelete").click(function(){
		var fnum = $(this).attr("fnum");
		$(this).parent().parent().hide();
		var str = "";
		var delfile = $("#delfile").val();
		
		delfile += " "+fnum;
		
		$("#delfile").val(delfile);
	});
	
	
	$("#chkopen").click(function(){
		alert("s");
		var s =$("#chkopen").is(":checked") ;
		if(s){
			$("#bopen").val("1");
		}else{
			$("#bopen").val("0");
		}
	});
	
	openchk();
});

function openchk(){
	var a = $("#bopen").val();

	if(a==1){
		$("#chkopen").prop("checked",true);
	}else{
		$("#chkopen").prop("checked",false);
	}
}
</script>
</head>
<%
	String root = request.getContextPath();
	String bnum = request.getParameter("bnum");
	System.out.println(bnum);
	String pageNum = request.getParameter("pageNum");
	
	Cookie cookie = new Cookie("bnum",bnum);
	cookie.setPath("/");
	response.addCookie(cookie);
	
	session.setAttribute("bnum", bnum);
	
	BoardDao bdao = new BoardDao();
	BoardDto bdto = bdao.getWebHardData(bnum);
	
	MemberDao mdao = new MemberDao();
	MemberDto dto = mdao.getMember(bdto.getBnum());
	
	FileDao fdao = new FileDao();
	List<FileDto> flist = fdao.getCommuGetFilelist(bdto.getBnum());
%>
<body>
<div style="width:100%">
<div style="width:70%">
<h1 id="webh">WEBHARD_<span style="font-size: 13pt;">UPDATE</span></h1>
<hr id="webhr">
<form action="webhard/webhard_updateaction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="bnum" value="<%=bdto.getBnum()%>">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
<input type="hidden" name="num" value="<%=bdto.getNum() %>">
<input type="hidden" name="delfile" id="delfile" value="">
<input type="hidden" name="bopen" id="bopen" value="<%=bdto.getBopen()%>">

	<table class="table table-bordered" id="webhardupdatetable">
		<tr>
			<td>
				<input type="text" name="bsubject" id="bsubject" value="<%=bdto.getBsubject() %>">
			</td>
		</tr>
		<tr>
			<td>
				<textarea name="bcontent" id="bcontent"><%=bdto.getBcontent() %></textarea>
			</td>
		</tr>
		<tr>
			<td>
			<input multiple="multiple" type="file" name="file">
			</td>
		</tr>
		<%
			for(FileDto fdto : flist)
			{
				%>
				<tr>
					<td><%=fdto.getFilename()%>&nbsp;&nbsp;<a class="filedelete" bnum="<%=fdto.getBnum() %>" fnum="<%=fdto.getFnum() %>" href="#">삭제</a></td>
				</tr>
				<%
			}
		%>
		<tr>
		<%
			if(bdto.getBopen().equals("1")){%>
			<td>
				<input type="checkbox" id="chkopen" checked>비공개
			</td>
			<%}else{%>
			<td>
				<input type="checkbox" id="chkopen">비공개
			</td>							
			<%}
		%>
		</tr>
		<tr>
			<td>
				<button type="submit" id="updatebtn">UPDATE</button>
				<button type="button" onclick="location.href='<%=root%>/startmain.jsp?content=webhard/webhard_getData.jsp?bnum=<%=bnum%>&pageNum=<%=pageNum%>'" id="cancelbtn">CANCEL</button>
			</td>
		</tr>
	</table>
</form>
</div>
</div>
</body>
</html>