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
	static final String INSERT = "INSERT INTO USER VALUES(?,?,?,?)";
	static final String UPDATE = "UPDATE USER SET UserID=?, UserPassword=?, UserName=? WHERE UserEmail=?";
	static final String DELETE = "DELETE FROM USER WHERE UserEmail=?";
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Statement stmt = null;
	
	/**
	 * 유저 정보 전부 얻기
	 * @return 유저정보 ArrayList
	 */
	public List<UserDto> getAll() {
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
	
	/**
	 * 새 유저정보 넣기
	 * @param dto
	 */
	public int insert(UserDto dto) {
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
	
	public int loginCheck(String id, String pw) {
		String selectID = "SELECT * FROM USER WHERE UserID=?";
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(selectID);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pw.equals(rs.getString("userPassword"))) {
					return 1;
				}
			}
			return -1;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	
	public int confirmUser(String id, String name, String email) {
		String selectID = "SELECT * FROM USER WHERE UserID=?";
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(selectID);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(name.equals(rs.getString("userName")) && email.equals(rs.getString("userEmail"))) {
					return 1;
				}
			}
			return -1;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
		
		
	}
	
	public void update(UserDto user) {
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
	
	public void delete(UserDto user) {
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
		UserDao user = new UserDao();
//		user.insert(new UserDto("min","2345","민종윤","bad"));
//		user.update(new UserDto("Yoon","1357","민종윤","bad"));
//		user.delete(new UserDto(null,null,null,"bad"));
		List<UserDto> list = user.getAll();
		for(UserDto users : list) {
			System.out.println(users);
		}
	}
}
