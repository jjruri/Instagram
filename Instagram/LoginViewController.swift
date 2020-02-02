//
//  LoginViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/01.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleLoginButton(_ sender: Any) {
        let address = mailAddressTextField.text!
        let password = passwordTextField.text!
        
        // アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
        if address.isEmpty || password.isEmpty {
            SVProgressHUD.showError(withStatus: "メールアドレスとパスワードを入力してください")
            print("DEBUG_PRINT: 何かが空文字です。")
            print("アドレスには\(address)が入ってる")
            return
        }
        else{
            SVProgressHUD.show()
            Auth.auth().signIn(withEmail: address, password: password){ authResult, error in
                if let error = error {
                    print("DEBUG PRINT:" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "ログイン失敗　やり直して下さい")
                    SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
                    return
                }
                print("ログイン成功")
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func handleCreatAccountButton(_ sender: Any) {
        //テキストだとif-letでnilチェックしてるけど、nilはこないからシンプルにしてみた
        //UITextFieldに何もいれずに押下した場合、.textはoptional("")でくるので、nilチェックはなしで強制アンラップの！をつけた
        let address = mailAddressTextField.text!
        let password = passwordTextField.text!
        let displayName = displayNameTextField.text!
        
        // アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
        if address.isEmpty || password.isEmpty || displayName.isEmpty {
            SVProgressHUD.showError(withStatus: "3項目全て入力してください")
            SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
            print("DEBUG_PRINT: 何かが空文字です。")
            print("アドレスには\(address)が入ってる")
            print("displaynameには\(displayName)が入ってる")
            return
        }
        else{//３カラムとも入力されている時の処理
            //押下してから処理が完了するまでサーバー待ちなので、まずは処理中表示を出す
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: address, password: password/*本来はここにcompletionがくるけど、この引数は長くなるので、一度カッコをきって別だしで{}で書くことが許されてるので外に書く */)
            { authResult , error in
                if let error = error {
                    print("DEBUG PRINT:" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "新規登録失敗　再度お試しください")
                    SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
                    return
                }
                //errorを吐かなかった場合はログを出してユーザー名の登録に移る
                print("ユーザー作成成功")
                
                let user = Auth.auth().currentUser!//この時点ではnilの可能性なし
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("DEBUG PRINT:" + error.localizedDescription)
                        SVProgressHUD.showError(withStatus: "表示名の登録に失敗しました。後から変更可能ですので、登録したメールアドレスとパスワードでログインしてください。")
                        SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
                        return
                    }
                    print("DEBUG PRINT: \(user.displayName!) の設定に成功しました。")
                    SVProgressHUD.dismiss()
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
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
