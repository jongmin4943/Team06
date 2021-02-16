package comment;

public class CommentDto {
	private String no;
	private String userID;
	private String boardNo;
	private String content;
	private String date;
	public CommentDto() {
		this(null,"", "", "", "");
	}

	public CommentDto(String no, String userID, String boardNo, String content, String date) {
		super();
		this.no = no;
		this.userID = userID;
		this.boardNo = boardNo;
		this.content = content;
		this.date = date;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "CommentDto [no=" + no + ", userID=" + userID + ", boardNo=" + boardNo + ", content=" + content
				+ ", date=" + date + "]";
	}

	
}
