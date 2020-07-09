package intranet.sms;

import java.util.HashMap;

import org.json.simple.JSONObject;

public class SMSManager {
	public static void sendSms(String msg, String phone,String adminhp) {
		String api_key = "NCSMIEC1QLBR0KUW";
		String api_secret = "2XYGSJVXVFJNT6PAOK2Y3MYL4OAPZJFP";
		Coolsms coolsms = new Coolsms(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", phone); // 수신번호

		set.put("from", adminhp); // 발신번호
		set.put("text", msg); // 문자내용
		set.put("type", "sms"); // 문자 타입

		JSONObject result = coolsms.send(set); // 보내기&전송결과받기
		if ((Boolean) result.get("status") == true) {
			// 메시지 보내기 성공 및 전송결과 출력
			System.out.println("성공");
			System.out.println(result.get("group_id")); // 그룹아이디
			System.out.println(result.get("result_code")); // 결과코드
			System.out.println(result.get("result_message")); // 결과 메시지
			System.out.println(result.get("success_count")); // 메시지아이디
			System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
		} else {
			// 메시지 보내기 실패
			System.out.println("실패");
			System.out.println(result.get("code")); // REST API 에러코드
			System.out.println(result.get("message")); // 에러메시지
		}
	}
}

