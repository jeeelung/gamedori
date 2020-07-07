package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	
	public Connection getConnection() throws Exception{
		return src.getConnection();
	}
	public int getSequence() throws Exception{
		Connection con = getConnection();
		String sql = "select file_seq.nextval form dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		con.close();
		return seq;
	}
	public void save(FilesDto fdto) throws Exception{
		Connection con = getConnection();
		String sql = "insert into files values(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fdto.getFile_no());
		ps.setString(2, fdto.getFile_name());
		ps.setLong(3, fdto.getFile_size());
		ps.setString(4, fdto.getFile_type());
		ps.execute();
		con.close();
	}
	public List<FilesDto> getList(int file_name) throws Exception {
		Connection con = getConnection();
		String sql = "select * from files where file_name = ? order by file_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_name);
		ResultSet rs = ps.executeQuery();
		List<FilesDto> list = new ArrayList<>();
		while(rs.next()) {
			FilesDto fdto = new FilesDto(rs);
			list.add(fdto);
		}
		con.close();
		return list;
	}
	public FilesDto get(int file_no) throws Exception {
		Connection con = getConnection();
		String sql = "select * from files where file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ResultSet rs = ps.executeQuery();
		FilesDto fdto;
		if(rs.next()) {
			fdto = new FilesDto(rs);
		}
		else {
			fdto = null;
		}
		con.close();
		return fdto;
	}
}
