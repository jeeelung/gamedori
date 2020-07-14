package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.NoticeFileDto;

public class NoticeFileDao {
	
	private static DataSource src;
	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 연결 메소드
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		return src.getConnection();
	}
	
	// 등록 메소드
	public void save(NoticeFileDto nfdto) throws Exception{
		Connection con = getConnection();
		String sql = "INSERT INTO notice_file VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, nfdto.getNotice_no());
		ps.setInt(2, nfdto.getFile_no());
		ps.execute();
		
		con.close();
	}
	public void deleteFile(int file_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM notice_file WHERE file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ps.execute();
		con.close();
	}
	
	public List<FilesDto> getList(int notice_no) throws Exception{
		Connection con = getConnection();
		String sql = "SELECT f.* "
				+ "FROM files f INNER JOIN Notice_file n "
				+ "ON n.file_no = f.file_no "
				+ "WHERE n.notice_no = ? "
				+ "ORDER BY f.file_no ASC";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, notice_no);
		ResultSet rs = ps.executeQuery();
		
		List<FilesDto> list = new ArrayList<FilesDto>();
		while(rs.next()) {
			FilesDto fdto = new FilesDto(rs);
			list.add(fdto);
		}
		con.close();
		return list;
	}
}