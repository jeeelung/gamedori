package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.FilesDto;

public class FilesDao {

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
	
	// 파일번호 시퀀스
	public int getSequence() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT file_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		
		return seq;
	}
	
	// 파일정보 업로드 메소드
	public void save(FilesDto fdto) throws Exception{
		Connection con = getConnection();
		String sql = "INSERT INTO files values(?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fdto.getFile_no());
		ps.setString(2, fdto.getFile_name());
		ps.setLong(3, fdto.getFile_size());
		ps.setString(4, fdto.getFile_type());
		
		ps.execute();
		
		con.close();
	}
	
	public FilesDto get(int file_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM files WHERE file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ResultSet rs = ps.executeQuery();
		
		FilesDto fdto = rs.next()? new FilesDto(rs): null;
		con.close();
		return fdto;
	}
}
