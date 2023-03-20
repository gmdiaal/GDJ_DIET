package com.goody.diet.member;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;



public class SendEmail {
	
	public String generateEmail(HttpSession httpSession) { //나중에 세션너워줘
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		final String username = "hckt21@gmail.com";
		final String password = "rzcdffqoxzyqwxht";

		Session session = Session.getInstance(props,
			    new javax.mail.Authenticator() {
			        protected PasswordAuthentication getPasswordAuthentication() {
			            return new PasswordAuthentication(username, password);
			        }
			    });
		
		try {
			//받아온 세션회원의 email 꺼내서 이메일 보내기.
//			MemberDTO memberDTO=(MemberDTO)httpSession.getAttribute("sessionMember");
//			String mail_address=memberDTO.getEmail();
			String mail_address="gmdiaal@gmail.com";
			
			String verificationCode = Integer.toString((int) (Math.random() * 899999) + 100000);
			
		    Message message = new MimeMessage(session);
		    message.setFrom(new InternetAddress("hckt21@gmail.com"));
		    message.setRecipients(Message.RecipientType.TO,
		            InternetAddress.parse(mail_address));
		    message.setSubject("다이어트다이어트");
		    message.setText("인증번호에용... "+verificationCode);

		    Transport.send(message);

		    httpSession.setAttribute("verificationCode", verificationCode);

		    System.out.println("Email sent successfully.");
		    return "1";
		    		
		    
		} catch (MessagingException e) {
		    throw new RuntimeException(e);
		}
		

	}
}
