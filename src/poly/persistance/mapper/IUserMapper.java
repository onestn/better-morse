package poly.persistance.mapper;

import config.Mapper;
import poly.dto.UserDTO;

@Mapper("UserMapper")
public interface IUserMapper {

	// 회원 가입하기 (회원 정보 등록)
	int insertUserInfo(UserDTO pDTO) throws Exception;

	// 회원 가입 전 중복체크 (DB조회하기)
	UserDTO getUserExists(UserDTO pDTO) throws Exception;

	// For Login
	UserDTO getUserLoginCheck(UserDTO pDTO) throws Exception;

	// 오답 문자를 업데이트
	int updateWrongCh(UserDTO pDTO) throws Exception;

	// 오답문자를 JSP에 로드하기 위함
	UserDTO getWrongCh(UserDTO pDTO) throws Exception;

	UserDTO existCheck(UserDTO pDTO) throws Exception;

	int changePwd(UserDTO pDTO) throws Exception;

	void deleteUser(UserDTO pDTO) throws Exception;

	UserDTO getFindId(UserDTO pDTO) throws Exception;

	void updateUserInfo(UserDTO pDTO) throws Exception;

	UserDTO showEmail(UserDTO pDTO) throws Exception;
}
