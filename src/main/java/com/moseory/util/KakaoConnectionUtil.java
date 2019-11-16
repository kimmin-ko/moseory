package com.moseory.util;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.stereotype.Component;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.moseory.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class KakaoConnectionUtil {


	public String getAccessToken (String code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            // post 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            // post 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=b419ae28c858db8583adbbee9c54f3bc");
            sb.append("&redirect_uri=http://localhost:9090/member/kakaoLogin");
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();
            
            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            log.info("responseCode : " + responseCode);
 
            // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            log.info("response body : " + result);
            
            // JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
            log.info("access_token : " + access_Token);
            log.info("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        
        return access_Token;
    }
	
	public MemberVO getUserInfo (String access_Token) {
	    /*
		    # 제공되는 Info 목록
		    
			{
			  "id":123456789,
			  "properties":{
			     "nickname":"홍길동카톡",
			     "thumbnail_image":"http://xxx.kakao.co.kr/.../aaa.jpg",
			     "profile_image":"http://xxx.kakao.co.kr/.../bbb.jpg",
			     "custom_field1":"23",
			     "custom_field2":"여"
			     ...
			  },
			  "kakao_account": { 
			    "profile_needs_agreement": false,
			    "profile": {
			      "nickname": "홍길동",
			      "thumbnail_image_url": "http://yyy.kakao.com/.../img_110x110.jpg",
			      "profile_image_url": "http://yyy.kakao.com/dn/.../img_640x640.jpg"
			    },
			    "email_needs_agreement":false, 
			    "is_email_valid": true,   
			    "is_email_verified": true,   
			    "email": "xxxxxxx@xxxxx.com"
			    "age_range_needs_agreement":false,
			    "age_range":"20~29",
			    "birthday_needs_agreement":false,
			    "birthday":"1130",
			    "gender_needs_agreement":false,
			    "gender":"female"
			  }
			}
	     */
	    MemberVO memberVo = new MemberVO();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        
	        // 요청에 필요한 Header에 포함될 내용
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        log.info("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String line = "";
	        String result = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        log.info("response body : " + result);
	        
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        
	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        String id_element = element.getAsJsonObject().get("id").getAsString();
	        
	        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	        String email = kakao_account.getAsJsonObject().get("email").getAsString();
	        
	        memberVo.setName(nickname);
	        memberVo.setEmail(email);
	        memberVo.setId(id_element);
	        
	    } catch (IOException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	    
	    return memberVo;
	}	
}
