<%@page import="java.util.Vector"%>
<%@page import="org.apache.commons.mail.MultiPartEmail"%>
<%@page import="org.apache.commons.mail.EmailAttachment"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dto.BoardDto"%>
<%@page import="intranet.dao.BoardDao"%>
<%@page import="intranet.email.SendMail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SendMail mail = new SendMail();
	request.setCharacterEncoding("UTF-8");
	
	String num = (String)session.getAttribute("num");
	String bnum = request.getParameter("bnum");
	System.out.println(bnum);
	
	BoardDao bdao = new BoardDao();
	BoardDto bdto = bdao.getWebHardData(bnum);
	
	FileDao fdao = new FileDao();
	List<FileDto> flist = fdao.getCommuGetFilelist(bnum);

	MemberDao mdao = new MemberDao();
	MemberDto mdto = mdao.getMember(num);
	
	String getPath = getServletContext().getRealPath("/webhard/"+bnum);
	
	String email = mdto.getEmail1()+"@"+mdto.getEmail2();
	
	
	

	MultiPartEmail multiPartEmail = new MultiPartEmail();

	 

	// 파라미터 가져오기


	long beginTime = System.currentTimeMillis();// 시작시간 설정

	 

	// SMTP 서버 연결 설정

	// SMTP 서버를 daum으로 했기 때문에 daum 계정으로 접속

	multiPartEmail.setHostName("smtp.naver.com");

	multiPartEmail.setSmtpPort(465); // 465(SSL방식) or 587(TLS방식)

	multiPartEmail.setAuthentication("corsair457@naver.com", "Tkxkd2468!!@"); // 아이디,패스워드

	multiPartEmail.setSSLOnConnect(true); // SSL 접속 활성화

	multiPartEmail.setStartTLSEnabled(true); // TLS 접속 활성화

	 

	// 보내는 사람=> daum으로 SMTP 서버로 연결했기 때문에 보내는 메일도 daum이 되어야한다

	multiPartEmail.setFrom("corsair457@naver.com","int ranet=6;","UTF-8");

	// 받는 사람

	multiPartEmail.addTo(email,"받는 사람","UTF-8");

	 

	 

	// 이메일에 추가될 내용 설정

	multiPartEmail.setSubject(bdto.getBsubject()); //제목

	multiPartEmail.setMsg(bdto.getBcontent());
	
	
	
	for(FileDto fdto : flist){
		
	EmailAttachment attachment = new EmailAttachment();
	
	attachment.setPath(getPath+"/"+fdto.getFilename());
		
	attachment.setDescription("파일에 대한 설명");

	attachment.setName(fdto.getFilename()); // 첨부파일 이름 => 필수사항은 아님
	
	multiPartEmail.attach(attachment); // 첨부파일 추가

	}

			
			
	

	 

	//* 지연시간을 줄이기 위한 방법으로 스레드로 이메일 전송

	new Thread(new Runnable() {

	@Override

	public void run() {

	try{

	multiPartEmail.send();

	long execTime = System.currentTimeMillis() - beginTime;

	System.out.println("이메일 전송에 걸린시간: "+execTime);

	}catch(Exception e){}

	}

	}).start();

	%>

	<!-- 
	
	JSONArray array = new JSONArray();
	JSONObject ob = new JSONObject();
	boolean sendEmailresult = mail.sendMails(mdto.getName(), email, email, bdto.getBsubject(), bdto.getBcontent(), fdto.getFilename(), getPath);
	
	ob.put("email",sendEmailresult);
	array.add(ob);
 -->
