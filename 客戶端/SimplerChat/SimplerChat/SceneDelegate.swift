//
//  SceneDelegate.swift
//  SimplerChat
//
//  Created by 迦晉 on 30/5/2020.
//  Copyright © 2020 tcust. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let IPurl:String = "thisfish.ddns.net/SimplerChat/API"


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    // APP從後台回到畫面
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        let roomID = UserDefaults().string(forKey: "RoomId") ?? ""
        let uname = UserDefaults().string(forKey: "uname") ?? ""
        if !roomID.isEmpty && !uname.isEmpty {
            // 創建請求網址
            let url = URL(string: "http://\(IPurl)/Login.php")

            // 創建請求體
            var request = URLRequest.init(
                url: url!,
                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                timeoutInterval: 15)
            // 定議發送內容
            request.httpBody = "roomid=\(roomID)&name=\(uname)".data(using: .utf8)
            request.httpMethod = "POST"

            
            let session = URLSession(configuration: .default)

            // 創建一个 Task 對象
            let dataTaskInsert = session.dataTask(with: request) { ( data, urlRespone, error) in
                // 判断是否有数据
                if error == nil, let data = data {
                    let html = String(data: data, encoding: .utf8)
                    print(html ?? "")
                } else {
                    print("登入失敗")
                }
            }
            //闕啟Task
            dataTaskInsert.resume()
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    // APP從畫面進入到後台
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        let roomID = UserDefaults().string(forKey: "RoomId") ?? ""
        let uname = UserDefaults().string(forKey: "uname") ?? ""
        if !roomID.isEmpty && !uname.isEmpty {
            // 创建请求网址
            let url = URL(string: "http://\(IPurl)/Logout.php")

            // 创建请求体
            var request = URLRequest.init(
                url: url!,
                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                timeoutInterval: 15)
            // 定議發送內容
            request.httpBody = "roomid=\(roomID)&name=\(uname)".data(using: .utf8)
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


}

