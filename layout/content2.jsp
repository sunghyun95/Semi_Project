<%@page import="intranet.dto.CommuDto"%>
<%@page import="intranet.dao.CommuDao"%>
<%@page import="intranet.dto.NoticeDto"%>
<%@page import="java.util.Vector"%>
<%@page import="intranet.dao.NoticeDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String root=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-------------------------반응형 --------------------------------  -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- -------------------------폰트 --------------------------------------- -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- ---------------------jquery,css 링크 ----------------------------------- -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<link rel="stylesheet" href="<%=root%>/css/content2.css" />

<title>content2</title>
<style type="text/css">
#noticetitle{
   color:blue;
   font-size:15pt;
}
#commutitle{
   color:orange;
   font-size:15pt;
}
</style>
<script type="text/javascript"> 
$(function(){
   
});

   imgslide(); //페이지가 로딩될때 함수를 실행합니다
   
   function imgslide(){

        $val = $("#slide").attr("val"); //현재 이미지 번호를 가져옵니다

        $mx = $("#slide").attr("mx"); //총 이미지 개수를 가져옵니다

          $("#img"+$val).hide();//현재 이미지를 사라지게 합니다.

         if( $val == $mx ){ $val = 1; } //현재이미지가 마지막 번호라면 1번으로 되돌립니다.

         else{ $val++; } //마지막 번호가 아니라면 카운트를 증가시켜줍니다

         $("#img"+$val).fadeIn('slow'); //변경된 번호의 이미지영역을 나타나게 합니다.괄호 안에 숫자는 페이드인 되는 시간을 나타냅니다. 

         $("#slide").attr('val',$val); //변경된 이미지영역의 번호를 부여합니다.

         setTimeout('imgslide()',1500); //1초 뒤에 다시 함수를 호출합니다.(숫자값 1000당 1초)

      }

   /* 현재 날짜와 현재 달에 1일의 날짜 객체를 생성합니다. */
   var date = new Date(); // 날짜 객체 생성
   var y = date.getFullYear(); // 현재 연도
   var m = date.getMonth(); // 현재 월
   var d = date.getDate(); // 현재 일

   var theDate = new Date(y,m,1);



   function back() {
      if(m==0){
         y=y-1; m=11;
         theDate = new Date(y,m,1);
      }else{
         m=m-1;
         theDate= new Date(y,m,1);
      }
      
      document.getElementById('ye').innerHTML = y+"년 "+(m+1)+"월";
      build();
   }

   function next() {
      if(m==11){
         y=y+1; m=1;
         theDate = new Date(y,m,1);
      }else{
         m=m+1;
         theDate= new Date(y,m,1);
      }
      
      document.getElementById('ye').innerHTML = y+"년 "+(m+1)+"월";
      build();
   }

   function build() {
      
      var theDay = theDate.getDay();

      var last = [31,28,31,30,31,30,31,31,30,31,30,31];

      if (y%4 && y%100!=0 || y%400===0) {
          lastDate = last[1] = 29;
      }


      var lastDate = last[m];

      var row = Math.ceil((theDay+lastDate)/7);
      
      var dNum = 1;
      calendar = ""
      for (var i=1; i<=row; i++) { // 행 만들기
          calendar += "<tr id='calendar-list3'>";
          for (var k=1; k<=7; k++) { // 열 만들기
              // 월1일 이전 + 월마지막일 이후 = 빈 칸으로!
              if(i===1 && k<=theDay || dNum>lastDate) {
                  calendar += "<td><div class='subcal1'>&nbsp;</div><div id='eq2' class='subcal'></div><div id='eq3' class='subcal'></div><div id='eq4' class='subcal'></div></td>";
              } else if(k==1) {
                  calendar += "<td><div class='subcal1' style='color: #FF0058;'>" + dNum + "</div><div id='eq2' class='subcal'></div><div id='eq3' class='subcal'></div><div id='eq4' class='subcal'></div></td>";
                  dNum++;
              } else if(k==7){
                 calendar += "<td><div class='subcal1' style='color: #0990B3;'>" + dNum + "</div><div id='eq2' class='subcal'></div><div id='eq3' class='subcal'></div><div id='eq4' class='subcal'></div></td>";
                  dNum++;
              } else {
                 calendar += "<td><div class='subcal1' style='color: black;'>" + dNum + "</div><div id='eq2' class='subcal'></div><div id='eq3' class='subcal'></div><div id='eq4' class='subcal'></div></td>";
                  dNum++;
              }
          }
          calendar += "</tr>";
         
      }
       
      $("#calendar3").html(calendar);
      
   }

   $(function() {
      document.getElementById('ye').innerHTML = y+"년 "+(m+1)+"월";
      build();
   });



</script>
</head>
<body>
   <div id="content-back">
   
      <!----------------------슬라이드------------------------------  -->
      <div id="slide" val="1" mx="4">
         <div id="img1">
            <img src="<%=root%>/images/slide1.jpg">
         </div>
         <div id="img2">
            <img src="<%=root%>/images/slide2.jpg">
         </div>
         <div id="img3">
            <img src="<%=root%>/images/slide3.jpg">
         </div>
         <div id="img4">
            <img src="<%=root%>/images/slide4.jpg">
         </div>
      </div>
   
   
   <div id="content2-list" align="center">
      
   
   
   <div class="main-block"></div>
   
   <div id="content-list2">
   
      <table id="con">
         <tr>
            <th rowspan="2" id="con-he"><a href="<%=root%>/startmain.jsp?content=cal/calender.jsp">
               
               <div onload="bluild();">
                  <table id="calendar" style="border-radius: 10px;">
                     <thead id="calendar-head">
                     <tr>
                        <td id='calender-back' onclick="back()" colspan="2"><</td>
                        <td style="text-align: center; color: #FF0058;" id='ye'
                           colspan='3'>yyyy년 xx월</td>
                        <td id='calendar-next' onclick="next()" colspan="2">></td>
                     </tr>
                     <tr>
                        <td><font color='#FF0058'>일</font></td>
                        <td><font color='black'>월</font></td>
                        <td><font color='black'>화</font></td>
                        <td><font color='black'>수</font></td>
                        <td><font color='black'>목</font></td>
                        <td><font color='black'>금</font></td>
                        <td><font color='#0990B3'>토</font></td>
                     </tr>
                     </thead>
                     <tbody id="calendar3">
   
                     </tbody>
                  </table>
               </div>
            
            </a></th>
            
            <td>
               <table id="notice-1" style="border-radius: 10px;">
                  <tr id="notice-2">
                     <td><font size="2.5px">공지사항</font>
                     <a href="<%=root%>/startmain.jsp?content=notice/noticeform.jsp" style="float:right;color:black;margin-right: 5%;">더보기</a>
                     <hr></td>
                  </tr>
                  <tr>
                     <td>
                        <div class="conlist">
                           <%
                              NoticeDao ndao = new NoticeDao();
                              int start=1;
                              int end=5;
                              List<NoticeDto> nlist = ndao.getAllNotice(null, null, start, end);
                           %>
                           <ul>
                           <%
                              for(NoticeDto ndto : nlist){%>
                              <li class="noticetitle"><font size="2px"color="#0990B3"><b><%=ndto.getBoardtype().equals("1")?"공지사항":null %></b></font><font size="2px">&nbsp;&nbsp;<%=ndto.getBsubject() %></font></li>                  
                              <%}
                           %>
                           </ul>
                        </div>
                     </td>
                  </tr>
            </table>
         </td>
      </tr>
      <tr>
         <td>
            <table id="commu-1" style="border-radius: 10px;">
               <tr id="commu-2" style="height: 25%;">
                  <td><font size="2.5px">커뮤니티</font>
                  <a href="<%=root%>/startmain.jsp?content=community/community.jsp" style="float:right;color:black;margin-right: 5%;">더보기</a>
                     <hr></td>
               </tr>
               <tr>
                  <td>
                     <div class="conlist">
                     <%
                        CommuDao cdao = new CommuDao();
                        start = 1;
                        end = 5;
                        List<CommuDto> clist = cdao.commuList(null, null, start, end);
                     %>
                     <ul>
                     <%
                        for(CommuDto cdto : clist){%>
                        <li class="commutitle"><font size="2px" color="#0990B3"><b><%=cdto.getBoardtype().equals("6")?"커뮤니티":null %></b></font><font size="2px">&nbsp;&nbsp;<%=cdto.getBsubject() %></font></li>                  
                        <%}
                        %>
                        </ul>
                     </div>
                  </td>
               </tr>
            </table>
            
            
   
            
            </td>
         </tr>      
      </table>
      
   </div>
</div>
   
   
   
</div> 
</body>
</html>



















