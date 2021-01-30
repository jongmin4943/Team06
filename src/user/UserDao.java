package user;

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
	static final String INSERT = "INSERT INTO USER (ID, PW, NAME, EMAIL) VALUES(?,?,?,?)";
	static final String UPDATE = "UPDATE USER SET ID=?, PW=?, NAME=? WHERE EMAIL=?";
	static final String DELETE = "DELETE FROM USER WHERE EMAIL=?";
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
	public void insert(UserDto dto) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(INSERT);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) {
				System.out.println("입력 성공");
				conn.commit();
			} else {
				System.out.println("입력 실패");
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	
	private void update(UserDto user) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(UPDATE);
			
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPw());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getEmail());
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
				System.out.println("수정 성공");
				conn.commit();
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
	
	private void delete(UserDto user) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(DELETE);
			pstmt.setString(1, user.getEmail());
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) {
				System.out.println("삭제 완료");
				conn.commit();
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
