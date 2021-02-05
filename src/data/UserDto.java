package data;

public class UserDto {
	private String userID;
	private String userPassword;
	private String userName;
	private String userEmail;

	public UserDto() {
		this("", "", "", "");
	}

	public UserDto(String userID, String userPassword, String userName, String userEmail) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
		this.userName = userName;
		this.userEmail = userEmail;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
	public String toString() {
		return "UserDto [userID=" + userID + ", userPassword=" + userPassword + ", userName=" + userName
				+ ", userEmail=" + userEmail + "]";
	}
	
}
