<?php
    
    // 引入資料庫檔
    require_once('DB.php');

    //POST方法为参数传递
    $roomId = $_POST['roomid'];
    $name   = $_POST['name']; 
    // $roomId = $_GET['roomid'];
    // $name   = $_GET['name']; 


    
    $sql = "DELETE FROM `talkrooms` WHERE `roomid` = '$roomId' and `name` = '$name'";
    //呼叫query方法(SQL語法)
    $result = $conn->query($sql);
    
    if ($result) {
        echo '登出成功';
    } else {
        echo "錯誤: " . $sql . "<br>" . $conn->error;
    }
    
    // 關閉連線
    mysqli_close($conn);
?>

