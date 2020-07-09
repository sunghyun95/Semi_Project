package intranet.email;

import java.util.*;
import java.io.*;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class SendMail {
	 static final String HOST = "smtp.live.com";
	   static final int PORT = 25;
	 /** JiniMailSender �� ������ */
	 public SendMail() {}

	 public boolean sendMails( String nameFrom, String emailFrom, String emailsTo,
	       String subject, String msgText, String filenames, String filepath ) {
	  
	  boolean sended = true;//���۰��
	  boolean debug = false;//���� �� ������ ����� ó���� �� �� �ֵ��� ��������

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
	    // ������/////////////////////////////////////////////////////////
	    mm.setRecipients( Message.RecipientType.TO, iaddr ) ;
	    // �۽���/////////////////////////////////////////////////////////
	    mm.setFrom( new InternetAddress( "\""+nameFrom+"\" <"+emailFrom+">" ) );
	    // ����///////////////////////////////////////////////////////////
	    mm.setSubject( subject );
	    // ����///////////////////////////////////////////////////////////
	    Multipart mp = new MimeMultipart();
	    //**�޽���**
	    MimeBodyPart mbp = new MimeBodyPart();
	    mbp.setContent( msgText, "text/html;charset=UTF-8" );
	    mp.addBodyPart( mbp );
	    mbp = null;
	    //**����÷��**
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
	     System.out.println( "in JiniMailSender : ���������� ���� : "+err );
	     sended = false;
	    }
	    mm.setContent(mp);
	    // ���۳�¥////////////////////////////////////////////////////////
	    mm.setSentDate( new Date() );
	    // ��������////////////////////////////////////////////////////////
	    Transport.send( mm );

	   }catch( MessagingException e ) {
	    String err = e.toString();
	    System.out.println( "in JiniMailSender : �������۽��� : "+err );
	    sended = false;
	   }
	  }//while end

	  return sended;
	 }

	 //����÷�ξ���
	 public boolean sendMails( String nameFrom, String emailFrom, String emailsTo, String subject, String msgText ) {
	  
	  boolean sended = true;//���۰��
	  boolean debug = false;//���� �� ������ ����� ó���� �� �� �ֵ��� ��������

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
	    // ������/////////////////////////////////////////////////////////
	    mm.setRecipients( Message.RecipientType.TO, iaddr ) ;
	    // �۽���/////////////////////////////////////////////////////////
	    mm.setFrom( new InternetAddress( "\""+nameFrom+"\" <"+emailFrom+">" ) );
	    // ����///////////////////////////////////////////////////////////
	    mm.setSubject( subject );
	    // ����///////////////////////////////////////////////////////////
	    Multipart mp = new MimeMultipart();
	    //**�޽���**
	    MimeBodyPart mbp = new MimeBodyPart();
	    mbp.setContent( msgText, "text/html;charset=euc-kr" );
	    mp.addBodyPart( mbp );
	    mm.setContent(mp);
	    // ���۳�¥////////////////////////////////////////////////////////
	    mm.setSentDate( new Date() );
	    // ��������////////////////////////////////////////////////////////
	    Transport.send( mm );

	   }catch( MessagingException e ) {
	    String err = e.toString();
	    System.out.println( "in JiniMailSender : �������۽��� : "+err );
	    sended = false;
	   }
	  }//while end

	  return sended;
	 }
	
}


