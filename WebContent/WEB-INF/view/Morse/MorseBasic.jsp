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
<style>
	@media (min-width: 1600px) {
		.fullcard {
			margin: 75px 35% 0% 35%;
			height: 100%;
		}
		.card-body {
			height: 800px;
		}
	}
	@media (min-width: 1024px) {
		.fullcard {
			margin: 75px 10% 0% 10%;
			height: 100%;
		}
		.card-body {
			height: 800px;
		}
	}
	@media (min-width: 320px) and (max-width: 1024px) {
		.fullcard {
			margin: 75px 10% 0% 10%;
			height: 100%;
		}
		.card-body {
			height: 800px;
		}
		#basic {
			font-size: 28px;
		}
	}
</style>
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
						<a class="navbar-brand" href="/Home/MorseMain.do">Better Morse</a> &nbsp; <i class="nc-icon nc-spaceship"></i>
					</div>
				</div>
			</nav>
			<!-- End Navbar -->
			<!-- 카드 시작 -->
			<div class="fullcard">
			<div class="content">
			<h2 class="ml-4 mt-4 mb-4 text-monospace text-center"> Playground </h2>
				<div class="card ml-4 mr-4">
					<div class="card-body">
						<div class="row">
							<div class="col-6">
								<h2 id="basic"class="m-5 text-monospace" style="color: #5ABB92">Basic</h2>
							</div>
						</div>
						
						<!-- 출력되는 문자 -->
						<!-- @TO DO
							1. -가 기준치를 넘어가면 .로 인식되는 버그
							2. 창보다 더 많은 문자를 입력하는 것에 대응하는 프론트 구현 
							3. 
						 -->
						<h3 class="ml-1 quoted text-monospace" id="jskey">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3><br>
				<!-- <form onsubmit="return false;">

					<input type="submit" value="QRQ" onclick="changespeed(1);return false;">
					<input type="submit" value="QRS" onclick="changespeed(0);return false;">
					<input type="submit" value="Clear" onclick="document.getElementById('jskey').innerHTML = '&nbsp;';return false;">
				</form> -->
				</div>
					</div>
				<!-- 카드 끝 -->
				
				<!-- SpaceBar를 누르면 모스부호가 입력된다.  -->
				<div class="ml-4 mr-4">
					<button class="shadow" type="submit" id="spacebar" style="border-radius: 12px; font-size: 50px; background-color: #5ABB92; height: 100px; width: 100%;"
							onmousedown="down();return false;" onmouseup="up();return false;"
							ontouchstart="down();return false;" ontouchend="up();return false;"></button>
				</div>
				<br>
				<div class="text-monospace" style="text-align: center; color: #5ABB92;">
				<p>SpaceBar = "Click"&nbsp;&nbsp;&nbsp;&nbsp;
					Enter = "Return"&nbsp;&nbsp;&nbsp;&nbsp;
					D = "Delete"
				</p>
					<a href="/Morse/MorseHome.do">"I need Beginner Mode"</a>
				</div>
				<div id="speed" class="text-monospace text-center font-weight-lighter" style="display: none;">Speed: 8WpM &nbsp; Ratio: 9592086411.9 &nbsp; eff.Speed: 0</div>
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
	<!-- Side bar Script -->
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
	<!-- Morse Variable -->
	<script>
	
	</script>
	<!-- Morse Functions -->
	<script>
		var space = document.getElementById("spacebar");
		let JsKey = document.getElementById("jskey");
		var answer = new Array();
	// Home/Basic은
	// 키보드 이벤트가 발생하였을 때 입력값에 따른 함수 실행
	document.onkeydown = function(evt) {
		evt = evt || window.event;

		if ("key" in evt) {
			// ESC시 입력 문자 초기화
			if (evt.key === "Escape" || evt.key === "Esc") {
				document.getElementById('jskey').innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				answer = new Array();
			// Enter입력 시 줄바꿈과 스페이스바 한칸을 삽입
			} else if (evt.key == "Enter") {
				document.getElementById('jskey').innerHTML += "<br><br>";
				document.getElementById('jskey').innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			} else if (evt.key === "d" || evt.key === "ㅇ") {
					// 제일 마지막에 해당하는 문자 제거
					answer.length = answer.length - 1;
					let tempAnswer = answer.toString().split(',');
					console.log("TEMP ANSWER : " + tempAnswer);
					var currentJsKey = JsKey.innerHTML;
					console.log(currentJsKey);

					JsKey.innerHTML = currentJsKey.slice(0, currentJsKey.length - 19);
			} else if (evt.key == " "){
				down();
			}
		}
	}
	
	document.onkeyup= function(evt) {
		evt = evt || window.event;
		if ("key" in evt) {
			if (evt.key == " "){
				up();
			}
		} 
	}
	
	var time;
	var temp;
	var lastchar = "";
	var dotlength = 150;
	var avgdot = dotlength;
	var avgdash = dotlength*3;
	var effspeed = 0;
	var idletime = new Date().getTime();
	var keydown = 0;
	var sent = 0;
	var queue = new Queue();
	
	var code = new Array();
	
	code['.-'] = "A";
	code['-...'] = "B"; 
	code['-.-.'] = "C";
	code['-..'] = "D"; 
	code['.'] = "E"; 
	code['..-.'] = "F";
	code['--.'] = "G"; 
	code['....'] = "H"; 
	code['..'] = "I";
	code['.---'] = "J"; 
	code['-.-'] = "K"; 
	code['.-..'] = "L";
	code['--'] = "M"; 
	code['-.'] = "N"; 
	code['---'] = "O";
	code['.--.'] = "P"; 
	code['--.-'] = "Q"; 
	code['.-.'] = "R";
	code['...'] = "S"; 
	code['-'] = "T"; 
	code['..-'] = "U";
	code['...-'] = "V"; 
	code['.--'] = "W"; 
	code['-..-'] = "X";
	code['-.--'] = "Y"; 
	code['--..'] = "Z";
	
	code['.----'] = "1";
	code['..---'] = "2"; 
	code['...--'] = "3"; 
	code['....-'] = "4";
	code['.....'] = "5"; 
	code['-....'] = "6"; 
	code['--...'] = "7";
	code['---..'] = "8"; 
	code['----.'] = "9"; 
	code['-----'] = "0";
	
	code['.-.-.-'] = "."; code['..--..'] = "?"; code['---...'] = ":";
	code['-....-'] = "-"; code['-.--.-'] = ")"; code['-.--.'] = "(";
	code['.-.-.'] = "+";
	
	/* 
	code['.-..'] = "ㄱ";
	code['..-.'] = "ㄴ";
	code['-...'] = "ㄷ";
	code['...-'] = "ㄹ";
	code['--'] = "ㅁ";
	code['.--'] = "ㅂ";
	code['--.'] = "ㅅ";
	code['-.-'] = "ㅇ";
	code['.--.'] = "ㅈ";
	code['-.-.'] = "ㅊ";
	code['-..-'] = "ㅋ";
	code['--..'] = "ㅌ";
	code['---'] = "ㅍ";
	code['.---'] = "ㅎ";
	
	code['.'] = "ㅏ";
	code['..'] = "ㅑ";
	code['-'] = "ㅓ";
	code['...'] = "ㅕ";
	code['.-'] = "ㅗ";
	code['-.'] = "ㅛ";
	code['....'] = "ㅜ";
	code['.-.'] = "ㅠ";
	code['-..'] = "ㅡ";
	code['..-'] = "ㅣ";
	code['-.--'] =  "ㅐ";
	code['--.-'] = "ㅔ"; */
	
	window.setInterval("checkspace();", 5*dotlength);
	
	// 스페이스 바를 눌렀을 경우 실행
	function down () {
		time = new Date().getTime();
		space.style.color = "#5ABB92";
		space.style.backgroundColor = "white";
		keydown = 1;
		gainNode.gain.value = 0.1;
	}
	
	// 스페이스바를 떼었을 경우 
	function up () {
		space.style.backgroundColor = "#5ABB92";
		space.style.color = "white";
		keydown = 0;
		gainNode.gain.value = 0.0;
		// 키를 뗐을 때 눌렀을 때와 비교한 시간을 time에 대입
		time = new Date().getTime() - time;
		var elements = "";
		
		// time에 따라 .과 -를 구분한다. 
		if (time > dotlength) {
			element = "-";
			space.innerText += element;
			avgdash = (avgdash + time)/2;
		} else {
			element = ".";
			space.innerText += element;
			avgdot = (avgdot + time)/2;
		}
		
		lastchar += element;
		update();
		idletime = new Date().getTime();
	}
	
	function checkspace () {
		if (keydown) { return; }
		var mytime = new Date().getTime();
		var diff = mytime - idletime;
		
		if (diff > 1000) {
			if (queue.getlength() > 0) {
				submittext(queue.purge(), Math.round(effspeed));
			}
		}
		
		if (diff > 2*dotlength) {
			if (code[lastchar]) {
				append(code[lastchar], "jskey");
				queue.add(code[lastchar]);
				space.innerText = "";
				answer.push(code[lastchar]);
			}
			else if (lastchar) {
				append("*", "jskey");
				queue.add('*');
				space.innerText = "";
			}
			
			lastchar = '';
			
			if (time - idletime > 4 * dotlength) {
				append(" ", "jskey");
				queue.add(' ');
			}
		}
	}
	
	// Func 키보드의 입력에 따라 추가되는 문자
	// what: 모스부호에 해당하는 문자, where: HTML에 삽입할 위치
	// Basic은 Enter를 누르면 줄바꿈을 함.
	function append(what, where) {
		document.getElementById(where).innerHTML += what + "&nbsp;&nbsp;&nbsp;";
	}
	
	// 초기값 150으로 지정된 dotlength를 5씩 변경한다.
	function changespeed (a) {
		if (a) {
			dotlength -= 5;	
		}
		else {
			dotlength += 5;	
		}
		update();
	}
	
	function update () {
		wpm = Math.round((10 * 1200) / dotlength)/10;
		ratio = Math.round((10 * avgdash) / avgdot)/10;
		effspeed = Math.round((10 * 3600) / avgdash)/10;
		var x = document.getElementById('speed');
		x.innerHTML = "SPEED: "+wpm+"WpM";
		x.innerHTML += "; RATIO: " + ratio;
		x.innerHTML += "; EFF.SPEED: " + effspeed;
	}
	
	function Queue () {
		this.content = '';
		this.tmp = '';
		this.add = function (chr) {
			this.content += chr;
		}
		this.getlength = function () {
			return this.content.length;
		}
		this.purge = function () {
			this.tmp = this.content;
			this.content = '';
			return this.tmp+ ' ';
		}
	}
	
	function submittext (text, wpm) {
	}

</script>


</body>

</html>
