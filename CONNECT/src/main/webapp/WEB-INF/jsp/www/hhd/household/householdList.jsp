<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가게부 목록</title>
</head>
<body>
    <h2>가게부 목록</h2>

    <button onclick="goToHouseholdModify()">글쓰기</button>
    <button onclick="goToHousehold()">통합</button>

    <table border="1" width="100%">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody id="householdListBody"></tbody>
    </table>

    <script>
        // ▼ JavaGen이 치환: hhd → bbs (또는 원하는 값), Household/household → 서비스명
        const API_BASE = '/api/hhd/household';   // → /api/bbs/board
        const householdIdx = 'householdIdx';             // → boardIdx

        $(function () { selectHouseholdList(); });

        function selectHouseholdList() {
            $.ajax({
                url: API_BASE + '/selectHouseholdList',
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

                            html += "<tr onclick=\"goToHouseholdModify('" + (r.householdIdx) + "')\">";
                            html += "<td>" + (r.householdIdx) + "</td>";
                            html += "<td>" + (r.title) + "</td>";
                            html += "<td>" + (r.createUser) + "</td>";
                            html += "<td>" + (createDate) + "</td>";
                            html += "</tr>";
                        }
                    }
                    $('#householdListBody').html(html);
                },
                error: function () { alert('목록 조회 중 오류 발생'); }
            });
        }

        function goToHouseholdModify(id) {
            // 페이지 라우팅: /hhd/household/householdModify → /bbs/board/boardModify
            let url = '/hhd/household/householdModify';
            if (id) url += '?' + householdIdx + '=' + encodeURIComponent(id);
            location.href = url;
        }
        
        function goToHousehold() {
            // 페이지 라우팅: /hhd/household/householdModify → /bbs/board/boardModify
            let url = '/hhd/household/household';
            location.href = url;
        }
    </script>
</body>
</html>
