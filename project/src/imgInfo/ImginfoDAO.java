package imgInfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import boards.Boards;
import imgInfo.ImgInfo;

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

	public ArrayList<ImgInfo> getPosNum() {
		String sql = "SELECT DISTINCT latitude, longitude FROM img_info";
		ArrayList<ImgInfo> list = new ArrayList<ImgInfo>();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ImgInfo imgInfo = new ImgInfo();
				imgInfo.setLatitude(rs.getString(1));
				imgInfo.setLongitude(rs.getString(2));
				list.add(imgInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int getPosCount(String lat, String lng){
		int count = 0;
		String sql = "select count(*) from img_info where latitude=? and longitude=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count; // 총 레코드 수 리턴
	}
	
	public ArrayList<ImgInfo> equalPos(String lat, String lng) {
		String sql = "SELECT * FROM img_info where latitude=? and longitude=?";
		ArrayList<ImgInfo> list = new ArrayList<ImgInfo>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ImgInfo imgInfo = new ImgInfo();
				imgInfo.setLatitude(rs.getString(1));
				imgInfo.setLongitude(rs.getString(2));
				imgInfo.setImg_path(rs.getString(3));
				list.add(imgInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public ImgInfo posData(String lat, String lng) {
		try {
			String SQL = "select * from img_info where latitude = ? and longitude=?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ImgInfo imgInfo = new ImgInfo();
				imgInfo.setLatitude(rs.getString(1));
				imgInfo.setLongitude(rs.getString(2));
				imgInfo.setImg_path(rs.getString(3));
				return imgInfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
