<?php
    $host = 'localhost';
    // 名字
    $user = 'root';
    // 密碼
    $passwd = 'usbw';
    // 資料庫
    $database = 'thetalk';

    // 實例化mysqli
    $conn = mysqli_connect( $host, $user,  $passwd);
    if (empty($conn)){
        print mysqli_error($conn);
        echo "無法連結資料庫";
        exit;
    }
    if( !mysqli_select_db($conn, $database)) {
        die ("無法選擇資料庫");
    }
    
    // 設定連線編碼，防止中文字亂碼
    mysqli_query( $conn, "SET NAMES 'utf8'");
?>