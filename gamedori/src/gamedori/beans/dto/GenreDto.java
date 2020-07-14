package gamedori.beans.dto;

public class GenreDto {
	private int genre_no;
	private String genre_type;
	
	public GenreDto() {
		super();
	}

	public int getGenre_no() {
		return genre_no;
	}

	public void setGenre_no(int genre_no) {
		this.genre_no = genre_no;
	}

	public String getGenre_type() {
		return genre_type;
	}

	public void setGenre_type(String genre_type) {
		this.genre_type = genre_type;
	}
	
}
