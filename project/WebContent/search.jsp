<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input id="bookName" type="text">
    <button id="search">검색</button>
    <p></p>

    <script src="./js/jquery-3.4.1.min.js"></script>

    <script>
        $(function () {

            $("#search").click(function () {

                $.ajax({
                    method: "GET",
                    url: "https://dapi.kakao.com/v2/local/search/keyword.json", // 전송 주소
                    data: { query: $("#bookName").val() }, // 보낼 데이터
                    headers: { Authorization: "KakaoAK 63d4f435f6458c5eeb9e89165d14b950" }
                })
                    .done(function (msg) { // 응답이 오면 처리를 하는 코드
                        console.log(msg);
                    });
            })
        });

    </script>
</body>
</html>