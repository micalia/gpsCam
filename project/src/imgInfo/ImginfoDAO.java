package imgInfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ImginfoDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ImginfoDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/gpscam";
			String dbID = "root";
			String dbPassword = "";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int upImgInfo(String lat, String lng, String path) {
		String SQL = "insert into img_info values (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			pstmt.setString(3, path);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}


}
