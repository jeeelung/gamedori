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

import gamedori.beans.dto.FAQFileDto;
import gamedori.beans.dto.FilesDto;

public class FAQFileDao {
	
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
	//저장 메소드
	public void save(FAQFileDto ffdto) throws Exception {
		Connection con = getConnection();
		
		String sql = "INSERT INTO FAQ_file VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, ffdto.getFaq_no());
		ps.setInt(2, ffdto.getFile_no());
		ps.execute();
		
		con.close();
	}
	public List<FilesDto> getList(int faq_no) throws Exception{
		Connection con = getConnection();
		String sql = "select * from files inner join faq_file on faq.file_no = files.file_no where faq.faq_no = ? order by files.file_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, faq_no);
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