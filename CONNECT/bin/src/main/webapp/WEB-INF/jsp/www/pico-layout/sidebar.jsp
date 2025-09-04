<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- 상단 내비게이션 (Pico 패턴) -->
<nav class="container">
  <ul>
    <li><strong><a href="/" style="text-decoration:none">CONNECT</a></strong></li>
  </ul>

  <ul>
    <li><a href="/bbs/board/boardList" data-nav="board">게시판</a></li>
    <li><a href="/hhd/household/householdList" data-nav="household">가계부</a></li>
  </ul>

  <ul>
    <sec:authorize access="!hasRole('EXTERNAL_AUTH')">
      <li><a role="button" class="secondary" href="/mba/auth/join">회원가입</a></li>
      <li><a role="button" href="/mba/auth/login">로그인</a></li>
    </sec:authorize>
    <sec:authorize access="hasRole('EXTERNAL_AUTH')">
      <li><a role="button" class="outline" href="/mba/auth/logout">로그아웃</a></li>
    </sec:authorize>
  </ul>
</nav>

<script>
  // 현재 경로에 맞춰 활성 메뉴 표시
  (function () {
    const p = location.pathname;
    const map = [
      ['board', '/bbs/board/'],
      ['household', '/hhd/household/']
    ];
    document.querySelectorAll('nav [data-nav]').forEach(a => {
      const key = a.getAttribute('data-nav');
      const hit = map.find(([k, prefix]) => k === key && p.startsWith(prefix));
      if (hit) a.setAttribute('aria-current', 'page'); // Pico 스타일의 active
    });
  })();
</script>