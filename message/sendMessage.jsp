<%@page import="intranet.dao.MessageDao"%>
<%@page import="intranet.dto.MessageDto"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style>
#mcontent {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

#sendBtn {
  width: 100%;
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

#cancelbtn {
  width: 100%;
  background-color: #4561A3;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

#sendBtn:hover {
  background-color: #45a049;
}

#senddiv {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script type="text/javascript">
function cancel(){
   window.close();
}
</script>
</head>
<body>
<%
   request.setCharacterEncoding("UTF-8");
   
   String key = request.getParameter("key");
   String writernum = request.getParameter("writernum");
   
   String num = (String)session.getAttribute("num");
   MemberDao mdao = new MemberDao();
   MemberDto mdto = mdao.getMember(writernum);
   
   
   if(key == null||key.equals("")){%>
   
   
<h3>SEND MESSAGE</h3>

<div id="senddiv">
  <form action="sendMessage.jsp" method="post">
   <input type="hidden" name="key" value="1">
   <input type="hidden" name="writernum" value="<%=mdto.getNum()%>">
    <label for="fname"><b><%=mdto.getName() %>(<%=mdto.getId() %>)</b></label>
   <textarea name="mcontent" id="mcontent" autofocus="autofocus" ></textarea>

  <button type="submit" id="sendBtn">SEND</button>
  <button type="button" onclick="cancel();" id="cancelbtn">CANCEL</button>
  </form>
</div> 
   <%}else{
      
      String reader = request.getParameter("writernum");
      String mcontent= request.getParameter("mcontent");
      MessageDto msdto = new MessageDto();
      MessageDao msdao = new MessageDao();
   
      msdto.setMwriter(num);
      msdto.setMreader(reader);
      msdto.setMcontent(mcontent);
      
      msdao.insertMessage(msdto);
      
      %>
         <script type="text/javascript">
         swal("전송이 완료되었습니다.")
         .then(function(value){
            window.close();
         });
            
         </script>
      <%
   }%>
</body>
</html>