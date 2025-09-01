<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<section>
    <h2 class="mb-3">게시판 <span id="pageTitle">수정</span></h2>

    <div class="mb-3">
        <button class="btn btn-primary" type="button" onclick="saveBoard()">저장</button>
        
	<c:if test="${not empty param.boardIdx}">
        <button class="btn btn-outline-danger" type="button" onclick="deleteBoard()">삭제</button>
    </c:if>
        <a class="btn btn-outline-secondary" href="/bbs/board/boardList">목록</a>
    </div>

    <form id="boardForm">
        <input type="hidden" name="boardIdx" id="boardIdx" value="${param.boardIdx}"/>

        <div class="form-group" style="max-width: 840px;">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title" />
        </div>

        <div class="form-group" style="max-width: 840px;">
            <label for="content">내용</label>
            <textarea class="form-control" name="content" id="content" rows="10"></textarea>
        </div>
        
        <div class="form-group" style="max-width: 840px;">
            <label for="title">첨부파일</label> 
            <input type="file" class="form-control" name="fileNm" id="fileNm" />
        </div>  
    </form>
</section>

<script>
    const API_BASE = '/api/bbs/board';
    const PK = 'boardIdx';

    $(document).ready(function () {
        const id = $("#" + PK).val();
        if (id && id !== "") {
            readBoard(id);
            $("#pageTitle").text("수정");
        } else {
        	$("#pageTitle").text("등록");
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
            success: function () {
                location.href = "/bbs/board/boardList";
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

        const sendData = {};
        sendData[PK] = id;

        $.ajax({
            url: API_BASE + "/deleteBoard",
            type: "post",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(sendData),
            success: function () {
                alert("삭제 완료되었습니다.");
                location.href = "/bbs/board/boardList";
            },
            error: function () {
                alert("삭제 중 오류 발생");
            }
        });
    }

    $.fn.serializeObject = function () {
        let obj = {};
        const arr = this.serializeArray();
        $.each(arr, function () {
            obj[this.name] = this.value;
        });
        return obj;
    };
</script>