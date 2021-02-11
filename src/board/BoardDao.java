package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;

public class BoardDao {
	private static Connection conn = null;
	private static Statement stmt,rvs = null;
	private static PreparedStatement pstmt = null;
	private static ResultSet rs = null;
	static final String SELECT = "SELECT * FROM BOARD";
	static final String SELECTID = "SELECT * FROM BOARD WHERE name=?";
	static final String INSERT = "INSERT INTO BOARD VALUES(?,?,?,?,null)";
	static final String UPDATE = "UPDATE BOARD SET textarea=? WHERE name=?"; // 나중에처리
	static final String DELETE = "DELETE FROM BOARD WHERE name=?"; // 나중에 다시선정
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
	public static List<BoardDto> SelectAll(){
		List<BoardDto> list = new ArrayList<BoardDto>();
		conn = JdbcUtil.getConnection();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SELECT);
			while(rs.next()) {
				BoardDto board = new BoardDto();
				board.setTitle(rs.getString(1));
				board.setName(rs.getString(2));
				board.setWriter(rs.getString(4));
				board.SetNo(rs.getString(5));
				list.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs,stmt,conn);
		}
		return list;
		
	}
}
