package poly.service.impl;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import poly.service.IMailService;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Service("MailService")
public class MailService implements IMailService {

    private Logger log = Logger.getLogger(this.getClass());

    final String host = "smtp.gmail.com"; // 구글에서 제공하는 SMTP서버
    final String from = "yang991211@gmail.com"; // 구글 이메일주소입력
    final String password =""; // 비밀번호입력

    final String to = "yang991211@naver.com";
    final String attachedFile = "/Users/dead_line/test.txt";
    // C:\Users\admin\test.txt

    @Override
    public int doSendMail() {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".doSendMail start!");

        // 메일 발송 성공여부(발송성공 : 1 / 발송실패 : 0)
        int res = 1;

        Properties props = new Properties();
        props.put("mail.smtp.host", host); // javax 외부 라이브러리에 메일 보내는 사람의 정보 설정
        props.put("mail.smtp.auth", "true"); // javax 외부 라이브러리에 메일 보내는 사람 인증 여부 설정
        props.put("mail.smtp.starttls.enable", "true"); // 로그인시 TLS를 사용
        props.put("mail.smtp.port", "587");     // TLS 포트

        // 구글 SMTP서버 인증 처리 로직
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // 메일 제목
            message.setSubject("제목");

            // 메일 내용
            message.setText("내용");

            // 보낼 파일의 경로 지정
            FileDataSource fds = new FileDataSource(attachedFile);

            message.setDataHandler(new DataHandler(fds));
            message.setFileName(fds.getName());

            // 메일발송
            Transport.send(message);

        } catch (MessagingException e) { // 메일 전송 관련 에러 다 잡기
            res = 0; // 메일 발송이 실패했기 때문에 0으로 변경
            log.info("[ERROR]" + this.getClass().getName() + ".doSendMail : " + e);

        } catch (Exception e) { // 모든 에러 다 잡기
            res = 0; // 메일 발송이 실패하기 떄문에 0으로 변경
            log.info("[ERROR]" + this.getClass().getName() + ".doSendMail : " + e);
        }

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".doSendMail end!");
        return res;

    }

}
