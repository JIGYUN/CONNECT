<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>로그인 | CONNECT</title>

    <style>
        /* ───────────────────────────
           배경
        ─────────────────────────── */
        .auth-shell{
            /* 화면 전체 높이 + 가운데 정렬 베이스 */
            min-height:100vh;
            display:flex;
            align-items:flex-start;    /* 위쪽 정렬(센터로 바꾸려면 center) */
            justify-content:center;
            /* 로그인 카드의 수직 위치(여기 숫자를 아주 살짝만 조정해서 내리거나 올리면 됩니다) */
            padding-top: clamp(48px, 9vh, 108px);

            /* 그라디언트 배경 */
            background:
                radial-gradient(1000px 400px at 10% -10%, #e7f1ff 0%, transparent 55%),
                radial-gradient(800px 300px at 100% 10%, #fff2f2 0%, transparent 50%),
                linear-gradient(180deg, #ffffff, #f7f9fb 60%);
        }

        /* ───────────────────────────
           카드(글래스 + 그림자)
        ─────────────────────────── */
        .auth-shell .glass-card{
            background:rgba(255,255,255,.85);
            backdrop-filter:blur(10px);
            border:1px solid rgba(255,255,255,.5);
            border-radius:1.25rem;
            box-shadow:0 10px 30px rgba(0,0,0,.06);
        }

        /* 브랜드 타이포 */
        .auth-shell .brand{
            font-weight:800;
            letter-spacing:.06em;
        }

        /* 인풋(전역 .form-control 영향 차단) */
        .auth-shell .form-control{
            height:48px;
            border-radius:.75rem;
        }

        /* 버튼(전역 .btn 영향 차단: 반드시 .auth-shell 범위로) */
        .auth-shell .btn-primary{
            background:#0d6efd;
            border-color:#0d6efd;
            height:44px;
            border-radius:.75rem;
            width:100%;
        }
        .auth-shell .btn-primary:hover{
            background:#0b5ed7;
            border-color:#0b5ed7;
        }

        .auth-shell .btn-ghost{
            border:1px solid rgba(13,110,253,.35);
            color:#0d6efd;
            background:transparent;
            height:44px;
            border-radius:.75rem;
            width:100%;
        }
        .auth-shell .btn-ghost:hover{
            background:rgba(13,110,253,.06);
        }

        /* 오류문구 */
        .auth-shell .help-error{
            color:#dc3545;
            font-size:.9rem;
        }

        /* 구분선 */
        .auth-shell .divider{
            display:flex;
            align-items:center;
            gap:12px;
            color:#8a95a6;
            margin:12px 0 10px;
        }
        .auth-shell .divider .line{
            height:1px;
            background:linear-gradient(90deg, transparent, #e6ebf2, transparent);
            flex:1;
        }

        /* Google 버튼(전역 영향 배제) */
        .auth-shell #googleWrap{ width:100%; }
        .auth-shell #googleBtn{
            width:100%;
            height:44px;
            border-radius:.75rem;
            border:1px solid #dfe3ea;
            background:#fff;
            display:flex;
            align-items:center;
            justify-content:center;
            gap:10px;
            color:#444;
            text-decoration:none;
            transition:box-shadow .15s ease, transform .03s ease;
        }
        .auth-shell #googleBtn:hover{
            box-shadow:0 4px 14px rgba(0,0,0,.08);
        }
        .auth-shell #googleBtn:active{
            transform:translateY(1px);
        }
        .auth-shell #googleIcon{
            width:18px; height:18px;
            display:inline-block;
            background-image:url('https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg');
            background-size:cover;
        }

        /* 카드 폭(반응형) */
        @media (min-width:576px){
            .auth-shell .glass-card{ max-width:420px; margin:0 auto; margin-top: 50px;} 
        }
        @media (max-width:575.98px){
            .auth-shell{ padding-top:40px; }
        }
    </style>
</head>
<body>

<div class="auth-shell"><!-- 헤더/네비게이션은 바깥(tiles)에서 렌더링된다고 가정 -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-sm-10 col-md-7 col-lg-5">
                <div class="glass-card p-4 p-md-5">
                    <h1 class="brand h4 mb-1">CONNECT</h1>
                    <p class="text-muted mb-4">계정에 로그인하세요</p>

                    <form name="frm" id="frm" method="post" action="/com/auth/login" autocomplete="off">
                        <input type="hidden" name="loginType" value="n"/>

                        <div class="form-group mb-3">
                            <label class="sr-only" for="mberId">아이디</label>
                            <input type="text" class="form-control" id="mberId" name="mberId" placeholder="아이디"/>
                        </div>

                        <div class="form-group mb-2">
                            <label class="sr-only" for="mberPw">비밀번호</label>
                            <input type="password" class="form-control" id="mberPw" name="mberPw" placeholder="비밀번호"/>
                        </div>

                        <c:if test="${map.failYn eq 'Y'}">
                            <div class="help-error mb-2">입력하신 회원정보를 찾을 수 없습니다.</div>
                        </c:if>

                        <button type="button"
                                class="btn btn-primary w-100 mb-2"
                                onclick="goLogin()">
                            Login
                        </button>

                        <div class="divider">
                            <span class="line"></span>
                            <span>또는</span>
                            <span class="line"></span>
                        </div>

                        <!-- Google Sign-In (버튼 크기 고정) -->
                        <div id="googleWrap" class="mb-3">
                            <a id="googleBtn" href="/com/auth/google/start">
                                <span id="googleIcon" aria-hidden="true"></span>
                                <span>Sign in with Google</span>
                            </a>
                        </div>

                        <button type="button"
                                class="btn btn-ghost w-100"
                                onclick="goLink('/mba/auth/join')">
                            회원가입
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function goLogin(){
        if ($("#mberId").val() === "") {
            alert("아이디를 입력해주세요.");
            return;
        }
        if (!checkId || !checkId($("#mberId").val())){
            alert("6-12자의 영문, 숫자, 기호(- _ )만 사용 가능합니다.");
            $("#mberId").focus();
            return;
        }
        if ($("#mberPw").val() === "") {
            alert("비밀번호를 입력해주세요.");
            return;
        }
        if (!checkPw || !checkPw($("#mberPw").val())){
            alert("8자리 이상, 영문 대/소문자, 특수문자, 숫자를 조합해서 입력해주세요.");
            $("#mberPw").focus();
            return;
        }
        $("#frm").attr("method","post")
                 .attr("action","/com/auth/login")
                 .submit();
    }

    // Enter 키로 로그인
    (function(){
        var pw = document.getElementById('mberPw');
        if (pw){
            pw.addEventListener('keydown', function(e){
                if (e.key === 'Enter' || e.keyCode === 13) goLogin();
            });
        }
    })();
</script>
</body>
</html> 