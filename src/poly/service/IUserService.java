package poly.service;

import poly.dto.UserDTO;

public interface IUserService {

	// 회원가입하기 (회원정보 등록)
	int InsertUserInfo(UserDTO pDTO) throws Exception;

	// 로그인을 위해 아이디와 비밀번호가 일치하는지 확인
	int getUserLoginCheck(UserDTO pDTO) throws Exception;

	// 사용자의 오답노트에서 값을 가져옴
	String getWrongCh(UserDTO pDTO) throws Exception;

	// MongoDB에 틀린 문자 insert
	int insertWrongChToMongo(String wrongCh, String user_id) throws Exception;

	// 사용자가 존재하는지 체크
	String existCheck(UserDTO pDTO) throws Exception;

	UserDTO userInfoCheck(UserDTO pDTO) throws Exception;

	// 인증코드
	String certNumber() throws Exception;
	// 비밀번호 변경
	int changePwd(UserDTO pDTO) throws Exception;
	// 계정 탈퇴
	void deleteUser(UserDTO pDTO) throws Exception;

	UserDTO getFindId(UserDTO pDTO) throws Exception;

	UserDTO getEmail(UserDTO pDTO) throws Exception;
	// 사용자 정보 수정
	void updateUserInfo(UserDTO pDTO) throws Exception;
	// 사용자의 오답노트를 수정하기 위함
	int updateWrongCh(UserDTO pDTO) throws Exception;
}
