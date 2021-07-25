<%@ page import="poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String certNum = CmmUtil.nvl((String) request.getAttribute("certNum"));
    String user_id = CmmUtil.nvl((String) request.getAttribute("user_id"));
%>
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
            <span class="login100-form-title p-b-49">Input Code</span>

            <div class="container">
                <div class="signup-content">
                    <form name="f" action="/user/passChg.do" onsubmit="return certCheck(this);">

                        <input type="text" name="user_id" style="display: none"
                               value="<%=user_id%>" readonly>

                        <div class="form-group wrap-input100 validate-input" data-validate="Error">
                            <span class="label-input100">CODE</span>
                            <input class="input100" type="text" name="certNum" id="user_id" placeholder="Type your CODE" />
                            <span id="emCheck" class="focus-input100" data-symbol="&#xf206;"></span>
                        </div>
                        <div class="msg m-b-15"></div>

                        <div class="form-group">
                            <div class="container-login100-form-btn">
                                <div class="wrap-login100-form-btn">
                                    <div class="login100-form-bgbtn"></div>
                                    <button type="submit" name="submit" class="form-submit login100-form-btn btn"style="background-color: #5ABB92">
                                        Next</button>
                                </div>
                            </div>

                        </div>

                    </form>
                </div>
            </div>

            <div class="text-right p-t-8 p-b-31"></div>

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
    function certCheck(f){
        if (f.certNum.value == "") {
            alert("인증번호를 입력하세요.");
            f.certNum.focus();
            return false;
        }
        if(f.certNum.value != "<%=certNum%>") {
            "<div class="alert alert-danger" role="alert">
                This is a danger alert—check it out!
            </div>"
            f.certNum.focus();
            return false;
        }
    }
</script>
</html>
