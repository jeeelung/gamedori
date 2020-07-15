package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class QnaDto {
	private int qna_no, member_no;
	private String qna_head,qna_title,qna_content,qna_email,qna_date,qna_answer;
	public QnaDto() {
		super();
	}
	public QnaDto(ResultSet rs) throws SQLException{
	 this.setQna_no(rs.getInt("qna_no"));
	 this.setMember_no(rs.getInt("member_no"));
	this.setQna_head(rs.getString("qna_head"));
	this.setQna_title(rs.getString("qna_title"));
	this.setQna_content(rs.getString("qna_content"));
	this.setQna_email(rs.getString("qna_email"));
	this.setQna_date(rs.getString("qna_date"));
	this.setQna_answer(rs.getString("qna_answer"));

	}
	
	public int getQna_no() {
		return qna_no;
	}
	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getQna_head() {
		return qna_head;
	}
	public void setQna_head(String qna_head) {
		this.qna_head = qna_head;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public String getQna_email() {
		return qna_email;
	}
	public void setQna_email(String qna_email) {
		this.qna_email = qna_email;
	}
	public String getQna_date() {
		return qna_date;
	}
	public void setQna_date(String qna_date) {
		this.qna_date = qna_date;
	}
	public String getQna_answer() {
		return qna_answer;
	}
	public void setQna_answer(String qna_answer) {
		this.qna_answer = qna_answer;
	}
	
	
	

}
