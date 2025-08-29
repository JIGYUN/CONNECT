<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
</head>
<body>
    <h2>게시판 목록</h2>

    <button onclick="goToBoardModify()">글쓰기</button>
    <button onclick="goToBoard()">통합</button>

    <table border="1" width="100%">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody id="boardListBody"></tbody>
    </table>

    <script>
        // ▼ JavaGen이 치환: bbs → bbs (또는 원하는 값), Board/board → 서비스명
        const API_BASE = '/api/bbs/board';   // → /api/bbs/board
        const boardIdx = 'boardIdx';             // → boardIdx

        $(function () { selectBoardList(); });

        function selectBoardList() {
            $.ajax({
                url: API_BASE + '/selectBoardList',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify({}),
                success: function (map) {
                    const resultList = map.result || [];
                    let html = '';
                    if (resultList.length === 0) {
                        html += "<tr><td colspan='4' style='text-align:center;'>등록된 데이터가 없습니다.</td></tr>";
                    } else {
                        for (let i = 0; i < resultList.length; i++) {
                            const r = resultList[i];
                            let createDate = r.createDate;
                            if (createDate && typeof createDate === 'object') createDate = (createDate.value || String(createDate));

                            html += "<tr onclick=\"goToBoardModify('" + (r.boardIdx) + "')\">";
                            html += "<td>" + (r.boardIdx) + "</td>";
                            html += "<td>" + (r.title) + "</td>";
                            html += "<td>" + (r.createUser) + "</td>";
                            html += "<td>" + (createDate) + "</td>";
                            html += "</tr>";
                        }
                    }
                    $('#boardListBody').html(html);
                },
                error: function () { alert('목록 조회 중 오류 발생'); }
            });
        }

        function goToBoardModify(id) {
            let url = '/bbs/board/boardModify';
            if (id) url += '?' + boardIdx + '=' + encodeURIComponent(id);
            location.href = url;
        }
        
        function goToBoard() {
            let url = '/bbs/board/board';
            location.href = url;
        }
    </script>
</body>
</html>
