<%@page import="java.util.Date"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="java.util.List"%>
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
</head>

<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/view/sidebar.jsp"%>
		<div class="main-panel">
			<!-- Navbar -->
			<nav
				class="navbar navbar-expand-lg 
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
		<div class="content">
			<h2 class="ml-4 mt-4 mb-4 text-monospace"> EDUCATION </h2>
				<div class="card">
					<div class="card-body">
						<!-- <div class="card" style="height: 300px;">
						<h4 class="m-5 text-monospace" style="color: green">
						<a href="/Edu/Kor/KorWord.do" class="stretched-line text-success">Word</a></h4></div> -->
						
						<div class="card" style="height: 300px;">
						<h4 class="m-5 text-monospace" style="color: green">
						<a href="/Edu/Kor/KorCh.do" class="stretched-line text-success">Character</a></h4></div>
						
						<div class="card" style="height: 300px;">
						<h4 class="m-5 text-monospace">
						<a href="/Edu/Kor/KorWorst.do" class="stretched-line text-success">Worst Character</a></h4></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--   Core JS Files   -->
	<script src="/resources/assets/js/core/jquery.min.js"></script>
	<script src="/resources/assets/js/core/popper.min.js"></script>
	<script src="/resources/assets/js/core/bootstrap.min.js"></script>
	<script
		src="/resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
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
		var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
		var oscillator = audioCtx.createOscillator();
		var biquadFilter = audioCtx.createBiquadFilter();
		var gainNode = audioCtx.createGain();
		
		var count = 0;
		
		biquadFilter.type = "lowpass";
		biquadFilter.frequency.setValueAtTime(600, audioCtx.currentTime);
		biquadFilter.Q.setValueAtTime(15, audioCtx.currentTime);
		
		oscillator.type = 'sine';
		oscillator.frequency.setValueAtTime(600, audioCtx.currentTime); // value in hertz
		
		oscillator.connect(gainNode);
		gainNode.connect(biquadFilter);
		biquadFilter.connect(audioCtx.destination);
		
		oscillator.start();
		
		gainNode.gain.value = 0;
	</script>
</body>

</html>
