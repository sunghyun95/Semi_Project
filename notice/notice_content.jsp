<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dto.NoticeDto"%>
<%@page import="intranet.dao.NoticeDao"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
<head>
<style type="text/css">

#noticeback{
	font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #000054;
}

#noticeback hr{
	border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    margin-bottom: 2%;
}

#not-ta th{
	font-size: 19px;
}

#not-ta td{
	font-style: 14px;
}

#contentsub{
	height: 30px;
}

#upbtn2{
	background-color: #008CBA;
	border: none;
	color: white;

	text-align: center;
	text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    float: right;
    margin-right: 20px;
    width: 60px;
    height: 35px;
}



.contentback{
	background-color: #555555;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    float: right;
}

.contentdel{
	background-color: #f44336;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    float: right;
}

.contentup{
	    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    float: right;
}

</style>
</head>
<%
   //num 읽기
   String mypage = request.getParameter("mypage");
   String bnum=request.getParameter("bnum");
   String num=(String)session.getAttribute("num");
   String pageNum=request.getParameter("pageNum");
   System.out.println(pageNum);
   
   //dao 선언
   NoticeDao db = new NoticeDao();
   MemberDao mdao = new MemberDao();
   FileDao fdao = new FileDao();
   //db로부터 num에 해당하는 dto 받기
   NoticeDto dto=db.getData(bnum);
   MemberDto mdto = mdao.getMember(dto.getNum());
   MemberDto mdto2=mdao.getMember(num);
   
   FileDto fdto = fdao.getBnumFile(bnum);
   
   //simple date 선언(년-월-일 시:분)
   SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>
<%
      String root=request.getContextPath();
      %>
<body>
<script type="text/javascript">

$(function(){
   
   $("#upbtn2").click(function(){
      
   $.ajax({
      type:"get",
      url:"notice/notice_upbnotice.jsp",
      dataType:"html",
      data:{"bnum":<%=bnum%>},
      success:function(data){
         swal("공지 추가!", "공지로 올리기 완료하였습니다", "success");
         
         
      },
   })   
   });
});

</script>
<div style="width:100%;">
	<div style="width:70%;">
	
	
<div id="noticeback" align="left" >
   <span style="text-align: left;">NOTICE</span>
   <hr>
</div>
<%
   //이미지가 실제 저장되어있는 경로구하기
   String saveFolder=getServletContext().getRealPath("/notice");
   //파일명
   String fileName=saveFolder+"\\"+fdto.getFilename();
   //File 생성
   File file=new File(fileName);
   //파일 사이즈(byte)
   long size=file.length();

%>
<table id="not-ta" style="width: 100%; text-align: left;">
<tr style=" ">
   <th id="contentnotice" style="width: 10%;">작성자</th>
   <td id="contentsub" style="width: 30%;"><%=mdto.getName()%></td>
   <td rowspan="5" style=" width: 70%;">
      <%
            //이미지가 실제 존재할 경우에만 이미지를 출력한다
            if(file.exists())
            {
            %>
               <img style="width: 100%; height: 400px;" src="<%=root %>/notice/<%=fdto.getFilename()%>"
               >
            <%}else{ %>
               <img style="width: 100%; height: 400px;" src="http://placehold.it/180">
               <%}%>
   </td>
</tr>
<tr style="height: 50px; ">
   <th id="contentnotice">작성일</th>
   <td id="contentsub"><%=dto.getBwriteday().toString().substring(0,10)%></td>
</tr>
<tr style=" height: 50px;">
   <th id="contentnotice">조회</th>
   <td id="contentsub"><%=dto.getBreadcount()%></td>
</tr>
<tr style=" height: 50px;">
   <th id="contentnotice">제목</th>
   <td id="contentsub"><%=dto.getBsubject()%>&nbsp;&nbsp;
   <%
   	if(dto.getNum().equals(num)||mdto2.getGrade().equals("관리자")){%>
      <button name="upbtn" id="upbtn2" >맨 위로</button></td>   		
   	<%}
   %>
</tr>
<tr style="height: 100px; ">
   <th id="contentnotice">내용</th>
   <td id="contentsub"><pre><%=dto.getBcontent()%></pre></td>
</tr>

      
      <tr>
         <td colspan="3" align="center" id="contentsub">
            <!-- 수정 버튼 -->
            <%if(dto.getNum().equals(num) || mdto2.getName().equals("관리자"))
            {
            %>
            <button type="button" id="contentbtn" class="contentup"
             onclick="location.href='<%=root%>/startmain.jsp?content=notice/notice_updateform.jsp?bnum=<%=dto.getBnum()%>&pageNum=<%=pageNum%>'">UPDATE</button>
            
            <!-- 삭제 버튼 -->
            <button type="button" id="contentbtn" class="contentdel"
             onclick="location.href='notice/notice_deleteaction.jsp?bnum=<%=dto.getBnum()%>&pageNum=<%=pageNum%>'">DELETE</button>
            <!-- 목록 버튼 -->
            <%}%>
            
            <%
            if(mypage==null){%>
            <button type="button"  id="contentbtn" class="contentback"
             onclick="location.href='<%=root%>/startmain.jsp?content=notice/noticeform.jsp?pageNum=<%=pageNum%>'">BACK</button>         
               
             <%} else{
                if(mypage.equals("1")){%>
                  <button type="button"  id="contentbtn"
             onclick="location.href='<%=root%>/startmain.jsp?content=mypage/normalboard.jsp?pageNum=<%=pageNum%>'">BACK</button>         
                   
                <%}else{%>
                       <button type="button"  id="contentbtn"
             onclick="location.href='<%=root%>/startmain.jsp?content=mypage/adminboard_form.jsp?pageNum=<%=pageNum%>'">BACK</button>         
           <%}
             }%>
            
         
          
         </td>
      </tr>
   
</table>

	</div>
</div>
</body>
</html>