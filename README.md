# SimplerChat
基於swift編寫的即時聊天應用

## 項目演示
![1](https://github.com/this-Fish/SimplerChat/blob/master/%E9%A0%85%E7%9B%AE%E6%BC%94%E7%A4%BA/%E9%A0%85%E7%9B%AE%E6%BC%94%E7%A4%BA.gif)


## 介紹
該項目分為兩部分：  

伺服器端:  
使用到用PHP獲取MYSQL數據、然后返回JOSN格式的字串供客戶端連接使用 
  
客戶端:
使用短輪詢向伺服器端獲取最新信息  

## 使用
### 在伺服器端中
運行時請自行把 伺服器端中的 SimplerChat 檔案放至入伺服器localhost底下的目錄  
運行時請自行更改 伺服器端/SimplerChat/API/DB.php 中登入資料庫的帳號和密碼  
運行時請自行把 thetalk.sql 自行匯入至資料庫  
  
### 在客戶端中
運行時請自行把 ScaneDelegate.swift 中的 IPurl 更改為自己的伺服器端接口地址  
運行時請自行把 NextController.swift 中的 IPurl 更改為自己的伺服器端接口地址  
