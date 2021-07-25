<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>SingUp</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--===============================================================================================-->
<link rel="icon" type="image/png"
	href="../resources2/images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/vendor/bootstrap/css/bootstrap.min.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/fonts/iconic/css/material-design-iconic-font.min.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/vendor/animate/animate.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/vendor/css-hamburgers/hamburgers.min.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/vendor/animsition/css/animsition.min.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/vendor/select2/select2.min.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources2/vendor/daterangepicker/daterangepicker.css" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="../resources2/css/util.css" />
<link rel="stylesheet" type="text/css" href="../resources2/css/main.css" />
<!--===============================================================================================-->
<style>
.bline {
	border-bottom: 2px solid #d9d9d9;
	padding-bottom: 15px;
	margin-bottom: 10px;
}

.m-b-15{
	font-size:13px;
}

</style>
</head>
<body>
	<div class="limiter">
		<div class="container-login100" style="background-color: #f4f3ef">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54 shadowbox">
				<form class="login100-form validate-form"
					action="/user/InsertUserInfo.do" method="post" onsubmit="return check()" >
					<span class="login100-form-title p-b-49">Sign up </span>

					<div class="wrap-input100 validate-input "
						data-validate="ID is reauired">
						<span class="label-input100">ID</span> <input class="input100"
							type="text" name="user_id" id="user_id" placeholder="Type your ID" />
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>
					<div class="msg m-b-15"></div>

					<div class="wrap-input100 validate-input "
						data-validate="Passwrod is reauired">
						<span class="label-input100">PASSWORD</span> <input
							class="input100" type="password" name="password" id="password"
							placeholder="Type your Password" /> <span class="focus-input100"
							data-symbol="&#xf190;"></span>
					</div>
					<div class="new m-b-15"></div> 
					<div class="wrap-input100 validate-input "
						data-validate="PasswrodCheck is reauired">
						<span class="label-input100">PASSWROD CHECK</span> <input
							class="input100" type="password" name="pwd2" id="passWordCheck"
							placeholder="Type your Password Check" /> <span
							class="focus-input100" data-symbol="&#xf190;"></span>
					</div>
					<div class="renew m-b-15"></div> 

					<div class="wrap-input100 validate-input "
						data-validate="Email is reauired">
						<span class="label-input100">EMAIL</span> <input class="input100"
							type="email" name="email" id="email"
							placeholder="Type your email" /> <span class="focus-input100"
							data-symbol="&#9993;"></span>
					</div>
					<div class="msg2 m-b-15"></div>

					<div class="text-right p-t-8 p-b-31"></div>

					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn btn" style="background-color: #5ABB92" type="submit">
								SIGN UP</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="dropDownSelect1"></div>

	<!--===============================================================================================-->
	<script src="../resources2/vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="../resources2/vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="../resources2/vendor/bootstrap/js/popper.js"></script>
	<script src="../resources2/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="../resources2/vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="../resources2/vendor/daterangepicker/moment.min.js"></script>
	<script src="../resources2/vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script src="../resources2/vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="../resources2/js/main.js"></script>

</body>
<script>
	var doCheck = 'N'
	$('#password').keyup(
			function() {

				var pw = document.getElementById("password").value; //비밀번호

				var pattern1 = /[0-9]/;

				var pattern2 = /[a-zA-Z]/;

				var pattern3 = /[~!@\#$%<>^&*]/; // 원하는 특수문자 추가 제거

				var SamePass_0 = 0; //동일문자 카운트

				if (!pattern1.test(pw) || !pattern2.test(pw)
						|| !pattern3.test(pw) || pw.length<8||pw.length>50) {

					$(".new").text("영문+숫자+특수기호 8자리 이상으로 구성하세요.");
					$(".new").css("color", "#f00");
				} else {

					$(".new").text("비밀번호 조건에 일치합니다");
					$(".new").css("color", "#00f");

				}

				for (var i = 0; i < pw.length; i++) {

					var chr_pass_0;

					var chr_pass_1;

					var chr_pass_2;

					if (i >= 2) {

						chr_pass_0 = pw.charCodeAt(i - 2);

						chr_pass_1 = pw.charCodeAt(i - 1);

						chr_pass_2 = pw.charCodeAt(i);

						//동일문자 카운트

						if ((chr_pass_0 == chr_pass_1)
								&& (chr_pass_1 == chr_pass_2)) {

							SamePass_0++;

						}

						else {

							SamePass_0 = 0;

						}

					}

				}
			})
	$('#passWordCheck').keyup(function() {

		var pw = document.getElementById("password").value; //비밀번호

		var pw2 = document.getElementById("passWordCheck").value; // 확인 비밀번호

		if (pw != '' && pw2 == '') {
			null;
		} else if (pw != "" || pw2 != "") {
			if (pw == pw2) {
				$(".renew").text("비밀번호가 일치합니다.");
				$(".renew").css("color", "#00f");
				doCheck = 'Y';
			} else {
				$(".renew").text("비밀번호가 일치하지 않습니다.");
				$(".renew").css("color", "#f00");
				doCheck = 'N';
			}
		}

	})

	$("#user_id").keyup(function() {
		var query = {
			user_id : $("#user_id").val()
		};
		$.ajax({
			url : "/idCheck.do",
			type : "post",
			data : query,
			dataType : "json",
			success : function(data) {
				if (data == 0) {
					$(".msg").text("사용 가능한 아이디입니다.");
					$(".msg").attr("style", "color:#00f");
					//$('#userId').attr("disabled", true);
					doCheck = 'Y'
				} else {
					$(".msg").text("사용하고 있는 아이디입니다.");
					$(".msg").attr("style", "color:#f00");
					doCheck = 'N'
				}
			}
		}); // ajax 끝
	});

	//이메일 중복확인
	var doCheck = 'N'
	$("#userEmail").keyup(function() {
		var query = {
			userEmail : $("#userEmail").val()
		};

		$.ajax({
			url : "emailCheck.do",
			type : "post",
			data : query,
			success : function(data) {

				if (data == 1) {
					$(".msg2").text("사용하고 있는 이메일입니다.");
					$(".msg2").attr("style", "color:#f00");
					doCheck = 'N'
				} else {
					$(".msg2").text("사용 가능한 이메일입니다.");
					$(".msg2").attr("style", "color:#00f");
					doCheck = 'Y'
				}
			}
		}); // ajax 끝
	});

	function check() {
		if (doCheck == 'N') {
			alert("입력을 다시 확인해주세요.")
			return false;
		}
	}
</script>
</html>
