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
                  name="f" action="/user/LoginResult.do" method="post">
                <span class="login100-form-title p-b-49">Better Morse</span>

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

                <div class="text-right p-t-8 p-b-31"></div>

                <div class="container-login100-form-btn">
                    <div class="wrap-login100-form-btn">
                        <div class="login100-form-bgbtn"></div>
                        <button class="login100-form-btn btn" onsubmit="return doLogin(this);" style="background-color: #5ABB92" type="submit">
                            Login In</button>
                    </div>
                </div><br>
                <div class="container-login100-form-btn">
                    <div class="wrap-login100-form-btn">
                        <div class="login100-form-bgbtn"></div>
                        <button class="login100-form-btn btn" name="signup" onclick="location.href='/user/signup.do'" style="background-color: #5ABB92" type="submit">
                            SIGN UP</button>
                    </div>
                </div><br>
                <div class="row text-center" style="color: #73B895">
                    <div class="col-6">
                        <a onclick="location.href='/user/FindId.do'">Find ID</a>
                    </div>
                    <div class="col-6">
                        <a onclick="location.href='/user/FindPass.do'" >Find PW</a>
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
    function doLogin(f) {

        if (f.user_id.value == "") {
            alert("Please Check ID.");
            f.user_id.focus();
            return false;
        }
        if (f.password.value == "") {
            alert("Please Check Password");
            f.password.focus();
            return false;
        }
    }
</script>
</html>
