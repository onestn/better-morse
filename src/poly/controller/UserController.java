package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import poly.dto.MailDTO;
import poly.dto.UserDTO;
import poly.service.IMailService;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Map;

@Controller
public class UserController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="UserService")
	private IUserService userService;

	@Resource(name="MailService")
	private IMailService mailService;

	// 회원가입 창 
	@RequestMapping(value="/user/signup")
	public String userIn() {
		log.info(this.getClass().getName() + " .user/signup start !");
		
		return"/user/signup";
	}

	@RequestMapping(value="/setting/updateEmail")
	public String updateEmail() {

		return "/setting/updateEmail";
	}

	@ResponseBody
	@RequestMapping(value="/user/settings/updateUserInfo")
	public void updateUserInfo(HttpServletRequest request, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + " .user/UpdateUserinfo start!");

		UserDTO pDTO = new UserDTO();

		String session_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
		String email = request.getParameter("email");

		log.info("사용자로 부터 받은 이메일 : " + email);
		log.info("사용자로 부터 받은 SESSION_ID : " + session_id);

		pDTO.setEmail(EncryptUtil.encAES128CBC(email));
		pDTO.setUser_id(session_id);

		// id가 session_id인 값에 해당하는 이메일을 변경함
		// email은 기존이 아닌 변경될 이메일
		userService.updateUserInfo(pDTO);
	}

	// 회원가입 창
	@RequestMapping(value="user/settings")
	public String settings(HttpServletRequest request, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + " SettingMain !");

		HttpSession session = request.getSession();

		String user_id = (String) session.getAttribute("SS_USER_ID");

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_id(user_id);

		// email 받기
		UserDTO rDTO = userService.getEmail(pDTO);

		String wrongCh = userService.getWrongCh(pDTO);

		String email = (String) EncryptUtil.decAES128CBC(rDTO.getEmail());

		log.info("CONTROLLER - 이메일 : " + email);

		model.addAttribute("email", email);
		model.addAttribute("user_id", user_id);

		if (wrongCh == null) {
			model.addAttribute("wrongCh", "아직 문제를 풀지 않았습니다.");
		} else {
			model.addAttribute("wrongCh", wrongCh);
		}

		return "setting/SettingMain";
	}
	
	// 회원가입 실행
	@RequestMapping(value="user/InsertUserInfo")
	public String InsertUserInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		
		log.info(this.getClass().getName() + " .InsertUserInfo Start !");
		
		String msg = "";
		
		UserDTO pDTO = null;
		
		try {
			String user_id = CmmUtil.nvl(request.getParameter("user_id"));
			String password = CmmUtil.nvl(request.getParameter("password"));
			String email = CmmUtil.nvl(request.getParameter("email"));
			
			log.info("user_id : " + user_id);
			log.info("pwd : " + password);
			log.info("email : " + email);

			// 웹에서 입력받은 정보를 저장할 변수 메모리에 올리기
			pDTO = new UserDTO();
			
			pDTO.setUser_id(user_id);
			// 비밀번호는 절대로 복호화되지 않도록 해시 알고리즘으로 암호화
			pDTO.setPassword(EncryptUtil.encHashSHA256(password));
			// 민감한 정보인 이메일은 AES-128로 암호화
			pDTO.setEmail(EncryptUtil.encAES128CBC(email));

			// 회원가입 진행
			int res = userService.InsertUserInfo(pDTO);
			// 5.20 : Service까지 잘 넘어감 
			// Service 실행 중 Mapper로 통하는 함수에서 에러가 발생
			
			if(res==1) {
				msg = "회원가입되었습니다. ";
			} else if(res == 2) {
				msg = "이미 가입된 회원입니다.";
			} else {
				msg = "오류로 인한 회원가입에 실패했습니다.";
			}
			
			} catch(Exception e) {
				//저장이 실패하면 사용자에게 보여주는 메세지 
				msg = "실패했습니다." + e.toString();
				log.info(e.toString());
				e.printStackTrace();
			} finally {
				//회원가입 여부 결과 메시지 보여주기 
				model.addAttribute("msg",msg);
				model.addAttribute("pDTO",pDTO);

				// 메모리 효율을 위한 변수 초기화
				pDTO = null;
			}
			
			log.info(this.getClass().getName() + ".InsertUserInfo End ! ");
			
			return "/index";
	}
	
	@RequestMapping(value="user/LoginResult")
	public String getUserLoginCheck (HttpSession session, HttpServletRequest request, HttpServletResponse 
			response, ModelMap model) throws Exception {
		
		log.info(this.getClass().getName() + " .getUserLoginCheck start !");
		
		int res = 0; 
		
		UserDTO pDTO = null;
		
		try {
			// 웹에서 받은 정보를 String 변수에 저장
			// 웹으로부터 받은 정보는 DTO에 저장하기 위해 임시로 String변수에 저장
			String user_id = CmmUtil.nvl(request.getParameter("user_id"));
			String password = CmmUtil.nvl(request.getParameter("password"));
			// 값을 받은 후 확인을 위해 로깅
			log.info("user_id : " + user_id);
			log.info("user_pwd : " + password);
			
			pDTO = new UserDTO(); 
			
			pDTO.setUser_id(user_id);
			pDTO.setPassword(EncryptUtil.encHashSHA256(password));

			// 로그인을 위해 일치하는지 확인
			res = userService.getUserLoginCheck(pDTO);

			// 로그인이 성공하면 Session에 아이디를 저장함
			if(res == 1) {
				session.setAttribute("SS_USER_ID", user_id);
				session.setAttribute("SS_PASSWORD", EncryptUtil.encHashSHA256(password));
				log.info("세션에 등록된 아이디 : " + user_id);
				return "Morse/MorseHome";
			} else {
				log.info("로그인 실패");
			}
			// 로그인에 실패
			} catch(Exception e) {
				res = 2;
				log.info(e.toString());
				e.printStackTrace();
			} finally {
				log.info(this.getClass().getName() + " .getUserLoginCheck end !");
	
				model.addAttribute("res",String.valueOf(res));
				
				pDTO = null;
			}
		
		return "user/Error";
	}

	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		// 로그아웃을 누르면 메인페이지로 리다이렉트함
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}

	@ResponseBody
	@RequestMapping("/idCheck")
	public int idCheck(HttpServletRequest request) throws Exception {

		log.info(this.getClass().getName() + ".existCheck start");

		int num = 0;

		String user_id = CmmUtil.nvl(request.getParameter("user_id"));

		log.info("user_id : " + user_id);

		UserDTO pDTO = new UserDTO();

		pDTO.setUser_id(user_id);

		String res = userService.existCheck(pDTO);

		log.info("res : " + res);

		if (res.length() > 1) {
			num = 1;
		}

		log.info("num : " + num);
		log.info(this.getClass().getName() + ".existCheck end");

		return num;
	}

	@RequestMapping(value = "/user/FindPass")
	public String FindPass() throws Exception {

		log.info(this.getClass().getName() + ".FindPass");

		return "/user/FindPass";
	}

	@RequestMapping(value = "/user/FindId")
	public String findId() throws Exception {

		log.info(this.getClass().getName() + ".findId");

		return "/user/FindId";
	}

	@RequestMapping(value = "user/getFindId")
	public String getFindId(HttpServletRequest request, ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".getFindId start");

		String email = CmmUtil.nvl(EncryptUtil.encAES128CBC(request.getParameter("email")));
		String msg = "";

		UserDTO pDTO = new UserDTO();
		MailDTO mDTO = new MailDTO();

		pDTO.setEmail(email);

		UserDTO rDTO = userService.getFindId(pDTO);

		if (rDTO == null) {
			rDTO = new UserDTO();
			msg = "등록되지 않은 이메일입니다!";
			model.addAttribute("msg", msg);
			return "/user/FindId";
		} else {
			mDTO.setToMail(EncryptUtil.decAES128CBC(CmmUtil.nvl(email)));
			mDTO.setTitle("Better Morse - 아이디 찾기");
			mDTO.setContents("안녕하세요. Better Morse팀입니다. \n\n회원님의 아이디는 \n\n[ " + rDTO.getUser_id() + " ] \n\n입니다.\n\n오늘도 좋은 하루 되세요!");


			msg = "입력하신 이메일로 회원님의 아이디를 발송했습니다.";

			model.addAttribute("msg", msg);
			mailService.doSendMail(mDTO);
		}

		return "/index";
	}

	@RequestMapping(value = "/user/getFindPass")
	public String getFindPass(HttpServletRequest request, ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".getFindPass start");

		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		String certNum = "";
		String msg = "";

		UserDTO pDTO = new UserDTO();
		MailDTO mDTO = new MailDTO();

		pDTO.setUser_id(user_id);

		String res = userService.existCheck(pDTO);
		UserDTO rDTO = userService.userInfoCheck(pDTO);

		if (res.length() > 0) {
			certNum = userService.certNumber();

			mDTO.setToMail(EncryptUtil.decAES128CBC(CmmUtil.nvl(rDTO.getEmail())));
			mDTO.setTitle("비밀번호 찾기를 위한 인증번호입니다.");
			mDTO.setContents("인증번호는 " + certNum + "입니다.");

			mailService.doSendMail(mDTO);
		} else {
			msg = "가입되지 않은 아이디입니다!";

			model.addAttribute("msg", msg);
			return "/user/FindPass";
		}

		model.addAttribute("certNum", certNum);
		model.addAttribute("user_id", user_id);

		log.info(this.getClass().getName() + ".getFindPass end");

		return "/user/certInput";
	}

	@RequestMapping(value = "/user/passChg")
	public String passChg(HttpServletRequest request, ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".passChg start");

		String user_id = CmmUtil.nvl(request.getParameter("user_id"));

		model.addAttribute("user_id", user_id);

		log.info(this.getClass().getName() + ".passChg End");

		return "/user/passChg";
	}

	@RequestMapping(value = "/user/passReset")
	public String passReset(HttpServletRequest request, ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".passReset start");

		String msg = "";

		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		String password = CmmUtil.nvl(request.getParameter("password"));

		UserDTO pDTO = new UserDTO();

		pDTO.setUser_id(user_id);
		pDTO.setPassword(EncryptUtil.encHashSHA256(password));

		int res = userService.changePwd(pDTO);

		if (res == 1) {
			msg = "비밀번호 변경에 성공했습니다!";
		} else {
			msg = "오류로 인해 비밀번호 변경에 실패했습니다!";
		}

		model.addAttribute("msg", msg);

		return "/user/chgPwdRes";
	}

	@RequestMapping(value="/deleteUser")
	public String deleteUser(UserDTO pDTO, HttpSession session) throws Exception {

		UserDTO rDTO = new UserDTO();

		rDTO.setUser_id((String) session.getAttribute("SS_USER_ID"));

		rDTO.setPassword((String) session.getAttribute("SS_PASSWORD"));

		userService.deleteUser(rDTO);

		session.invalidate();

		return "/index";
	}


}
