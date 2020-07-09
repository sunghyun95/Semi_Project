package intranet.email;

import java.util.*;
import java.io.*;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class SendMail {
	 static final String HOST = "smtp.live.com";
	   static final int PORT = 25;
	 /** JiniMailSender 의 생성자 */
	 public SendMail() {}

	 public boolean sendMails( String nameFrom, String emailFrom, String emailsTo,
	       String subject, String msgText, String filenames, String filepath ) {
	  
	  boolean sended = true;//전송결과
	  boolean debug = false;//차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능

	  Properties prop = new Properties();
	  prop.put("mail.smtp.host", "smtp.naver.com");
	  Session msgSession = Session.getDefaultInstance(prop, null);
	  msgSession.setDebug(debug);

	  StringTokenizer str = new StringTokenizer( emailsTo, ";" );
	  while( str.hasMoreTokens() ) {
	   String emailTo = str.nextToken().trim();
	   try {
	    MimeMessage mm = new MimeMessage( msgSession );

	    InternetAddress[] iaddr = { new InternetAddress(emailTo) };
	    // 수신자/////////////////////////////////////////////////////////
	    mm.setRecipients( Message.RecipientType.TO, iaddr ) ;
	    // 송신자/////////////////////////////////////////////////////////
	    mm.setFrom( new InternetAddress( "\""+nameFrom+"\" <"+emailFrom+">" ) );
	    // 제목///////////////////////////////////////////////////////////
	    mm.setSubject( subject );
	    // 내용///////////////////////////////////////////////////////////
	    Multipart mp = new MimeMultipart();
	    //**메시지**
	    MimeBodyPart mbp = new MimeBodyPart();
	    mbp.setContent( msgText, "text/html;charset=UTF-8" );
	    mp.addBodyPart( mbp );
	    mbp = null;
	    //**파일첨부**
	    try {
	     if( !filenames.equals("") ) {
	      StringTokenizer str2 = new StringTokenizer( filenames, "|" );
	      while( str2.hasMoreTokens() ) {
	       String filename = str2.nextToken();
	       if( filename.trim().length() != 0 ) {
	        MimeBodyPart mbp2 =  new MimeBodyPart();
	        FileDataSource fds = new FileDataSource( filepath+filename );
	        mbp2.setDataHandler( new DataHandler(fds) );
	        mbp2.setFileName( new String(fds.getName().getBytes("KSC5601"), "8859_1") );
	        mp.addBodyPart( mbp2 );
	        mbp2 = null;
	       }
	      }
	     }
	    }catch( Exception e1 ) {
	     String err = e1.toString();
	     System.out.println( "in JiniMailSender : 파일전송중 에러 : "+err );
	     sended = false;
	    }
	    mm.setContent(mp);
	    // 전송날짜////////////////////////////////////////////////////////
	    mm.setSentDate( new Date() );
	    // 메일전송////////////////////////////////////////////////////////
	    Transport.send( mm );

	   }catch( MessagingException e ) {
	    String err = e.toString();
	    System.out.println( "in JiniMailSender : 메일전송실패 : "+err );
	    sended = false;
	   }
	  }//while end

	  return sended;
	 }

	 //파일첨부없이
	 public boolean sendMails( String nameFrom, String emailFrom, String emailsTo, String subject, String msgText ) {
	  
	  boolean sended = true;//전송결과
	  boolean debug = false;//차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능

	  Properties prop = new Properties();
	  prop.put("mail.smtp.host", "smtp.naver.com");
	  prop.put("mail.mime.charset", "UTF-8");
	  prop.put("mail.mime.encodefilename", true);
	  Session session = Session.getDefaultInstance(prop, null);
	  
	  
	  Session msgSession = Session.getDefaultInstance(prop, null);
	  msgSession.setDebug(debug);

	  StringTokenizer str = new StringTokenizer( emailsTo, ";" );
	  while( str.hasMoreTokens() ) {
	   String emailTo = str.nextToken().trim();
	   try {
	    MimeMessage mm = new MimeMessage( msgSession );

	    InternetAddress[] iaddr = { new InternetAddress(emailTo) };
	    // 수신자/////////////////////////////////////////////////////////
	    mm.setRecipients( Message.RecipientType.TO, iaddr ) ;
	    // 송신자/////////////////////////////////////////////////////////
	    mm.setFrom( new InternetAddress( "\""+nameFrom+"\" <"+emailFrom+">" ) );
	    // 제목///////////////////////////////////////////////////////////
	    mm.setSubject( subject );
	    // 내용///////////////////////////////////////////////////////////
	    Multipart mp = new MimeMultipart();
	    //**메시지**
	    MimeBodyPart mbp = new MimeBodyPart();
	    mbp.setContent( msgText, "text/html;charset=euc-kr" );
	    mp.addBodyPart( mbp );
	    mm.setContent(mp);
	    // 전송날짜////////////////////////////////////////////////////////
	    mm.setSentDate( new Date() );
	    // 메일전송////////////////////////////////////////////////////////
	    Transport.send( mm );

	   }catch( MessagingException e ) {
	    String err = e.toString();
	    System.out.println( "in JiniMailSender : 메일전송실패 : "+err );
	    sended = false;
	   }
	  }//while end

	  return sended;
	 }
	
}


