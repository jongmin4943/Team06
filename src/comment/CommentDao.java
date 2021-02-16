package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class CommentDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void insertComment(CommentDto cDto) {
		String insert = "INSERT INTO COMMENT VALUES(null,?,?,?,?)";
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(insert);
			pstmt.setString(1, cDto.getUserID());
			pstmt.setString(2, cDto.getBoardNo());
			pstmt.setString(3, cDto.getContent());
			pstmt.setString(4, getDate());
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
//				System.out.println("입력성공");
			} else {
				System.out.println("입력실패");
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	
	private String getDate() {
		String getDate = "SELECT NOW()";
		try {
			PreparedStatement ps = conn.prepareStatement(getDate);
			rs = ps.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<CommentDto> getComment(String boardno) {
		String select = "SELECT * FROM COMMENT WHERE boardNO=?";
		List<CommentDto> list = new ArrayList<CommentDto>();
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(select);
			pstmt.setString(1, boardno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentDto cDto = new CommentDto();
				cDto.setUserID(rs.getString(2));
				cDto.setBoardNo(rs.getString(3));
				cDto.setContent(rs.getString(4));
				cDto.setDate(rs.getString(5));
				list.add(cDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return list;
	}
	
	public CommentDto selectOne(String no) {
		String select = "SELECT * FROM COMMENT WHERE boardNO=?";
		conn = JdbcUtil.getConnection();
		CommentDto cDto = null;
		try {
			pstmt = conn.prepareStatement(select);
			pstmt.setString(1, no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cDto = new CommentDto();
				cDto.setNo(Integer.toString(rs.getInt(1)));
				cDto.setUserID(rs.getString(2));
				cDto.setBoardNo(rs.getString(3));
				cDto.setContent(rs.getString(4));
				cDto.setDate(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return cDto;
	}
	public void delete(CommentDto cDto) {
		conn = JdbcUtil.getConnection();
		String delectOne = "DELETE FROM COMMENT WHERE NO=?";
		try {
			pstmt = conn.prepareStatement(delectOne);
			pstmt.setString(1, cDto.getNo());
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) {
//				System.out.println("삭제성공");
			} else {
				System.out.println("삭제실패");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
}
