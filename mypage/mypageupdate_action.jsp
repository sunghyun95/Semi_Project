<%@page import="java.io.File"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
   
   
   
   MemberDto dto=new MemberDto();
   MemberDao dao=new MemberDao();
   
   String mnum=(String)session.getAttribute("num");
   MemberDto mdto=dao.getMember(mnum);
   
   //저장경로 선언
   String uploadFolder=getServletContext().getRealPath("/saveimage");
   System.out.println(uploadFolder);
   //사이즈 지정
   int uploadSize=1024*1024*10;
   //multi클래스 생성
   MultipartRequest multi=null;
   
   try{
   multi=new MultipartRequest(request,uploadFolder,uploadSize,"utf-8",new DefaultFileRenamePolicy());
   String num=multi.getParameter("num");
   String image=multi.getFilesystemName("image");
   String id=multi.getParameter("id");
   String name=multi.getParameter("name");
   String buseo=multi.getParameter("buseo");
   String grade=multi.getParameter("grade");
   String email1=multi.getParameter("email1");
   String email2=multi.getParameter("email2");
   String addr1=multi.getParameter("addr1");
   String addr2=multi.getParameter("addr2");
   String birth=multi.getParameter("birth");
   String hp1=multi.getParameter("hp1");
   String hp2=multi.getParameter("hp2");
   String hp3=multi.getParameter("hp3");
   String ipsaday=multi.getParameter("ipsaday");
   
   //기존 파일명
   String uploadFileName=dao.getMember(num).getImage();
   File file=new File(uploadFolder+"\\"+uploadFileName);
   System.out.println("file="+file);
   file.delete();
   //dto에 저장
   dto.setNum(num);
   dto.setImage(image);
   dto.setId(id);
   dto.setName(name);
   dto.setBuseo(buseo);
   dto.setGrade(grade);
   dto.setEmail1(email1);
   dto.setEmail2(email2);
   dto.setAddr1(addr1);
   dto.setAddr2(addr2);
   dto.setBirth(birth);
   dto.setHp1(hp1);
   dto.setHp2(hp2);
   dto.setHp3(hp3);
   dto.setIpsaday(ipsaday);


   dao.updateMember(dto);
   System.out.println("num="+num);
   System.out.println("image="+image);
      
      if(mdto.getName().equals("관리자")){
            response.sendRedirect("mypageupdate_action2.jsp");
            %>
              <script type="text/javascript">
            alert("사원정보 수정이 완료되었습니다.");
            </script>
            <%
      }else{
         response.sendRedirect("mypageupdate_action2.jsp");
      %>
         <script type="text/javascript">
            alert("사원정보 수정이 완료되었습니다.");
            history.back();
         </script>
      <% }
   }catch(Exception e){
      System.out.println("upload error:"+e.getMessage());
   }
   %>

