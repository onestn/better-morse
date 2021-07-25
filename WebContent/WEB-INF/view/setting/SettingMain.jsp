<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />

    <link rel="apple-touch-icon" sizes="76x76" href="/resources/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/resources/assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Better Morse (Basic)</title>
    <meta
            content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
            name='viewport' />
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <!-- CSS Files -->
    <link href="/resources/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/resources/assets/css/paper-dashboard.css?v=2.0.1"
          rel="stylesheet" />
    <link rel="stylesheet" href="/resources/scss/Button.css">
    <style>
        @media (min-width: 1600px) {
            .fullcard {
                margin: 75px 35% 0% 35%;
                height: 100%;
            }
            .card-body {
                height: 100%;
            }
        }
        @media (min-width: 1024px) {
            .fullcard {
                margin: 75px 10% 0% 10%;
                height: 100%;
            }
            .card-body {
                height: 100%;
            }
        }
        @media (min-width: 320px) and (max-width: 1024px) {
            .fullcard {
                margin: 75px 5% 0% 5%;
                height: 100%;
            }
            .card-body {
                height: 100%;
            }
        }
    </style>
</head>

<body>
<div class="wrapper">
    <%@ include file="/WEB-INF/view/sidebar.jsp"%>
    <div class="main-panel">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg
					   navbar-absolute fixed-top
					   navbar-transparent">
            <div class="container-fluid">
                <div class="navbar-wrapper">
                    <div class="navbar-toggle">
                        <button type="button" class="navbar-toggler" id="navbar-toggler">
                            <span class="navbar-toggler-bar bar1"></span>
                            <span class="navbar-toggler-bar bar2"></span>
                            <span class="navbar-toggler-bar bar3"></span>
                        </button>
                    </div>
                    <a class="navbar-brand" href="javascript:;">Better Morse</a>
                </div>
            </div>
        </nav>
        <!-- End Navbar -->
        <!-- 카드 시작 -->
        <div class="fullcard">
            <div class="content"><br>
                <h1 class="ml-4 mt-4 mb-4 text-monospace text-center">-&nbsp;Settings&nbsp;-</h1><br><br>
                <div class="card ml-5 mr-5">
                    <div class="card-body">
                        <!-- 기본적인 회원 정보를 볼 수 있음 -->
                        <!-- 상세보기 페이지는 이메일까지 보여줌 -->
                        <div class="card" style="height: 150px; background-color: #F4F3EF;">
                            <h2 class="m-5 text-monospace" style="text-align: center;">
                                <a href="/setting/updateEmail.do" style="color: #73B895;">Change Email</a>
                            </h2>
                        </div>

                        <div class="card" style="height: 150px; background-color: #F4F3EF;">
                            <h2 class="m-5 text-monospace" style="text-align: center;">
                                <a href="javascript:showUserInfo();" style="color: #73B895;">Show UserInfo</a></h2>
                        </div>

                        <div class="card" style="height: 150px; background-color: #F4F3EF;">
                            <h2 class="m-5 text-monospace" style="text-align: center;">
                                <a href="/deleteUser.do" style="color: #73B895;" onclick="deleteMessage()">Withdrawal</a>
                            </h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--   Core JS Files   -->
<script>
    function showUserInfo() {
        alert("사용자 정보\n\n" + "아이디 : " + "${user_id}" + "\n\n" + "이메일 : " + "${email} \n\n 최근에 틀린 문자 : " + "${wrongCh}");
    }
</script>
<script src="/resources/assets/js/core/jquery.min.js"></script>
<script src="/resources/assets/js/core/popper.min.js"></script>
<script src="/resources/assets/js/core/bootstrap.min.js"></script>
<script src="/resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!-- Chart JS -->
<script src="/resources/assets/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="/resources/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
<script>
    $("#navbar-toggler").on('click', function() {
        if ($(this).hasClass("toggled")) {
            $(this).removeClass("toggled");
            $("html").first().removeClass("nav-open");
        } else {
            $(this).addClass("toggled");
            $("html").first().addClass("nav-open");

        }

    })
    $("#go-bottom").click(function(){
        $('html, body').scrollTop( $(document).height() );
    });
</script>
<!-- Morse Audio -->
<script>
    function deleteMessage() {
        alert("탈퇴하셨습니다. 감사합니다.");
    }
</script>
</body>
</html>
