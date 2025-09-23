<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 공통 페이징 -->
<script src="/static/js/paging.js"></script>

<style>
    :root{ --bg:#f6f8fb; --card:#ffffff; --line:#e9edf3; --text:#0f172a; --muted:#6b7280; }
    body{ background:var(--bg); }
    .page-title{ font-size:26px; font-weight:800; color:var(--text); margin:12px 0 14px; }
    .toolbar{ display:flex; gap:8px; align-items:center; flex-wrap:wrap; margin:8px 0 16px; }
    .btn,.form-control,.custom-select{ border-radius:12px; }
    .table-hover tbody tr{ cursor:pointer; }
</style>

<section class="container-fluid">
    <h2 class="page-title">게시글 목록</h2>

    <div class="toolbar">
        <input id="keyword" class="form-control" type="text" placeholder="제목/내용 검색"/>
        <select id="boardId" class="custom-select" style="max-width:160px;">
            <option value="">전체 게시판</option>
        </select>
        <button id="btnSearch" class="btn btn-outline-secondary" type="button">검색</button>
        <div class="ml-auto"></div>
        <a class="btn btn-primary" href="/brd/boardPost/boardPostModify">새 글</a>
    </div>

    <div class="table-responsive card p-2" style="border-radius:16px; border:1px solid var(--line); background:#fff;">
        <table class="table table-hover align-middle mb-2">
            <thead class="thead-light">
                <tr>
                    <th style="width: 90px; text-align:right;">번호</th>
                    <th>제목</th>
                    <th style="width: 220px;">작성일</th>
                </tr>
            </thead>
            <tbody id="postTbody"></tbody>
        </table>

        <!-- 페이징 -->
        <div id="pager"></div>
    </div>
</section>

<script>
    // ===== API =====
    const API_LIST  = '/api/brd/boardPost/selectBoardPostListPaged';
    const API_BOARD = '/api/brd/boardDef/selectBoardDefList';

    // ===== sessionStorage 키(페이징.js와 동일 prefix) =====
    const PAGING_KEY   = location.pathname + '::boardPost';
    const FILTERS_KEY  = location.pathname + '::boardPost.filters';

    // ===== 전역 =====
    var pager;

    $(function () {
        // 페이징 인스턴스(초기 자동 로드 X)
        pager = Paging.create('#pager', function (page, size) {
            loadPage(page, size);
        }, { size: 20, maxButtons: 7, autoLoad: false, key: 'boardPost' });

        // 필터 복원
        restoreFilters();

        // 게시판 목록 로드 후, 저장된 page/size 복원하여 최초 호출
        loadBoards().always(function () {
            const saved = readSession(PAGING_KEY);
            const hash  = Paging.parseHash();
            let p  = (saved && saved.page) ? parseInt(saved.page, 10) : (hash.page ? parseInt(hash.page, 10) : 1);
            let sz = (saved && saved.size) ? parseInt(saved.size, 10) : (hash.size ? parseInt(hash.size, 10) : pager.getState().size);

            if (isFinite(sz) && sz > 0 && sz !== pager.getState().size) {
                // setSize가 go(1,true) 호출 → 이후 아래 go로 덮어씀
                pager.setSize(sz);
            }
            if (!isFinite(p) || p < 1) p = 1;

            pager.go(p, true); // 최초 1회만 강제 로드
        });

        // 검색 버튼/엔터 → 1페이지부터
        $('#btnSearch').on('click', function () {
            saveFilters();
            pager.go(1, true);
        });
        $('#keyword').on('keydown', function (e) {
            if (e.key === 'Enter') {
                saveFilters();
                pager.go(1, true);
            }
        });
        $('#boardId').on('change', function () {
            saveFilters();
            pager.go(1, true);
        });
    });

    // ===== Boards 드롭다운 =====
    function loadBoards () {
        return $.ajax({
            url: API_BOARD,
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({ useAt: 'Y' }),
            success: function (map) {
                var list = map.result || map.list || [];
                var $sel = $('#boardId').empty();
                $sel.append('<option value="">전체 게시판</option>');
                for (var i = 0; i < list.length; i++) {
                    var r = list[i];
                    var id = r.boardId || r.BOARD_ID;
                    var nm = r.boardNm || r.BOARD_NM || r.title || r.TITLE;
                    if (id && nm) $sel.append('<option value="' + id + '">' + nm + '</option>');
                }
                // 필터 복원 시 boardId 값 반영
                const f = readSession(FILTERS_KEY);
                if (f && f.boardId != null) $sel.val(f.boardId);
            }
        });
    }

    // ===== 목록 로딩 =====
    function loadPage (page, size) {
        var params = {
            page   : page,
            size   : size,
            boardId: $('#boardId').val() || null,
            keyword: $('#keyword').val() || null
        };
        $.ajax({
            url: API_LIST,
            type: 'post',
            contentType: 'application/json',
            dataType: 'json',
            data: JSON.stringify(params),
            success: function (res) {
                renderRows(res.result || []);
                if (res.page) {
                    // update가 내부적으로 session/hash를 동기화함
                    pager.update(res.page);
                }
            },
            error: function () {
                alert('목록 조회 실패');
            }
        });
    }

    // ===== 테이블 렌더 =====
    function renderRows (rows) {
        var $tb = $('#postTbody').empty();
        if (!rows || !rows.length) {
            $tb.append('<tr><td colspan="3" class="text-center text-muted">등록된 데이터가 없습니다.</td></tr>');
            return;
        }
        for (var i = 0; i < rows.length; i++) {
            var r = rows[i];
            var id = r.POST_ID || r.postId;
            var title = r.TITLE || r.title || '(제목 없음)';
            var created = r.CREATED_DT || r.createdDt || '';
            var tr = '<tr onclick="goDetail(' + id + ')">';
            tr += '  <td class="text-right">' + id + '</td>';
            tr += '  <td>' + escapeHtml(title) + '</td>';
            tr += '  <td>' + created + '</td>';
            tr += '</tr>';
            $tb.append(tr);
        }
    }

    // ===== 상세 이동 =====
    function goDetail (id) {
        if (!id) return;
        // 페이징.js가 session/hash를 이미 저장하고 있으므로 단순 이동만 하면 복귀 시 복원됨
        location.href = '/brd/boardPost/boardPostModify?postId=' + encodeURIComponent(id);
    }

    // ===== 필터 저장/복원 =====
    function saveFilters () {
        var f = {
            boardId: $('#boardId').val() || '',
            keyword: $('#keyword').val() || ''
        };
        writeSession(FILTERS_KEY, f);
    }
    function restoreFilters () {
        var f = readSession(FILTERS_KEY);
        if (f) {
            if (f.keyword != null) $('#keyword').val(f.keyword);
            // boardId는 loadBoards()에서 옵션 생성 후에 반영
        }
    }

    // ===== sessionStorage 유틸 =====
    function readSession (key) {
        try { var v = sessionStorage.getItem(key); return v ? JSON.parse(v) : null; } catch (e) { return null; }
    }
    function writeSession (key, obj) {
        try { sessionStorage.setItem(key, JSON.stringify(obj)); } catch (e) {}
    }

    // ===== HTML escape =====
    function escapeHtml (s) {
        return String(s || '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }
</script>  