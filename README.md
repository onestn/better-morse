# BetterMorse

"군대에서 배운 모스부호를 어떻게 하면 일반인들이 쉽게 배울 수 있을까?"
라는 생각으로 일반인들도 쉽게 모스부호를 배울 수 있는 프로젝트입니다.

최종 목표는 특전사에 보급되어 다양한 환경에서 모스부호를 익힐 수 있도록 함

~~WebSite : http://yang.ncloudpaas-ta.com~~

## 적용 기술
	- 프레임워크 : SpringFramework MVC
	- 데이터베이스 : MySQL, MongoDB
	- 배포 환경 : ncloud
	- 사용 언어 : Java, JavaScript
	- 사용 기술 : Ajax, WebAudioAPI
	- 에디터 : IntelliJ

## 기능

학습법의 종류는 크게 두 가지로, 첫 번째는 사용자가 직접 모스부호를 Spacebar로 입력하는 것이고, 두 번째는 출력되는 모스부호의 Sound를 듣고 답을 맞추는 방식입니다.

1. Playground
	- 사용자가 배운 모스부호를 Spacebar와 Click으로 자유롭게 작성하며 복습하는 페이지 
2. Education
	- English, Korean, Number 세 가지의 문자가 예시로 주어지고, Spacebar를 통해 직접 입력하며 학습하는 페이지
3. Listen
	- 사용자의 모스부호 청취 역량을 기를 수 있는 기능들을 모은 페이지
4. Listen - Test
	- 모스부호의 Sound 출력 속도로 난이도를 조절하고, 사용자는 해당 모스부호를 답변에 입력하는 방식
	- 사용자가 답을 입력하면 사용자의 답변을 답변 배열에 대입하고, 출력된 Sound에 해당하는 문제 배열과 비교 후 비교된 배열에서 틀린 문자를 Count하여 오름차순으로 정렬 후 최상위 3개의 문자를 사용자의 최근 틀린 문자 Column과 MongoDB에 저장
	- MySQL에 저장되는 최근 틀린 문자는 문제를 풀때마다 변경된다.
	- MongoDB에 저장되는 문자는 추 후 전체 사용자들이 제일 많이 틀린 문자를 WordCloud로 출력하기 위함이다.

### 프로젝트 기간 
	- 2021.05.01 ~ 2021.06.01

#### 부족한 점
	1. Ajax
	2. Spring Annotation
	3. JavaScript 개념

#### TODO
	1. 사용자가 만드는 단어 퀴즈를 모스부호로 출제
	2. Education, Test에서 각 문자를 counting하여 칸으로 힌트
	3. 해군이 배에서 깜빡이로 신호를 보내는 것처럼 화면에 출력
	4. 통신 기능을 넣어 다른 유저와 모스부호로 채팅
	5. Listen 기능에 배경음으로 잡음을 넣어 실제 훈련 상황과 동일한 상황에서의 청취 역량을 키움
