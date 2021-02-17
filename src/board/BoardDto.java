package board;

public class BoardDto {
	private String no;
	private String title;
	private String name;
	private String textarea;
	private String writer;
	private String date;
	private String selector;
	
	public String getSelector() {
		return selector;
	}
	public void setSelector(String selector) {
		this.selector = selector;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public BoardDto(String no, String title, String name, String textarea, String writer, String date,
			String selector) {
		this.no = no;
		this.title = title;
		this.name = name;
		this.textarea = textarea;
		this.writer = writer;
		this.date = date;
		this.selector = selector;
	}
	public BoardDto(String no) {
		this(no, "", "", "","","","");
	}
	public BoardDto() {
	}
	@Override
	public String toString() {
		return "BoardDto [no=" + no + ", title=" + title + ", name=" + name + ", textarea=" + textarea + ", writer="
				+ writer + ", date=" + date + ", selector=" + selector + "]";
	}

}
