# BetterMorse

군에서 특전통신을 담당하며 선임들에게 배운 모스부호를 어떻게 하면 사회에서 일반인들이 쉽게 배울 수 있을까?
를 염두하며 군생활 중 배운 내용을 토대로 하여 일반인들이 쉽게 모스부호를 배우는 것을 목표로 하여 만들었습니다.

## WebSite : http://yang.ncloudpaas-ta.com

## 적용 기술
	- 프레임워크 : SpringFramework MVC
	- 데이터베이스 : MySQL, MongoDB
	- 클라우드 환경 : ncloud
	- 기타 기술 : Ajax, JQuery, WebAudioAPI
	- 에디터 : IntelliJ

웹 서버 배포는 학교에서 배운 네이버클라우드 서비스를 통해 배포하였습니다.

## 기능

학습법의 종류는 크게 두 가지로, 첫 번째는 사용자가 직접 모스부호를 Spacebar로 입력하고, 두 번째는 모스부호의 Sound를 듣고 맞추는 방식입니다.

1. Playground
	- 사용자가 배운 모스부호를 Spacebar와 Mouse로 자유롭게 작성하며 놀이할 수 있는 페이지 
2. Education
	- English, Korean, Number 세 가지의 문자를 예시로 보고 Spacebar를 통해 직접 입력하며 학습하는 페이지
3. Listen
	- 사용자의 모스부호 청취 역량을 기를 수 있는 기능들을 모은 페이지
4. Listen - Test
	- 모스부호의 Sound 출력 속도로 난이도를 조절하고, 사용자는 해당하는 모스부호를 답변에 입력하는 방식
	- 사용자가 답을 입력하면 사용자의 답변을 답변 배열에 대입하고, 출력된 Sound에 해당하는 문제 배열과 비교 후 비교된 배열에서 틀린 문자를 Count하여 오름차순으로 정렬 후 최상위 3개의 문자를 사용자의 최근 틀린 문자 Column과 MongoDB에 저장

