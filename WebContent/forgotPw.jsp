<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
    <title>Sign Up</title>
    
    <link href='css/join_style.css' rel='stylesheet' style='text/css'/>
 
    <script type="text/javascript">
    
        // 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
        function checkValue()
        {
            if(!document.userInfo.id.value){
                alert("아이디를 입력하세요.");
                return false;
            }
            
            if(!document.userInfo.mail.value){
                alert("이메일을 입력하세요.");
                return false;
            }
        }
        
        // 취소 버튼 클릭시 로그인 화면으로 이동
        function goLoginForm() {
            location.href="LoginForm.jsp";
        }
    </script>
    
</head>
<body>
    <!-- div 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div id="wrap">
        <br><br>
        <b><font size="6" color="gray">Find Password</font></b>
        <br><br><br>
        
        
        <!-- 입력한 값을 전송하기 위해 form 태그를 사용한다 -->
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
                    <td id="title">Name</td>
                    <td>
                        <input type="text" name="name" maxlength="12">
                    </td>
                </tr>
                <tr>
                    <td id="title">E-mail</td>
                    <td>
                        <input type="text" name="mail" maxlength="50">
                    </td>
                </tr>
                    
            </table>
            <br>
            <input type="submit" value="비밀번호 찾기"/>  
        </form>
    </div>
</body>
</html>


