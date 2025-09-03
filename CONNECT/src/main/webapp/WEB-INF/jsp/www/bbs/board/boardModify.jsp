<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>게시판 수정</title>
	
    <!-- Bootstrap & jQuery (네 프로젝트에 이미 있으면 중복 로드 X) -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
    <!-- Toast UI Editor -->
    <link rel="stylesheet"
          href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
    <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	
    <style>
        /* 에디터 카드 느낌 */
        .editor-card{
            border:1px solid #e9ecef;
            border-radius:12px;
            padding:12px;
        }
    </style>
</head>
<body class="container my-4">
    <h2 class="mb-3">게시판 수정</h2>

    <form id="boardForm" onsubmit="return false;">
        <!-- PK -->
        <input type="hidden" name="boardIdx" id="boardIdx" value="${param.boardIdx}" />

        <div class="form-group">
            <label>제목</label>
            <input type="text" class="form-control" name="title" id="title"
                   value="${result.title}" placeholder="제목을 입력하세요" />
        </div>

        <!-- ✅ 서버로 보낼 필드 (Markdown / HTML) -->
        <textarea id="contentMd" name="content" style="display:none;"><c:out value="${result.content}"/></textarea>
        <textarea id="contentHtml" name="contentHtml" style="display:none;"></textarea>

        <label class="mb-2 d-block">내용</label>
        <div class="editor-card">
            <div id="editor" style="height:460px;"></div>
        </div>

        <div class="mt-3">
            <button type="button" class="btn btn-primary" onclick="saveBoard()">저장</button>
            <button type="button" class="btn btn-outline-secondary"
                    onclick="location.href='/bbs/board/boardList'">목록</button>
        </div>
    </form>

    <script>
        // 1) 에디터 초기화
        var initialMD = document.getElementById('contentMd').value || '';
        var editor = new toastui.Editor({
            el: document.querySelector('#editor'),
            height: '460px',
            initialEditType: 'markdown',   // 'wysiwyg'도 가능
            previewStyle: 'vertical',
            initialValue: initialMD,
            toolbarItems: [
                ['heading', 'bold', 'italic', 'strike'],
                ['hr', 'quote'],
                ['ul', 'ol', 'task'],
                ['table', 'link'],
                ['code', 'codeblock']
            ],
            hooks: {
                // 이미지 업로드 훅 (선택): 서버에 업로드 후 URL 반환
                addImageBlobHook: function (blob, callback) {
                    var formData = new FormData();
                    formData.append('file', blob);

                    $.ajax({
                        url: '/api/files/upload',   // ← 너의 업로드 엔드포인트로 변경
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (res) {
                            // res.url 형태로 이미지 접근 URL을 반환하도록 서버 구현
                            callback(res.url, 'image');
                        },
                        error: function () {
                            alert('이미지 업로드 실패');
                        }
                    });
                }
            }
        });

        // 2) 저장
        function saveBoard() {
            var id = $('#boardIdx').val();
            var url = id ? '/api/bbs/board/updateBoard' : '/api/bbs/board/insertBoard';

            // Markdown / HTML 모두 준비
            var md = editor.getMarkdown();
            var html = editor.getHTML();
            $('#contentMd').val(md);
            $('#contentHtml').val(html);

            var payload = $('#boardForm').serializeObject();
            $.ajax({
                url: url,
                type: 'POST',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(payload),
                success: function () {
                    location.href = '/bbs/board/boardList';
                },
                error: function (xhr) {
                    alert('저장 실패: ' + (xhr.responseText || xhr.status));
                }
            });
        }

        // jQuery 폼 → JSON
        $.fn.serializeObject = function() {
            var obj = {};
            var arr = this.serializeArray();
            $.each(arr, function() { obj[this.name] = this.value; });
            return obj;
        };
    </script>
</body>
</html>  