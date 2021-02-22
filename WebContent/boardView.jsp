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
String who = request.getParameter("who");
String currPage = request.getParameter("currPage");
String cate = request.getParameter("cate");
String keyword = request.getParameter("keyword");
System.out.println("no : "+ no);
BoardDto board = BoardDao.selectOne(new BoardDto(no));
System.out.println("board : "+ board);
CommentDao cDao = new CommentDao();
List<CommentDto> list = cDao.getComment(no);

String guestID=null;
PrintWriter pr = response.getWriter();
if(session.getAttribute("guestID") != null) {		
	guestID = (String)session.getAttribute("guestID");
}
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if (userID==null||!userID.equals((String)board.getWriter())) {
	switching = "none";
}
%>
<script src="https://code.jquery.com/jquery.js"></script>
<script>
var guestID = "<%=guestID%>";
var no = "<%=no%>";
var flag = false;
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
				if(!flag) {
					flag = true;
				    event.preventDefault();
				    var commentNo = $(this).attr("data-comment-no");
				    var where = $('span[data-comment-no^='+commentNo+']'); // content와 option 둘다 해당되지만 content가 먼저 나오는걸 이용, 선택한다.
					var modi = "<textarea class = 'form-control' name='modiarea' id='modiarea' rows='2' cols='50' style='width:670px'>"+where.text()+"</textarea><input type='button' id='modiBtn' value='댓글 수정' />";
					where.html(modi);
					$('#modiBtn').click(function() {
						event.preventDefault();
						if($("#modiarea").val() == "") {
						alert("수정할 댓글을 입력해주세요.");
							return false;
						}
						var modiTxt = $("#modiarea").val();
					    modifyComment(commentNo,modiTxt);	//해당 코멘트 수정
					});
				} else {
					alert("수정은 한번에 하나만 가능합니다.");
				}
			    return false;
			}); //end Modi
		});
	}
	
	getComment();// 시작과 동시에 댓글 호출
	getAroundBoard();//현재 게시글의 전 , 현 , 후 글 불러오기
	
	
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
			if($("#textarea").val() == "") {
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
					if(!flag) {
						flag = true;
					    event.preventDefault();
					    var commentNo = $(this).attr("data-comment-no");
					    var where = $('span[data-comment-no^='+commentNo+']');
						var modi = "<textarea class = 'form-control' name='modiarea' id='modiarea' rows='2' cols='50' style='width:670px'>"+where.text()+"</textarea><input type='button' id='modiBtn' value='댓글 수정' />";
						where.html(modi);
						$('#modiBtn').click(function() {
							event.preventDefault();
							if($("#modiarea").val() == "") {
							alert("수정할 댓글을 입력해주세요.");
								return false;
							}
							var modiTxt = $("#modiarea").val();
						    modifyComment(commentNo,modiTxt);	//해당 코멘트 수정
						});
					} else {
						alert("수정은 한번에 하나만 가능합니다.");
					}
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
					commentNo : commentNo,
					boardNo : no
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
				flag = false;
				getComment();	//수정 후 댓글 리스트 호출
			},
			error: function(jqxhr, textStatus, errorThrown) {
				alert("ERROR, STATUS : "+textStatus +", Error thrown : "+errorThrown);
			}
		});
	}
	var currNo = null;
	var preNo = null;
	var nextNo = null;
	function getAroundBoard() {
		$.ajax({
			type: "POST",
			url: "boardPreNextAjax.jsp",
			data: {
				currentNo : no
			},
			success: function(data) {
				sentJsObj = JSON.parse(data.trim());
				var suc = null;
				if(sentJsObj.preNextBoard != null) {
					suc = sentJsObj.preNextBoard;
					$("#previous").attr("disabled", false);
					$("#next").attr("disabled", false);
					
					//현 게시글 값 담기
					$("#boardTitle").html(suc[1].title);
					$("#boardName").html(suc[1].name);
					$("#boardWriter").html(suc[1].writer);
					$("#boardDate").html(suc[1].date);
					$("#boardContent").html(suc[1].textarea);
					if(suc[1].picUrl == null || suc[1].picUrl == "undefined"){
						suc[1].picUrl = "noPic.jpg";
					};
					$("#picUrl").attr("src", "img/"+suc[1].picUrl)
					//전 게시글 값 담기
					$("#preBoardTitle").html(suc[0].title);
					$("#preBoardName").html(suc[0].name);
					$("#preBoardWriter").html(suc[0].writer);
					$("#preBoardDate").html(suc[0].date);
					$("#preBoardContent").html(suc[0].textarea);
					if(suc[0].picUrl == null || suc[0].picUrl == "undefined"){
						suc[0].picUrl = "noPic.jpg";
					};
					$("#prePicUrl").attr("src", "img/"+suc[0].picUrl)
					//후 게시글 값 담기
					$("#nextBoardTitle").html(suc[2].title);
					$("#nextBoardName").html(suc[2].name);
					$("#nextBoardWriter").html(suc[2].writer);
					$("#nextBoardDate").html(suc[2].date);
					$("#nextBoardContent").html(suc[2].textarea);
					if(suc[2].picUrl == null || suc[2].picUrl == "undefined"){
						suc[2].picUrl = "noPic.jpg";
					};
					$("#nextPicUrl").attr("src", "img/"+suc[2].picUrl)
					resetBoardLocation();
					currNo = suc[1].no;
					preNo = suc[0].no;
					nextNo = suc[2].no;
					resetBoardMenu(currNo);
				} else if (sentJsObj.nextBoard != null) {
					suc = sentJsObj.nextBoard;
					$("#previous").attr("disabled", true);
					$("#next").attr("disabled", false);
					
					//현 게시글 값 담기
					$("#boardTitle").html(suc[0].title);
					$("#boardName").html(suc[0].name);
					$("#boardWriter").html(suc[0].writer);
					$("#boardDate").html(suc[0].date);
					$("#boardContent").html(suc[0].textarea);
					if(suc[0].picUrl == null || suc[0].picUrl == "undefined"){
						suc[0].picUrl = "noPic.jpg";
					};
					$("#picUrl").attr("src", "img/"+suc[0].picUrl)
					//후 게시글 값 담기
					$("#nextBoardTitle").html(suc[1].title);
					$("#nextBoardName").html(suc[1].name);
					$("#nextBoardWriter").html(suc[1].writer);
					$("#nextBoardDate").html(suc[1].date);
					$("#nextBoardContent").html(suc[1].textarea);
					if(suc[1].picUrl == null || suc[1].picUrl == "undefined"){
						suc[1].picUrl = "noPic.jpg";
					};
					$("#nextPicUrl").attr("src", "img/"+suc[1].picUrl)
					resetBoardLocation();
					currNo = suc[0].no;
					nextNo = suc[1].no;
					resetBoardMenu(currNo);
				} else if (sentJsObj.preBoard != null) {
					suc = sentJsObj.preBoard;
					$("#previous").attr("disabled", false);
					$("#next").attr("disabled", true);
					
					//현 게시글 값 담기
					$("#boardTitle").html(suc[1].title);
					$("#boardName").html(suc[1].name);
					$("#boardWriter").html(suc[1].writer);
					$("#boardDate").html(suc[1].date);
					$("#boardContent").html(suc[1].textarea);
					if(suc[1].picUrl == null || suc[1].picUrl == "undefined"){
						suc[1].picUrl = "noPic.jpg";
					};
					$("#picUrl").attr("src", "img/"+suc[1].picUrl)
					//전 게시글 값 담기
					$("#preBoardTitle").html(suc[0].title);
					$("#preBoardName").html(suc[0].name);
					$("#preBoardWriter").html(suc[0].writer);
					$("#preBoardDate").html(suc[0].date);
					$("#preBoardContent").html(suc[0].textarea);
					if(suc[0].picUrl == null || suc[0].picUrl == "undefined"){
						suc[0].picUrl = "noPic.jpg";
					};
					$("#prePicUrl").attr("src", "img/"+suc[0].picUrl)
					resetBoardLocation();
					currNo = suc[1].no;
					preNo = suc[0].no;
					resetBoardMenu(currNo);
				}
			}
 		});
	}
	var clicked = false;
	$("#previous").click(function() {
		if(!clicked) {
			clicked = true;
			$(".board").animate({
				left:1200
			});
			$(".preBoard").animate({
				left:0
			},500,function(){
				no = preNo;
				getAroundBoard();
				getComment();
			});
		}//end click check;
	});//end previous
	$("#next").click(function() {
		if(!clicked) {
			clicked = true;
			$(".board").animate({
				left:-1200
			});
			$(".nextBoard").animate({
				left:0
			},500,function(){
				no = nextNo;
				getAroundBoard();
				getComment();	
			});
		}//end click check
	});//end next
	
	function resetBoardLocation() {
		$(".board").animate({
			left:0
		},0);
		$(".nextBoard").animate({
			left:1200
		},0,function(){
			clicked = false;
		});
		$(".preBoard").animate({
			left:-1200
		},0,function(){
			clicked = false;
		});
	}
	
	function resetBoardMenu(no) {
		var currPage = <%=currPage%>;
		var switching = "<%=switching%>";
		var cate = <%=cate%>;
		var keyword = <%=keyword%>;
		$("#boardMenu01").html('<a href="boardList2.jsp?page='+currPage+'">목록</a><span id="non" style="display:'+switching+'"><a href="boardDelete.jsp?no='+no+'" onclick=\'return confirm("삭제 하시겠습니까?")\'>삭제</a><a href="boardModi.jsp?no='+no+'">수정</a></span>');
		$("#boardMenu02").html('<a href="boardSearch.jsp?page='+currPage+'&cate='+cate+'&keyword='+keyword+'">목록</a><span id="non" style="display:'+switching+'"><a href="boardDelete.jsp?no='+no+'" onclick=\'return confirm("삭제 하시겠습니까?")\'>삭제</a><a href="boardModi.jsp?no='+no+'">수정</a></span>');
		$("#boardMenu03").html('<a href="boardSearch.jsp?page='+currPage+'&cate='+cate+'&keyword='+keyword+'">목록</a><span id="non" style="display:'+switching+'"><a href="boardDelete.jsp?no='+no+'" onclick=\'return confirm("삭제 하시겠습니까?")\'>삭제</a><a href="boardModi.jsp?no='+no+'">수정</a></span>');
		$("#boardMenu04").html('<a href="boardMyList.jsp?page='+currPage+'">목록</a><span id="non" style="display:'+switching+'"><a href="boardDelete.jsp?no='+no+'" onclick=\'return confirm("삭제 하시겠습니까?")\'>삭제</a><a href="boardModi.jsp?no='+no+'">수정</a></span>');
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
.preBoard {
	position: relative;
	left : -1200px;
	top : 1px;
}
.board {
	position: relative;
	left : 0px;
	top : -555px;
}
.nextBoard {
	position: relative;
	left : 1200px;
	top : -1111px;
}
.allBoard {
	 white-space: nowrap;
	 float : left;
	 max-height:580px;
}
img {
	
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
	if (board != null) {
	%>
			<hr>
			<h1>맛집보기</h1>
			<p>기억에 남은 식당을 기록하는 곳.</p>
			<br>
			<br>
			<h4 style="float:left; margin-left: 500px; padding-right: 50px;">
			<button id="previous" disabled="disabled">◀</button></h4>
			<h4><button id="next" disabled="disabled">▶</button></h4>
			<br>
			
		<div style="max-width:1200px; margin : 0 auto; overflow:hidden; ">
			<div class="allBoard">
				<div class="preBoard"><!-- 전 테이블시작 -->
					<table>
						<tr>
							<td class="menu">title</td>
							<td class="menu2" colspan="5" id="preBoardTitle"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="menu">name</td>
							<td class="menu2" id="preBoardName"></td>
							<td class="menu">writer</td>
							<td class="menu2" id="preBoardWriter"></td>
							<td class="menu" >date</td>
							<td class="menu2" id="preBoardDate"></td>
						</tr>
						<tr>
							<td class="menu" id="comment">comment</td>
							<td colspan="4" class="menu2" id="preBoardContent" style="max-width: 500px;"></td>
							<td align=right><img id="prePicUrl" src="img/noPic.jpg" style="width:500px;height:300px;"></img></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div><!-- 테이블 끝 -->
				<div class="board" style="white-space: nowrap;"><!-- 현 테이블시작 -->
					<table>
						<tr>
							<td class="menu">title</td>
							<td class="menu2" colspan="5" id="boardTitle"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="menu">name</td>
							<td class="menu2" id="boardName"></td>
							<td class="menu">writer</td>
							<td class="menu2" id="boardWriter"></td>
							<td class="menu" >date</td>
							<td class="menu2" id="boardDate"></td>
						</tr>
						<tr>
							<td class="menu" id="comment">comment</td>
							<td colspan="4" class="menu2" id="boardContent" style="max-width: 500px;"></td>
							<td align=right><img id="picUrl" src="img/noPic.jpg" style="width:500px;height:300px;"></img></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div><!-- 테이블 끝 -->
				<div class="nextBoard" style="white-space: nowrap;"><!-- 후 테이블시작 -->
					<table>
						<tr>
							<td class="menu">title</td>
							<td class="menu2" colspan="5" id="nextBoardTitle"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="menu">name</td>
							<td class="menu2" id="nextBoardName"></td>
							<td class="menu">writer</td>
							<td class="menu2" id="nextBoardWriter"></td>
							<td class="menu" >date</td>
							<td class="menu2" id="nextBoardDate"></td>
						</tr>
						<tr>
							<td class="menu" id="comment">comment</td>
							<td colspan="4" class="menu2" id="nextBoardContent" style="max-width: 50px;"></td>
							<td align=right><img id="nextPicUrl" src="img/noPic.jpg" style="width:500px;height:300px;"></img></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div><!-- 테이블 끝 -->
			</div>
		</div>
		
		<div style="width:1089px; border: 1px solid lightgray;">
			<div style="margin-left:7px;">
				<span style="width:150px;">ID</span>
				<span style="width:730px;">comment</span>
				<span style="text-align:left; width:150px;">date</span>
			</div>
		</div>
		<div style="margin:10px 0px; width:1089px; border: 1px solid lightgray;">
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
		<%if(who == null && (cate == null && keyword == null)) {%><!--전체목록에서 그냥 들어옴  -->
			<span id="boardMenu01" style="align:right"><a href="boardList2.jsp?page=<%=currPage%>">목록</a><span id="non" style="display:<%=switching%>"><a href="boardDelete.jsp?no=<%=no%>" onclick='return confirm("삭제 하시겠습니까?")'>삭제</a>
			<a href="boardModi.jsp?no=<%=no%>">수정</a></span></span>
		<%} else if(who == null && cate != null && keyword != null) {%><!--전체목록에서 검색 후 들어옴  -->
			<span id="boardMenu02" style="align:right"><a href="boardSearch.jsp?page=<%=currPage%>&cate=<%=cate%>&keyword=<%=keyword%>">목록</a><span id="non" style="display:<%=switching%>"><a href="boardDelete.jsp?no=<%=no%>" onclick='return confirm("삭제 하시겠습니까?")'>삭제</a>
			<a href="boardModi.jsp?no=<%=no%>">수정</a></span></span>
		<%} else if(who != null && cate != null && keyword != null){%><!--내 목록에서 검색 후 들어옴-->
			<span id="boardMenu03" style="align:right"><a href="boardSearch.jsp?page=<%=currPage%>&cate=<%=cate%>&keyword=<%=keyword%>">목록</a><span id="non" style="display:<%=switching%>"><a href="boardDelete.jsp?no=<%=no%>" onclick='return confirm("삭제 하시겠습니까?")'>삭제</a>
			<a href="boardModi.jsp?no=<%=no%>">수정</a></span></span>
		<%} else {%><!--내 목록에서 그냥 들어옴-->
			<span id="boardMenu04" style="align:right"><a href="boardMyList.jsp?page=<%=currPage%>">목록</a><span id="non" style="display:<%=switching%>"><a href="boardDelete.jsp?no=<%=no%>" onclick='return confirm("삭제 하시겠습니까?")'>삭제</a>
			<a href="boardModi.jsp?no=<%=no%>">수정</a></span></span>
		<%} %>
	<%} %>
</body>
</html>