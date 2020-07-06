package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.MemberDto;

public class MemberDao {
	
	private static DataSource src;
	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context)ctx.lookup("java:/comp/env");
			src = (DataSource)env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 연결 메소드
			public Connection getConnection() throws Exception {
//			
				return src.getConnection();
			}

			// 가입 메소드
			public void join(MemberDto mdto) throws Exception {
				Connection con = getConnection();

				String sql = "INSERT INTO member VALUES(member_seq.nextval, ?, ?, ?, ?, ?, '일반',0, sysdate, null)";
				PreparedStatement ps = con.prepareStatement(sql);

				ps.setString(1, mdto.getMember_name());
				ps.setString(2, mdto.getMember_id());
				ps.setString(3, mdto.getMember_pw());
				ps.setString(4, mdto.getMember_nick());
				ps.setString(5, mdto.getMember_phone());

				ps.execute();

				con.close();
			}
	
}
