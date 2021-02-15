package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import util.JdbcUtil;

public class BoardDao {
	private static Connection conn = null;
	private static Statement stmt = null;
	private static PreparedStatement pstmt = null;
	private static ResultSet rs = null;
	static final String SELECT = "SELECT * FROM BOARD ORDER BY no DESC";
	static final String SELECTBD = "SELECT * FROM BOARD WHERE no=?";
	static final String INSERT = "INSERT INTO BOARD VALUES(?,?,?,?,null)";
	static final String UPDATE = "UPDATE BOARD SET title=?, name=?, textarea=? WHERE no=?"; // 나중에처리
	static final String DELETE = "DELETE FROM BOARD WHERE no=?"; // 나중에 다시선정
	static final String UPSTREAM = "SELECT * FROM BOARD ";

	public static void insert(BoardDto dto) {
		conn = JdbcUtil.getConnection();

		try {
			pstmt = conn.prepareStatement(INSERT);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTextarea());
			pstmt.setString(4, dto.getWriter());
			int cnt = pstmt.executeUpdate();
			if (cnt > 0) {
				System.out.println("저장 완료!");
				conn.commit();
			} else {
				System.out.println("저장 실패!");
				conn.rollback();
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
			JdbcUtil.close(stmt);
		}
	}

	/*
	 * public static List<BoardDto> SelectAll() { List<BoardDto> list = new
	 * ArrayList<BoardDto>(); conn = JdbcUtil.getConnection(); try { stmt =
	 * conn.createStatement(); rs = stmt.executeQuery(SELECT); while (rs.next()) {
	 * BoardDto board = new BoardDto(); board.setTitle(rs.getString(1));
	 * board.setName(rs.getString(2)); board.setWriter(rs.getString(4));
	 * board.SetNo(rs.getString(5)); list.add(board); } } catch (SQLException e) {
	 * e.printStackTrace(); } finally { JdbcUtil.close(rs, stmt, conn); } return
	 * list;
	 * 
	 * }
	 */

	public static BoardDto selectOne(BoardDto dto) {
		BoardDto otd = null;
		conn = JdbcUtil.getConnection();

		try {
			pstmt = conn.prepareStatement(SELECTBD);
			pstmt.setString(1, dto.getNo());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				otd = new BoardDto();
				otd.setTitle(rs.getString(1));
				otd.setName(rs.getString(2));
				otd.setTextarea(rs.getString(3));
				otd.setWriter(rs.getString(4));
				otd.SetNo(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return otd;
	}

	public static void delete(BoardDto dto) {
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(DELETE);
			pstmt.setString(1, dto.getNo());
			int cnt = pstmt.executeUpdate();
			if (cnt > 0) {
				System.out.println("삭제되었습니다.");
				conn.commit();
			} else {
				System.out.println("삭제시키지 못했습니다.");
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	public static void modify(BoardDto dto) {
		conn = JdbcUtil.getConnection();
		
		try {
			pstmt= conn.prepareStatement(UPDATE);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTextarea());
			pstmt.setString(4, dto.getNo());
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
				System.out.println("수정되었습니다.");
				conn.commit();
			}else {
				System.out.println("수정하지 못했습니다.");
				conn.rollback();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
	}
	
	public int selectCnt(String table) {
		int result = 0;
		ResultSet rs = null;
		String sql = "select count(*) from "+table;
		conn = JdbcUtil.getConnection();
		try {
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return result;
	}
	public List<BoardDto> selectPage(String table, int start, int pageCnt){
		ResultSet rs = null;
		String SQL = "SELECT * FROM "+table+" ORDER BY no DESC limit ?, ?";
		List<BoardDto> v = new ArrayList<BoardDto>();
		conn = JdbcUtil.getConnection();
		
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageCnt);
			rs= pstmt.executeQuery();
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				dto.setTitle(rs.getString("title"));
				dto.setName(rs.getString("name"));
				dto.setTextarea(rs.getString("textarea"));
				dto.setWriter(rs.getString("writer"));
				dto.SetNo(rs.getString("no"));
				v.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
			if(rs !=null) {
					rs.close();
				} 
			if(pstmt !=null) {
				pstmt.close();
			} 
			if(conn !=null) {
				conn.close();
			} 
			
			}catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return v;
	}

}
