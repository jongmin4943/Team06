<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
	<script type="text/javascript">
        // 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
        function checkValue()
        {
            if(!document.userInfo.id.value){
                alert("아이디를 입력하세요.");
                return false;
            }
            
            if(!document.userInfo.password.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
        }
        function goSignUpForm() {
            location.href="signUp.jsp";
        }
        function goForgotPwForm() {
            location.href="forgotPw.jsp";
        }
    </script>
 <body>
 <br><br>
        <b><font size="6" color="gray">Sign In</font></b>
        <br><br><br>
    <form action="loginCheck.jsp" method="post" name="userInfo" 
                onsubmit="return checkValue()">
               <table>
				<tr>
                    <td id="title">ID</td>
                    <td>
                        <input type="text" name="id" maxlength="10">
                    </td>
                </tr>
                <tr>
                    <td id="title">Password</td>
                    <td>
                        <input type="text" name="password" maxlength="12">
                    </td>
                </tr>
                </table>
		<input type="submit" value="Sign In">
		<input type="button" value="Sign Up" onclick="goSignUpForm()">
		<input type="button" value="forgot password?" onclick="goForgotPwForm()">
	</form>
</body>
</html>


