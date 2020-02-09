//
//  SettingViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/01.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class SettingViewController: UIViewController {
    
    @IBOutlet weak var displaynameTextField: UITextField!
    
    @IBAction func hadleChangeButton(_ sender: Any) {
        let user = Auth.auth().currentUser!
        let changeRequest = user.createProfileChangeRequest()
        
        if displaynameTextField.text == "" {
            SVProgressHUD.showError(withStatus: "表示名は必須です。必ず入力してください")
            SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
        }
        else{
        changeRequest.displayName = displaynameTextField.text
        changeRequest.commitChanges { error in
            if let error = error {
                print("DEBUG PRINT:" + error.localizedDescription)
                SVProgressHUD.showError(withStatus: "表示名の登録に失敗しました。もう一度お試しください")
                SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
                return
            }
            //print("DEBUG PRINT: \(user.displayName!) の設定に成功しました。")
            SVProgressHUD.showSuccess(withStatus: "表示名の変更が完了しました")
            SVProgressHUD.dismiss(withDelay: 1.0, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func handleLogoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        SVProgressHUD.showSuccess(withStatus: "ログアウトしました")
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        SVProgressHUD.dismiss(withDelay: 1.0, completion: {self.present(loginViewController!, animated: true, completion: nil)})
        //ログアウトしましたって出して1秒たってからログイン画面に戻したいので、completionに記載した
        //tabBarController?.selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let user = Auth.auth().currentUser!
        print("user情報:\(user)")
        displaynameTextField.text = user.displayName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
