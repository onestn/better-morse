package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.UserDTO;
import poly.service.IMailService;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class TestController {

	@Resource(name="MailService")
	private IMailService mailService;

	@Resource(name="UserService")
	private IUserService userService;

	private Logger log = Logger.getLogger(this.getClass());


		@RequestMapping(value="/Test/email")
		public String StarEduNum() {
			log.info(this.getClass().getName() + ".메일 START!");

			int number = mailService.doSendMail();

			log.info("성공여부 : " + number);

			return "/Test/test";
		}

		@RequestMapping(value="/Test/TestMain") 
		public String StartEduNum() {
			log.info(this.getClass().getName() + ".MorseEdu START!");
			
			return "/Test/TestMain";
		}
		
		@RequestMapping(value="/Test/Listen/EduListen")
		public String EduListen() {
			log.info(this.getClass().getName() + ".ListenCh START!");
			
			return "/Test/EduListen";
		}

		@RequestMapping(value="/Test/LearnNumber")
		public String LearnNumber() {
			log.info(this.getClass().getName());

			return "/Test/Level/NumberTest";
		}

		@RequestMapping(value="/Test/Listen/LevelMain")
		public String ListenTestMain() {
			log.info(this.getClass().getName());
			return "Test/LevelMain";
		}

		@RequestMapping(value="/Test/Level/LvBronze")
		public String LvBronze() {
			log.info(this.getClass().getName() + "BRONZE");
			return "Test/Level/LvBronze";
		}
		@RequestMapping(value="/Test/Level/LvGold")
		public String LvGold() {
			log.info(this.getClass().getName() + "GOLD");
			return "Test/Level/LvGold";
		}
		@RequestMapping(value="/Test/Level/LvPlatinum")
		public String LvPlatinum() {
			log.info(this.getClass().getName() + "PLATINUM");
			return "Test/Level/LvPlatinum";
		}
		@RequestMapping(value="/Test/Level/LvChallenger")
		public String LvChallenger() {
			log.info(this.getClass().getName() + "Challenger");
			return "Test/Level/LvChallenger";
		}
		@RequestMapping(value="/Test/Level/LvHardcore")
		public String LvDiamond() {
			log.info(this.getClass().getName() + "HARDCORE!!");
			return "Test/Level/LvHardcore";
		}

		// 사용자의 오답을 데이터베이스에 올리기 위함
		// 사용자의 기존 테이블을 가져옴.
		// 테이블에서 wrongCh 컬럼에 기존값 + 새로운 오답을 추가함
		// 전체 테이블 업데이트
		@ResponseBody
		@RequestMapping(value="/Test/Listen/Submit")
		public void GotoResult(HttpServletRequest request) throws Exception {

			HttpSession session = request.getSession();

			int res = 0;

			String ss_user_id = (String)session.getAttribute("SS_USER_ID");
			log.info("세션에 저장된 값을 가져옴 : " + ss_user_id);
			// JSP에서 AJAX로 전달한 오답 문자
			String wrongCh = request.getParameter("wrongCh");
			log.info("사용자의 오답 : " + request.getParameter("wrongCh"));

			// 세션에 있는 아이디와 WrongCh를 데이터베이스에 올리기 위한 변수 rDTO
			UserDTO rDTO = new UserDTO();
			rDTO.setUser_id(ss_user_id);
			rDTO.setWrongCh(wrongCh);
			// 문제를 다 풀면 메인으로 이동
			res = userService.updateWrongCh(rDTO);

			if (res == 1) {
				log.info("Service.updateWrongCh 성공");
			}

			res = userService.insertWrongChToMongo(wrongCh, ss_user_id);

			if (res == 1) {
				log.info("MongoDB에 틀린 문자가 들어감");
			}
		}
}
