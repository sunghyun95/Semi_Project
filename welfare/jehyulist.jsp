<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dto.JehyuDto"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dao.JehyuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>


<title>제휴업체 목록</title>
<style type="text/css">
#list td{
    text-align: center;
}
#welhr{
    border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    margin-bottom: 2%;
}
#wel{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #FF0058;
}
.btn{
   cursor: pointer;
}
#insert{
   float: right;
   margin-right: 2%;
   font-size: 15pt;
   color: #FF0058;
}
.subtr{
   font-size: 14pt;
}
</style>
</head>
<body>
<div style="width:100%;">
	<div style="width:70%;">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=475f9789374794eac2c525a1bb477d09"></script>
<%
   String root = request.getContextPath();
   request.setCharacterEncoding("UTF-8");
   String num=(String)session.getAttribute("num");
   JehyuDao dao = new JehyuDao();
   MemberDao mdao=new MemberDao();
   MemberDto mdto=mdao.getMember(num);
   List<JehyuDto> list = dao.getAllJehyu();

%>

<h1 id="wel">WELFARE LIST</h1>
<%
        if(mdto.getName().equals("관리자"))
        {%>
               
      <a href="<%=root %>/startmain.jsp?content=welfare/jehyuinsert.jsp"  id="insert" >INSERT</a><br><br>
       <%}
         
         %>
<hr id="welhr">
<!-- <div id="map" style="width:100%;height:350px;"></div>
 -->
 <div style="display:inline-block;">
<div style=" float:left; width:55%;">
   <table id="list">
      <tr class="subtr">
         
         <th style="width:10%; text-align: center;" id="jhname">제휴업체</th>
         <th style="width:10%; text-align: center;" id="jhaddr">주소</th>
         <th style="width:10%; text-align: center;" id="jhcontent">혜택</th>
         <th style="width:10%; text-align: center;">위치</th>
         <%
            if(mdto.getName().equals("관리자"))
            {%>
               
         <th style="width:10%; text-align: center;" id="writeday">등록일</th>
         <th style="width:5%; text-align: center;"></th>
            <%}
         
         %>
      </tr>
      <%
      
   
      
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      
      for(JehyuDto dto2: list)
      {%>
         <tr>
         
         <td><b><%=dto2.getJhname()%></b></td>
         <td><%=dto2.getJhaddr()%></td>
         <td><%=dto2.getJhcontent()%></td>
         <td><span class="btn" wido="<%=dto2.getWido()%>" gyungdo="<%=dto2.getGyungdo()%>"> 보기</span></td>
         <%
            if(mdto.getName().equals("관리자"))
            {%>
               
         <td><%=sdf.format(dto2.getWriteday())%></td>
         <td align="center">
         <a href="welfare/deleteaction.jsp?num=<%=dto2.getNum()%>"
            style="cursor:pointer; color:black">DELETE</a>
         </td>
             <%}
         
         %>
         </tr>
         
      <%}
      %>
   </table>
</div>
<div  id="map" style=" height:500px; width: 44%; float:left; "></div>
</div>
<script>    
// 이미지 지도에 표시할 마커입니다
// 이미지 지도에 표시할 마커를 아래와 같이 배열로 넣어주면 여러개의 마커를 표시할 수 있습니다 
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(<%=list.get(0).getWido()%>, <%=list.get(0).getGyungdo()%>), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 title 객체 배열입니다 
var positions = [
   <%
         for(int i=0; i<list.size(); i++){
            if((list.size()-1)==i){
               %>
                  {
                   title: '<%=list.get(i).getJhname()%>', 
                    latlng: new kakao.maps.LatLng(<%=list.get(i).getWido()%>, <%=list.get(i).getGyungdo()%>)
   
                     
                  }
               <%
            }else{
               %>
               {
                  title: '<%=list.get(i).getJhname()%>', 
                   latlng: new kakao.maps.LatLng(<%=list.get(i).getWido()%>, <%=list.get(i).getGyungdo()%>)
        
                 },
               <%
            }
         }
   %>
];

// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
    
    $(function(){
       
       
       $(".btn").click(function(){
          var wido = $(this).attr("wido");
          var gyungdo = $(this).attr("gyungdo");
          
          panTo(wido,gyungdo);
       });
    });
    
    function panTo(wido,gyungdo) {
        // 이동할 위도 경도 위치를 생성합니다 
        var moveLatLon = new kakao.maps.LatLng(wido, gyungdo);
        
        // 지도 중심을 부드럽게 이동시킵니다
        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
        map.panTo(moveLatLon);  
       }      
   
}
</script>
</div>
</div>
</body>
</html>