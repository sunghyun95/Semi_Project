<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dao.DiaryDao"%>
<%@page import="intranet.dto.DiaryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	String num = (String) session.getAttribute("num");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link rel="stylesheet" href="<%=root%>/css/calender.css" />

<!-- -------------------달력 ---------------------------------------- -->
<style type="text/css">
#calendar {
	width: 100%;
	height: 200px;
}

#calendar td,#calendar3 td {
	text-align: center;
	font-size: 20px;
	font-family: 바탕;
	border: 2px solid #787878;
	border-radius: 8px;
}

#calender-back, #calendar-next {
	width: 28.5%;
}

#calendar4 {
	width: 100%;
	height: 600px;
}

.eq1 {
	font-size: 16px;
	text-align: right;
	height: 20%;
}

.subcal1, .subcal2, .subcal3 {
	height: 20%;
}

.subcal1back {
	background-color: skyblue;
	font-weight:bold;
}

.subcal2back {
	background-color: yellow;
	font-weight:bold;
}

.subcal3back {
	background-color: #66FF99;
	font-weight:bold;
}
</style>

<script type="text/javascript">
	var listdate=[];
	var num =<%=num%>;
	var strarray = [];
	var str = "";
	var count = 0;
	/* 현재 날짜와 현재 달에 1일의 날짜 객체를 생성합니다. */
	var date = new Date(); // 날짜 객체 생성
	var y = date.getFullYear(); // 현재 연도
	var m = date.getMonth(); // 현재 월
	var d = date.getDate(); // 현재 일

	var theDate = new Date(y, m, 1);

	var str1 = "";
	var str2 = "";

	function back() {
		if (m == 0) {
			y = y - 1;
			m = 11;
			theDate = new Date(y, m, 1);

		} else {
			m = m - 1;
			theDate = new Date(y, m, 1);

		}

		document.getElementById('ye').innerHTML = y + "년 " + (m + 1) + "월";
		build();
	}

	function next() {
		if (m == 11) {
			y = y + 1;
			m = 1;
			theDate = new Date(y, m, 1);
		} else {
			m = m + 1;
			theDate = new Date(y, m, 1);
		}

		document.getElementById('ye').innerHTML = y + "년 " + (m + 1) + "월";
		build();
	}

	function build() {
		
		var theDay = theDate.getDay();

		var last = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

		if (y % 4 && y % 100 != 0 || y % 400 === 0) {
			lastDate = last[1] = 29;
		}

		var lastDate = last[m];

		var row = Math.ceil((theDay + lastDate) / 7);

		var dNum = 1;
		calendar = "<table id='calendar4'>"

		for (var i = 1; i <= row; i++) { // 행 만들기
			calendar += "<tr>";
			for (var k = 1; k <= 7; k++) { // 열 만들기
				// 월1일 이전 + 월마지막일 이후 = 빈 칸으로!
				if (i === 1 && k<=theDay || dNum>lastDate) {
					calendar += "<td><div class='eq1'>&nbsp;</div><div id='eq2' class='subcal1'></div><div id='eq3' class='subcal2'></div><div id='eq4' class='subcal3'></div></td>";
				} else {
					
					calendar += "<td style='width:14.1%'><div id="+dNum+" class='eq1' value="+dNum+">"+dNum+"</div><div id='eq2' class='subcal1'></div><div id='eq3' class='subcal2'></div><div id='eq4' class='subcal3'></div></td>";
					dNum++;
				}
			}
			calendar += "</tr>";
		}

		calendar += "</table>";
		$("#calendar3").html(calendar);

		
		$.ajax({
			type : "post",
			url : "cal/calendar_action.jsp",
			dataType : "json",
			success : function(data) {

				$.each(data, function(i, item) {
					
					getDateRange(item.startdate, item.enddate, listdate);
		
					for (var i = 0; i < listdate.length; i++) {
						
						strarray = listdate[i].split('-');
						str = strarray[0] + "년 " + parseInt(strarray[1]) + "월";
						var titlemonth = $("#ye").text();

						if (str == titlemonth) {
							
							if (item.diarytype == "개인") {
								if (item.num == num) {
									$("#" + parseInt(strarray[2]) + "").next().next().next().addClass("subcal3back");
									$("#" + parseInt(strarray[2]) + "").next().next().next().html("<span class='dsubject' dnum='"+item.dnum+"'></span>");										
									
									if(item.startdate==listdate[i]){
									$("#" + parseInt(strarray[2]) + "").next().next().next().html("<span class='dsubject' dnum='"+item.dnum+"'style='color:white;'>"+item.dsubject+"</span>");										
									}
									
								}
							} else {
								if (item.diarytype == "회사") {
									$("#" + parseInt(strarray[2]) + "").next().addClass("subcal1back");
									$("#" + parseInt(strarray[2]) + "").next().html("<span class='dsubject dnum='"+item.dnum+"'></span>");										
									
									if(item.startdate==listdate[i]){
									$("#" + parseInt(strarray[2]) + "").next().html("<span class='dsubject' dnum='"+item.dnum+"' style='color:white;'>"+item.dsubject+"</span>");										
									}
								} else {
									if (item.diarytype == item.buseo) {
										$("#" + parseInt(strarray[2]) + "").next().next().addClass("subcal2back");
										$("#" + parseInt(strarray[2]) + "").next().next().html("<span class='dsubject' dnum='"+item.dnum+"'></span>");										
										
										if(item.startdate==listdate[i]){
										$("#" + parseInt(strarray[2]) + "").next().next().html("<span class='dsubject' dnum='"+item.dnum+"' style='color:white;'>"+item.dsubject+"</span>");										
										}
									}

								}
							}

						}
					}
						listdate=[];
					
					
				});
			}
		});
		
		
	}

	$(function() {
		document.getElementById('ye').innerHTML = y + "년 " + (m + 1) + "월";
		build();

		$(document).on("click","div.eq1",function() {
							str1 = $("#calendar").children().children().find("#ye").text();

							str2 = $(this).text();

							var date = str1 + str2;

							window.open("cal/calendar_writeform.jsp?date="+ date + "", "","width=600px,height=650px,left=600px,top=100px");

						});
		
		$(document).on("click","span.dsubject",function(){
			var dnum = $(this).attr("dnum");
			window.open("cal/calendar_select.jsp?dnum="+dnum+"","","width=600px,height=650px,left=600px,top=100px");

		});
	});

	function getDateRange(startDate, endDate, listDate)

	{

		var dateMove = new Date(startDate);

		var strDate = startDate;

		if (startDate == endDate)

		{

			var strDate = dateMove.toISOString().slice(0, 10);

			listDate.push(strDate);

		}

		else

		{

			while (strDate < endDate)

			{

				var strDate = dateMove.toISOString().slice(0, 10);

				listDate.push(strDate);

				dateMove.setDate(dateMove.getDate() + 1);

			}

		}
		return listDate;

	};
</script>
<title>calender</title>

</head>

<body>
<div style="width:100%;">
	<div style="width:70%;">
	<h1>SCHEDULE / DIARY</h1>
	<!-- ---------------main -----------------------------------------  -->
	<div onload="build();">
		<table id="calendar">
			<tr>
				<td id='calender-back' onclick="back()" colspan="2"><</td>
				<td align='center' id='ye' colspan='3' style="font-weight:bold; color:pink;">yyyy년 xx월</td>
				<td id='calendar-next' onclick="next()" colspan="2">></td>
			</tr>
			<tr>
				<td><font color='red'>일</font></td>
				<td><div>월</div></td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td><font color='blue'>토</font></td>
			</tr>
		</table>

		<div id="calendar3"></div>
	</div>
	</div>
	</div>
</body>
</html>

























