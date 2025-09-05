<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<header class="site-header sticky-top">
    <nav class="navbar navbar-expand-lg nav-elevated">
        <div class="container">
            <!-- 브랜드 -->
            <a class="navbar-brand brand-wordmark" href="/">CONNECT</a>

            <!-- 토글 (모바일) -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNav"
                    aria-controls="mainNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- 메뉴 + 액션 -->
            <div class="collapse navbar-collapse" id="mainNav">
                <!-- 좌측 메뉴 -->
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/bbs/board/boardList" data-active="/bbs/board">REPORT</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/hhd/household/householdList" data-active="/hdd/household">HOUSEHOLD</a>
                    </li>    
                    <li class="nav-item">
                        <a class="nav-link" href="/mmp/map/mapList" data-active="/mmp/map">MAP</a>
                    </li>     
                    <li class="nav-item">
                        <a class="nav-link" href="/mai/main/culture" data-active="/mai/main">INFO</a>
                    </li>
                </ul>

                <!-- 우측 액션 -->
                <div class="navbar-actions d-flex align-items-center">  
                    <sec:authorize ifNotGranted="EXTERNAL_AUTH">
                        <a class="btn btn-ghost mr-2" href="/mba/auth/join">JOIN</a>
                        <a class="btn btn-ghost-primary" href="/mba/auth/login">LOGIN</a>
                    </sec:authorize>  

                    <sec:authorize access="hasRole('EXTERNAL_AUTH')">
                        <div class="dropdown">
                            <button class="btn btn-ghost dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="avatar">U</span> ACCOUNT
                            </button>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="/mypage">MYPAGE</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="/mba/auth/logout">LOGOUT</a>
                            </div>
                        </div>
                    </sec:authorize>
                </div>
            </div>
        </div>
    </nav>
</header>

<!-- 헤더 스타일 -->
<style>
    /* 전체 프레임 */
    .site-header { margin-top: .75rem; }

    /* 떠있는 화이트 바 */
    .nav-elevated{
        background:#fff;
        border-radius:14px;
        box-shadow:0 .25rem 1rem rgba(0,0,0,.06);
        padding:.5rem .75rem;
    }

    /* 브랜드 워드마크 */
    .brand-wordmark{
        font-weight:800;
        letter-spacing:.06em;
        font-size:1.25rem;
        color:#111 !important;
    }

    /* 네비 링크 */
    .navbar-nav .nav-link{
        position:relative;
        padding:.5rem .75rem;
        font-weight:600;
        color:#6c757d !important;
        transition:color .15s ease;
    }
    .navbar-nav .nav-link:hover{ color:#0d6efd !important; }
    .navbar-nav .nav-link::after{
        content:"";
        position:absolute; left:.75rem; right:.75rem; bottom:.35rem;
        height:2px; background:#0d6efd; opacity:.85;
        transform:scaleX(0); transform-origin:center;
        transition:transform .2s ease;
        border-radius:2px;
    }
    .navbar-nav .nav-link:hover::after,
    .navbar-nav .nav-link.active::after{ transform:scaleX(1); }

    /* 우측 버튼: 미니멀 고스트 스타일 */
    .navbar-actions .btn{ border-radius:999px; }
    .btn-ghost{
        background:transparent;
        border:1px solid rgba(0,0,0,.12);
        color:#495057;
    }
    .btn-ghost:hover{ background:rgba(0,0,0,.03); }
    .btn-ghost-primary{
        border:1px solid rgba(13,110,253,.35);
        color:#0d6efd;
        background:transparent;
    }
    .btn-ghost-primary:hover{ background:rgba(13,110,253,.06); }

    /* 아바타 플레이스홀더 */
    .avatar{
        width:28px; height:28px;
        border-radius:50%;
        display:inline-flex; align-items:center; justify-content:center;
        background:#f1f3f5; margin-right:.5rem;
        font-weight:700; font-size:.85rem; color:#495057;
    }

    /* 모바일 폰트/여백 소폭 축소 */
    @media (max-width:576px){
        .brand-wordmark{ font-size:1.1rem; }
    }
</style>

<!-- 현재 경로 기준 활성 메뉴 처리 -->
<script>
    (function(){
        var path = location.pathname;
        document.querySelectorAll('[data-active]').forEach(function(a){
            if(path.indexOf(a.getAttribute('data-active')) === 0){
                a.classList.add('active');
            }
        });
    })();
</script>