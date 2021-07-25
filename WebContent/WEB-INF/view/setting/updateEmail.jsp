<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>ChangeEmail</title>
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
				<form class="login100-form validate-form" method="post" onsubmit="return check()" >
					<span class="login100-form-title p-b-49">Change Email </span>

					<div class="wrap-input100 validate-input " data-validate="Email is reauired">
						<span class="label-input100">EMAIL</span>
							<input class="input100" type="email" name="email" id="email" placeholder="Type your email" />
						<span class="focus-input100" data-symbol="&#9993;"></span>
					</div>
					<div class="msg2 m-b-15"></div>

					<div class="text-right p-t-8 p-b-31"></div>

					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn btn" style="background-color: #5ABB92" type="submit">
								Submit</button>
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
	<script src="../resources2/vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="../resources2/js/main.js"></script>

</body>
<script>

	//이메일 중복확인
	let doCheck = 'N'
	$("#email").keyup(function() {
		var query = { email : $("#email").val() };

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
		$.ajax({
			type: 'POST',
			url: "/user/settings/updateUserInfo.do",
			data: "email=" + $('#email').val()
		});
		alert("이메일이 변경되었습니다.");
	}
</script>
</html>
