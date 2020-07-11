package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.MemberDto;
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
		public List<QnaDto> getList(int member_no, String auth, int start , int finish) throws Exception{
			Connection con = getConnection();
			String sql = "SELECT * FROM( "
					+ "SELECT ROWNUM rn, T.* FROM( "
					+ "SELECT * FROM qna q INNER JOIN MEMBER m ON q.MEMBER_NO = m.MEMBER_NO "
					+ "WHERE (q.member_no=? OR '관리자' = ? ) "
					+ "ORDER BY qna_no desc "
					+ ")T "
				+ ") WHERE rn BETWEEN ? and ?";
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1, member_no);
			ps.setString(2, auth);
			ps.setInt(3, start);
			ps.setInt(4, finish);
			
		
			
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
		public List<QnaDto> search(String type, String auth, String keyword, int member_no, int start, int finish) throws Exception{
			Connection con = getConnection();
			
			String sql = "SELECT * FROM( "
					+ "SELECT ROWNUM rn, T.* FROM( "
					+ "SELECT * FROM qna q INNER JOIN MEMBER m ON q.MEMBER_NO = m.MEMBER_NO "
					+ "WHERE instr(#1, ?) > 0 and (q.member_no=? OR '관리자' = ?) " 
					+ "ORDER BY qna_no desc "
					+ ")T "
				+ ") WHERE rn BETWEEN ? and ?";
					
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);			
			ps.setString(1, keyword);
			ps.setInt(2, member_no);
			ps.setString(3,auth);
			ps.setInt(4, start);
			ps.setInt(5, finish);
			
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
		public QnaDto get(int Qna_no) throws Exception {
			Connection con = getConnection();
			
			String sql = "SELECT * FROM qna WHERE Qna_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, Qna_no);
			ResultSet rs = ps.executeQuery();
			

			QnaDto qdto = rs.next() ? new QnaDto(rs) : null;//3항 연산자
			
			con.close();
			
			return qdto;
		}
		//시퀀스 생성
		// - dual 테이블은 오라클이 제공하는 임시 테이블
		public int getSequence() throws Exception{
			Connection con = getConnection();
			
			String sql = "SELECT qna_seq.nextval FROM dual";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int seq = rs.getInt(1);//rs.getInt("NEXTVAL");
			
			con.close();
			
			return seq;
		}
		
		// 게시물 등록 메소드
		public void write(QnaDto qdto) throws Exception{
			Connection con = getConnection();
			String sql = "INSERT INTO qna"
					+ "("
					+ "qna_no, "
					+ "member_no, "
					+ "qna_head, "
					+ "qna_title, "
					+ "qna_content, "
					+ "qna_email, "
					+ "qna_answer "
					+ ") "
					+ "values(?,?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, qdto.getQna_no());
			ps.setInt(2, qdto.getMember_no());
			ps.setString(3, qdto.getQna_head());
			ps.setString(4, qdto.getQna_title());
			ps.setString(5, qdto.getQna_content());
			ps.setString(6, qdto.getQna_email());
			ps.setString(7, qdto.getQna_answer());
			
			ps.execute();
			con.close();
		}
		
		//관리자 문의 답변 메소드
		
	
		//게시글 삭제
		public void delete(int qna_no) throws Exception {
			Connection con = getConnection();

			String sql = "DELETE qna WHERE qna_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, qna_no);
			ps.execute();
			
			
			con.close();
		}
		
		//게시글 수정
		public void edit(QnaDto qdto) throws Exception {
			Connection con = getConnection();
			
			String sql = "UPDATE qna SET "
								+ "qna_head=?, qna_title=?, qna_content=?, "
								+ "qna_email=?, qna_answer=? " 
								+ "where qna_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, qdto.getQna_head());
			ps.setString(2, qdto.getQna_title());
			ps.setString(3, qdto.getQna_content());
			ps.setString(4, qdto.getQna_email());	
			ps.setString(5, qdto.getQna_answer());				
			ps.setInt(6, qdto.getQna_no());
			ps.execute();
			
			con.close();
		}
		//개수 조회 메소드
		public int getCount() throws Exception{
			Connection con = getConnection();
			String sql="select count(*) from qna";
			PreparedStatement ps=con.prepareStatement(sql);
			ResultSet rs= ps.executeQuery();
			rs.next();
			int count =rs.getInt(1); //또는 rs.getInt ("count(*)");
			con.close();
			
			return count;
		}
		
		public int getCount(String type,String keyword,int member_no, String auth) throws Exception{
			Connection con = getConnection();
			String sql = "SELECT count (*)  FROM qna q INNER JOIN MEMBER m ON q.member_no = m.member_no "
					+ "WHERE instr(#1, ?) > 0 and (q.member_no= ? or '관리자'=?) "
					+ "order by qna_no desc";
					
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setInt(2, member_no);
			ps.setString(3, auth);
			
			
			ResultSet rs= ps.executeQuery();
			rs.next();
			int count = rs.getInt(1); //또는 rs.getInt("count(*));
			
			con.close();
			return count;
			
		}
		//문의글 작성자 닉네임 불러오기 
		
		public MemberDto getWriter(int member_no) throws Exception {
			Connection con = getConnection();
			String sql = "SELECT m.* "
					+ "FROM member m  INNER JOIN qna q "
					+ "ON m.member_no = q.member_no "
					+ "where q.member_no= ? ";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, member_no);
			ResultSet rs = ps.executeQuery();
			MemberDto mdto = rs.next()? new MemberDto(rs): null;
			con.close();
			return mdto;
		}
}


