<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>screenTitle 목록</title>
</head>
<body>
    <h2>screenTitle 목록</h2>

    <button onclick="goToTemplateModify()">글쓰기</button>
    <button onclick="goToTemplate()">통합</button>

    <table border="1" width="100%">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody id="templateListBody"></tbody>
    </table>

    <script>
        // ▼ JavaGen이 치환: BIZ_SEG → bbs (또는 원하는 값), Template/template → 서비스명
        const API_BASE = '/api/BIZ_SEG/template';   // → /api/bbs/board
        const PK_PARAM = 'templateIdx';             // → boardIdx

        $(function () { selectTemplateList(); });

        function selectTemplateList() {
            $.ajax({
                url: API_BASE + '/selectTemplateList',
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

                            html += "<tr onclick=\"goToTemplateModify('" + (r.templateIdx) + "')\">";
                            html += "<td>" + (r.templateIdx) + "</td>";
                            html += "<td>" + (r.title) + "</td>";
                            html += "<td>" + (r.createUser) + "</td>";
                            html += "<td>" + (createDate) + "</td>";
                            html += "</tr>";
                        }
                    }
                    $('#templateListBody').html(html);
                },
                error: function () { alert('목록 조회 중 오류 발생'); }
            });
        }

        function goToTemplateModify(id) {
            let url = '/BIZ_SEG/template/templateModify';
            if (id) url += '?' + PK_PARAM + '=' + encodeURIComponent(id);
            location.href = url;
        }
        
        function goToTemplate() {
            let url = '/BIZ_SEG/template/templateModify';
            location.href = url;
        }
    </script>
</body>
</html>