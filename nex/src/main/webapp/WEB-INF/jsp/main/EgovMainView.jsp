<%--
  Class Name : EgovMainView.jsp
  Description : 메인화면
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성

    author   : 실행환경개발팀 JJY
    since    : 2011.08.31
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<title>NEX Corp</title>
</head>
<body>
<noscript><p>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</p></noscript>

    <!-- skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- header start -->
	    <c:import url="/sym/mms/EgovHeader.do" />
	    <!-- //header end -->

        <div class="container">
            <div class="p_main">
                <div class="visual">
                    <p>
                        <span class="t1">넥스 홈페이지</span>
                        <span class="t2">NEX 포털</span>
                        <span class="t3">하이오맨 퇴근시간<span id="hioman"></span></span>
                        <span class="t2">캡틴 합격 기원</span>
                    </p>
                </div>

                <!-- 게시물 -->
                <div class="dash_board">
                    <div class="inner">
                        <ul class="tab">
                            <li><a href="" class="cur">캡틴의 라스트 댄스</a></li>
                            <li><a href="">자유게시판</a></li>
                            <!-- <li><a href="">묻고 답하기</a></li> -->
                        </ul>

                        <div class="tab_contents">

                        	<!-- 공지사항 -->
                            <div class="tab_item">
                                <h2 class="blind">캡틴의 라스트 댄스</h2>
                                <ul>
                                    <li>
                                        <a href="<c:url value='https://www.op.gg/summoners/kr/NEX%20Captain-KR1'/>">
                                        	<span class="tit">
												캡틴 중계점 - opgg
                                       		</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="<c:url value='https://your.gg/ko/kr/profile/NEX%20captain'/>">
                                        	<span class="tit">
												캡틴 중계점 - your.gg
                                       		</span>
                                        </a>
                                    </li>
                                </ul>
                                <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>" class="more">더보기</a>
                            </div>

                            <!-- 자유게시판 -->
                            <div class="tab_item">
                                <h2 class="blind">자유게시판</h2>
                                <ul>

                                	<c:if test="${fn:length(bbsList) == 0}" >
				                        <li>최신 게시물이 없습니다.</li>
				                    </c:if>

				                    <c:forEach var="result" items="${bbsList}" begin="0" end="2" step="1" varStatus="status">
                                    <li>
                                        <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_BBBBBBBBBBBB'/>">
                                            <c:if test="${!(result.isExpired=='Y' || result.useAt == 'N')}">
	                                            <span class="tit">
	                                            	<c:choose>
	                                            		<c:when test="${fn:length(result.nttSj) > 51 }">
	                                            			<c:out value="${fn:substring(result.nttSj, 0, 50)}" />...
	                                            		</c:when>
	                                            		<c:otherwise>
	                                            			<c:out value="${result.nttSj }"></c:out>
	                                            		</c:otherwise>
	                                            	</c:choose>
	                                            </span>
	                                            <span class="desc">
	                                            	<c:choose>
	                                            		<c:when test="${fn:length(result.nttCn) > 151 }">
	                                            			<c:out value="${fn:substring(result.nttCn, 0, 150)}" />...
	                                            		</c:when>
	                                            		<c:otherwise>
	                                            			<c:out value="${result.nttCn }"></c:out>
	                                            		</c:otherwise>
	                                            	</c:choose>
	                                            </span>
	                                            <span class="dates">
	                                            	<c:out value="${result.frstRegisterPnttm}"/>
	                                            </span>
                                            </c:if>
                                        </a>
                                    </li>
                                    </c:forEach>

                                </ul>
                                <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_BBBBBBBBBBBB'/>" class="more">더보기</a>
                            </div>

                            <!-- 묻고답하기 -->
                        </div>
                    </div>
                </div>
                <!--// 게시물 -->

            </div>
        </div>

<script>
    // 저녁 8시까지의 시간을 설정 (24시간 형식)
    const targetHour = 20;

    // 업데이트 간격 (밀리초 단위)
    const updateInterval = 1000;

    function updateRemainingTime() {
        // 현재 시간 얻기
        const now = new Date();

        // 목표 시간 설정
        const targetTime = new Date(now);
        targetTime.setHours(targetHour, 0, 0, 0);

        // 남은 시간 계산
        let timeDiff = targetTime - now;
        if (timeDiff < 0) {
            // 저녁 8시가 이미 지났으면 다음 날로 설정
            targetTime.setDate(targetTime.getDate() + 1);
            timeDiff = targetTime - now;
        }

        // 시, 분, 초 계산
        const hours = Math.floor(timeDiff / (1000 * 60 * 60));
        timeDiff -= hours * 1000 * 60 * 60;
        const minutes = Math.floor(timeDiff / (1000 * 60));
        timeDiff -= minutes * 1000 * 60;
        const seconds = Math.floor(timeDiff / 1000);

        // 남은 시간을 표시할 요소 찾기
        const hiomanElement = document.getElementById("hioman");

        // 남은 시간 업데이트
        namuntime = '남은시간:' + hours + '시간 ' +minutes + '분 ' + seconds + '초';

        hiomanElement.innerHTML = namuntime;

        // 일정 간격으로 업데이트
        setTimeout(updateRemainingTime, updateInterval);
    }

    // 페이지 로드 시 남은 시간 업데이트 시작
    updateRemainingTime();
</script>
        <!-- footer 시작 -->
	    <c:import url="/sym/mms/EgovFooter.do" />
	    <!-- //footer 끝 -->
    </div>

</body>
</html>