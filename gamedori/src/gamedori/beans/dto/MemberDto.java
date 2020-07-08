package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDto {

	private int member_no, member_point;
	private String member_name, member_id, member_pw, member_nick, member_phone
	, member_auth, member_join_date, member_login_date;
	
	public MemberDto() {
		super();
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getMember_point() {
		return member_point;
	}

	public void setMember_point(int member_point) {
		this.member_point = member_point;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_nick() {
		return member_nick;
	}

	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_auth() {
		return member_auth;
	}

	public void setMember_auth(String member_auth) {
		this.member_auth = member_auth;
	}

	public String getMember_join_date() {
		return member_join_date;
	}

	public void setMember_join_date(String member_join_date) {
		this.member_join_date = member_join_date;
	}

	public String getMember_login_date() {
		return member_login_date;
	}

	public void setMember_login_date(String member_login_date) {
		this.member_login_date = member_login_date;
	}
	
	public MemberDto(ResultSet rs) throws SQLException {
		this.setMember_no(rs.getInt("member_no"));
		this.setMember_name(rs.getString("member_name"));
		this.setMember_id(rs.getString("member_id"));
		this.setMember_pw(rs.getString("member_pw"));
		this.setMember_nick(rs.getString("member_nick"));
		this.setMember_phone(rs.getString("member_phone"));
		this.setMember_auth(rs.getString("member_auth"));
		this.setMember_point(rs.getInt("member_point"));
		this.setMember_join_date(rs.getString("member_join_date"));
		this.setMember_login_date(rs.getString("member_login_date"));
	}
	
}