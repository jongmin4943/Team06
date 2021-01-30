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
        
        // 취소 버튼 클릭시 로그인 화면으로 이동
        function goLoginForm() {
            location.href="LoginForm.jsp";
        }
    </script>
    <form action="04loginCheck.jsp" method="post" name="userInfo" 
                onsubmit="return checkValue()">
		<fieldset>
			<legend>Sign In</legend>
			<tr>
                    <td id="title">ID</td>
                    <td>
                        <input type="text" name="id" maxlength="10">
                    </td>
                </tr>
                        
                    <td id="title">Password</td>
                    <td>
                        <input type="text" name="password" maxlength="12">
                    </td>
                </tr>
		</fieldset>
		<input type="submit" value="Sign In">
	</form>
	<form action="http://localhost:8080/MyJourney/signUp.jsp" method="post">
		<input type="submit" value="Sing Up">
	</form>
	<form action="http://localhost:8080/MyJourney/forgotPw.jsp" method="post">
		<input type="submit" value="forgot password?">
	</form>
</body>
</html>


