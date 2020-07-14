package gamedori.beans.dto;

import java.sql.ResultSet;

public class GameGenreDto {
	private int game_genre_no;
	private int genre_no;
	private int game_no;
	
	public GameGenreDto() {
		super();
	}
	
	public GameGenreDto(ResultSet rs) throws Exception {
		this.setGame_genre_no(rs.getInt("game_genre_no"));
		this.setGenre_no(rs.getInt("genre_no"));
		this.setGame_no(rs.getInt("game_no"));
	}

	public int getGame_genre_no() {
		return game_genre_no;
	}

	public void setGame_genre_no(int game_genre_no) {
		this.game_genre_no = game_genre_no;
	}

	public int getGenre_no() {
		return genre_no;
	}

	public void setGenre_no(int genre_no) {
		this.genre_no = genre_no;
	}

	public int getGame_no() {
		return game_no;
	}

	public void setGame_no(int game_no) {
		this.game_no = game_no;
	}
	
	
}
