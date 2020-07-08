package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.FAQFileDto;

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
	
	
	
	
}