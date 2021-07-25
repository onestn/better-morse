package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import poly.dto.UserDTO;
import poly.service.IUserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

@Controller
public class EduController {

	@Resource(name="UserService")
	private IUserService userService;

	private Logger log = Logger.getLogger(this.getClass());

	// 모스부호 언어 카테고
	@RequestMapping(value="/Edu/EduMain")
	public String MorseEdu() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/EduMain";
	}

	// Education English 카테고리
	@RequestMapping(value="/Edu/Eng/EngMain")
	public String StartEduEng() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Eng/EngMain";
	}

	@RequestMapping(value="/Edu/Eng/EngCh")
	public String StartEngch() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Eng/EngCh";
	}

	@RequestMapping(value="/Edu/Eng/EngWorst")
	public String StartEngWorst(HttpServletRequest request, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("SS_USER_ID");

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_id(user_id);

		String wrongChs = userService.getWrongCh(pDTO);

		String wrongArr = Arrays.toString(wrongChs.split(","));

		if (wrongArr == null) {
			wrongArr += "아직 문제를 풀지 않았습니다.";
		}
		log.info("사용자로부터 받은 문자 : " + wrongArr);

		model.addAttribute("wrongChs", wrongChs);

		return "/Edu/Eng/EngWorst";
	}

	@RequestMapping(value="/Edu/Eng/EngWord")
	public String EngWord() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Eng/EngWord";
	}

	// Education Korean 카테고리
	@RequestMapping(value="/Edu/Kor/KorMain")
	public String StartKorMain() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Kor/KorMain";
	}

	@RequestMapping(value="/Edu/Kor/KorWord")
	public String KorWord() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Kor/KorWord";
	}

	@RequestMapping(value="/Edu/Kor/KorCh")
	public String KorCh() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Kor/KorCh";
	}

	@RequestMapping(value="/Edu/Kor/KorWorst")
	public String KorWorst() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Kor/KorWorst";
	}

	@RequestMapping(value="/Edu/Num/NumMain")
	public String StartEduNum() {
		log.info(this.getClass().getName() + ".MorseEdu START!");

		return "/Edu/Num/NumMain";
	}
}
