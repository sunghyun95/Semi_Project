package intranet.sms;

import java.util.HashMap;

import org.json.simple.JSONObject;

public class SMSManager {
	public static void sendSms(String msg, String phone,String adminhp) {
		String api_key = "NCSMIEC1QLBR0KUW";
		String api_secret = "2XYGSJVXVFJNT6PAOK2Y3MYL4OAPZJFP";
		Coolsms coolsms = new Coolsms(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", phone); // ���Ź�ȣ

		set.put("from", adminhp); // �߽Ź�ȣ
		set.put("text", msg); // ���ڳ���
		set.put("type", "sms"); // ���� Ÿ��

		JSONObject result = coolsms.send(set); // ������&���۰���ޱ�
		if ((Boolean) result.get("status") == true) {
			// �޽��� ������ ���� �� ���۰�� ���
			System.out.println("����");
			System.out.println(result.get("group_id")); // �׷���̵�
			System.out.println(result.get("result_code")); // ����ڵ�
			System.out.println(result.get("result_message")); // ��� �޽���
			System.out.println(result.get("success_count")); // �޽������̵�
			System.out.println(result.get("error_count")); // ������ ������ ������ �޽��� ��
		} else {
			// �޽��� ������ ����
			System.out.println("����");
			System.out.println(result.get("code")); // REST API �����ڵ�
			System.out.println(result.get("message")); // �����޽���
		}
	}
}

