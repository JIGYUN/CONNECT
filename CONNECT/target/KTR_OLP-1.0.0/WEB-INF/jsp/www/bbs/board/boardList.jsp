<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판 목록</title>
	<script src="/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h2>게시판 목록</h2>

	<button onclick="goToBoardModify()">글쓰기</button>

	<table border="1" width="100%">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th> 
				<th>작성일</th>
			</tr>
		</thead>
		<tbody id="boardListBody">
		</tbody>
	</table>

	<script type="text/javascript">
		$(document).ready(function () {
			selectBoardList();
		});

		function selectBoardList() {
			$.ajax({
				url: "/api/bbs/board/selectBoardList",
				type: "post",
				contentType: "application/json",
				data: JSON.stringify({}),
				success: function (map) {
					var resultList = map.result; 
					let tbody = "";

					if (resultList.length === 0) {
						tbody += "<tr><td colspan='4' style='text-align:center;'>등록된 게시글이 없습니다.</td></tr>";
					} else {
						for (var i = 0; i < resultList.length; i++) {
							tbody += "<tr onclick=\"goToBoardModify('" + resultList[i].boardIdx + "')\">";
							tbody += "<td>" + resultList[i].boardIdx + "</td>";
							tbody += "<td>" + resultList[i].title + "</td>";
							tbody += "<td>" + resultList[i].createUser + "</td>";
							tbody += "<td>" + resultList[i].createDate + "</td>";
							tbody += "</tr>";
						}
					} 

					$("#boardListBody").html(tbody);
				},
				error: function (request, status, error) {
					alert("목록 조회 중 오류 발생");
				}
			});
		}

		function goToBoardModify(boardIdx) {
			let url = "/bbs/board/boardModify";
			if (boardIdx) {
				url += "?boardIdx=" + boardIdx;
			}
			location.href = url;
		}
	</script>
</body>
</html>