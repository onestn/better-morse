package poly.dto;

public class UserDTO {
	private String user_id; // 아이디
	private String password; // 패스워드
	private String email; // 이메일
	private String wrongCh; // 오답노트에 필요

	// 회원가입 시, 중복가입 방지를 위한 변수
	// DB를 조회해서 회원이 존재하면 Y값을 반환
	// DB에 존재하지 않는 가상의 컬럼 (ALIAS)
	private String exists_yn;

	public String getUser_id() {
		return user_id;
	}

	public String getWrongCh() {
		return wrongCh;
	}

	public void setWrongCh(String wrongCh) {
		this.wrongCh = wrongCh;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getExists_yn() {
		return exists_yn;
	}
	public void setExists_yn(String exists_yn) {
		this.exists_yn = exists_yn;
	}
	
	
}
