package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class FAQNickDto {
	private int member_no;
	private String faq_head;
	private String faq_title;
	private String member_nick;
	private int faq_no;
	public int getFaq_no() {
		return faq_no;
	}

	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}

	public FAQNickDto() {
		super();
	}

	public String getMember_nick() {
		return member_nick;
	}

	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
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
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public FAQNickDto(ResultSet rs) throws SQLException {
		this.setMember_no(rs.getInt("member_no"));
		this.setFaq_no(rs.getInt("faq_no"));
		this.setFaq_head(rs.getString("faq_head"));
		this.setFaq_title(rs.getString("faq_title"));
		this.setMember_nick(rs.getString("member_nick"));
	}
}
