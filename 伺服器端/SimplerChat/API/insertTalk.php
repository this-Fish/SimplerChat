<?php
   
    // 引入資料庫檔
    require_once('DB.php');

    //post方法参数传递
    $roomId = $_POST['roomid'];
    $name   = $_POST['name'];
    $talk   = $_POST['talk']; 
    // $roomId = $_GET['roomid'];
    // $name   = $_GET['name'];
    // $talk   = $_GET['talk'];

    $sql = "INSERT INTO talks (roomid, name, talk) VALUES ('$roomId', '$name', '$talk')";
    //呼叫query方法(SQL語法)
    $result = $conn->query($sql);
    
    if ($result) {
        echo '新增成功';
    } else {
        echo "錯誤: " . $sql . "<br>" . $conn->error;
    }

    // 關閉連線
    mysqli_close($conn);
?>

