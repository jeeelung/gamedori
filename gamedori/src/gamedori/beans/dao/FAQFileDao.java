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
	
	//시퀀스 생성 메소드
	public int getSequence() throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT FAQ_file_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);//rs.getInt("NEXTVAL");
		
		con.close();
		
		return seq;
	}
	
	//저장 메소드
	// - 시퀀스 번호까지 이미 뽑혀 있으므로 자동 생성할 데이터가 없다
	public void save(FAQFileDto ffdto) throws Exception {
		Connection con = getConnection();
		
		String sql = "INSERT INTO FAQ_file VALUES(?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, ffdto.getFaq_file_no());
		ps.setString(2, ffdto.getFaq_file_name());
		ps.setLong(3, ffdto.getFaq_file_size());
		ps.setString(4, ffdto.getFaq_file_type());
		ps.setInt(5, ffdto.getFaq_origin());
		ps.execute();
		
		con.close();
	}
	
	//게시글 첨부파일 조회(댓글 조회와 동일)
	public List<FAQFileDto> getList(int faq_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM FAQ_file "
							+ "WHERE FAQ_origin = ? "
							+ "ORDER BY FAQ_file_no ASC";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, faq_no);
		ResultSet rs = ps.executeQuery();
		List<FAQFileDto> list = new ArrayList<>();
		while(rs.next()) {
			FAQFileDto ffdto = new FAQFileDto(rs);
			list.add(ffdto);
		}
		con.close();
		return list;
	}
	
	//단일조회 기능
	public FAQFileDto get(int faq_file_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT * FROM FAQ_file WHERE FAQ_file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, faq_file_no);
		ResultSet rs = ps.executeQuery();
		
		FAQFileDto ffdto;
		if(rs.next()) {
			ffdto = new FAQFileDto(rs);
		}
		else {
			ffdto = null;
		}
		
		con.close();
		return ffdto;
	}
}














