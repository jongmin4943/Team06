package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import comment.CommentDao;
import util.JdbcUtil;

public class BoardDao {
	private static Connection conn = null;
	private static Statement stmt = null;
	private static PreparedStatement pstmt = null;
	private static ResultSet rs = null;
	static final String SELECT = "SELECT * FROM BOARD ORDER BY no DESC";
	static final String SELECTBD = "SELECT * FROM BOARD WHERE no=?";
	static final String INSERT = "INSERT INTO BOARD VALUES(null,?,?,?,?,?,?,?,?)";
	static final String UPDATE = "UPDATE BOARD SET title=?, name=?, textarea=?, selector=?, picUrl=? WHERE no=?"; // 나중에처리
	static final String DELETE = "DELETE FROM BOARD WHERE no=?"; // 나중에 다시선정
	public static void insert(BoardDto dto) {
		conn = JdbcUtil.getConnection();

		try {
			pstmt = conn.prepareStatement(INSERT);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTextarea());
			pstmt.setString(4, dto.getWriter());
			pstmt.setString(5, getDate());
			pstmt.setString(6, dto.getSelector());
			pstmt.setString(7, dto.getCountCom());
			pstmt.setString(8, dto.getPicUrl());
			int cnt = pstmt.executeUpdate();
			if (cnt > 0) {
//				System.out.println("저장 완료!");
			} else {
				System.out.println("저장 실패!");
				conn.rollback();
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
			JdbcUtil.close(stmt);
		}
	}
	public static String getCommentCount(String boardNo) {
		String selectTop = "SELECT COUNT(BOARDNO) AS best FROM comment where boardNo = ?"; 
		Connection conn = JdbcUtil.getConnection();
		String result = "0";
		try {
			pstmt = conn.prepareStatement(selectTop);
			pstmt.setString(1, boardNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString(1);
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return result;
	}
	private static String getDate() {
		String getDate = "SELECT NOW()";
		conn = JdbcUtil.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement(getDate);
			rs = ps.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
//		System.out.println("널값줄거양");
		return null;
	}
	public List<BoardDto> selectAll() {
		List<BoardDto> list = new ArrayList<BoardDto>();
		conn = JdbcUtil.getConnection();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SELECT);
			while (rs.next()) {
				BoardDto board = new BoardDto();
				board.setNo(Integer.toString(rs.getInt(1)));
				board.setTitle(rs.getString(2));
				board.setName(rs.getString(3));
				board.setTextarea(rs.getString(4));
				board.setWriter(rs.getString(5));
				board.setDate(rs.getString(6));
				board.setSelector(rs.getString(7));
				board.setCountCom(rs.getString(8));
				board.setPicUrl(rs.getString(9));
				list.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			JdbcUtil.close(rs, stmt, conn);
		}
		return list;
	}
	 

	public static BoardDto selectOne(BoardDto dto) {
		BoardDto otd = null;
		conn = JdbcUtil.getConnection();

		try {
			pstmt = conn.prepareStatement(SELECTBD);
			pstmt.setString(1, dto.getNo());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				otd = new BoardDto();
				otd.setNo(rs.getString(1));
				otd.setTitle(rs.getString(2));
				otd.setName(rs.getString(3));
				otd.setTextarea(rs.getString(4));
				otd.setWriter(rs.getString(5));
				otd.setDate(rs.getString(6));
				otd.setSelector(rs.getString(7));
				otd.setCountCom(rs.getString(8));
				otd.setPicUrl(rs.getString(9));
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
		return otd;
	}
	
	public static BoardDto selectOneAfterInsert(BoardDto dto) {
		BoardDto otd = null;
		conn = JdbcUtil.getConnection();
		String SAI="select no from board where Title=? and Name=? and Textarea=? and Writer=? and Selector=? and countCom=?";
		try {
			pstmt = conn.prepareStatement(SAI);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTextarea());
			pstmt.setString(4, dto.getWriter());
			pstmt.setString(5, dto.getSelector());
			pstmt.setString(6, dto.getCountCom());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				otd = new BoardDto();
				otd.setNo(rs.getString(1));
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
		return otd;
	}

	public static void delete(BoardDto dto) {
		conn = JdbcUtil.getConnection();
		CommentDao cDao = new CommentDao();
		cDao.deletedBoard(dto);
		try {
			pstmt = conn.prepareStatement(DELETE);
			pstmt.setString(1, dto.getNo());
			int cnt = pstmt.executeUpdate();
			if (cnt > 0) {
//				System.out.println("삭제되었습니다.");
			} else {
				System.out.println("삭제시키지 못했습니다.");
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
			pstmt.setString(4, dto.getSelector());
			pstmt.setString(5, dto.getPicUrl());
			pstmt.setString(6, dto.getNo());
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
//				System.out.println("수정되었습니다.");
			}else {
				System.out.println("수정하지 못했습니다.");
				conn.rollback();
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return result;
	}
	public int selectFilterCnt(String filter) {
		int result = 0;
		ResultSet rs = null;
		String sql = "select count(*) from board WHERE selector=?";
		conn = JdbcUtil.getConnection();
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, filter);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
				dto.setNo(rs.getString("no"));
				dto.setDate(rs.getString("date"));
				dto.setSelector(rs.getString("selector"));
				dto.setCountCom(rs.getString("countCom"));
				dto.setPicUrl(rs.getString("picUrl"));
				v.add(dto);
			}
			
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
	public List<BoardDto> boardfilter(String table,String filter,int start,int pageCnt) {
		String SQL = "SELECT * FROM "+table+" WHERE selector="+filter+" ORDER BY no DESC limit ?, ?";
		List<BoardDto> list = new ArrayList<BoardDto>();
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageCnt);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDto bDto = new BoardDto();
				bDto.setNo(Integer.toString(rs.getInt(1)));
				bDto.setTitle(rs.getString(2));
				bDto.setName(rs.getString(3));
				bDto.setTextarea(rs.getString(4));
				bDto.setWriter(rs.getString(5));
				bDto.setDate(rs.getString(6));
				bDto.setSelector(rs.getString(7));
				bDto.setCountCom(rs.getString(8));
				bDto.setPicUrl(rs.getString(9));
				list.add(bDto);
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return list;
	}
	public List<BoardDto> search(String keyword,String cate,int start,int pageCnt) {
		String search = "select * from board where "+cate+" like '%"+keyword+"%' ORDER BY no DESC limit ?, ?";
		List<BoardDto> list = new ArrayList<BoardDto>();
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(search);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageCnt);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDto bDto = new BoardDto();
				bDto.setNo(Integer.toString(rs.getInt(1)));
				bDto.setTitle(rs.getString(2));
				bDto.setName(rs.getString(3));
				bDto.setTextarea(rs.getString(4));
				bDto.setWriter(rs.getString(5));
				bDto.setDate(rs.getString(6));
				bDto.setSelector(rs.getString(7));
				bDto.setCountCom(rs.getString(8));
				bDto.setPicUrl(rs.getString(9));
				list.add(bDto);
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return list;
	}
	public List<BoardDto> searchInMine(String keyword,String cate,int start,int pageCnt,String where) {
		String search = "select * from (select * from board where selector="+where+") sub where "+cate+" like '%"+keyword+"%' ORDER BY no DESC limit ?, ?";
		List<BoardDto> list = new ArrayList<BoardDto>();
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(search);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageCnt);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDto bDto = new BoardDto();
				bDto.setNo(Integer.toString(rs.getInt(1)));
				bDto.setTitle(rs.getString(2));
				bDto.setName(rs.getString(3));
				bDto.setTextarea(rs.getString(4));
				bDto.setWriter(rs.getString(5));
				bDto.setDate(rs.getString(6));
				bDto.setSelector(rs.getString(7));
				bDto.setCountCom(rs.getString(8));
				bDto.setPicUrl(rs.getString(9));
				list.add(bDto);
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return list;
	}
	public int selectSearchCnt(String cate, String keyword) {
		int result = 0;
		ResultSet rs = null;
		String sql = "select count(*) from board where "+cate+" like '%"+keyword+"%'";
		conn = JdbcUtil.getConnection();
		try {
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return result;
	}
	public void increseCountCom(String boardNo) {
		String increaseCountCom = "update board set countCom = countCom + 1 where no = ?";
		Connection connec = JdbcUtil.getConnection();
		try {
			pstmt = connec.prepareStatement(increaseCountCom);
			pstmt.setString(1, boardNo);
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
//				System.out.println("수정성공");
			} else {
				System.out.println("수정실패");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void decreseCountCom(String boardNo) {
		String increaseCountCom = "update board set countCom = countCom - 1 where no = ?";
		Connection connec = JdbcUtil.getConnection();
		try {
			pstmt = connec.prepareStatement(increaseCountCom);
			pstmt.setString(1, boardNo);
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
//				System.out.println("수정성공");
			} else {
				System.out.println("수정실패");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public List<BoardDto> selectLatelyHotboard() {
		List<BoardDto> list = new ArrayList<BoardDto>();
		String selectBest = "select * from (SELECT * FROM Board WHERE DATE BETWEEN DATE_ADD(NOW(),INTERVAL -1 WEEK ) AND NOW()) sub ORDER BY countCom DESC LIMIT 5";
		conn = JdbcUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(selectBest);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				dto.setNo(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setTextarea(rs.getString(4));
				dto.setWriter(rs.getString(5));
				dto.setDate(rs.getString(6));
				dto.setSelector(rs.getString(7));
				dto.setCountCom(rs.getString(8));
				dto.setPicUrl(rs.getString(9));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs, pstmt, conn);
		}
		return list;
	}
}
