<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<style>
    :root{ --bg:#f6f8fb; --card:#ffffff; --line:#e9edf3; --text:#0f172a; --muted:#6b7280; }
    body{ background:var(--bg); }
    .page-title{ font-size:28px; font-weight:700; color:var(--text); margin-bottom:12px; }
    .toolbar{ display:flex; gap:10px; align-items:center; flex-wrap:wrap; margin:8px 0 18px; }
    .card{ background:var(--card); border:1px solid var(--line); border-radius:16px; box-shadow:0 2px 8px rgba(15,23,42,.05); padding:18px; }
    .form-label{ font-weight:600; color:#334155; }
    .btn,.form-select,.form-control{ border-radius:12px; }
</style>

<section>
    <h2 class="page-title">게시글 <span id="pageTitle" class="text-muted" style="font-size:16px;">등록</span></h2>

    <div class="toolbar">
        <button class="btn btn-primary" type="button" onclick="saveBoardPost()">저장</button>
        <c:if test="${not empty param.postId}">
            <button class="btn btn-outline-danger" type="button" onclick="deleteBoardPost()">삭제</button>
        </c:if>
        <a class="btn btn-outline-secondary" href="/brd/boardPost/boardPostList">목록</a>
    </div>

    <form id="boardPostForm" class="card">
        <input type="hidden" name="postId" id="postId" value="${param.postId}"/>

        <div class="row g-3">
            <div class="col-md-4">
                <label for="boardId" class="form-label">게시판</label>
                <select id="boardId" name="boardId" class="form-select"></select>
            </div>
            <div class="col-12">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요">
            </div>
            <div class="col-12">
                <label class="form-label">내용</label>
                <div id="editor" style="height: 460px;"></div>
                <!-- 서버 전송용 -->
                <input type="hidden" name="contentMd" id="contentMd"/>
                <input type="hidden" name="contentHtml" id="contentHtml"/>
            </div>
        </div>
    </form>
</section>

<script>
    const API_POST  = '/api/brd/boardPost';
    const API_BOARD = '/api/brd/boardDef';
    const PK        = 'postId';
    let editor;

    $(document).ready(function () {
        // 에디터
        editor = new toastui.Editor({
            el: document.querySelector('#editor'),
            height: '460px',
            initialEditType: 'markdown',
            previewStyle: 'vertical',
            placeholder: '내용을 입력해주세요...'
        });

        // 게시판 목록 로드 → 상세 or 신규 분기
        loadBoards().then(function(){
            const id = $("#" + PK).val();
            if (id) {
                readBoardPost(id);
                $("#pageTitle").text("수정");
            } else {
                // URL의 ?boardId 유지
                const qBoard = getParam('boardId');
                if (qBoard) $('#boardId').val(qBoard);
                $("#pageTitle").text("등록");
            }
        });
    });

    function getParam(name){
        const url = new URL(location.href);
        return url.searchParams.get(name);
    }

    function loadBoards(){
        return $.ajax({
            url: API_BOARD + '/selectBoardDefList',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({ useAt: 'Y' })
        }).then(function (map){
            const list = map.result || map.list || [];
            let html = '';
            for (let i=0;i<list.length;i++){
                const r = list[i];
                const id = r.boardId || r.BOARD_ID;
                const nm = r.boardNm || r.title || r.BOARD_NM || r.TITLE;
                html += '<option value="'+ id +'">'+ nm +'</option>';
            }
            $('#boardId').html(html);
        });
    }

    function readBoardPost(id) {
        const sendData = {}; sendData[PK] = id;
        $.ajax({
            url: API_POST + "/selectBoardPostDetail",
            type: "post",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(sendData),
            success: function (map) {
                const r = map.result || map.boardPost || map;
                if (!r) return;
                $("#boardId").val(r.boardId || r.BOARD_ID);
                $("#title").val(r.title || r.TITLE || "");
                // HTML 우선, 없으면 MD
                const html = r.contentHtml || r.CONTENT_HTML || '';
                const md   = r.contentMd   || r.CONTENT_MD   || '';
                if (html) editor.setHTML(html);
                else      editor.setMarkdown(md);
            },
            error: function () {
                alert("조회 중 오류 발생");
            }
        });
    }

    function saveBoardPost() {
        const id  = $("#" + PK).val();
        const url = id ? (API_POST + "/updateBoardPost") : (API_POST + "/insertBoardPost");

        if (!$('#boardId').val()) { alert("게시판을 선택해주세요."); $('#boardId').focus(); return; }
        if ($("#title").val() === "") { alert("제목을 입력해주세요."); $("#title").focus(); return; }
        const html = editor.getHTML().trim();
        if (html === "") { alert("내용을 입력해주세요."); return; }

        // 전송용 동기화
        $("#contentMd").val(editor.getMarkdown());
        $("#contentHtml").val(html);

        const formData = $("#boardPostForm").serializeObject();

        $.ajax({
            url: url,
            type: "post",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(formData),
            success: function () {
                // 선택했던 게시판 유지
                const b = $('#boardId').val();
                location.href = "/brd/boardPost/boardPostList" + (b ? ("?boardId=" + encodeURIComponent(b)) : "");
            },
            error: function () {
                alert("저장 중 오류 발생");
            }
        });
    }

    function deleteBoardPost() {
        const id = $("#" + PK).val();
        if (!id) { alert("삭제할 대상이 없습니다."); return; }
        if (!confirm("정말 삭제하시겠습니까?")) return;

        const sendData = {}; sendData[PK] = id;

        $.ajax({
            url: API_POST + "/deleteBoardPost",
            type: "post",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(sendData),
            success: function () {
                const b = $('#boardId').val();
                alert("삭제 완료되었습니다.");
                location.href = "/brd/boardPost/boardPostList" + (b ? ("?boardId=" + encodeURIComponent(b)) : "");
            },
            error: function () {
                alert("삭제 중 오류 발생");
            }
        });
    }

    // serializeObject
    $.fn.serializeObject = function () {
        var obj = {};
        var arr = this.serializeArray();
        $.each(arr, function () { obj[this.name] = this.value; });
        return obj;
    };
</script> 