package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.MemberDto;

public class QnaWriterDao {
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
	
	//작성자 정보 메소드
	
	public MemberDto getWriter() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT m.member_nick FROM member m  INNER JOIN qna q "
				+ "ON m.member_no = q.member_no";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		MemberDto mdto = rs.next()? new MemberDto(rs): null;
		
		con.close();
		
		return mdto;

	}

}
