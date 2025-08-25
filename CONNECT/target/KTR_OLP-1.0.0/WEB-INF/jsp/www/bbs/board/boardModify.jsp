<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 수정</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h2>게시글 수정</h2>

	<form id="boardForm">
		<input type="hidden" name="boardIdx" id="boardIdx" value="${param.boardIdx}"/>

		<label>제목</label><br/>
		<input type="text" name="title" id="title" style="width:500px;" /><br/><br/>

		<label>내용</label><br/> 
		<textarea name="content" id="content" rows="10" cols="80"></textarea><br/><br/>

		<label>작성자</label><br/>
		<input type="text" name="createUser" id="createUser" /><br/><br/>

		<button type="button" onclick="updateBoard()">수정</button>
		<button type="button" onclick="deleteBoard()">삭제</button>
		<button type="button" onclick="goLink('/board/list')">목록</button>
	</form>

	<script>
	$(document).ready(function () {
		const boardIdx = $("#boardIdx").val();
		if (boardIdx != "") { 
			readBoard(boardIdx);  
		}
	});

	function readBoard(boardIdx) {
		
	    var sendData = {};
	    sendData.boardIdx = $("#boardIdx").val();
	
		$.ajax({
			url: "/api/bbs/board/selectBoardDetail",
			type: "post",      
			contentType: "application/json",   
			dataType: "json",  
			data: JSON.stringify(sendData),   
			success: function (map) {
				var result = map.result;   
				console.log(result);  
				$("#title").val(result.title);  
				$("#content").val(result.content);
				$("#createUser").val(result.createUser);   
			},
			error: function () {
				alert("조회 중 오류 발생");
			}
		});
	}

	function updateBoard() {
		var boardIdx = $("#boardIdx").val();
		var url = "";
		if (boardIdx != "") {      
			url = "/api/bbs/board/updateBoard";
		} else {
			url = "/api/bbs/board/insertBoard";
		}
		
		if ($("#title").val() === "") {
			alert("제목을 입력해주세요."); 
			return;  
		}
		if ($("#content").val() === "") {
			alert("내용을 입력해주세요.");
			return;
		}
		
		const formData = $("#boardForm").serializeObject();
		$.ajax({
			url: url,  
			type: "post",
			contentType: "application/json", 
			dataType: "json",
			data: JSON.stringify(formData),
			success: function (map) {
				alert("수정 완료되었습니다.");
				goLink("/bbs/board/boardList");
			},
			error: function () {
				alert("수정 중 오류 발생");
			}
		});
	}

	function deleteBoard() {
		if (!confirm("정말 삭제하시겠습니까?")) return;

		var boardIdx = $("#boardIdx").val();
		$.ajax({
			url: "/api/bbs/board/deleteBoard",
			type: "post",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify({ boardIdx }), 
			success: function () {
				alert("삭제 완료되었습니다.");
				goLink("/bbs/board/boardList");
			},
			error: function () {
				alert("삭제 중 오류 발생");
			}
		});
	}

	function goLink(path) {
		location.href = path;
	}

	// serializeObject 정의
	$.fn.serializeObject = function () {
		let obj = {};
		const arr = this.serializeArray();
		$.each(arr, function () {
			obj[this.name] = this.value;
		});
		return obj;
	};
	</script>
</body>
</html>