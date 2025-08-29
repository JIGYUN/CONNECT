<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가게부 수정</title>
</head>
<body>
    <h2>가게부 수정</h2>

    <form id="householdForm">
        <!-- PK 파라미터 (치환 대상) -->
        <input type="hidden" name="householdIdx" id="householdIdx" value="${param.householdIdx}"/>

        <label>제목</label><br/>
        <input type="text" name="title" id="title" style="width:500px;" /><br/><br/>

        <label>내용</label><br/>
        <textarea name="content" id="content" rows="10" cols="80"></textarea><br/><br/>

        <button type="button" onclick="saveHousehold()">저장</button>
        <button type="button" onclick="deleteHousehold()">삭제</button>
        <button type="button" onclick="goLink('/hhd/household/householdList')">목록</button>
    </form>

    <script>
        /* ===== 치환 토큰 =====
           - hhd: bbs 등 비즈 세그먼트
           - Household/household: 서비스명/소문자
           - householdIdx: householdIdx → 예: boardIdx
        */
        const API_BASE = '/api/hhd/household';
        const PK = 'householdIdx';

        $(document).ready(function () {
            const id = $("#" + PK).val();
            if (id && id !== "") {
                readHousehold(id);
            }
        });

        function readHousehold(id) {
            const sendData = {};
            sendData[PK] = id;

            $.ajax({
                url: API_BASE + "/selectHouseholdDetail",
                type: "post",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(sendData),
                success: function (map) {
                    // 서버 응답 키 유연 처리
                    var result = map.result || map.household || map;
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

        function saveHousehold() {
            const id = $("#" + PK).val();
            let url = id && id !== "" ? (API_BASE + "/updateHousehold") : (API_BASE + "/insertHousehold");

            if ($("#title").val() === "") {
                alert("제목을 입력해주세요.");
                return;
            }
            if ($("#content").val() === "") {
                alert("내용을 입력해주세요.");
                return;
            }

            const formData = $("#householdForm").serializeObject();
            $.ajax({
                url: url,
                type: "post",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(formData),
                success: function (map) {
                    goLink("/hhd/household/householdList");
                },
                error: function () {
                    alert("저장 중 오류 발생");
                }
            });
        }

        function deleteHousehold() {
            const id = $("#" + PK).val();
            if (!id || id === "") {
                alert("삭제할 대상의 PK가 없습니다.");
                return;
            }
            if (!confirm("정말 삭제하시겠습니까?")) return;

            const sendData = {}; sendData[PK] = id;
            $.ajax({
                url: API_BASE + "/deleteHousehold",
                type: "post",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(sendData),
                success: function (map) {
                    alert((map && map.msg) || "삭제 완료되었습니다.");
                    goLink("/hhd/household/householdList");
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
