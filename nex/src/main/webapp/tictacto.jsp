
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TicTacToe</title>
</head>
<link rel="stylesheet" href="style.css">
<body>
    <div class="container">
        <div class="game">
            <h1>∙ Tic Tac Toe ∙</h1>
            <div class="tictactoe"></div>
            <button id="play">Start !</button>
        </div>
    </div>

 <script>
    var gameDiv = document.querySelector(".game");
    var tictactoeDiv = document.querySelector(".tictactoe");
    //틱택토 게임이 만들어질 div 를 가져온다.
    var playbutton = document.querySelector("#play");

    var nodeList = [];
    var size = 3; // 게임의 크기를 정한다.
    var turn = -1;
    var playername = "";
    var color = ""; //칼라를 넣어줄 변수를 생성한다.

    var nodeEvent = function(e) {
        target = e.target;
        if(String(target.textContent) === ""){ /* 여기서 target 은 node 이다. */
            if(turn%2==0){
                target.textContent = "O";
                color = "#9acdfb70";
                playername = "∙ Blue ";
            }else{
                target.textContent = "X";
                color = "#ffafaf70";
                playername = "∙ Pink ";
            }
            target.style.backgroundColor = color;
            turn++;
            if(turn > (size*2)-2){
                /* 여기서 2 는 플레이어의 숫자
                size 에 어떤수를 입력하더라도 동일한 결과가 나오게 작성해보았다. */
                win_check(target.textContent);
            }
        }
    }
    function win_check(check){
        var left = 0; var right = 0;
        for(var i=0; i<size; i++){
           var y=0; var x=0; //리셋해준다.
            for(var j=0; j<size; j++){
                text = nodeList[i][j].textContent; //가로를 체크하는 변수
                text2 = nodeList[j][i].textContent; //세로를 체크하는 변수
                if(check === text){
                    x++; //가로
                    if(i === j){
                        left++; //왼쪽사이드
                    }
                }
                if(check === text2){
                    y++; //세로
                    if(j === size-i-1){
                        right++; //오른쪽사이드
                    }
                }
                if(y===size || x===size || left===size || right===size){
                    turn = 0; win_show(); return;
                }
                if(turn >= size * size){ /* 무승부인 경우 */
                    win_show();
                }
            }
        }
    }
    function win_show(){ //승부가 났을경우
        setTimeout (function(){
            tictactoeDiv.innerHTML = "";
          //gameDiv 안에 생성된 모든 코드를 없애준다.
            var show = document.createElement("div");
            show.classList.add('show');
            tictactoeDiv.appendChild(show);
            if(turn != 0){
                show.style.backgroundColor = "#ebdfdf";
                show.textContent = "∙ 무 승 부 ∙";
            }else{
                show.style.backgroundColor = color;
                show.textContent = playername+" WIN! ∙";
            }
            playbutton.textContent = "Play Again";
        },300);
    }
    playbutton.addEventListener("click",function(){
        //  console.log("hi"); 화면출력 확인
        if(turn === -1){
           turn++;
             /*(게임이 재생성되지않도록 +1 해준다.)*/
            playbutton.textContent = "Reset";
            var table = document.createElement("table");
            for(var i=0; i<size; i++){
                var line = document.createElement("tr");
                nodeList.push([]);
                for(var j = 0; j<size; j++){
                    var node = document.createElement("td");
                    node.classList.add('node');
                    node.addEventListener("click",nodeEvent);
                    /* 화면을 클릭했을때 O or X 가 출력될수있게 한다. */
                    node.textContent = "";
                    line.append(node);
                    /* tr 안에 td 가 들어간다. */
                    nodeList[i].push(node);
                }
                table.append(line);
                /* table 안에 tr 이 들어간다. */
            }
            tictactoeDiv.appendChild(table);
            /* tictactoeDiv 안에 table 을 넣어준다. */
        }else{
            history.go(0);
        }
    })

    </script>
</body>
</html>
