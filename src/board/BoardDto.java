package board;

public class BoardDto {
	private String no;
	private String title;
	private String name;
	private String textarea;
	private String writer;

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

	public BoardDto(String no, String title, String name, String textarea, String writer) {
		this.no = no;
		this.title = title;
		this.name = name;
		this.textarea = textarea;
		this.writer = writer;
	}
	public BoardDto() {
		this("", "", "", "","");
	}
	public BoardDto(String no) {
		this(no, "", "", "","");
	}
	@Override
	public String toString() {
		return "BoardDto [no=" + no + ", title=" + title + ", name=" + name + ", textarea=" + textarea + ", writer="
				+ writer + "]";
	}
}
