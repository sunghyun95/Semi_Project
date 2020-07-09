<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#ins{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #FF0058;
}
#inshr{
    border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #FF0058, #f0f0f0);
    margin-bottom: 2%;
}

#accbtn{
   background-color: #FF0058; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:left;
}
#sample6_jehyuname, #sample6_postcode, #sample6_address,#sample6_detailAddress,#sample6_jehyucontent {
  width: 500px;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
}

#sample6_jehyucontent {
   height:200px;
}
#webhardinserttable{
   margin-top:2%;
}

#webhardForm{
   box-shadow:;
}

</style>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=475f9789374794eac2c525a1bb477d09&libraries=services"></script>

<script>
$(function(){
   $("#sample6_detailAddress").focusout(function(){
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
           level: 3 // 지도의 확대 레벨
       };  

   // 지도를 생성합니다    
   var map = new kakao.maps.Map(mapContainer, mapOption); 

   // 주소-좌표 변환 객체를 생성합니다
   var geocoder = new kakao.maps.services.Geocoder();

   // 주소로 좌표를 검색합니다
   geocoder.addressSearch($("#sample6_address").val(), function(result, status) {

       // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {

           var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

           document.getElementById("sample6_wido").value = result[0].y;
           document.getElementById("sample6_gyungdo").value = result[0].x;
           // 결과값으로 받은 위치를 마커로 표시합니다
           var marker = new kakao.maps.Marker({
               map: map,
               position: coords
           });

           // 인포윈도우로 장소에 대한 설명을 표시합니다
           var infowindow = new kakao.maps.InfoWindow({
               content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
           });
           infowindow.open(map, marker);

           // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
           map.setCenter(coords);
       } 
   });    
   });
});


    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                var wido='';
                var gyungdo='';

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<%
   String root=request.getContextPath();
%>
</head>
<body>

<div style="width: 100%;">
   <div style="width: 70%;">
   
   
<h1 id="ins">WELFARE_<span style="font-size: 13pt">INSERT</span></h1>

<hr id="inshr">
<form action="<%=root %>/welfare/addaction.jsp" method="post">
<table>
   <tr>
      <td style="width:50%;">
         <input type="text" id="sample6_jehyuname" name="sample6_jehyuname" placeholder="제휴업체">
<br><br>
<input type="text" id="sample6_postcode" name="sample6_postcode" placeholder="우편번호">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample6_address" name="sample6_address" placeholder="주소"><br>
<input type="text" id="sample6_detailAddress" name="sample6_detailAddress" placeholder="상세주소">

<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
<input type="hidden" id="sample6_wido" name="sample6_wido">
<input type="hidden" id="sample6_gyungdo" name="sample6_gyungdo">
<br><br>
<p style="margin-top:-12px">
    <em class="link">
        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
            혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
        </a>
    </em>
</p>


<br><br>
<textarea id="sample6_jehyucontent" name="sample6_jehyucontent" placeholder="제휴혜택"></textarea>

      </td>
      
      <td style="width:50%;">
         <div id="map" style="width:100%;height:500px;float:right;"></div>
      </td>
   </tr>
   <tr>
   <td colspan="2"><button id="accbtn" type="submit">accept</button></td>
   </tr>

</table>



</form>

</div>
</div>

</body>
</html>