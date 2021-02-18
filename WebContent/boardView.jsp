<%@page import="comment.CommentDto"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String userID = null;
String switching = "inline-block";
String no = request.getParameter("no");
//System.out.println("no => " + no);
BoardDto board = BoardDao.selectOne(new BoardDto(no));
//	System.out.println(board);
CommentDao cDao = new CommentDao();
List<CommentDto> list = cDao.getComment(no);

String guestID=null;
PrintWriter pr = response.getWriter();
if(session.getAttribute("guestID") != null) {		
	guestID = (String)session.getAttribute("guestID");
}%>
<script src="https://code.jquery.com/jquery.js"></script>
<script>
var guestID = "<%=guestID%>";
var no = "<%=no%>";
$(function() {
	function getComment() {	//댓글 불러오기 함수
		$.get("commentCheckAjax.jsp?boardNo="+no,function(data,status) {
				var commentList = JSON.parse(data.trim()).sent;
				var start = "<span style='width:150px; margin-left:5px'>";
				for(var i = 0; i<commentList.length; i++){
					item = commentList[i];
					if(i>0) {
						start +="<span style='width:150px; margin-left:5px'>";
					}
					if(guestID != item.guestID) {
						option = "<p style='width: 70px;'></p>";
					} else {
						option = "<a class='commentModi' data-comment-no='"+item.commentNo+"' href=''>수정</a><a class='commentDel' data-comment-no='"+item.commentNo+"' href=''>삭제</a>";
					}
					start += item.guestID+"</span><span class='modifying' data-comment-no='"+item.commentNo+"' style='width:670px'>"+item.content+"</span><span style='text-align:right'>"+option+"</span><span style='text-align:left; width:150px;'>"+item.date.substring(0,19)+"</span>";
				}//end for
			$("#reply").html(start);
				
			$('.commentDel').click(function(event) { 	//삭제 링크 클릭
			    event.preventDefault(); 
			    var commentNo = $(this).attr("data-comment-no");
			    deleteComment(commentNo);	//해당 코멘트 삭제
			    return false;
			});//end Del
			
			$('.commentModi').click(function(event) { 	//수정 링크 클릭
			    event.preventDefault();
			    var commentNo = $(this).attr("data-comment-no");
			    var where = $('span[data-comment-no^='+commentNo+']');
				var modi = "<textarea class = 'form-control' name='modiarea' id='modiarea' rows='2' cols='50' style='width:670px'>"+where.text()+"</textarea><input type='button' id='modiBtn' value='댓글 수정' />";
				where.html(modi);
				$('#modiBtn').click(function() {
					event.preventDefault();
					if($("#modiarea").value == "") {
					alert("수정할 댓글을 입력해주세요.");
						return false;
					}
					var modiTxt = $("#modiarea").val();
				    modifyComment(commentNo,modiTxt);	//해당 코멘트 수정
				});
			    return false;
			}); //end Modi
		});
	}
	
	
	getComment();// 시작과 동시에 댓글 호출
	
	
	$('#cBtn').click(function() {
		if(guestID == 'null') {
			var c = confirm('로그인 하시겠습니까?.');
			if(c) {
				top.location.href = 'signIn.jsp';
				return false;
			} else {
				return false;
			}
		} else {
			event.preventDefault();
			if($("#textarea").value == "") {
				alert("댓글을 입력해주세요.");
				return false;
			}
		} //end if
		
		var textarea = $("#textarea").val();
		$.ajax({ //댓글 작성 ajax
			type: "POST",
			url: "commentCheckAjax.jsp",
			data: {comment : textarea,
					boardNo : no		
			},  
			success: function(data) {
				var commentList = JSON.parse(data.trim()).sent;
				var start = "<span style='width:150px; margin-left:5px'>";
				for(var i = 0; i<commentList.length; i++){
					item = commentList[i];
					if(i>0) {
						start +="<span style='width:150px; margin-left:5px'>";
					}
					if(guestID != item.guestID) {
						option = "<p style='width: 70px;'></p>";
					} else {
						option = "<a class='commentModi' data-comment-no='"+item.commentNo+"' href=''>수정</a><a class='commentDel' data-comment-no='"+item.commentNo+"' href=''>삭제</a>";
					}
					start += item.guestID+"</span><span class='modifying' data-comment-no='"+item.commentNo+"' style='width:670px'>"+item.content+"</span><span style='text-align:right'>"+option+"</span><span style='text-align:left; width:150px;'>"+item.date.substring(0,19)+"</span>";
				}//end for
				$("#reply").html(start);
				$("#textarea").val("");
				
				$('.commentDel').click(function(event) { 	//삭제 링크 클릭
				    event.preventDefault(); 
				    var commentNo = $(this).attr("data-comment-no");
				    deleteComment(commentNo);	//해당 코멘트 삭제
				    return false;
				});//end Del
				
				$('.commentModi').click(function(event) { 	//수정 링크 클릭
				    event.preventDefault();
				    var commentNo = $(this).attr("data-comment-no");
				    var where = $('span[data-comment-no^='+commentNo+']');
					var modi = "<textarea class = 'form-control' name='modiarea' id='modiarea' rows='2' cols='50' style='width:670px'>"+where.text()+"</textarea><input type='button' id='modiBtn' value='댓글 수정' />";
					where.html(modi);
					$('#modiBtn').click(function() {
						event.preventDefault();
						if($("#modiarea").value == "") {
						alert("수정할 댓글을 입력해주세요.");
							return false;
						}
						var modiTxt = $("#modiarea").val();
					    modifyComment(commentNo,modiTxt);	//해당 코멘트 수정
					});
				    return false;
				}); //end Modi
			},
			error: function(jqxhr, textStatus, errorThrown) {
				alert("ERROR, STATUS : "+textStatus +", Error thrown : "+errorThrown);
			}
		});
	});
	
	
	function deleteComment(commentNo) {	//댓글 삭제 함수
		var check = confirm("삭제 하시겠습니까?");
		if(check == false) {
			return false;
		} else {
			$.ajax({
				type: "POST",
				url: "commentDeleteAjax.jsp",//삭제 페이지로 이동
				data: {
					commentNo : commentNo		
					},  
				success: function(data) {
					var suc = data.trim();
					getComment();	//삭제 후 댓글 리스트 호출
				},
				error: function(jqxhr, textStatus, errorThrown) {
					alert("ERROR, STATUS : "+textStatus +", Error thrown : "+errorThrown);
				}
			});
		}
	}
	function modifyComment(commentNo,modiTxt) {	//댓글 수정 함수
		$.ajax({
			type: "POST",
			url: "commentModifyAjax.jsp",//수정 페이지로 이동
			data: {
				commentNo : commentNo,
				modiText : modiTxt
				},  
			success: function(data) {
				var suc = data.trim();
				console.log(suc);
				getComment();	//수정 후 댓글 리스트 호출
			},
			error: function(jqxhr, textStatus, errorThrown) {
				alert("ERROR, STATUS : "+textStatus +", Error thrown : "+errorThrown);
			}
		});
	}
});
</script>
</head>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<style>
body {
	width: 1300px;
	padding: 100px;
	background-color: rgb(238, 242, 242);
}

table {
	width: 1100px;
}

.menu {
	width: 100px;
	background-color: lightgray;
	padding: 2px;
	border: 1px;
	text-align: center;
}

.menu2 {
	padding: 0px 10px;
	border: 1px solid rgb(186, 186, 186);
	width: 1000px;
}

#comment {
	height: 500px;
}

a {
	margin: 2px;
}

span {
	display: inline-block;
	margin : 7px 0px;
	word-break:break-all;
}

.reply{
	border-bottom:1px solid lightgray; 
}
</style>
<body data-mode="day">
	<input type="image" src="img/nightbtn.png" id="changebtn" align="right"
		onclick="
			if(document.querySelector('body').dataset.mode ==='day'){
				document.querySelector('body').style.backgroundColor = 'gray';
				document.querySelector('body').style.color = 'white';	
				document.querySelector('table').style.color = 'white';
				document.querySelector('body').dataset.mode = 'night'
				this.src = 'img/daybtn.png'
			}else{
				document.querySelector('body').style.backgroundColor = 'rgb(238,242,242)';
				document.querySelector('body').style.color = 'black';	
				document.querySelector('table').style.color = 'black';	
				document.querySelector('body').dataset.mode = 'day'
				this.src = 'img/nightbtn.png'
			}
		">

	<%
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID==null||!userID.equals((String)board.getWriter())) {
		switching = "none";
	}
	if (board != null) {
	%>
			<hr>
			<h1>맛집보기</h1>
			<p>기억에 남은 식당을 기록하는 곳.</p>
			<br>
			<br>
			<br>
		<table>
			<tr>
				<td class="menu">title</td>
				<td class="menu2" colspan="5"><%=board.getTitle()%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td class="menu">name</td>
				<td class="menu2"><%=board.getName()%></td>
				<td class="menu">writer</td>
				<td class="menu2"><%=board.getWriter()%></td>
				<td class="menu" >date</td>
				<td class="menu2"><%=board.getDate().substring(0, 19)%></td>
			</tr>
			<tr>
				<td class="menu" id="comment">comment</td>
				<td colspan="5" class="menu2"><%=board.getTextarea()%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<div style="backgroundColor=lightgray; margin:10px; width:1080px; border: 1px solid lightgray;">
			<div style="margin-left:7px;">
				<span style="width:150px;">ID</span>
				<span style="width:730px;">comment</span>
				<span style="text-align:left; width:150px;">date</span>
			</div>
		</div>
		<div style="backgroundColor=lightgray; margin:10px; width:1080px; border: 1px solid lightgray;">
			<div class="reply" id="reply"><!-- 받은것 넣는곳 --></div>
		</div>
	<form>
		<table>
			<tr>
				<td colspan="5" >
					<textarea class = "form-control" name="textarea" id="textarea" placeholder="댓글을 남겨보세요." rows="2" cols="50" style="width:1000px"></textarea>
					<input type="hidden" name="no" id="no" value=<%=no%>>
				</td>
				<td colspan="2">
					<input style="height:60px" type="button" id="cBtn" value="댓글 등록" />
				</td>
			</tr>
		</table>
	</form>
	<span style="align:right"><a href="boardList2.jsp">목록</a><span id="non" style="display:<%=switching%>"><a href="boardDelete.jsp?no=<%=board.getNo()%>" onclick='return confirm("삭제 하시겠습니까?")'>삭제</a><a href="boardModi.jsp?no=<%=board.getNo()%>">수정</a></span></span>
	<%
	}
	%>
</body>
</html>