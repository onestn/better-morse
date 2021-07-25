//package test;
//
//import org.junit.Test;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//
//public class MySQLConnTest {
//	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
//	private static final String URL = "jdbc:mysql://mydb1.csgkfhju8sbd.ap-northeast-2.rds.amazonaws.com:3306/morse_user?characterEncoding=UTF-8&serverTimezone=UTC&";
//	private static final String USER = "admin";
//	private static final String PW = "adminadmin";
//	/*
//	 	@Test : 테스트해야 하는 내용을 메소드 안에 작성하고 메소드 위에 @Test 애노테이션을 추가하면 jUnit은 해당 메소드를 테스트용 코드로 간주하고 테스트를 진행
//
//
//		@Before : 모든 테스트 작업에 앞서 준비되어야 하는 내용을 작성해서 메소드에 추가하는 애노테이션이고 @Test 전에 실행되기에 테스트를 위한 준비 작업을 할 때 사용
//
//
//		@After : 테스트 작업이 끝난 후 자동으로 실행되는 메소드에 추가하는 애노테이션
//	 */
//
//	@Test //jUnit이 테스트함
//	public void testConnection() throws Exception {
//		Class.forName(DRIVER); //DRIVER라는 이름을 가진 클래스를 찾음
//
//		try (Connection con = DriverManager.getConnection(URL, USER, PW)) { //DB 계정과 연결하여 연결된 객체를 Connection 클래스의 인스턴스인 con에 담음
//			int num = insert(con, "koo1", "JDBC 테스트", "Hello");
//			System.out.println(num + "개 행 삽입 완료");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//
//	//INSERT 문을 날리는 메서드 (id는 db에서 자동으로 생성하기에 넣을 필요 없음, 반환값은 넣은 행의 개수)
//	public int insert(Connection con, String name, String remark, String test) {
////		final String SQL= "INSERT INTO TEST(name,remark) VALUES (?,?)"; //sql 쿼리
//
//		final String LoginSQL = "INSERT INTO USER_INFO (USER_ID, PASSWORD, EMAIL) VALUES (?, ?, ?)";
//
//		//PreparedStatement에서 해당 SQL을 미리 컴파일함
//		try (PreparedStatement pstml = (PreparedStatement) con.prepareStatement(LoginSQL)) {
//			pstml.setString(1, name); //1번째 물음표에 name 삽입
//			pstml.setString(2, remark); //2번째 물음표에 remark 삽입
//			pstml.setString(3, test);
//			return pstml.executeUpdate(); //쿼리실행 반환 값 삽입한 행의 개수
//		} catch (Exception e) { //예외처리
//			e.printStackTrace();
//			System.out.println("테이블에 행 삽입 실패");
//			return 0;
//		}
//	}
//}
////
//////	@Test
//////	public void testConnection() throws Exception {
//////		Class.forName(DRIVER);
//////
//////		try (Connection con = DriverManager.getConnection(URL, USER, PW)) {
//////			System.out.println("SUCCESS: JDBC 연결 성공");
//////			System.out.println(con);
//////
//////			insertQuery(con, 10, "test", "test");
//////		} catch (Exception e) {
//////			e.printStackTrace();
//////		}
//////	}
////
////	@Test
////	public void testQuery() throws Exception {
////		Class.forName(DRIVER);
////
////		try (Connection con = DriverManager.getConnection(URL, USER, PW)) {
////
//////			// INSERT
//////			int num = insertQuery(con, "test", "JDBC Test");
//////			System.out.println(num + "개 행 삽입 완료");
////
////			// SELECT
//////			int id = 1;
//////			String name = selectQuery(con, id);
//////			System.out.println("id: " + id + ", name: " + name);
////
////			// DELETE
////			int id = 1;
////			int num = deleteQuery(con, id);
////			System.out.println(num + "개의 행이 삭제되었습니다.");
////
////		} catch (Exception e) {
////			e.printStackTrace();
////		}
////	}
////
////	// TEST: INSERT
////	@Test
////	public int insertQuery(Connection con, int id, String name, String remark) {
////		final String SQL = "INSERT INTO TEST(name, remark) VALUES (?,?)"; 	// SQL 쿼리
////
////		try (PreparedStatement pstml = (PreparedStatement) con.prepareStatement(SQL)) {
////			pstml.setString(1, name);
////			pstml.setString(2, remark);
////			return pstml.executeUpdate(); // 쿼리 실행 반환 값 삽입한 행의 개수
////		} catch (Exception e) {
////			e.printStackTrace();
////			System.out.println("테이블에 행 삽입 실패");
////			return 0;
////		}
////	}
////
////	// TEST: SELECT
////	private static final String SQL2 = "select name from TEST where id = ?;";	// SQL 쿼리
////
////	public String selectQuery(Connection con, Integer id) throws Exception {
////		String result = null;
////
////		try (PreparedStatement pstmt = con.prepareStatement(SQL2)) {
////			pstmt.setString(1, id.toString());
////			ResultSet rs = pstmt.executeQuery();
////
////			if (rs.next()) // 다음 행이 있는지 확
////				result = rs.getString("name");
////		} catch (Exception e) {
////			throw e;
////		}
////		return result;
////	}
////
////	// TEST: DELETE
////	private static final String SQL3 = "delete from TEST where id = ?;";
////
////	public int deleteQuery(Connection con, Integer id) throws Exception {
////		int result = 0;
////
////		try (PreparedStatement pstmt = con.prepareStatement(SQL3)) {
////			pstmt.setString(1, id.toString());
////			result = pstmt.executeUpdate();
////		} catch (Exception e) {
////			throw e;
////		}
////		return result;
////	}
////}
