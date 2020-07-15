package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberFavoriteDto {
	
	private int MemberFavorite_no;
	private int genre_no;
	private int member_no;
	
	
	public MemberFavoriteDto() {
		super();
	}
	
	public MemberFavoriteDto (ResultSet rs) throws SQLException {
		setMemberFavorite_no(rs.getInt("memberfavorite_no"));
		setGenre_no(rs.getInt("genre_no"));
		setMember_no(rs.getInt("member_no"));
	}

	public int getMemberFavorite_no() {
		return MemberFavorite_no;
	}

	public void setMemberFavorite_no(int memberFavorite_no) {
		MemberFavorite_no = memberFavorite_no;
	}

	public int getGenre_no() {
		return genre_no;
	}

	public void setGenre_no(int genre_no) {
		this.genre_no = genre_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	
	

}
