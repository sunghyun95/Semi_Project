<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dto.DiaryDto"%>
<%@page import="intranet.dao.DiaryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#fname,#fstartdate,#fenddate,#fcontent {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

#delbtn {
  width: 100%;
  background-color: red;
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


#delbtn:hover {
  background-color: #45a049;
}



#deldiv {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
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
   DiaryDao ddao = new DiaryDao();
   
   if(key==null){
      String dnum = request.getParameter("dnum"); 
      DiaryDto ddto = ddao.getDiary(dnum);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd [HH:mm]");
      MemberDao mdao = new MemberDao();
      MemberDto mdto = mdao.getMember(ddto.getNum());
   %>
   
   <h3>SELECT SCHEDULE</h3>

<div id="deldiv">
    <b><%=mdto.getBuseo()%> <%=mdto.getName() %>(<%=mdto.getId() %>)</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <label style="float:right; color:blue;"><%=sdf.format(ddto.getDwriteday()) %></label>
    <br><br>
      <b>SCHEDULE NAME</b>
    <input type="text" id="fname" name="firstname" readonly="readonly" value="<%=ddto.getDsubject() %>">
      <b>START DATE</b>
    <input type="text" id="fstartdate" name="firstname" readonly="readonly" value="<%=ddto.getStartdate() %>">
      <b>END DATE</b>
    <input type="text" id="fenddate" name="firstname" readonly="readonly" value="<%=ddto.getEnddate() %>">
    <b>CONTENT</b>
    <pre id="fcontent"><%=ddto.getDcontent() %></pre>
     <form action="calendar_select.jsp" method="post">
   <input type="hidden" name="dnum" value="<%=ddto.getDnum() %>">
   <input type="hidden" name="key" value="1">               
   <button type="submit" id="delbtn">DELETE</button>
   </form>
   <button type="button" id="cancelbtn" onclick="cancel();">CANCEL</button>
</div>
   
   
   <%}else{
      String dnum = request.getParameter("dnum");
      
      ddao.deleteDiary(dnum);
      %>
      <script type="text/javascript">
      swal("삭제 완료!","일정 삭제가 완료되었습니다!","success")
      .then(function(value){
    	  opener.location.reload();    
         window.close();
      });
         
      </script>
      <%
   }
   
%>


</body>
</html>