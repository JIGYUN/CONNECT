<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>screenTitle 목록</title>
</head>
<body>
    <h2>screenTitle 목록</h2>

	<button onclick="goToTemplateList()">목록</button>
    <!-- ✨ 추가: 제목 한 줄 입력 → Enter로 즉시 등록 -->
    <div style="margin:10px 0;">
        <input type="text" id="titleInput" placeholder="제목 입력 후 Enter" style="width:60%;" />
<!--         <span style="color:#666;font-size:12px;">Enter: 추가 / 행의 [삭제] 클릭 시 즉시 삭제</span> -->
    </div>

    <table border="1" width="100%">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
<!--                 <th>작성자</th> -->
                <th>작성일</th> 
                <th style="width:90px;">관리</th> <!-- ✨ 추가 -->
            </tr>
        </thead>
        <tbody id="templateListBody"></tbody>
    </table>

    <script>
        // ▼ JavaGen 치환 포인트 유지
        const API_BASE = '/api/BIZ_SEG/template';   // → /api/bbs/board
        const PK_PARAM = 'templateIdx';             // → boardIdx

        // 초기 로드
        (function () {
            selectTemplateList();
            // ✨ Enter로 추가
            var input = document.getElementById('titleInput');
            input.addEventListener('keydown', function(e){
                if (e.key === 'Enter') {
                    var title = (input.value || '').trim();
                    if (title) insertTitle(title);
                }
            });
        })();

        // 목록 조회 (기존 패턴 유지)
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
                        html += "<tr><td colspan='5' style='text-align:center;'>등록된 데이터가 없습니다.</td></tr>";
                    } else {
                        for (let i = 0; i < resultList.length; i++) {
                            const r = resultList[i];
                            let createDate = r.createDate;
                            if (createDate && typeof createDate === 'object') createDate = (createDate.value || String(createDate));

                            // 행 클릭 → 기존 modify 이동 유지
                            html += "<tr onclick=\"goToTemplateModify('" + (r.templateIdx) + "')\">";
                            html += "  <td>" + (r.templateIdx ?? '') + "</td>";
                            html += "  <td>" + (escapeHtml(r.title ?? '')) + "</td>";
                            //html += "  <td>" + (escapeHtml(r.createUser ?? '')) + "</td>";
                            html += "  <td>" + (escapeHtml(createDate ?? '')) + "</td>";
                            // ✨ 삭제 버튼 (이벤트 전파 막아 modify로 튀지 않게)
                            html += "  <td style='text-align:center;'>";
                            html += "    <button type='button' onclick=\"event.stopPropagation(); deleteRow('" + (r.templateIdx) + "')\">삭제</button>";
                            html += "  </td>";
                            html += "</tr>";
                        }
                    }
                    $('#templateListBody').html(html);
                },
                error: function () { alert('목록 조회 중 오류 발생'); }
            });
        }

        // ✨ 제목만 받아 등록 → 성공 시 목록 갱신
        function insertTitle(title) {
            // 서버가 JSON(body) 받는 기존 패턴 유지
            var payload = { title: title };
            $.ajax({
                url: API_BASE + '/insertTemplate',
                type: 'post',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(payload),
                success: function () {
                    document.getElementById('titleInput').value = '';
                    selectTemplateList();
                },
                error: function (xhr) {
                    alert('등록 실패: ' + (xhr.responseText || xhr.status));
                }
            });
        }

        // ✨ 행 즉시 삭제 (기존 deleteTemplate 패턴 유지: { PK_PARAM: id })
        function deleteRow(id) {
            if (!id) return;
            //if (!confirm('정말 삭제하시겠습니까?')) return;

            var sendData = {};
            sendData[PK_PARAM] = id;

            $.ajax({
                url: API_BASE + '/deleteTemplate',
                type: 'post',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(sendData),
                success: function () {
                    selectTemplateList();
                },
                error: function (xhr) {
                    alert('삭제 실패: ' + (xhr.responseText || xhr.status));
                }
            });
        }

        function goToTemplateModify(id) {
            // 페이지 라우팅: /BIZ_SEG/template/templateModify → /bbs/board/boardModify
            let url = '/BIZ_SEG/template/templateModify';
            if (id) url += '?' + PK_PARAM + '=' + encodeURIComponent(id);
            location.href = url;
        }

        function escapeHtml(s){
            return String(s).replace(/[&<>"']/g, function(m){return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m];});
        }
        
        function goToTemplateList() {
            let url = '/BIZ_SEG/template/templateList';
            location.href = url;
        }
    </script>
</body>
</html>