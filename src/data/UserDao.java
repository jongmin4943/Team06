package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class UserDao {
	static final String SELECT = "SELECT * FROM USER";
	static final String SELECTID = "SELECT * FROM USER WHERE userID=?";
	static final String INSERT = "INSERT INTO USER VALUES(?,?,?,?)";
	static final String UPDATE = "UPDATE USER SET UserPassword=? WHERE userID=?";
	static final String DELETE = "DELETE FROM USER WHERE UserEmail=?";
	static private Connection conn = null;
	static private PreparedStatement pstmt = null;
	static private ResultSet rs = null;
	static private Statement stmt = null;
	
	/**
	 * 유저 정보 전부 얻기
	 * @return 유저정보 ArrayList
	 */
	public static List<UserDto> getAll() {
		List<UserDto> list = new ArrayList<UserDto>();
		conn = JdbcUtil.getConnection();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SELECT);
			while(rs.next()) {
				String id = rs.getString(1);
				String pw = rs.getString(2);
				String name = rs.getString(3);
				String email = rs.getString(4);
				
				UserDto user = new UserDto(id,pw,name,email);
				list.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					if(rs != null)rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return list;
	}
	public static UserDto selectUser(String userID) {	//날아온 아이디값을 이용해 그 사람의 정보를 수집.
		conn = JdbcUtil.getConnection();
		UserDto user = null;
		try {
			pstmt = conn.prepareStatement(SELECTID);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String id = rs.getString(1);
				String pw = rs.getString(2);
				String name = rs.getString(3);
				String email = rs.getString(4);
				
				user = new UserDto(id,pw,name,email);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return user;
	}
	
	/**
	 * 새 유저정보 넣기
	 * @param dto
	 */
	public static int insert(UserDto dto) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(INSERT);
			pstmt.setString(1, dto.getUserID());
			pstmt.setString(2, dto.getUserPassword());
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getUserEmail());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("이미 존재하는 아이디");
			return -1;
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	
	public static boolean loginCheck(String id, String pw) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(SELECTID);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pw.equals(rs.getString("userPassword"))) {
					return true;
				}
			}
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	
	public static boolean confirmUser(String id, String name, String email) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(SELECTID);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(name.equals(rs.getString("userName")) && email.equals(rs.getString("userEmail"))) {
					return true;
				}
			}
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static int updatePassword(String id, String pw) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(UPDATE);
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("업데이트 실패");
			return -1;
		}
	}
	
	public static void update(UserDto user) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(UPDATE);
			
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
				System.out.println("수정 성공");
			} else {
				System.out.println("수정 실패 : email이 존재하지 않음");
				conn.rollback();
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	
	public static void delete(UserDto user) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(DELETE);
			pstmt.setString(1, user.getUserEmail());
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) {
				System.out.println("삭제 완료");
			} else {
				System.out.println("삭제 실패 : 존재하지 않는 이메일");
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		
	}
	
	
	
	public static void main(String[] args) {
//		user.insert(new UserDto("min","2345","민종윤","bad"));
//		user.update(new UserDto("Yoon","1357","민종윤","bad"));
//		user.delete(new UserDto(null,null,null,"bad"));
		List<UserDto> list = UserDao.getAll();
		for(UserDto users : list) {
			System.out.println(users);
		}
	}
}
