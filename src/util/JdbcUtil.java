package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcUtil {
	private static String url = "jdbc:h2:tcp://localhost/~/test";
	private static String user = "sa";
	private static String password = "12345";
	
	//나중에 외부에서 설정하게 하면 된다
	public void set(String url, String user, String password) {
		this.url = url;
		this.user = user;
		this.password = password;
	}
	
	public static Connection getConnection() {
		try {
			Class.forName("org.h2.Driver");
			//드라이버 검색
			//DB 서버가 실행 중이어야 접속 가능.
			Connection conn = DriverManager.getConnection(url, user, password);
			return conn;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public static void close(Connection conn) {
		try {
			if(conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(ResultSet rs) {
		try {
			if(rs != null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		try {
			if(stmt != null) stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void close(ResultSet rs,Statement stmt,Connection conn) {
		close(rs);
		close(stmt);
		close(conn);
	}
}

