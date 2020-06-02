//
//  ViewController.swift
//  SimplerChat
//
//  Created by 迦晉 on 30/5/2020.
//  Copyright © 2020 tcust. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    /* 暫存輸入框元件 */
    var currentTextField: UITextField?
    /* 暫存 View 的範圍 */
    var rect: CGRect?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /* 開始輸入時，將輸入框實體儲存 */
        currentTextField = textField
    }
    
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var textField1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 重置名字資料
        UserDefaults().setValue("", forKey: "RoomId")
        UserDefaults().setValue("", forKey: "uname")
        // 監聽 鍵盤
        textField1.delegate = self
        
        /* 監聽 鍵盤顯示/隱藏 事件 */
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        /* 將 View 原始範圍儲存 */
        rect = view.bounds
    }
    
    // 鍵盤按下確定
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkName()
        return true
    }
    
    // 按鈕披按下
    @IBAction func onClick(_ sender: Any) {
         checkName()
    }
    
    // 檢查名字
    func checkName() {
         var name = textField1.text ?? ""
         
         name = name.trimmingCharacters(in: .whitespaces)
         
         if !name.isEmpty {
             if name.count > 10 {
                 lable1.text = "名稱必須少於10字元"
             } else {
                 lable1.text = ""
                 textField1.text = ""
                 // 前住下一頁
                 UserDefaults().setValue("T001", forKey: "RoomId")
                 UserDefaults().setValue(name, forKey: "uname")
                 performSegue(withIdentifier: "toNext", sender: nil)
             }
         } else if name.isEmpty {
             lable1.text = "請輸入顯示名字"
         }
    }
    
    
    // 鍵盤顯示時
    @objc func keyboardWillShow(note: NSNotification) {
         if currentTextField == nil {
             return
         }
         
         let userInfo = note.userInfo!
         /* 取得鍵盤尺寸 */
         let keyboard = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
         let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
         /* 取得焦點輸入框的位置 */
         let origin = (currentTextField?.frame.origin)!
         /* 取得焦點輸入框的高度 */
         let height = (currentTextField?.frame.size.height)!
         /* 計算輸入框最底部Y座標，原Y座標為上方位置，需要加上高度 */
         let targetY = origin.y + height
         /* 計算扣除鍵盤高度後的可視高度 */
         let visibleRectWithoutKeyboard = self.view.bounds.size.height - keyboard.height
         
         /* 如果輸入框Y座標在可視高度外，表示鍵盤已擋住輸入框 */
         if targetY >= visibleRectWithoutKeyboard {
             var rect = self.rect!
             /* 計算上移距離，若想要鍵盤貼齊輸入框底部，可將 + 5 部分移除 */
             rect.origin.y -= (targetY - visibleRectWithoutKeyboard) + 5
             
             UIView.animate(
                 withDuration: duration,
                 animations: { () -> Void in
                     self.view.frame = rect
                 }
             )
        }
    }
    
    // 鍵盤隱藏時
    @objc func keyboardWillHide(note: NSNotification) {
         /* 鍵盤隱藏時將畫面下移回原樣 */
         let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
         let duration = TimeInterval(truncating: keyboardAnimationDetail[UIResponder.keyboardAnimationDurationUserInfoKey]! as! NSNumber)
         
         UIView.animate(
             withDuration: duration,
             animations: { () -> Void in
                 self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.view.frame.origin.y)
             }
         )
     }


}

