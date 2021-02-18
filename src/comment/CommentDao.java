package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board.BoardDao;
import board.BoardDto;
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
				BoardDao dao = new BoardDao();
				dao.increseCountCom(cDto.getBoardNo());
//				System.out.println("입력성공");
			} else {
				System.out.println("입력실패");
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
				cDto.setNo(rs.getString(1));
				cDto.setUserID(rs.getString(2));
				cDto.setBoardNo(rs.getString(3));
				cDto.setContent(rs.getString(4));
				cDto.setDate(rs.getString(5));
				list.add(cDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return cDto;
	}
	public void delete(String cNo,String bNo) {
		conn = JdbcUtil.getConnection();
		String delectOne = "DELETE FROM COMMENT WHERE NO=?";
		try {
			pstmt = conn.prepareStatement(delectOne);
			pstmt.setString(1, cNo);
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) {
				BoardDao dao = new BoardDao();
				dao.decreseCountCom(bNo);
//				System.out.println("삭제성공");
			} else {
				System.out.println("삭제할 댓글이 없음");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	public void deletedBoard(BoardDto bDto) {
		conn = JdbcUtil.getConnection();
		String delectFromBoard = "DELETE FROM COMMENT WHERE boardNO=?";
		try {
			pstmt = conn.prepareStatement(delectFromBoard);
			pstmt.setString(1, bDto.getNo());
			int cnt = pstmt.executeUpdate();
			if(cnt > 0) {
//				System.out.println("삭제성공");
			} else {
				System.out.println("삭제할 댓글이 없음");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	public void updateComment(String no, String txt) {
		conn = JdbcUtil.getConnection();
		String modify = "UPDATE COMMENT SET CONTENT = ? WHERE NO = ?";
		try {
			pstmt = conn.prepareStatement(modify);
			pstmt.setString(1, txt);
			pstmt.setString(2, no);
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
//				System.out.println("수정완료");
			} else {
				System.out.println("댓글 수정 실패");
			}
		} catch (SQLException e) {
			System.out.println("댓글 수정실패");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
}
