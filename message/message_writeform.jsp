<%@page import="java.util.List"%>
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
#mreader,#mcontent {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

#sendbtn {
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


#sendbtn:hover {
  background-color: #45a049;
}

#mboard,#members {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script type="text/javascript">
var str ="";
var valstr = "";
$(function(){
   $("#mreader").change(function(){
      var s1 = $(this).val(); // 선택된 option의 value 값
      
      valstr+=s1+" ";
      
      $("#writernum").val(valstr);
      
      var s3=$(":selected").text(); //선택된 option의 텍스트
       str +=s3+" ";
      
      $("#members").html("<label>"+str+"</label>");
      
   });
});

function cancel(){
   window.close();
}


</script>
</head>
<body>
<%
   request.setCharacterEncoding("UTF-8");
   
   String key = request.getParameter("key");
   
   String num = (String)session.getAttribute("num");
   MemberDao mdao = new MemberDao();
   List<MemberDto> mlist = mdao.getMemberList();
   
   if(key == null||key.equals("")){%>
   
   <h3>SEND MESSAGE</h3>

<div id="mboard">
  <form action="message_writeform.jsp" method="post">
     <input type="hidden" name="key" value="1">
   <input type="hidden" name="writernum" id="writernum" value="">
    <select id="mreader" name="mreader">
     <option></option>
               <%
                  for(MemberDto mdto : mlist){
                 	 if(!num.equals(mdto.getNum())&&mdto.getId().length()==5){%>
                     <option value="<%=mdto.getNum()%>"><%=mdto.getName() %>(<%=mdto.getId() %>)</option>
                 	 <%}
                  }
               %>
    </select>
     <div id="members">
   </div>
   
    <label for="fname">CONTENT</label>
    <textarea name="mcontent" id="mcontent" autofocus="autofocus"></textarea>

    <button type="submit" id="sendbtn">SEND</button>
   <button type="button" onclick="cancel();" id="cancelbtn">CANCEL</button>
  </form>
</div>
   
   <%}else{
      
      String reader = request.getParameter("writernum");
      System.out.println(reader);
      reader = reader.trim();
      
      String[] arr = reader.split(" ");
      
      String mcontent= request.getParameter("mcontent");
      
      MessageDao msdao = new MessageDao();
      
      for(String s : arr){
       
      
      MessageDto msdto = new MessageDto();
      
      msdto.setMwriter(num);
      msdto.setMreader(s);
      msdto.setMcontent(mcontent);
      
      msdao.insertMessage(msdto);
      
      }
      %>
         <script type="text/javascript">
         swal("전송 완료!", " ","success")
         .then(function(value){
            window.close();
         });
            
            
         </script>
      <%
   }%>

</body>
</html>