<%@page import="intranet.dto.DiaryDto"%>
<%@page import="intranet.dao.DiaryDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#csubject,#startdate,#enddate,#diarytype, #dcontent {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

#calsubmit {
  width: 100%;
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

#cancelBtn {
  width: 100%;
  background-color: #4561A3;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}


#calsubmit:hover {
  background-color: #45a049;
}



#caldiv {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
</head>
<body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<%
   request.setCharacterEncoding("UTF-8");
   String key = request.getParameter("key");
   String num = (String)session.getAttribute("num");
   
   MemberDao mdao = new MemberDao();
   
   MemberDto mdto = mdao.getMember(num);
%>

<%if(key==null){
   String date = request.getParameter("date");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   String year;
   String month;
   String day;
   
   int idx = date.lastIndexOf("월");
   
   year = date.substring(0,4);
   
   month = date.substring(date.lastIndexOf("년")+2,date.lastIndexOf("월"));
   
   if(month.length()==1){
      month = "0"+month;
   }
   
   day = date.substring(date.lastIndexOf("월")+1,date.length());      
   
   if(day.length()==1){
      day = "0"+day;
   }
   
//   System.out.println(year+","+month+","+day);

String startday =year+month+day;
   
   System.out.println(startday);
%>
<script type="text/javascript">
   
   $(function(){
      
      
      $("#startdate").change(function(){
         var date = $("#startdate").val();
         $("#start").val(date);
      });
});

   function cancel(){
      window.close();
   }
   
   
</script>


<h3>INSERT SCHEDULE</h3>

<div id="caldiv">
  <form action="calendar_writeform.jsp" method="post">
  <input type="hidden" name="key" value="1">
    <label for="country">SCHEDULE TYPE</label>
    
    <select id="diarytype" name="diarytype">
      <%
               if(mdto.getBuseo().equals("인사팀")||mdto.getGrade().equals("부장")||mdto.getName().equals("관리자")){%>
            <option value="회사">회사일정</option>                  
               <%}
   
            if(mdto.getGrade().equals("부장")||mdto.getGrade().equals("팀장")){%>
            <%
               if(mdto.getBuseo().equals("개발팀")){%>
               <option value="개발팀">개발팀</option>                              
               <%}else if(mdto.getBuseo().equals("인사팀")){%>
               
               <option value="인사팀">인사팀</option>                              
                  
               <%}else{%>
               <option value="디자인팀">디자인팀</option>      
               <%}
            }
            %>
            <option value="개인">개인일정</option>

    </select>
  
     <label for="lname">SHEDULE NAME</label>
     <input type="text" name="dsubject" id="csubject">
    <label for="fname">START DATE</label>
    <input type="date" id="startdate" name="startdate">

    <label for="lname">END DATE</label>
    <input type="date" id="enddate" name="enddate">
   
   <label for="lname">CONTENT</label>
     <textarea id="dcontent" name="dcontent"></textarea>   
    <input type="submit" id="calsubmit" value="SAVE">
    <button type="button" id="cancelBtn" onclick="cancel();">CANCEL</button>
  </form>
</div>
   <%}else{
      
      SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
      Date time = new Date();
   
      String diarytype = request.getParameter("diarytype");
      String startdate = request.getParameter("startdate");
      String enddate = request.getParameter("enddate");
      String dcontent = request.getParameter("dcontent");
      String dsubject = request.getParameter("dsubject");
      String now = sdf2.format(time);
      
      System.out.println("startdate:"+startdate);
      System.out.println("enddate:"+enddate);
      
      
      int nowtime = Integer.parseInt(now);
      
      String[] startarr = startdate.split("-");
      String[] endarr = enddate.split("-");
      
      String startstr = startarr[0]+startarr[1]+startarr[2];
      String endstr = endarr[0]+endarr[1]+endarr[2];
      
      System.out.println("startstr:"+startstr);
      System.out.println("endstr:"+endstr);
      
      
      
      int starttime = Integer.parseInt(startstr);
      
      System.out.println("nowtime:"+nowtime);
      System.out.println("starttime:"+starttime);
      
      
      if(nowtime > starttime){%>
         <script type="text/javascript">
         swal("추가 실패!","현재보다 이전 날짜는 시작날짜로 설정할 수 없습니다","warning")
         .then(function(value){
            history.back();
         });
            </script>
      <%}else{
      int endtime = Integer.parseInt(endstr);
      System.out.println("endtime:"+endtime);
      if(starttime > endtime){%>
         <script type="text/javascript">
         swal("추가 실패!","끝날짜는 시작날짜보다 이전날짜로 설정할 수 없습니다","warning")
         .then(function(value){
            history.back();
         });
            
         </script>
      <%}else{
         DiaryDao ddao = new DiaryDao();
         
         DiaryDto ddto = new DiaryDto();
         
         ddto.setNum(num);
         ddto.setStartdate(startdate);
         ddto.setEnddate(enddate);
         ddto.setDsubject(dsubject);
         ddto.setDcontent(dcontent);
         ddto.setDiarytype(diarytype);
         
         ddao.insertDiary(ddto);
      %>
      <script type="text/javascript">
      swal("추가 완료!","일정 추가가 완료되었습니다!","success")
      .then(function(value){
    	  opener.location.reload();    	  
         window.close();
         
      });
         
      </script>
      <%
            
      }
         
      }
      
      
      
   }%>
</body>
</html>