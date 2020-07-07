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

import gamedori.beans.dto.QnaDto;

public class QnaDao {
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
	
	//목록 메소드
		public List<QnaDto> getList(int Qna_no) throws Exception{
			Connection con = getConnection();
			
			String sql = "SELECT * FROM Qna ORDER BY Qna_no DESC";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1,Qna_no);
			ResultSet rs = ps.executeQuery();
			
			List<QnaDto> list = new ArrayList<>();
			while(rs.next()) {
				QnaDto qdto = new QnaDto(rs);
				list.add(qdto);
			}
			
			con.close();
			return list;
		}
		
		//검색 메소드
		public List<QnaDto> search(String type, String keyword ,int start,int finish) throws Exception{
			Connection con = getConnection();
			
			String sql = "SELECT * FROM("
					+ "SELECT ROWNUM rn, T.* FROM("
					+ "SELECT * FROM board "
					+ "WHERE instr(#1, ?) > 0 "
					+ "CONNECT BY PRIOR board_no = super_no "
					+ "START WITH super_no IS NULL "
					+ "ORDER SIBLINGS BY group_no DESC, board_no ASC"
				+ ")T"
			+ ") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setInt(2, start);
			ps.setInt(3,finish);
			
			ResultSet rs = ps.executeQuery();
			
			List<QnaDto> list = new ArrayList<>();
			while(rs.next()) {
				QnaDto qdto = new QnaDto(rs);
				list.add(qdto);
			}
			
			con.close();
			return list;
		}
		
		//단일조회
		public BoardDto get(int board_no) throws Exception {
			Connection con = getConnection();
			
			String sql = "SELECT * FROM board WHERE board_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, board_no);
			ResultSet rs = ps.executeQuery();
			
//			BoardDto bdto = 객체 or null;
//			BoardDto bdto;
//			if(rs.next()) {
//				bdto = new BoardDto(rs);
//			}
//			else {
//				bdto = null;
//			}
			BoardDto bdto = rs.next() ? new BoardDto(rs) : null;//3항 연산자
			
			con.close();
			
			return bdto;
		}
	

}
