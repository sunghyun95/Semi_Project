<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dto.MessageDto"%>
<%@page import="intranet.dao.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
      #msglisthr{
   border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    margin-bottom: 2%;
    margin-top: 3%;
}
#msglist{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #8C8C8C;
}
</style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<%
   request.setCharacterEncoding("UTF-8");
   String mnum = request.getParameter("mnum");
   MessageDao msdao = new MessageDao();
   MessageDto msdto = msdao.getMessage(mnum);
   String pageNum=request.getParameter("pageNum");
   msdao.updateChecks(mnum);

   String message = request.getParameter("message");
   
   MemberDao mdao = new MemberDao();
   MemberDto mdto = mdao.getMember(msdto.getMwriter()); //보낸사람 정보
   MemberDto mdto2 = mdao.getMember(msdto.getMreader());//받는사람 정보
   
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (hh:MM)");
   String num = (String)session.getAttribute("num");
   String root = request.getContextPath();
   
%>


<script type="text/javascript">
var message = <%=message%>;
$(function(){
   $("#replyBtn").click(function(){
      window.open("message/sendMessage.jsp?writernum=<%=msdto.getMwriter()%>","","width=600px,height=365px,left=600px,top=100px");
   });
   
   $("#delbtn").click(function(){
         
         var mnum = $(this).attr("mnum");
         var num = <%=num%>;
         
         swal({
              title: "쪽지를 삭제하시겠습니까?",
              text: "삭제된 쪽지의 내용은 복원되지 않습니다",
              icon: "error",
              buttons: true,
              dangerMode: true,
            })
            .then(function(willDelete){
              if (willDelete) {
                 $.ajax({
                     type:"get",
                     url:"message/message_deleteaction.jsp",
                     dataType:"html",
                     data:{"mnum":mnum,"num":num},
                     success:function(){
                        if(message==1){
                           location.href="<%=root%>/startmain.jsp?content=message/message_fromlist.jsp?pageNum=<%=pageNum%>";
                        }else{
                           location.href="<%=root%>/startmain.jsp?content=message/message_tolist.jsp?pageNum=<%=pageNum%>";
                        }
                        
                     }
                  });
                
              } else {
                return;
              }
            });
         
      });
});
</script>
</head>
<body>
<div style=width:100%;>
<div style="width:70%;">
<%
      if(num.equals(msdto.getMwriter())){%>
<h1  id="msglist">MY MESSAGE<span style="color:pink">_</span><span style="font-size: 13pt; color:pink">FROM</span></h1>
<%}else{%>
<h1  id="msglist">MY MESSAGE<span style="color:pink">_</span><span style="font-size: 13pt; color:pink">TO</span></h1>

<%}%>
<br><br>
<hr id="msglisthr">
<table  style="width:50%; background-color: #F6F6F6; font-size: 15pt">
   <%
      if(num.equals(msdto.getMwriter())){%>
   <tr style="height: 50px; line-height: 50px">
      <th style="color:pink">FROM</th>
      <td style="font-size: 13pt"><%=mdto2.getName()%>(<%=mdto2.getId() %>)</td>
      <td style="font-size: 13pt; color:gray; text-align: right"><%=sdf.format(msdto.getMwriteday()) %></td>
   </tr>         
      <%}else{%>
   <tr  style="height: 50px; line-height: 50px">
      <th style="color:pink">TO</th>
      <td style="font-size: 13pt"><%=mdto.getName()%>(<%=mdto.getId() %>)</td>
      <td style="font-size: 13pt; color:gray; text-align: right"><%=sdf.format(msdto.getMwriteday()) %></td>
   </tr>         
      <%}%>
      
   <tr>
      <td colspan="3" style="height: 300px; background-color: white;"><pre><%=msdto.getMcontent() %></pre>
      </td>
   </tr>
   <tr style="height: 20px"></tr>
      <%
      if(num.equals(msdto.getMreader())){
         //from(내가 보냈어)
      %>
      <tr>
         <td colspan="3" style="text-align: center; border-radius: 5%;background-color: red;height: 40px;">
         <a href="#" id="replyBtn"  style="color:white;">ANSWER</a></td></tr>
         <tr style="height: 20px"></tr>
         <tr><td colspan="3" style="text-align: center; border-radius: 5%;background-color: green;height: 40px;">
         <a href="#" id="delbtn" style="color:white;" mnum="<%=msdto.getMnum()%>">DELETE</a>
         
         </td>
      
            
      </tr>            
      <%}else{%>
      <tr>
         <td colspan="3" style="text-align: center; border-radius: 5%;background-color: green;height: 40px;">
            <a href="#" id="delbtn" style="color:white;" mnum="<%=msdto.getMnum()%>">DELETE</a>
         </td>
      </tr>
      <%}
   %>
      
      <tr>
      </tr>
      <tr style="height: 20px"></tr>
      <tr>
         <td colspan="3" style="text-align: center; background-color: #3162C7;  border-radius: 5%;height: 40px;">
            <a href="#" onclick="history.back()" style="color:white;">LIST</a>
         </td>
      </tr>
   
</table>
</div>
</div>
</body>
</html>