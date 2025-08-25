<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 수정</title>
</head>
<body>
    <h2>게시판 수정</h2>

    <form id="boardForm">
        <!-- PK 파라미터 (치환 대상) -->
        <input type="hidden" name="boardIdx" id="boardIdx" value="${param.boardIdx}"/>

        <label>제목</label><br/>
        <input type="text" name="title" id="title" style="width:500px;" /><br/><br/>

        <label>내용</label><br/>
        <textarea name="content" id="content" rows="10" cols="80"></textarea><br/><br/>

        <label>작성자</label><br/>
        <input type="text" name="createUser" id="createUser" /><br/><br/>

        <button type="button" onclick="saveBoard()">저장</button>
        <button type="button" onclick="deleteBoard()">삭제</button>
        <button type="button" onclick="goLink('/bbs/board/boardList')">목록</button>
    </form>

    <script>
        /* ===== 치환 토큰 =====
           - bbs: bbs 등 비즈 세그먼트
           - Board/board: 서비스명/소문자
           - boardIdx: boardIdx → 예: boardIdx
        */
        const API_BASE = '/api/bbs/board';
        const PK = 'boardIdx';

        $(document).ready(function () {
            const id = $("#" + PK).val();
            if (id && id !== "") {
                readBoard(id);
            }
        });

        function readBoard(id) {
            const sendData = {};
            sendData[PK] = id;

            $.ajax({
                url: API_BASE + "/selectBoardDetail",
                type: "post",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(sendData),
                success: function (map) {
                    // 서버 응답 키 유연 처리
                    var result = map.result || map.board || map;
                    if (!result) return;
                    $("#title").val(result.title || "");
                    $("#content").val(result.content || "");
                    $("#createUser").val(result.createUser || "");
                },
                error: function () {
                    alert("조회 중 오류 발생");
                }
            });
        }

        function saveBoard() {
            const id = $("#" + PK).val();
            let url = id && id !== "" ? (API_BASE + "/updateBoard") : (API_BASE + "/insertBoard");

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
                    alert((map && map.msg) || "저장 완료되었습니다.");
                    goLink("/bbs/board/boardList");
                },
                error: function () {
                    alert("저장 중 오류 발생");
                }
            });
        }

        function deleteBoard() {
            const id = $("#" + PK).val();
            if (!id || id === "") {
                alert("삭제할 대상의 PK가 없습니다.");
                return;
            }
            if (!confirm("정말 삭제하시겠습니까?")) return;

            const sendData = {}; sendData[PK] = id;
            $.ajax({
                url: API_BASE + "/deleteBoard",
                type: "post",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(sendData),
                success: function (map) {
                    alert((map && map.msg) || "삭제 완료되었습니다.");
                    goLink("/bbs/board/boardList");
                },
                error: function () {
                    alert("삭제 중 오류 발생");
                }
            });
        }

        function goLink(path) { location.href = path; }

        /* serializeObject: 폼 → JSON */
        $.fn.serializeObject = function () {
            let obj = {};
            const arr = this.serializeArray();
            $.each(arr, function () { obj[this.name] = this.value; });
            return obj;
        };
    </script>
</body>
</html>
