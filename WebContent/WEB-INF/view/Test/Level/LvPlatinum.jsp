<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

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
<div class="wrapper" id="full1">
	<%@ include file="/WEB-INF/view/sidebar.jsp"%>
	<div class="main-panel" id="full">
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
					<a class="navbar-brand" id="topMain" href="/Home/MorseMain.do">Better Morse</a> &nbsp; <i class="nc-icon nc-spaceship"></i>
				</div>
			</div>
		</nav>
		<!-- LISTEN : 사용자에게 Flash와 Sound를 주고,해당하는 문자를 input text 형식의 submit을 통해
                        제출한 문자와 답을 비교하여 결과페이지로 이동 -->
		<!-- End Navbar -->
		<!-- 카드 시작 -->
		<div class="content" id="full2"><br>
			<h2 class="m-3 text-monospace text-center" id="round"> Round 1 </h2><br>
			<h5 id="questionIs" class="ml-5 text-monospace" style="font-size: 30px; color: #5ABB92">Question is</h5>
			<div id="flashBody" class="card ml-5 mr-5">
				<div class="card-body m-4">
					<!-- FLASH -->
					<button id="flash" class="text-monospace" style="border-radius: 12px; color: #5ABB92; font-size: 50px; background-color: #5ABB92; height: 200px; width: 100%;"/>
				</div>
			</div>
			<br><hr>
			<!-- Your Answer -->
			<div class="card-body ml-4 mr-4 mt-3">
				<label id="yourAnswerIs" class="text-monospace" style="font-size: 30px;color: #5ABB92;">Your Answer is</label>
				<input class="border border-0 text-center shadow text-uppercase" type="text" id="userInput" style="border-radius: 12px; height: 100px; width: 100%; font-size: 60px; color: #5ABB92;" autofocus/>
			</div>

			<!-- Buttons -->
			<div class="card-body ml-4 mr-4 text-monospace">
				<div class="row">
					<div class="col-6">
						<button id="sound" class="shadow text" onclick="ClickSoundBtn();" style="border-radius: 12px; color: white; font-size: 18px; background-color: #5ABB92; height: 80px; width: 100%;">Sound</button>
					</div>
					<div class="col-6">
						<button id="next" class="shadow" onclick="ClickNextBtn();" style="border-radius: 12px; color: white; font-size: 18px; background-color: #5ABB92; height: 80px; width: 100%;">Next</button>
					</div>
				</div>
			</div>
			<div class="mt-4 text-monospace" style="text-align: center; color: #5ABB92;">
<%--				<button id="moreFast" class="mb-2"style="background: none;color: #5ABB92;" onclick="clickSpeedMessage();">> More Fast? Click this Message.<</button>--%>
				<p id="yourSpeed" class="mb-2">Your Speed Level is</p><p id="speedLevel" style="color: #ccc5b9">Begginer</p>
			</div>
			<div id="speed" style="display: none;" class="text-monospace text-center font-weight-lighter">Speed: 8WpM &nbsp; Ratio: 9592086411.9 &nbsp; eff.Speed: 0</div>
		</div>
	</div>
</div>
<!--   Core JS Files   -->
<script src="/resources/assets/js/core/jquery.min.js"></script>
<script src="/resources/assets/js/core/popper.min.js"></script>
<script src="/resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!-- AJAX & JQUERY -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
	});
	$("#go-bottom").click(function(){
		$('html, body').scrollTop( $(document).height() );
	});
</script>
<!-- Morse Audio -->
<script>
	let audioCtx = new AudioContext();
	let oscillator = audioCtx.createOscillator();
	let biquadFilter = audioCtx.createBiquadFilter();

	oscillator.type = "sine";
	oscillator.frequency.setValueAtTime(780, audioCtx.currentTime);
	let gainNode = audioCtx.createGain();

	biquadFilter.type = "lowpass";
	biquadFilter.frequency.setValueAtTime(600, audioCtx.currentTime);
	biquadFilter.Q.setValueAtTime(15, audioCtx.currentTime);

	gainNode.gain.value = 0;

	oscillator.connect(gainNode);
	gainNode.connect(biquadFilter);
	biquadFilter.connect(audioCtx.destination);
	oscillator.start();

</script>
<!-- Morse Functions -->
<script>
	// HTML 관련 변수
	let htmlWord = document.getElementById("Word");
	let htmlCode = document.getElementById("Code");
	let htmlNum = document.getElementById("Num");
	let htmlFlash = document.getElementById("flash");
	let userInput = document.getElementById("userInput");

	// 모스부호 변수
	let code = new Map();
	code['.-'] = "A";code['-...'] = "B";code['-.-.'] = "C";code['-..'] = "D";
	code['.'] = "E";code['..-.'] = "F";code['--.'] = "G";code['....'] = "H";
	code['..'] = "I";code['.---'] = "J";code['-.-'] = "K";code['.-..'] = "L";
	code['--'] = "M";code['-.'] = "N";code['---'] = "O";code['.--.'] = "P";
	code['--.-'] = "Q";code['.-.'] = "R";code['...'] = "S";code['-'] = "T";
	code['..-'] = "U";code['...-'] = "V";code['.--'] = "W";code['-..-'] = "X";
	code['-.--'] = "Y";code['--..'] = "Z";

	// code['.----'] = "1"; code['..---'] = "2"; code['...--'] = "3"; code['....-'] = "4";
	// code['.....'] = "5"; code['-....'] = "6"; code['--...'] = "7"; code['---..'] = "8";
	// code['----.'] = "9"; code['-----'] = "0";

	// 화면에 출력되는 문자의 모스부호가 저장될 변수
	let translatedWord = new Array();
	// 문자 배열의 값을 증가시키며 보여주기 위한 변수
	let indexCnt = 0;

	let soundOnOff = false;
	// 키를 입력하였을 때 기능하는 함수
	document.onkeydown = function(evt) {
		evt = evt || window.event;
		if ("key" in evt) {
			// Enter로 사용자의 입력값과 답을 비교한다.
			if (evt.key === "Escape" || evt.key === "Esc") {
				// 이전으로 이동하는 기능 구현 예정
				// 소리를 전부 끄는 기능
			} else if (evt.key === "Enter") {
				// Enter 시 처음부터 다시 입력할 수 있도록 변수 초기화
				ClickNextBtn();
			} else if (evt.key === " ") {
				ClickSoundBtn();
			}
		}
	}

	let questionWords = ["ALPHA", "BRAVO", "CHARLIE", "DELTA", "ECHO",
						"FOXTROT", "GOLF", "HOTEL", "INDIA", "JULIET",
						"KILO", "LIMA", "MIKE", "NOVEMBER", "OSCAR",
						"PAPA", "QUEBEC", "ROMEO", "SIERRA", "TANGO",
						"UNIFORM", "VICTOR", "WHISKEY", "XRAY", "YANKEE", "ZULU"];

	let roundIndex = 0;
	let questionCnt = 0;

	let totalQuestion = new Array();
	// 문제에 해당하는 5개의 랜덤한 값을 만든다.
	// 1. 난수 생성
	// 2. 인덱스 난수에 해당하는 quiz를 통해 단어 생성
	// 3. 생성된 단어를 TotalQuestion 배열에 대입
	// 4. 최종적으로 사용자의 답배열과 비교할 것
	function GenerateQuestion() {

		for (let i = 0; i < 5; i++) {
			if (questionCnt > questionWords.length - 1) {
				questionCnt = 0;
			}
			totalQuestion.push(questionWords[Math.floor(Math.random() * 26)]);
		}
		console.log("임의의 문제: " + totalQuestion);
	}

	window.onload = function() {
		GenerateQuestion();
		document.getElementById('flash').style.color = "white";
		// 제공하지 않기
		document.getElementById('speedLevel').style.color = "#83EAAB";
		document.getElementById('speedLevel').innerText = "Platinum";
	}

	// toMorse : String -> MorseCodeArr
	// 1. "ABC"
	function toMorse(word) {

		let code = new Map();
		code['.-'] = "A";code['-...'] = "B";code['-.-.'] = "C";code['-..'] = "D";
		code['.'] = "E";code['..-.'] = "F";code['--.'] = "G";code['....'] = "H";
		code['..'] = "I";code['.---'] = "J";code['-.-'] = "K";code['.-..'] = "L";
		code['--'] = "M";code['-.'] = "N";code['---'] = "O";code['.--.'] = "P";
		code['--.-'] = "Q";code['.-.'] = "R";code['...'] = "S";code['-'] = "T";
		code['..-'] = "U";code['...-'] = "V";code['.--'] = "W";code['-..-'] = "X";
		code['-.--'] = "Y";code['--..'] = "Z";

		// 2. "A", "B", "C";
		let tmpWord = word.split('');

		let resultMorse = new Array();

		for (i in tmpWord) {
			resultMorse.push(getKeyByValue(code, tmpWord[i]) + " ");
		}
		console.log("받은 문자 : [" + word + "] / 변환한 코드 : [" + resultMorse.toString().replaceAll(",", " ") + "]");
		return resultMorse;
	}

	let testNum = 0;
	// soundMorseCode : MorseCode -> MorseChar -> Sound
	// ["-.", "-...", "-.-."]
	function soundMorseCode(morseCode) {

		let t = audioCtx.currentTime;
		let dot = 1.2 / 20;
		let adjustInterval = 6.5;

		// 2. "-.", "-...", "-.-."
		for (code in morseCode) {
			// 3. "-." -> "-", "."
			// console.log("SOUND : " + morseCode[code]);
			morseCode[code].split("").forEach(function (letter) {
				switch (letter) {
					case ".":
						gainNode.gain.setValueAtTime(1, t);
						t += dot;
						gainNode.gain.setValueAtTime(0, t);
						t += dot;
						break;
					case "-":
						gainNode.gain.setValueAtTime(1, t);
						t += 3 * dot;
						gainNode.gain.setValueAtTime(0, t);
						t += dot;
						break;
					case " ":
						t += adjustInterval * dot;
						break;
				}
			});
		}

		return false;
	}


	// 배열에 value를 주면 key를 return하기 위한 함수
	function getKeyByValue(object, value) {
		return Object.keys(object).find(key => object[key] === value);
	}

	function compare(a, b) {
		// 차집합. a와 b를 비교하여 a의 차집합을 출력함
		let diff = a.filter(x => !b.includes(x));

		// 두 배열의 차이점이 없기 때문에 ""이 대입됨
		if (diff == "") {
			console.log("정답");
		} else {
			resultArr.push(diff);
		}
		// 같은 문자가 존재하고, 그 중 하나를 맞췄으나 다른 하나를 틀렸을 경우
		// 차집합이기때문에 출력되지 않지만, 이는 하나를 알면 다른 하나는 당연히 안다고 단정지어 그대로 사용
		console.log("현재까지의 오답 : " + resultArr);
		console.log("문제 : [" + a + "], " + "사용자의 답 : [" + b + "], " + "비교 결과 : " + diff);
	}
	// Sound 버튼을 누르면
	// 1. 문제의 사운드가 재생됨
	// 2. 버튼의 값이 Re-Sound로 변경됨
	// 3. 다시 누를 경우 사운드 재생
	// TODO: Sound를 들을 기회를 한정함
	function ClickSoundBtn() {
		soundMorseCode(toMorse(totalQuestion[roundIndex]));

		document.getElementById("sound").innerText = "Re-Sound";
	}

	// 사용자가 입력한 문자를 저장하는 변수
	let userAnswer = new Array();
	// 문제를 임시로 담는 배열
	let question = new Array();
	// 최종 결과를 데이터베이스로 전송하기 위한 변수
	let resultArr = new Array();

	function ClickNextBtn() {
		console.log("ROUDN INDEX : " + roundIndex);
		// 사용자의 답변을 Upper하여 userAnswer배열에 push함
		// 배열이 두개로 감싸여 있어서 차집합에 에러가 발생헀었음
		roundIndex++;
		document.getElementById("round").innerText = "Round" + " " + (roundIndex + 1);
		userAnswer = (document.getElementById('userInput').value).toUpperCase().split('');

		console.log("USER ANSWER : " + userAnswer);



		// 난이도가 올라가면 가리기
		// 다음 단어를 풀기 위하여 리셋
		userAnswer = new Array();
		userInput.value = "";

		if (roundIndex > totalQuestion.length - 1) {
			document.getElementById('flash').innerText = "Go To Main!";
			document.getElementById('round').innerText = "Finish";
			analyseResult(resultArr);
			resultLocation();
		} else {
			let tempQuestion = totalQuestion[roundIndex].split('');
			// 새로운 문제를 사용자에게 제공하기 위함

			compare(tempQuestion, userAnswer);

		}
		document.getElementById("sound").innerText = "Sound";
	}

	// 사용자의 틀린 문자 중 카운트함
	function analyseResult(resultArr) {
		let tempArr = new Array();
		for (i in resultArr) {
			for (j in resultArr[i]) {
				tempArr.push(resultArr[i][j])
			}
		}
		let result = {};
		tempArr.forEach((x) => {
			result[x] = (result[x] || 0) + 1;
		});

		const sortable = Object.entries(result)
			.sort(([, a], [, b]) => b - a)
			.reduce((r, [k, v]) => ({ ...r, [k]: v }), {});

		console.log(result);
		console.log(sortable);

		// 사용자의 오답 중 상위 {}를 체크함
		let wroungCnt = 0;
		for (let i in sortable) {
			wroungCnt++;
			if (wroungCnt > 3) {
				break;
			}
			resultWrongCharacter.push(i);
		}
		console.log("사용자가 틀린 답 중 상위 3개 : " + resultWrongCharacter);
		return resultWrongCharacter;
	}
	let resultWrongCharacter = [];

	// result화면으로 이동하기 위한 함수
	// 변수는 사용자의 틀린 문자의 수와 틀린 문자 상위 3개를 같이 보냄
	// 이는 추후 데이터베이스에 저장될 것
	function resultLocation() {
		if (resultWrongCharacter != null) {
			alert("제일 많이 틀린 문자입니다. " + "[" + resultWrongCharacter + "]\n\n Level 선택화면으로 이동합니다.");
		} else {
			alert("대단한 실력이네요!\n\n Level 선택화면으로 이동합니다.");
		}
		$.ajax({
			url: "/Test/Listen/Submit.do",
			data: "wrongCh=" + resultWrongCharacter,
			type: "POST"
		});

		window.location.href = "/Test/Listen/LevelMain.do";
	}

</script>
</body>
</html>
