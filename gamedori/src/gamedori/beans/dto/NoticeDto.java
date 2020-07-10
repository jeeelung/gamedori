package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class NoticeDto {
	private int notice_no, member_no, notice_read;
	private String notice_title, notice_content, notice_date;

	public NoticeDto() {
		super();
	}

	// 추가 : ResultSet을 NoticeDto로 변환하는 생성자
	public NoticeDto(ResultSet rs) throws SQLException {
		this.setNotice_no(rs.getInt("notice_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setNotice_title(rs.getString("notice_title"));
		this.setNotice_content(rs.getString("notice_content"));
		this.setNotice_date(rs.getString("notice_date"));
		this.setNotice_read(rs.getInt("notice_read"));
		
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getNotice_read() {
		return notice_read;
	}

	public void setNotice_read(int notice_read) {
		this.notice_read = notice_read;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}

	// 메소드 2개를 추가
	// [1] getBoard_time() : 시간을 반환하는 메소드
	// [2] getBoard_day() : 날짜를 반환하는 메소드
	// [3] getBoard_autotime() : 자동으로 오늘날짜에는 시간을, 아닌 경우는 날짜를 반환
	public String getNotice_time() {
		return notice_date.substring(11, 16);
	}

	public String getNotice_day() {
		return notice_date.substring(0, 10);
	}

	public String getNotice_auto() {
//			Date d = new Date();
//			Format f = new SimpleDateFormat("yyyy-MM-dd");
//			String today = f.format(d);
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if (getNotice_day().equals(today)) {// 오늘 작성한 글이라면
			return getNotice_time();
		} else {// 아니라면
			return getNotice_day();
		}
	}

//		추가된 항목에 대한 변수와 setter/getter 추가
	private int notice_replycount;

	public int getNotice_replycount() {
		return notice_replycount;
	}

	public void setNotice_replycount(int notice_replycount) {
		this.notice_replycount = notice_replycount;
	}

//		계층형 게시판을 위해 추가한 데이터 구현(변수 + setter/getter)
	private int super_no;
	private int group_no;
	private int depth;

	public int getSuper_no() {
		return super_no;
	}

	public void setSuper_no(int super_no) {
		this.super_no = super_no;
	}

	public int getGroup_no() {
		return group_no;
	}

	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

}
