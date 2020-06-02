<?php

    // 引入資料庫檔
    require_once('DB.php');
    
    //post方法参数传递
    $roomId = $_POST['roomid'];
    //$roomId = $_GET['roomid'];
    

    $sql ="select * , (select count(*) from talkrooms where roomid = '$roomId' ) as userCount from talks ORDER BY `time` DESC limit 30";
    //呼叫query方法(SQL語法)
    $result = mysqli_query($conn, $sql);
    
    $arr = array();
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        array_push($arr,$row);//往array数组中加入查询得到的数据   
    }
    // 顯示JSON格式的資料庫資料
    echo json_encode($arr,JSON_UNESCAPED_UNICODE);
    
    // 關閉連線
    mysqli_close($conn);
?>