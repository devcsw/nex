<%--
  Class Name :
  Description :
  Modification Information

       수정일              수정자             수정내용
    ----------  ---------   ---------------------------
    2009.03.19  이삼섭             최초 생성
    2011.08.31  JJY         경량환경 버전 생성
    2021.08.12  신용호              신규 디자인 적용

    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<!-- <link rel="stylesheet" href="<c:url value='/'/>css_old/default.css" type="text/css" > -->


<script type="text/javascript">
<!--

	function fn_egov_addNotice() {
		document.frm.action = "<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>";
		document.frm.submit();
	}

	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_notice(nttId, bbsId) {
		//document.subForm.nttId.value = nttId;
		//document.subForm.bbsId.value = bbsId;
		//document.subForm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
		//document.subForm.submit();
	}
//-->
</script>
<title>샘플 포털 > 로또 > 로또</title>
<!-- <link href="css_old/default.css" rel="stylesheet" type="text/css" > -->
</head>
<body>

    <a href="#contents" class="skip_navi">본문 바로가기</a>
		<!-- header start -->

     <div class="wrap">
        <!-- header start -->
	    <c:import url="/sym/mms/EgovHeader.do" />
	    <!-- //header end -->

         <div class="container">
        <div class="game">
            <h1>∙ Tic Tac Toe ∙</h1>
            <div class="tictactoe"></div>
            <button id="play">Start !</button>
        </div>
    </div>
    <script>
        function generateLottoNumbers() {
        	getLogData('except7');
            var userNumbersInput = document.getElementById("userNumbers").value;
            var userNumbers = userNumbersInput.split(',').map(Number);
            if (userNumbers.length !== 7) {
                alert("7개의 숫자를 입력해야 합니다.");
                return;
            }
            if (userNumbers.some(isNaN)) {
                alert("숫자만 입력해야 합니다.");
                return;
            }

            var lottoNumbers = [];
            while (lottoNumbers.length <6) {
                var randomNum = Math.floor(Math.random() * 45) + 1;
                if (userNumbers.indexOf(randomNum) === -1 && lottoNumbers.indexOf(randomNum) === -1) {
                    lottoNumbers.push(randomNum);
                }
            }

            lottoNumbers.sort(function(a, b) {
                return a - b;
            });

            var resultText = "로또 번호 (입력한 숫자 제외): " + lottoNumbers.join(", ");

            var newP = document.createElement("p"); // 새로운 <p> 요소 생성
            newP.innerHTML = resultText; // 내용 설정
            document.getElementById("lottoResults").appendChild(newP); // <div>에 추가
        }

        function generateLottoNumbersOrigin() {
        	getLogData('origin');
            var lottoNumbers = [];
            while (lottoNumbers.length < 5) {
                var randomNum = Math.floor(Math.random() * 45) + 1;
                if (lottoNumbers.indexOf(randomNum) === -1) {
                    lottoNumbers.push(randomNum);
                }
            }

            lottoNumbers.sort(function(a, b) {
                return a - b;
            });

            var resultText = "로또 번호: " + lottoNumbers.join(", ");

            var newP = document.createElement("p"); // 새로운 <p> 요소 생성
            newP.innerHTML = resultText; // 내용 설정
            document.getElementById("lottoResults").appendChild(newP); // <div>에 추가
        }
        function deleteAllP() {
            var lottoResults = document.getElementById("lottoResults");
            while (lottoResults.firstChild) {
                lottoResults.removeChild(lottoResults.firstChild);
            }
        }

        function fetchLottoData() {
            const userNumbersInput = document.getElementById("userNumbers");
            const lottoData = document.getElementById("lottoData");
	        const drwNo = lottoData.value; // 원하는 로또 회차 번호를 지정
	        const url = "/getLottoNumber/get.do?lottoNumber="+ drwNo;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                // 서버에서 받은 데이터를 처리
                // 각 번호를 변수에 할당
                const drwtNo1 = data.drwtNo1;
                const drwtNo2 = data.drwtNo2;
                const drwtNo3 = data.drwtNo3;
                const drwtNo4 = data.drwtNo4;
                const drwtNo5 = data.drwtNo5;
                const drwtNo6 = data.drwtNo6;
                const bnusNo = data.bnusNo;
                userNumbersInput.value = drwtNo1 +","+ drwtNo2 +","+ drwtNo3+","+drwtNo4+","+drwtNo5+","+ drwtNo6+","+bnusNo;

            })
            .catch(error => {
                console.error(error);
            });
    }


    function lottoGenerator() {
            var userNumbersInput = document.getElementById("userNumbers").value;
            var userNumbers = userNumbersInput.split(',').map(Number);
            if (userNumbers.length !== 7) {
                alert("7개의 숫자를 입력해야 합니다.");
                return;
            }
            if (userNumbers.some(isNaN)) {
                alert("숫자만 입력해야 합니다.");
                return;
            }

            var lottoNumbers = [];
            while (lottoNumbers.length <6) {
                var randomNum = Math.floor(Math.random() * 45) + 1;
                if (userNumbers.indexOf(randomNum) === -1 && lottoNumbers.indexOf(randomNum) === -1) {
                    lottoNumbers.push(randomNum);
                }
            }

            lottoNumbers.sort(function(a, b) {
                return a - b;
            });

            var resultText = "로또 번호 (입력한 숫자 제외): " + lottoNumbers.join(", ");
            return lottoNumbers;
        }

    function findMostFrequentNumbers1() {
    	getLogData('100man1');
        for(var i=0;i<5;i++){
            var resultText  = numberFrequencies();

            var newP = document.createElement("p");
            newP.innerHTML = resultText;
            document.getElementById("lottoResults").appendChild(newP);
        }

    }
    function findMostFrequentNumbers2() {
    	getLogData('100man2');
            var top6Frequencies1  = numberFrequencies2();
            var top6Frequencies2 = numberFrequencies2();
            var top6Frequencies3 = numberFrequencies2();
            var top6Frequencies4  = numberFrequencies2();
            var top6Frequencies5  = numberFrequencies2();

            var unionArray = unionAndExtractFirstValues(top6Frequencies1, top6Frequencies2, top6Frequencies3, top6Frequencies4, top6Frequencies5);

            var random6Elements1 = getRandomElementsFromArray(unionArray, 6);
            var random6Elements2 = getRandomElementsFromArray(unionArray, 6);
            var random6Elements3 = getRandomElementsFromArray(unionArray, 6);
            var random6Elements4 = getRandomElementsFromArray(unionArray, 6);
            var random6Elements5 = getRandomElementsFromArray(unionArray, 6);
    }

    function numberFrequencies(){
        var numberFrequencies = new Map();
        for (var i = 0; i < 1000000; i++) {
            var lottoNumbers = lottoGenerator();
            lottoNumbers.forEach(function(number) {
                    if (numberFrequencies.has(number)) {
                        numberFrequencies.set(number, numberFrequencies.get(number) + 1);
                    } else {
                        numberFrequencies.set(number, 1);
                    }
                });
        }

        var sortedFrequencies = [...numberFrequencies].sort((a, b) => b[1] - a[1]);
        var top6Frequencies = sortedFrequencies.slice(0, 6);
        // Create a copy for sorting
        var top6FrequenciesSort = [...top6Frequencies];

        // Sort the top6FrequenciesSort array in ascending order
        top6FrequenciesSort.sort((a, b) => a[0] - b[0]); // Sort in ascending order based on the first element (the numbers)

        var resultText = "상위 6개의 가장 자주 발생하는 숫자: ";
        top6Frequencies.forEach((pair, index) => {
            resultText += pair[0];
            if (index < top6Frequencies.length - 1) {
                resultText += ", ";
            }
        });

        var resultText = "상위 6개의 가장 자주 발생하는 숫자(정렬): ";
        top6FrequenciesSort.forEach((pair, index) => {
            resultText += pair[0];
            if (index < top6FrequenciesSort.length - 1) {
                resultText += ", ";
            }
        });
        return resultText;
    }
    function numberFrequencies2(){
        var numberFrequencies = new Map();
        for (var i = 0; i < 1000000; i++) {
            var lottoNumbers = lottoGenerator();
            lottoNumbers.forEach(function(number) {
                    if (numberFrequencies.has(number)) {
                        numberFrequencies.set(number, numberFrequencies.get(number) + 1);
                    } else {
                        numberFrequencies.set(number, 1);
                    }
                });
        }

        var sortedFrequencies = [...numberFrequencies].sort((a, b) => b[1] - a[1]);
        var top6Frequencies = sortedFrequencies.slice(0, 6);
        // Create a copy for sorting
        var top6FrequenciesSort = [...top6Frequencies];

        // Sort the top6FrequenciesSort array in ascending order
        top6FrequenciesSort.sort((a, b) => a[0] - b[0]); // Sort in ascending order based on the first element (the numbers)


        return top6Frequencies;
    }

    function unionAndExtractFirstValues(...maps) {
    const result = new Set();

    for (const map of maps) {
        map.forEach((value) => {
            if (Array.isArray(value) && value.length > 0) {
                result.add(value[0]);
            }
        });
    }

    return Array.from(result);
}

function getRandomElementsFromArray(arr, count) {
    const shuffledArray = arr.slice(); // 복사본을 만듭니다.
    for (let i = shuffledArray.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [shuffledArray[i], shuffledArray[j]] = [shuffledArray[j], shuffledArray[i]];
    }
    var resultText = "로또번호: ";

    var resultArray = shuffledArray.slice(0, count).sort();

    resultText += resultArray.join(", "); // 배열의 요소들을 쉼표로 구분하여 추가

    var newP = document.createElement("p");
    newP.innerHTML = resultText;
    document.getElementById("lottoResults").appendChild(newP);
}


function getLogData(target) {
    const url = "/lottoLog.do?target=" + target;
    fetch(url)
    .then(data => {
    })
    .catch(error => {
    });
}
    </script>
	<c:import url="/sym/mms/EgovFooter.do" />

	</div>


</body>
</html>