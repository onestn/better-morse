<%@page import="java.util.Date"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	String wrongChs = (String) request.getAttribute("wrongChs");
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8" />

	<link rel="apple-touch-icon" sizes="76x76" href="/resources/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="/resources/assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>Better Morse (EngWord)</title>
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
					<a class="navbar-brand" href="/Home/MorseMain.do">Better Morse</a> &nbsp; <i class="nc-icon nc-spaceship"></i>
				</div>
			</div>
		</nav>
		<!-- End Navbar -->
		<!-- 카드 시작 -->
		<div class="content"><br>
			<h2 class="ml-4 mt-4 mb-4 text-monospace text-center"> Worst Character </h2><br>
			<div class="card ml-4 mr-4">
				<div class="card-body">
					<h2 class="ml-5 mt-4 text-monospace" id="Num" style="color: #5ABB92">#1</h2>
					<!-- 출력되는 문자 -->
					<h1 class="text-center text-monospace" id="Word"></h1><br><hr><br>
					<div class="row">
						<!-- 출력된 문자에 해당하는 모스부호 -->
						<div class="col-6">
							<h2 class="text-center text-monospace" id="Code"></h2>
						</div>
						<div class="col-6">
							<h2 class="ml-1 text-monospace text-center" style="color: #5ABB92" id="userInput">&nbsp;</h2>
						</div>
					</div>

				</div>
			</div>

			<div class="ml-4 mr-4">
				<!-- SpaceBar를 누르면 모스부호가 입력된다.  -->
				<button type="submit" id="spacebar" style="border-radius: 12px; font-size: 50px; background-color: #5ABB92; height: 100px; width: 100%;"
						onmousedown="down();return false;" onmouseup="up();return false;"
						ontouchstart="down();return false;" ontouchend="up();return false;"></button>
				<!-- 카드 끝 -->
			</div>
			<div id="speed" style="display: none;" class="text-monospace text-center font-weight-lighter">Speed: 8WpM &nbsp; Ratio: 9592086411.9 &nbsp; eff.Speed: 0</div>
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
<!-- Morse Functions -->
<script>

	// HTML 관련 변수
	var htmlWord = document.getElementById("Word");
	var htmlCode = document.getElementById("Code");
	var htmlNum = document.getElementById("Num");
	var userInput = document.getElementById("userInput");
	var space = document.getElementById("spacebar");

	// 모스부호 변수
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

	let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "N", "M", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

	// Key -> Value
	// document.write(code['.-']);

	// Value -> Key
	// getKeyByValue(code, "A");

	let roundCnt = 0;

	// 사용자가 입력한 문자를 저장하는 변수
	var userAnswer = new Array();
	// 화면에 출력되는 문자의 모스부호가 저장될 변수
	var translatedWord = new Array();
	// 문자 배열의 값을 증가시키며 보여주기 위한 변수
	var indexCnt = 0;

	let wrongString = "<%=wrongChs%>".split(",");
	console.log(wrongString);

	// 시작됨과 동시에 선언
	htmlWord.innerText = wrongString[indexCnt];
	htmlCode.innerHTML = "<br>";
	if (wrongString[indexCnt] == "아직 문제를 풀지 않았습니다.") {
		htmlCode.innerText += "";
	} else {
		htmlCode.innerText += getKeyByValue(code, wrongString[indexCnt]);
	}

	htmlCode.innerHTML += "<br><br>";

	document.onkeydown = function(evt) {

		evt = evt || window.event;

		if ("key" in evt) {
			// esc가 입력되면 사용자가 입력한 데이터가 없어지고,
			// 처음부터 쓸 수 있게 된다.
			if (evt.key === "Escape" || evt.key === "Esc") {
				userInput.innerHTML = "<br>";
				userAnswer = new Array();
			}
			// Enter로 사용자의 입력값과 답을 비교한다.
			else if (evt.key === "Enter") {
				indexCnt++;
				// Enter 시 처음부터 다시 입력할 수 있도록 변수 초기화

				if (indexCnt > wrongString.length - 1) {
					indexCnt = 0;
				}

				spacebar.innerHTML = "&nbsp;";
				userInput.innerHTML = "<br>";


				htmlNum.innerText = "#" + (indexCnt + 1);
				htmlWord.innerText = wrongString[indexCnt];
				htmlCode.innerHTML = "<br>";
				htmlCode.innerText += getKeyByValue(code, wrongString[indexCnt]);
				htmlCode.innerHTML += "<br><br>";


				// 마지막에 작성한 문자를 제거하기 위한 함수
			} else if (evt.key === "d" || evt.key === "ㅇ") {
				// 제일 마지막에 해당하는 문자 제거
				userAnswer.length = userAnswer.length - 1;
				var tempuserAnswer = userAnswer.toString().split(',');
				spacebar.innerHTML = "<br>";

				for (i in tempuserAnswer) {
					spacebar.innerHTML += tempuserAnswer[i] + "<br><br>";
				}

			} else if (evt.key == " ") {
				down();
			}
		}
	}

	// 스페이스바를 떼었을 때 실행되는 함수
	document.onkeyup = function(evt) {
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
	var idletime = new Date().getTime();
	var keydown = 0;
	var sent = 0;
	var queue = new Queue();
	var element = "";

	window.setInterval("checkspace();", (5 * dotlength));

	//	<button id="spacebar" style="background-color: black; height: 100px; width: 100%;"></button>
	// 키를 누를 경우 gainNode의 소리가 나옴
	function down () {
		time = new Date().getTime();
		space.style.color = "#5ABB92";
		space.style.backgroundColor = "white";
		checkspace();
		keydown = 1;
		gainNode.gain.value = 0.1;
	}

	// 배열에 value를 주면 key를 return하기 위한 함수
	function getKeyByValue(object, value) {
		return Object.keys(object).find(key => object[key] === value);
	}

	// 키를 떼었을 경우
	// 1. gainNode의 소리를 없앰
	// 2. time 변수에 전역 변수 time과 현재 시간을 뺀 값을 넣음
	// 3. 만약 time이 dotlength보다 크다면 ->
	//	  변수 element에 "-"를 대입함
	// 4. time이 dotlength보다 낮다면 ->
	//	  변수 element에 "."를 대입
	// 5.
	function up () {
		space.style.backgroundColor = "#5ABB92";
		space.style.color = "white";

		keydown = 0;
		gainNode.gain.value = 0.0;
		time = new Date().getTime() - time;
		elements = "";

		if (time > dotlength) {
			element = "-";
			space.innerText += element;
			avgdash = (avgdash + time)/2;
		}
		else {
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

		// 만약 diff가 1000보다 크면서 queue.getlength()가 0보다 크다면 ->
		// text = queue.purge(), wpm = Math.round(effspeed)
		if (diff > 1000) {
			if (queue.getlength() > 0) {
				submittext(queue.purge(), Math.round(effspeed));
			}
		}

		if (diff > 2*dotlength) {
			if (code[lastchar]) {
				append(code[lastchar], "userInput", lastchar);
				queue.add(code[lastchar]);

				// 부호에 해당하는 문자 화면에 출력

				space.innerText = "";
			} else if (lastchar) {
				append("*", "userInput");
				queue.add('*');
			}

			lastchar = '';

			if (time - idletime > 4 * dotlength) {
				append(" ", "userInput");
				queue.add(' ');
			}
		}
	}

	// Func 키보드의 입력에 따라 추가되는 문자
	// what: 모스부호에 해당하는 문자, where: HTML에 삽입할 위치, lastchar: 문자에 해당하는 모스부호
	function append(what, where, lastchar) {

		if (what == " ") {
			document.getElementById(where).innerHTML += what + "<br/>";
		} else {
			count++;
			document.getElementById(where).innerHTML = "<br>";
			document.getElementById(where).innerHTML += lastchar + "<br>";
		}

	}

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
		wpm = Math.round(10*1200/dotlength)/10;
		ratio = Math.round((10 * avgdash) / avgdot)/10;
		effspeed = Math.round(10*3600/avgdash)/10;
		var x = document.getElementById('speed');
		x.innerHTML = "Speed: "+wpm+"WpM";
		x.innerHTML += "; Ratio: " + ratio;
		x.innerHTML += "; eff. Speed: " + effspeed;
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
