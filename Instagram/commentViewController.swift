//
//  commentViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/11.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase

class commentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idCaption: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    /*
     var postArray:[PostData] = []
     var listener: ListenerRegistration!
     */
    var id:String! = ""
    var name:String! = ""
    var caption:String! = ""
    var date:String! = ""
    //var image = UIImage(named:"")
    var postArray:[PostData] = []
    var postDic:[String] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print("id:\(String(describing: id))")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let postRef = Firestore.firestore().collection(Const.PostPath).document(self.id)
        print("postRef:\(postRef)")
        postRef.getDocument(){(document,error) in
            if error != nil{
                print("error")
            }
            else{
                print("document:\(String(describing: document))")
                /*
                 let data = document?.data().map(String.init(describing: ))!
                 //print("name:\(data.name.text)")
                 print("data:\(String(describing: data!))")
                 self.name = data?["name"]
                 print("name:\(name)")
                 
                 self.postArray = document?.data().map{document in
                 let postData = PostData(document: document)
                 } ??
                 return PostData
                 }
                 */
            }
            
        }
    }//ここでviewWillAppear終了
    
    
    
    
    
    //ここからコメント一覧の表示処理を記載
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        return cell
    }
    
    
    
    //ここからコメント投稿の処理を記載
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
