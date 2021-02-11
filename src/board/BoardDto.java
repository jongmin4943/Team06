package board;

public class BoardDto {
	private String name;
	private String textarea;
	private String writer;
	private String title;
	private String no;
	public BoardDto() {
		this("","","","","");
	}
	@Override
	public String toString() {
		return "BoardDto [name=" + name + ", textarea=" + textarea + ", writer=" + writer + ", title=" + title + "]";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTextarea() {
		return textarea;
	}
	public void setTextarea(String textarea) {
		this.textarea = textarea;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getNo() {
		return no;
	}
	public void SetNo(String no) {
		this.no=no;
	}


	public BoardDto(String title, String name, String textarea, String writer, String no) {
		this.title = title;
		this.name = name;
		this.textarea = textarea;
		this.writer = writer;
		this.no = no;
	}
	
}
