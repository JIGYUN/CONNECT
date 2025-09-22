<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    :root{ --bg:#f6f8fb; --card:#ffffff; --line:#e9edf3; --text:#0f172a; --muted:#6b7280; }
    body{ background:var(--bg); }
    .page-title{ font-size:28px; font-weight:700; color:var(--text); margin-bottom:12px; }
    .toolbar{ display:flex; gap:10px; align-items:center; flex-wrap:wrap; margin:8px 0 18px; }
    .table-card{ background:var(--card); border:1px solid var(--line); border-radius:16px; box-shadow:0 2px 8px rgba(15,23,42,.05); }
    .table{ margin-bottom:0; }
    .table thead th{ font-weight:700; color:#475569; background:#f3f5f8; border-bottom:1px solid var(--line); }
    .table tbody tr{ cursor:pointer; }
    .table tbody tr:hover{ background:#f9fbff; }
    .btn,.form-select,.form-control{ border-radius:12px; }
    #boardSel{ min-width:240px; }
    .ms-auto{ margin-left:auto; }
</style>

<section>
    <h2 class="page-title">게시글</h2>

    <div class="toolbar">
        <select id="boardSel" class="form-select"></select>
        <input id="kw" class="form-control" placeholder="제목 검색" style="width:260px;">
        <button class="btn btn-outline-secondary" type="button" id="btnSearch">검색</button>
        <button class="btn btn-primary ms-auto" type="button" onclick="goToBoardPostModify()">글쓰기</button>
    </div>

    <div class="table-responsive table-card">
        <table class="table table-hover align-middle">
            <thead>
                <tr>
                    <th style="width:90px; text-align:right;">번호</th>
                    <th>제목</th>
                    <th style="width:100px;">조회</th>
                    <th style="width:200px;">작성일</th>
                </tr>
            </thead>
            <tbody id="boardPostListBody">
                <tr><td colspan="4" class="text-center text-muted">Loading…</td></tr>
            </tbody>
        </table>
    </div>
</section>

<script>
    // API
    const API_POST  = '/api/brd/boardPost';
    const API_BOARD = '/api/brd/boardDef';
    const PK_PARAM  = 'postId';

    $(function () {
        loadBoards().then(function () {
            bindEvents();
            reload();
        });
    });

    function bindEvents() {
        $('#boardSel').on('change', reload);
        $('#btnSearch').on('click', reload);
        $('#kw').on('keyup', function (e) { if (e.key === 'Enter') reload(); });
    }

    function getParam(name){
        const url = new URL(location.href);
        return url.searchParams.get(name);
    }

    function text(v){ return (v == null ? '' : String(v)); }

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
                html += '<option value="'+ text(r.boardId || r.BOARD_ID) +'">'
                      + text(r.boardNm || r.title || r.BOARD_NM || r.TITLE)
                      + '</option>';
            }
            $('#boardSel').html(html);

            // URL ?boardId 유지
            const q = getParam('boardId');
            if (q) $('#boardSel').val(q);
        });
    }

    function reload(){
        const data = {
            boardId: $('#boardSel').val(),
            kw: $('#kw').val()
        };

        $.ajax({
            url: API_POST + '/selectBoardPostList',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (map) {
                const resultList = map.result || map.list || [];
                let html = '';

                if (!resultList.length) {
                    html += "<tr><td colspan='4' class='text-center text-muted'>등록된 글이 없습니다.</td></tr>";
                } else {
                    for (let i=0;i<resultList.length;i++){
                        const r = resultList[i];
                        const id = r.postId || r.POST_ID || r.boardPostIdx;
                        const title = text(r.title || r.TITLE);
                        const viewCnt = text(r.viewCnt || r.VIEW_CNT || 0);
                        const created = text(r.createdDt || r.CREATED_DT || r.createDate || r.CREATE_DATE);

                        html += "<tr onclick=\"goToBoardPostDetail('"+ id +"')\">";
                        html += "  <td class='text-end'>"+ id +"</td>";
                        html += "  <td>"+ title +"</td>";
                        html += "  <td>"+ viewCnt +"</td>";
                        html += "  <td>"+ created +"</td>";  
                        html += "</tr>";
                    }
                }
                $('#boardPostListBody').html(html);
            },
            error: function () {
                $('#boardPostListBody').html("<tr><td colspan='4' class='text-center text-danger'>목록 조회 중 오류</td></tr>");
            }
        });
    }

    function goToBoardPostModify(id) {
        let url = '/brd/boardPost/boardPostModify';
        const b = $('#boardSel').val();
        const qp = [];
        if (id) qp.push(PK_PARAM + '=' + encodeURIComponent(id));
        if (b)  qp.push('boardId=' + encodeURIComponent(b));
        if (qp.length) url += '?' + qp.join('&');
        location.href = url;
    }
    
    function goToBoardPostDetail(id) {
        let url = '/brd/boardPost/boardPostDetail';
        const b = $('#boardSel').val();
        const qp = [];
        if (id) qp.push(PK_PARAM + '=' + encodeURIComponent(id));
        if (b)  qp.push('boardId=' + encodeURIComponent(b));
        if (qp.length) url += '?' + qp.join('&');
        location.href = url;
    }
</script>