//
//  commentViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/11.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit

class commentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idCaption: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var nameCaption:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idCaption.text = nameCaption

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
