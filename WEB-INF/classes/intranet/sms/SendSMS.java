package intranet.sms;

import java.io.*;


public class SendSMS

{

    public SendSMS(String hp,String randomsu)

    {
        SMS sms = new SMS();

        String[] hpArr = hp.split("-");
        
       
        

        sms.appversion("TEST/1.0");

        sms.charset("utf8");

        sms.setuser("songcho99@gmail.com", "s-30909685");				// coolsms ���� �Է����ֽø�ǿ�



        String number[] = new String[2];                                  // ���� ��� ����ȣ

        number[0] = hpArr[0]+hpArr[1]+hpArr[2];

        

        for( int i = 0 ; i < number.length ; i ++ ) {

	        SmsMessagePdu pdu = new SmsMessagePdu();

	        pdu.type = "SMS";

	        pdu.destinationAddress = number[i];

	        pdu.scAddress = number[0]	;                   // �߽��� ��ȣ          

	        pdu.text = "[int ranet=6; �����ڵ�]�ȳ��ϼ���. ������ȣ�� "+randomsu+"�Դϴ�.";					    // ���� �޼��� ����

	        sms.add(pdu);

	   

	        try {

	            sms.connect();

	            sms.send();

	            sms.disconnect();

	        } catch (IOException e) {

	            System.out.println(e.toString());

	        }

	        sms.printr();

	        sms.emptyall();

	    }

    }

}