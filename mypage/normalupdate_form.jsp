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
</script>

</head>
<%
   String bnum = request.getParameter("bnum");
   NoticeDao dao= new NoticeDao();
   NoticeDto dto = dao.getData(bnum);
   FileDao fdao = new FileDao();
   FileDto fdto = fdao.getBnumFile(bnum);
%>
<body>
<h1>공지사항 수정</h1>
<form action="mypage/normalupdate_action.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=dto.getNum()%>">
<table border="1">
<tr>
   <td rowspan="4"><img id="blah" src="notice/<%=fdto.getFilename()%>" style="max-width: 200px;" /></td>
   <th>제목</th>
   <td><input type="text" name="bsubject" value="<%=dto.getBsubject()%>"></td>
</tr>
<tr>
   <th>내용</th>
   <td><textarea name="bcontent"value="<%=dto.getBcontent()%>"></textarea></td>
</tr>
<tr>
   <th>파일첨부</th>
   <td><input type="file" name="photo" style="width: 250px;"
       onchange="readURL(this)" ></td>
</tr>
<tr>
   <td colspan="2">
      <!-- hidden -->
      <input type="hidden" name="bnum" value="<%=dto.getBnum()%>">
      <button type="submit">수정하기</button>
   </td>
</tr>
</table>
</form>

</body>
</html>