package imgInfo;

import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import imgInfo.DBConnectionMgr;
import imgInfo.ImgInfo;

public class ImginfoDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	/*
	 * public ImginfoDAO() { try { String dbURL =
	 * "jdbc:mysql://localhost:3306/gpscam";//aws도 localhost임 String dbID = "root";
	 * String dbPassword = ""; //String dbPassword = "root";//AWS
	 * Class.forName("com.mysql.jdbc.Driver"); conn =
	 * DriverManager.getConnection(dbURL, dbID, dbPassword); } catch (Exception e) {
	 * e.printStackTrace(); } }
	 */
	private DBConnectionMgr pool = null;
		
		public ImginfoDAO() {
	 	 try{
	 	   pool = DBConnectionMgr.getInstance();
	 	   }catch(Exception e){
	 	      System.out.println("Error : 커넥션 얻어오기 실패");
	 	   }
	     }
		
	public int upImgInfo(String lat, String lng, String path) {
		String SQL = "insert into gpscam.img_info(latitude, longitude, img_path, time) values (?, ?, ?, now())";
		try {
			conn = pool.getConnection();
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
		String sql = "SELECT DISTINCT latitude, longitude FROM gpscam.img_info";
		ArrayList<ImgInfo> list = new ArrayList<ImgInfo>();
		try {
			conn = pool.getConnection();
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
			/*
			 * try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); } catch
			 * (Exception e) { e.printStackTrace(); }
			 */
			pool.freeConnection(conn);
		}
		return list;
	}
	
	public int getPosCount(String lat, String lng){
		int count = 0;
		String sql = "select count(*) from gpscam.img_info where latitude=? and longitude=?";
		try {
			conn = pool.getConnection();
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
			/*
			 * try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); } catch
			 * (Exception e) { e.printStackTrace(); }
			 */
			pool.freeConnection(conn);
		}
		return count; // 총 레코드 수 리턴
	}
	
	public ArrayList<ImgInfo> equalPos(String lat, String lng) {
		String sql = "SELECT * FROM gpscam.img_info where latitude=? and longitude=?";
		ArrayList<ImgInfo> list = new ArrayList<ImgInfo>();
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ImgInfo imgInfo = new ImgInfo();
			
				imgInfo.setNum(rs.getInt(1));
				imgInfo.setLatitude(rs.getString(2));
				imgInfo.setLongitude(rs.getString(3));
				imgInfo.setImg_path(rs.getString(4));
				imgInfo.setTime(rs.getString(5));
				list.add(imgInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			/*
			 * try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); } catch
			 * (Exception e) { e.printStackTrace(); }
			 */
			pool.freeConnection(conn);
		}
		return list;
	}
	
	public ImgInfo posData(String lat, String lng) {
		try {
			conn = pool.getConnection();
			String SQL = "select * from gpscam.img_info where latitude = ? and longitude=?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ImgInfo imgInfo = new ImgInfo();
				
				imgInfo.setNum(rs.getInt(1));
				imgInfo.setLatitude(rs.getString(2));
				imgInfo.setLongitude(rs.getString(3));
				imgInfo.setImg_path(rs.getString(4));
				imgInfo.setTime(rs.getString(5));
				return imgInfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn);
		}
		return null;
	}
	
	public ImgInfo infoGet(String num) {
		int n = Integer.parseInt(num);
		String SQL = "select * from gpscam.img_info where num = ?";
		try {
			conn = pool.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, n);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ImgInfo info = new ImgInfo();
				info.setNum(rs.getInt(1));
				info.setLatitude(rs.getString(2));
				info.setLongitude(rs.getString(3));
				info.setImg_path(rs.getString(4));
				info.setTime(rs.getString(5));
				return info;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			/*
			 * try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); } catch
			 * (Exception e) { e.printStackTrace(); }
			 */
			pool.freeConnection(conn);
		}
		return null;
	}
	
	
}
