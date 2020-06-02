//
//  NextController.swift
//  SimplerChat
//
//  Created by 迦晉 on 30/5/2020.
//  Copyright © 2020 tcust. All rights reserved.
//

import UIKit

class NextController: UIViewController, UITextFieldDelegate {
    let IPurl:String = "thisfish.ddns.net/SimplerChat/API"
    var roomID:String? = nil
    var name:String? = nil

    @IBOutlet weak var Nlable: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var NtextField: UITextField!
    
    @IBOutlet weak var barUCtext: UIBarButtonItem!
    // 設置計時器&輪詢
    var timer : Timer?
    var dataTaskSelect:URLSessionDataTask? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 監聽textField
        NtextField.delegate = self
        
    }
    
    // 載入畫面時
    override func viewDidAppear(_ animated: Bool) {
        NSLog("進入畫面", 1)
        roomID = UserDefaults().string(forKey: "RoomId") ?? ""
        name = UserDefaults().string(forKey: "uname") ?? ""
        Nlable.text = name
        sendLogin(roomID!,name!)
        
        getAPIMsg()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.getAPIMsg), userInfo: nil, repeats: true)
        
    }
    
    // 退出畫面時
    override func viewWillDisappear(_ animated: Bool) {
        NSLog("退出畫面", 2)
        sendLogout(roomID!,name!)
        sleep(1)
        if self.timer != nil {
            dataTaskSelect?.cancel()
            self.timer?.invalidate()
        }
    }
    
    //sceneDidEnterBackground
    //override
    
    // 限制輸入字數
    @IBAction func CheckTextLength(_ sender: Any) {
        let fieldStr = String(NtextField.text ?? "" )
        let maxLength = 100
        if !fieldStr.isEmpty {
            if fieldStr.count >= maxLength {
                // 設定文字不改變
                NtextField.text = String( fieldStr[fieldStr.index(fieldStr.startIndex,offsetBy: 0)..<fieldStr.index(fieldStr.index(fieldStr.startIndex,offsetBy: 0), offsetBy: maxLength)] )
            }
        }
    }
    
    // 鍵盤按下確定
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendMsg(roomID!, name!)
        return true
    }
    
    // 按鈕按下
    @IBAction func NonClick(_ sender: Any) {
        NtextField.resignFirstResponder()
        sendMsg(roomID!, name!)
    }
    
    // 登入請求
    func sendLogin(_ rid:String ,_ uname:String) {
        
        if !rid.isEmpty && !uname.isEmpty {
            // 创建请求网址
            let url = URL(string: "http://\(IPurl)/Login.php")

            // 创建请求体
            var request = URLRequest.init(
                url: url!,
                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                timeoutInterval: 15)
            // 定議發送內容
            request.httpBody = "roomid=\(rid)&name=\(uname)".data(using: .utf8)
            request.httpMethod = "POST"

            // 创建一个NSURLSession 对象
            let session = URLSession(configuration: .default)

            // 创建一个 Task 对象
            let dataTaskInsert = session.dataTask(with: request) { ( data, urlRespone, error) in
                // 判断是否有数据
                if error == nil, let data = data {
                    let html = String(data: data, encoding: .utf8)
                    print(html ?? "")
                } else {
                    print("登入失敗")
                }
            }
            //开启Task
            dataTaskInsert.resume()
        }
    }
    
    // 登出請求
    func sendLogout(_ rid:String, _ uname:String) {
        
        if !rid.isEmpty && !uname.isEmpty  {
            // 创建请求网址
            let url = URL(string: "http://\(IPurl)/Logout.php")

            // 创建请求体
            var request = URLRequest.init(
                url: url!,
                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                timeoutInterval: 15)
            // 定議發送內容
            request.httpBody = "roomid=\(rid)&name=\(uname)".data(using: .utf8)
            request.httpMethod = "POST"

            // 创建一个NSURLSession 对象
            let session = URLSession(configuration: .default)

            // 创建一个 Task 对象
            let dataTaskInsert = session.dataTask(with: request) { ( data, urlRespone, error) in
                // 判断是否有数据
                if error == nil, let data = data {
                    let html = String(data: data, encoding: .utf8)
                    print(html ?? "")
                } else {
                    print("登出失敗")
                }
            }
            //开启Task
            dataTaskInsert.resume()
        }
    }
    
    // 發送訊息
    func sendMsg(_ rid:String, _ uname:String) {
        let msg = NtextField.text ?? ""
        if !rid.isEmpty && !uname.isEmpty && !msg.isEmpty {
            // 创建请求网址
                let url = URL(string: "http://\(IPurl)/insertTalk.php")

                // 创建请求体
                var request = URLRequest.init(
                    url: url!,
                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                    timeoutInterval: 15)
                // 定議發送內容
                request.httpBody = "roomid=\(rid)&name=\(uname)&talk=\(msg)".data(using: .utf8)
                request.httpMethod = "POST"

                // 创建一个NSURLSession 对象
                let session = URLSession(configuration: .default)

                // 创建一个 Task 对象
                let dataTaskInsert = session.dataTask(with: request) { ( data, urlRespone, error) in
                    // 判断是否有数据
                    if error == nil, let data = data {
                        let html = String(data: data, encoding: .utf8)
                        print(html ?? "")
                    } else {
                        print("資料讀取失敗")
                    }
                }
                //开启Task
                dataTaskInsert.resume()
            
            NtextField.text = ""
        }
    }
    
    // 取得對話記錄
    @objc func getAPIMsg() {
        let rid = UserDefaults().string(forKey: "RoomId") ?? ""
        if !rid.isEmpty {
            
            // 创建请求网址
            let url = URL(string: "http://\(IPurl)/getTalks.php")

            // 创建请求体
            var request = URLRequest.init(
                url: url!,
                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                timeoutInterval: 15)
                // 定議發送內容
            request.httpBody = "roomid=\(rid)".data(using: .utf8)
            request.httpMethod = "POST"

            // 创建一个NSURLSession 对象
            let session = URLSession(configuration: .default)

            // 创建一个 Task 对象
            dataTaskSelect = session.dataTask(with: request) { ( data, urlRespone, error) in
                // 判断是否有数据
                if error == nil, let data = data {
                    do {
                    // 解釋JSON 然后更新晝面
                        var str:String = ""
                        let jsonObj = try JSONSerialization.jsonObject(
                            with: data,
                            options: .allowFragments
                        ) as! [[String: Any]]
                        //self.updataView(jsonObj)
                        
                        var userCount:String! = ""
                        for p in jsonObj {
                            if !"\(p["name"]!)".isEmpty {
                                str += "\(p["name"]!):\(p["talk"]!)\n"
                            }
                            userCount = "\(p["userCount"]!)"
                        }
                        
                        DispatchQueue.main.async {
                            self.textView.text = str
                            self.barUCtext.title = "線上人數：\(userCount!)"

                            print("取得資料成功")
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("資料讀取失敗")
                }
            }
            //开启Task
            dataTaskSelect?.resume()
            
        }
    }
    
    // 返回按鈕
    @IBAction func exit(_ sender: Any) {
        UserDefaults().setValue("", forKey: "RoomId")
        UserDefaults().setValue("", forKey: "uname")
        self.dismiss(animated: true, completion: nil)
    }
}
