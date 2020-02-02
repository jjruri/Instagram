//
//  SettingViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/01.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase


class SettingViewController: UIViewController {
    @IBAction func handleLogoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        tabBarController?.selectedIndex = 0
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
