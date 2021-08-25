
package poly.service.impl;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import poly.dto.UserDTO;
import poly.persistance.mapper.IUserMapper;
import poly.persistance.mongo.IMongoTestMapper;
import poly.service.IUserService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import java.util.Random;

@Service("UserService")
public class UserService implements IUserService{
	
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name="UserMapper")
	private IUserMapper userMapper;

	@Resource(name="MongoTestMapper")
	private IMongoTestMapper mongoTestMapper;

	 @Override
	 public int InsertUserInfo(UserDTO pDTO) throws Exception {
		 
		 log.info(this.getClass().getName() + " .InsertUserInfo Start!");
		 // 회원가입 성공 : 1, 중복으로 인한 취소 : 2, 기타에러 발생 : 0
		 int res = userMapper.insertUserInfo(pDTO);
		 
		 if(pDTO == null) {
			 pDTO = new UserDTO();
		 }
		 // 회원가입 중복방지를 위해 DB에서 데이터 조회
		 UserDTO rDTO = userMapper.getUserExists(pDTO);

		 if(rDTO == null) {
			 rDTO = new UserDTO();
		 }
		 // 중복된 회원정보가 있는 경우 , 결과값을 2로 변경, 더 이상 작업을 진행하지 않음
		if(CmmUtil.nvl(rDTO.getExists_yn()).equals("Y")) {
			res = 2;
		} else {
			// 회원가입
			int success = userMapper.insertUserInfo(pDTO);
			// DB에 데이터가 등록되었다면,
			if(success > 0) {
				res = 1;
			}else {
				res = 0;
			}
		}
		
		log.info(this.getClass().getName() + ".InsertUserInfo End !" + res);
		
		return res;
	 }

	 @Override
	 public int getUserLoginCheck(UserDTO pDTO) throws Exception {
	 	int res = 0;
	 	// UserMapper로부터 SELECT 쿼리의 결과로 회원 아이디를 받으면 성공
	 	UserDTO rDTO = userMapper.getUserLoginCheck(pDTO);
	 	if (rDTO == null) {
	 		rDTO = new UserDTO();
		}
	 	// 로그인 성공 여부 체크
	 	if (CmmUtil.nvl(rDTO.getUser_id()).length() > 0) {
	 		res = 1;
		}
	 	return res;
	 }

	@Override
	public UserDTO getFindId(UserDTO pDTO) throws Exception {
		UserDTO rDTO = userMapper.getFindId(pDTO);
		if(rDTO == null) {
			rDTO = new UserDTO();
		}
		return rDTO;
	}

	@Override
	public void updateUserInfo(UserDTO pDTO) throws Exception {
	 	log.info("UPDATE USER INFO START!");
	 	// pDTO는 세션 아이디와 변경할 이메일을 가짐
		userMapper.updateUserInfo(pDTO);
	}

	@Override
	 public int updateWrongCh(UserDTO pDTO) throws Exception {
	 	log.info(getClass().getName() + "updateWrongCh Start!");
		log.info("사용자의 업데이트 내용 : " + pDTO.getWrongCh());
		log.info("pDTO.user_id : " + pDTO.getUser_id());
		int res = 0;
		res = userMapper.updateWrongCh(pDTO);
	 	if (res == 1) {
	 		log.info("업데이트 성공");
		} else {
	 		log.info("오답문자 업데이트에 실패하였습니다.");
		}
	 	return res;
	 }

	 @Override
	 public String getWrongCh(UserDTO pDTO) throws Exception {

	 	log.info(getClass().getName() + "Get Wrong Ch Start!");
	 	log.info("사용자의 세션 아이디 : " + pDTO.getUser_id());

		 String wrongString = "";

	 	UserDTO rDTO = userMapper.getWrongCh(pDTO);

	 	if (rDTO == null) {
	 		rDTO = new UserDTO();
	 		log.info("사용자의 데이터베이스에서 값을 가져오지 못했습니다.");
	 		return "아직 문제를 풀지 않았습니다.";
		} else {
	 		wrongString = rDTO.getWrongCh();
			log.info("사용자의 데이터베이스에서 가져온 데이터 : " + rDTO.getWrongCh());
		}

		return wrongString;
	 }

	@Override
	public UserDTO getEmail(UserDTO pDTO) throws Exception {

	 	log.info(getClass().getName() + ". GET User Email");
	 	log.info("사용자의 세션 아이디 : " + pDTO.getUser_id());

	 	String email = "";

	 	UserDTO rDTO = userMapper.showEmail(pDTO);

		if (rDTO == null) {
			rDTO = new UserDTO();
			log.info("사용자의 데이터베이스에서 값을 가져오지 못했습니다.");
		} else {
			email = rDTO.getEmail();
			log.info("사용자의 데이터베이스에서 가져온 데이터 : " + email);
		}
		return rDTO;
	}

	@Override
	public int insertWrongChToMongo(String wrongCh, String user_id) throws Exception {

	 	int res = 0;

	 	log.info(getClass().getName() + ".MONGO InsertWrongCH");
		res = mongoTestMapper.insertWrongCh(wrongCh, "WrongCollection", user_id);

		if (res == 0) {
			log.info("MONGO : INSERT FAIL");
		}

		return res;
	}

	@Override
	public String existCheck(UserDTO pDTO) throws Exception {
		String res = "";

		if(pDTO == null) {
			pDTO = new UserDTO();
		}

		UserDTO rDTO = userMapper.existCheck(pDTO);
		log.info("rDTO : " + rDTO);
		if(rDTO != null) {
			res = "success";
		}else {
			res = "fali.";
		}
		return res;
	}

	@Override
	public UserDTO userInfoCheck(UserDTO pDTO) throws Exception {
		UserDTO rDTO = userMapper.existCheck(pDTO);
		if(rDTO == null) {
			rDTO = new UserDTO();
		}
		return rDTO;
	}

	@Override
	public String certNumber() throws Exception {
		Random ran = new Random();
		String str;
		String value = "";
		for (int i = 0; i < 6; i++) {
			if (ran.nextBoolean()) {
				// A-Z
				str = String.valueOf((char) ((ran.nextInt(26)) + 65));
				value = value + str;
				continue;
			} else {
				// 0-9
				str = String.valueOf(ran.nextInt(10));
				value = value + str;
				continue;
			}
		}
		return value;
	}

	@Override
	public int changePwd(UserDTO pDTO) throws Exception {
		int res = 0;
		int success = userMapper.changePwd(pDTO);

		if (success > 0) {
			res = 1;
		} else {
			res = 0;
		}

		return res;
	}

	@Override
	public void deleteUser(UserDTO pDTO) throws Exception {
	 	// user_id, password가 담겨 있어야 함
	 	userMapper.deleteUser(pDTO);
	}

}
