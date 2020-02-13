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
    
    
     var listener: ListenerRegistration!
     
    var postId:String! = ""
    var postName:String! = ""
    var caption:String! = ""
    var postDate:String! = ""
    //var image = UIImage(named:"")
    var postArray:[PostData] = []
    var postDic:[String] = []
    
    var commentArray:[CommentData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print("postId:\(String(describing: postId))")
        // Do any additional setup after loading the view.
        
        //カスタムtableViewCellを受け入れる部分を記載する
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let postRef = Firestore.firestore().collection(Const.PostPath).document(self.postId)
        print("postRef:\(postRef)")
        /*
        postRef.getDocument(){(document,error) in
            if error != nil{
                print("error")
            }
            else{
                print("document:\(String(describing: document))")
                
                 let data = document?.data().map(String.init(describing: ))
                 print("name:\(data!)")
                 print("data:\(String(describing: data!))")
                 /*self.name = data?["name"]
                 print("name:\(name)")
                 */
                 self.postArray = document?.data().map{document in
                 let postData = PostData(document: document)//これのためにdataはpostdata型にしておく必要がある
                 } ??
                 return postData
                 }
                 
            }
        */
        
        let commentRef = Firestore.firestore().collection(Const.CommentPath)
        print("commentRef:\(commentRef)")
        
        listener = commentRef.whereField("postID", isEqualTo: postId).order(by: "date", descending: true).addSnapshotListener(){(commentSnapshot,error) in
            if error != nil {
                print("コメント読み込みエラー\(error)")
            }
            else{
                print("コメント読み込み開始")
                self.commentArray = commentSnapshot!.documents.map(){commentDocument in
                    let commentData = CommentData(commentDocument: commentDocument)
                    print("commentData:\(commentData)")
                    return commentData
                }
            print("commentArray.count= \(self.commentArray.count)")
            self.tableView.reloadData()
            }
        }
        
        
        }
    //ここでviewWillAppear終了
    
    
    
    
    
    //ここからコメント一覧の表示処理を記載
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("テーブル作成時のcommentArrayの数:\(commentArray.count)")
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommentTableViewCell
        
        cell.setCommentViewCell(commentArray[indexPath.row])
        
        return cell
    }
    
    
    
    //ここからコメント投稿の処理を記載
    @IBAction func handleCommentButton(_ sender: Any) {
        let commentRef = Firestore.firestore().collection(Const.CommentPath).document()
        let commentName = Auth.auth().currentUser?.displayName
        
        let commentDic = ["postID":postId!, "name": commentName!,"commentText":commentTextField.text!,"date":FieldValue.serverTimestamp() ] as [String : Any]
        
        commentRef.setData(commentDic)
        commentTextField.text = ""
        tableView.reloadData()
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
