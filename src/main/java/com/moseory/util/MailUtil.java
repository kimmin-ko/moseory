package com.moseory.util;

import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;

@Component
public class MailUtil {
	

	public void sendMail(Map<String, Object> map) {
		
		try {
			
			String html = "";
			
			String host = "smtp.gmail.com"; //  메일
			int port = 465; //포트번호 465 587
			final String username = "moonseungchan3362";  // 아이디
			final String password = "4586336Dl";  // 비번
			
			html = getHTML(map);
			
			String recipient = (String) map.get("EMAIL"); // 받을 이메일
			String title = "MOSEORY 임시 비밀번호 변경 알림"; // 제목
			
			
			Properties properties = System.getProperties(); // 정보를 담기 위한 객체 생성
			
			// SMTP 서버 정보 설정
			properties.put("mail.smtp.host", host); 
			properties.put("mail.smtp.port", port); 
			properties.put("mail.smtp.auth", "true"); 
			properties.put("mail.smtp.ssl.enable", "true"); 
			properties.put("mail.smtp.ssl.trust", host);
	
			// 메일 세션
			Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
				String un=username;
				String pw=password;
				protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
					return new javax.mail.PasswordAuthentication(un, pw); 
				}
			});
	
			MimeMessage mimeMessage = new MimeMessage(session); //MimeMessage 생성
			
			
			mimeMessage.setFrom(new InternetAddress(username+"@gmail.com", "모서리 비밀번호 변경"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅
			mimeMessage.setSubject(title, "utf-8"); //제목셋팅 
			mimeMessage.setContent(html, "text/html; charset=UTF-8");
			
			Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
			System.out.println("메일 발송 완료");
			
		} catch (Exception e) {
			System.out.println("메일 발송중 에러");
			e.printStackTrace();
		}
	}

	private String getHTML(Map<String, Object> map) {
		
		String html ="";
		html += "<body>";
		html += "	임시 비밀번호로 변경되었습니다.";
		html += "	비밀번호는 <Strong>";
		html += 	map.get("pw");
		html += "	</Strong> 입니다.";
		html += "</body>";
		return html;
	}
	
}