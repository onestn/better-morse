
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sidebar" data-color="white" data-active-color="danger" id="downFull">
     <div class="sidebar-wrapper" id="sideBarFull" >
        <ul class="nav" >
          <li id="index">
            <a href="/Morse/MorseBasic.do" >
              <i class="nc-icon nc-planet"></i>
              <p>Playground</p>
            </a>
          </li>
          <li id="wordCard">
            <a href="/Edu/EduMain.do">
              <i class="nc-icon nc-book-bookmark"></i>
              <p>Education</p>
            </a>
          </li>
          <li>
            <a href="/Test/TestMain.do">
              <i class="nc-icon nc-headphones"></i>
              <p>Listen</p>
            </a>
          </li>
          <li>
            <a href="/user/settings.do">
              <i class="nc-icon nc-settings-gear-65"></i>
              <p>Settings</p>
            </a>
          </li>
          <li>
            <a style="color: #73B895" href="/logout.do">
                <i class="nc-icon nc-user-run"></i>
                <p>LOGOUT</p>
            </a>
          </li>
        </ul>
      </div>
    </div>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   
    <!-- 선택 메뉴창을 클릭했을때 active클래스 추가 삭제-->
    <script>
    $('li').on('click', function() {
    	$('li').removeClass('active');
    	$(this).addClass('active');
    });
   </script>

