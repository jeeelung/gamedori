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

import gamedori.beans.dto.FAQNickDto;

public class FAQNickDao {
	
	//context.xml에서 관리하는 자원 객체를 참조할 수 있도록 연결 코드 구현
	private static DataSource src;//리모컨 선언
	
	//static 변수의 초기화가 복잡할 경우에 사용할 수 있는 static 전용 구문
	static {
		try {
			//src = context.xml에서 관리하는 자원의 정보;
			Context ctx = new InitialContext();//탐색 도구
			Context env = (Context) ctx.lookup("java:/comp/env");//Context 설정 탐색
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	//연결 메소드
	public Connection getConnection() throws Exception {
//		Class.forName("oracle.jdbc.OracleDriver");
//		return DriverManager.getConnection(
//				"jdbc:oracle:thin:@localhost:1521:xe", "c##kh", "c##kh");
		return src.getConnection();
	}
	public List<FAQNickDto> getList() throws Exception{
		Connection con = getConnection();
		String sql ="SELECT f.member_no, f.faq_no, f.faq_head, f.FAQ_title, m.member_nick FROM member m INNER JOIN faq f ON m.member_no = f.member_no";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<FAQNickDto> listNick = new ArrayList<>();
		while(rs.next()) {
			FAQNickDto fndto = new FAQNickDto(rs);
			listNick.add(fndto);
		}
		con.close();
		return listNick;
	}
}
