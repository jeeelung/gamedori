package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class FAQDto {
	private int faq_no, member_no;
	private String faq_head, faq_title, faq_content;
	public FAQDto() {
		super();
	}
	public int getFaq_no() {
		return faq_no;
	}
	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getFaq_head() {
		return faq_head;
	}
	public void setFaq_head(String faq_head) {
		this.faq_head = faq_head;
	}
	public String getFaq_title() {
		return faq_title;
	}
	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	public FAQDto(ResultSet rs) throws SQLException {
		this.setFaq_no(rs.getInt("faq_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setFaq_head(rs.getString("faq_head"));
		this.setFaq_title(rs.getString("faq_title"));
		this.setFaq_content(rs.getString("faq_content"));
	}
}