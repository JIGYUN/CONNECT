<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<section>
    <h2 class="mb-3">screenTitle <span id="pageTitle">수정</span></h2>

    <div class="mb-3">
        <button class="btn btn-primary" type="button" onclick="saveTemplate()">저장</button>
		<c:if test="${not empty param.PK_PARAM}">
	        <button class="btn btn-outline-danger" type="button" onclick="deleteTemplate()">삭제</button>
	    </c:if>
        <a class="btn btn-outline-secondary" href="/BIZ_SEG/template/templateList">목록</a>
    </div>
 
    <form id="templateForm">
        <!-- PK 파라미터 (치환 대상) -->
        <input type="hidden" name="PK_PARAM" id="PK_PARAM" value="${param.PK_PARAM}"/>

        <div class="form-group" style="max-width: 640px;">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title"/>
        </div>

        <div class="form-group" style="max-width: 840px;">
            <label for="content">내용</label>
            <textarea class="form-control" name="content" id="content" rows="10"></textarea>
        </div>
    </form>
</section>

<script>
    /* ===== 치환 토큰 =====
       - BIZ_SEG: 비즈 세그먼트
       - Template/template: 서비스명
       - PK_PARAM: templateIdx 등
    */
    const API_BASE = '/api/BIZ_SEG/template';
    const PK = 'PK_PARAM';

    $(document).ready(function () {
        const id = $("#" + PK).val();
        if (id && id !== "") {
            readTemplate(id);
            $("#pageTitle").text("수정");
        } else {
        	$("#pageTitle").text("등록");
        }
    });

    function readTemplate(id) {
        const sendData = {};
        sendData[PK] = id;

        $.ajax({
            url: API_BASE + "/selectTemplateDetail",
            type: "post",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(sendData),
            success: function (map) {
                const result = map.result || map.template || map;
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

    function saveTemplate() {
        const id = $("#" + PK).val();
        const url = id && id !== ""
            ? (API_BASE + "/updateTemplate")
            : (API_BASE + "/insertTemplate");

        if ($("#title").val() === "") {
            alert("제목을 입력해주세요.");
            return;
        }
        if ($("#content").val() === "") {
            alert("내용을 입력해주세요.");
            return;
        }

        const formData = $("#templateForm").serializeObject();

        $.ajax({
            url: url,
            type: "post",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(formData),
            success: function () {
                location.href = "/BIZ_SEG/template/templateList";
            },
            error: function () {
                alert("저장 중 오류 발생");
            }
        });
    }

    function deleteTemplate() {
        const id = $("#" + PK).val();
        if (!id || id === "") {
            alert("삭제할 대상의 PK가 없습니다.");
            return;
        }
        if (!confirm("정말 삭제하시겠습니까?")) return;

        const sendData = {};
        sendData[PK] = id;

        $.ajax({
            url: API_BASE + "/deleteTemplate",
            type: "post",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(sendData),
            success: function () {
                alert("삭제 완료되었습니다.");
                location.href = "/BIZ_SEG/template/templateList";
            },
            error: function () {
                alert("삭제 중 오류 발생");
            }
        });
    }

    // serializeObject: 폼 → JSON
    $.fn.serializeObject = function () {
        let obj = {};
        const arr = this.serializeArray();
        $.each(arr, function () {
            obj[this.name] = this.value;
        });
        return obj;
    };
</script>