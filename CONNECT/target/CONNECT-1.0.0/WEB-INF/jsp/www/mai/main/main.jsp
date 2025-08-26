<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
  <!DOCTYPE html>
<html>
  <body>

  <meta name="google-signin-client_id" content="442434028472-3k5o0k7urabal0ff915pt58788v44pm1.apps.googleusercontent.com">
  <div class="col-sm-5">
      <h1 class="h3 mb-3 fw-normal">메인화면</h1>
  </main>
  </div>
  <script>
	function goLogin(){
	    if ($("#registerId").val() == "") {
	        alert("아이디를 입력해주세요.");
	        return;
	    }

	    if ($("#password").val() == "") {
	        alert("비밀번호를 입력해주세요.");
	        return;
	    }

        $("#frm").attr("method","post");
        $("#frm").attr("action", "/com/auth/login");
        $("#frm").submit();
	    
/* 		var sendData = {};
		sendData.registerId = $("#registerId").val();
		sendData.password = $("#password").val();

	    $.ajax({
	        url: "/web/auth/selectLogin",  
	        type: "post",
	        contentType: "application/json", 
	        data: JSON.stringify(sendData),  
	        success: function (map){
	        	console.log(map); 
                alert("로그인이 완료되었습니다.");
	        },
	        error: function(request, status, error){
	            
	        }
	    }); */
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