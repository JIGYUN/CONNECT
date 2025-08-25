<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.apache.commons.configuration.Configuration"%>
<%@page import="org.springframework.validation.Errors"%>
<%@page import="org.springframework.validation.ObjectError"%>
<%@page import="org.springframework.context.MessageSource"%>
<%@page import="org.springframework.web.servlet.support.RequestContext"%>
<%@page import="org.springframework.validation.BindingResult"%>
<%!
	/*
	* spring applicationContext를 가져온다.
	*/
	ApplicationContext getApplicationContext(HttpServletRequest request){
		return WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
	}


	/*
	* Configuration bean객체를 가져온다. (config.xml)
	*/
	Configuration getConfiguration(HttpServletRequest request){
		return getApplicationContext(request).getBean(Configuration.class);
	}
%>  
<%  
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    //String sSiteCode = "CC896";			// NICE로부터 부여받은 사이트 코드
    //String sSitePassword = "eiUdJONUcgdq";		// NICE로부터 부여받은 사이트 패스워드
    

	String sSiteCode			= getConfiguration(request).getString("nice.sitecode");                               // 본인실명확인 사이트코드
	String sSitePassword		= getConfiguration(request).getString("nice.password");							      // 본인실명확인 비밀번호

    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "M";      	// 없으면 기본 선택화면, M(휴대폰), X(인증서공통), U(공동인증서), F(금융인증서), S(PASS인증서), C(신용카드)
	String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지
	String domain = request.getRequestURL().toString().replace(request.getRequestURI(),"");
	
	String retUrl = domain + "/www/jsp/auth/nice/";
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
    String sReturnUrl = retUrl + "/checkplus_success.jsp";      // 성공시 이동될 URL
    String sErrorUrl = retUrl + "/checkplus_fail.jsp";          // 실패시 이동될 URL
  
    // 입력될 plain 데이타를 만든다. 
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +  
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 )
    {
        sEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>

<%  
    NiceID.Check.CPClient niceCheck2 = new  NiceID.Check.CPClient();
    
    //String sSiteCode = "CC896";			// NICE로부터 부여받은 사이트 코드
    //String sSitePassword = "eiUdJONUcgdq";		// NICE로부터 부여받은 사이트 패스워드
    

	String sSiteCode2			= getConfiguration(request).getString("nicecompany.sitecode");                               // 본인실명확인 사이트코드
	String sSitePassword2		= getConfiguration(request).getString("nicecompany.password");							      // 본인실명확인 비밀번호

    String sRequestNumber2 = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber2 = niceCheck.getRequestNO(sSiteCode2);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType2 = "U";      	// 없으면 기본 선택화면, M(휴대폰), X(인증서공통), U(공동인증서), F(금융인증서), S(PASS인증서), C(신용카드)
	String customize2 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지
	String domain2 = request.getRequestURL().toString().replace(request.getRequestURI(),"");
	
	String retUrl2 = domain2 + "/www/jsp/auth/nice/";
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
    String sReturnUrl2 = retUrl2 + "/checkplus_success2.jsp";      // 성공시 이동될 URL
    String sErrorUrl2 = retUrl2 + "/checkplus_fail2.jsp";          // 실패시 이동될 URL
  
    // 입력될 plain 데이타를 만든다. 
    String sPlainData2 = "7:REQ_SEQ" + sRequestNumber2.getBytes().length + ":" + sRequestNumber2 +
                        "8:SITECODE" + sSiteCode2.getBytes().length + ":" + sSiteCode2 +
                        "9:AUTH_TYPE" + sAuthType2.getBytes().length + ":" + sAuthType2 +
                        "7:RTN_URL" + sReturnUrl2.getBytes().length + ":" + sReturnUrl2 +
                        "7:ERR_URL" + sErrorUrl2.getBytes().length + ":" + sErrorUrl2 +  
                        "9:CUSTOMIZE" + customize2.getBytes().length + ":" + customize2;
    
    String sMessage2 = "";
    String sEncData2 = "";
    
    int iReturn2 = niceCheck.fnEncode(sSiteCode2, sSitePassword2, sPlainData2);
    if( iReturn2 == 0 )
    {
        sEncData2 = niceCheck.getCipherData();
    }
    else if( iReturn2 == -1)
    {
        sMessage2 = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn2 == -2)
    {
        sMessage2 = "암호화 처리오류입니다.";
    }    
    else if( iReturn2 == -3)
    {
        sMessage2 = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn2 == -9)
    {
        sMessage2 = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage2 = "알수 없는 에러 입니다. iReturn : " + iReturn2;
    }
%>
<!DOCTYPE html> 

<html>   
    <body>  
	<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusService">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	</form>
	
	<form name="form_chk2" method="post">
		<input type="hidden" name="m" value="checkplusService">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData2 %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	</form> 
    <form name="sendForm" id="sendForm">
    	<input type="hidden" class="form-control" name="mberNo" id="mberNo" />
    	<input type="hidden" class="form-control" name="di" id="di" />
    	<input type="hidden" class="form-control" name="birthday" id="birthday" />
    	<input type="hidden" class="form-control" name="gender" id="gender" />
    	<input type="hidden" class="form-control" name="mberNm" id="mberNm" />
    	<input type="hidden" class="form-control" name="cryalTelno" id="cryalTelno" />
    	<input type="hidden" class="form-control" name="bizrno" id="bizrno" />
    </form>

	<div class="row row-cols-1 row-cols-md-4 mb-4 text-center">
      <div class="col">
        <div class="card mb-3 rounded-3 shadow-sm">  
          <div class="card-header py-3">
            <h4 class="my-0 fw-normal">개인 회원</h4>
          </div>  
          <div class="card-body">
            <h1 class="card-title pricing-card-title"> <!-- $0<small class="text-body-secondary fw-light">/mo</small> --></h1>
            <ul class="list-unstyled mt-3 mb-4">  
              <li>만 14세 이상 개인회원</li>  
-             <li> </li>
			  <li>&nbsp;</li>  
            </ul>
            <button type="button" class="w-100 btn btn-lg btn-primary" onClick="fnPopup()">인증</button>
          </div>
        </div>
      </div>   
      <div class="col">
        <div class="card mb-3 rounded-3 shadow-sm">
          <div class="card-header py-3">
            <h4 class="my-0 fw-normal">기업 회원</h4>
          </div>
          <div class="card-body">
            <ul class="list-unstyled mt-3 mb-4">
              <li>사업자공동인증서로 최초 기업 회원가입</li>
              <li> </li>
              <li>&nbsp;</li>   
            </ul>
            <button type="button" class="w-100 btn btn-lg btn-primary" onClick="fnPopup2()">인증</button>  
          </div>
        </div>
      </div>  
      <div class="col">
        <div class="card mb-3 rounded-3 shadow-sm">  
          <div class="card-header py-3">
            <h4 class="my-0 fw-normal">기업 회원</h4> 
          </div>
          <div class="card-body">
            <!-- <h1 class="card-title pricing-card-title">$0<small class="text-body-secondary fw-light">/mo</small></h1> -->
            <ul class="list-unstyled mt-3 mb-4">
              <li>서류인증(사업자등록증, 재직증명서)으로 가입이 필요한 경우</li>   
            </ul>
            <button type="button" class="w-100 btn btn-lg btn-primary" onClick="goLink('/mba/auth/companyDocJoin')">회원가입</button>
          </div>
        </div>
      </div> 
      <div class="col">
        <div class="card mb-3 rounded-3 shadow-sm">  
          <div class="card-header py-3">
            <h4 class="my-0 fw-normal">기업 담당자</h4>
          </div>
          <div class="card-body">
            <ul class="list-unstyled mt-3 mb-4">
              <li>추가 업무담당자 가입이  필요한 경우</li>
              <li> </li>    
              <li>&nbsp;</li>  
            </ul>
            <button type="button" class="w-100 btn btn-lg btn-primary" onClick="goLink('/mba/auth/companyManagerJoin')">회원가입</button>
          </div>
        </div>
      </div>

  
  <script>   
  
	window.name ="Parent_window";  
	
	function fnPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
	
	function fnPopup2(){
		window.open('', 'popupChk2', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk2.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk2.target = "popupChk2";
		document.form_chk2.submit();  
	}
	
	
	function checkDi(){
		//alert("시작");  
		
		var formData = $("#sendForm").serializeObject();
		$.ajax({
	        url: "/api/auth/checkDi",
	        type: "post",
	        contentType: "application/json",
	        dataType :'json',
	 		data : JSON.stringify(formData),  
	        success: function (map){
	        	var result = map.result;  
	        	//alert("시작2");   
	        	console.log(map);
	        	console.log(result);   
	        	if (result != null) {   
	        		alert("이미 등록된 사용자 입니다."); 
	        	} else {
	        		$("#sendForm").attr("method","post");
        	        $("#sendForm").attr("action", "/mba/auth/personalJoin");
        	        $("#sendForm").submit();
	        	}
	        	
	        },
	        error: function(request, status, error){
	            
	        }
		});
	}   
	
	function checkBizrno(){
		//alert("시작");  
		
		var formData = $("#sendForm").serializeObject();
		$.ajax({
	        url: "/api/auth/checkBizrno",
	        type: "post",
	        contentType: "application/json",
	        dataType :'json',
	 		data : JSON.stringify(formData),  
	        success: function (map){
	        	var result = map.result;  
	        	//alert("시작2");
	        	console.log(map);
	        	console.log(result);   
	        	if (result != null) {   
	        		alert("이미 등록된 기업 대표 아이디 사용자 입니다./n업무 담당자 회원가입이 필요한 경우/n업무담당자로 회원가입해 주세요"); 
	        	} else {  
	        		$("#sendForm").attr("method","post");
        	        $("#sendForm").attr("action", "/mba/auth/companyJoin");
        	        $("#sendForm").submit();
	        	}
	        	
	        },
	        error: function(request, status, error){
	            
	        }
		});
	}   

    $(document).ready(function(){
        $("input[name=password]").keydown(function (key) {
            if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
                goLogin();
            }
        });
    });
  </script>

  </body>
</html>