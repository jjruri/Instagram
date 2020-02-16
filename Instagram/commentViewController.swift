//
//  commentViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/11.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class commentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idCaption: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    var listener: ListenerRegistration!
    //var postInfo: [PostData]=[]
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
 /*以下はコメントをサブコレクションで実装した場合のコードで今回は使わない
         けどオリジナルアプリで参考になりそうなので残しておく
        //コメントテーブルの読み込み
        let commentRef = Firestore.firestore().collection(Const.PostPath).document(postId).collection(Const.CommentPath)
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
        */
        
        //上部のポストの画像表示
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postId + ".jpg")
        imageView.sd_setImage(with: imageRef)
        
        //上部のポストの内容表示
        let postRef = Firestore.firestore().collection(Const.PostPath).document(self.postId)
        print("postRef:\(postRef)")
        
        postRef.getDocument { ( document , error ) in
            if error != nil {
                print("poseRef読み込みエラー")
            }
            else{
                print("elseに入ったよ")
                
                print("document:\(document)")
                self.idCaption.text = "\(document?["name"] as! String)|\(document?["caption"] as! String)"
                print("date:\(document?["date"])")
                
                var timestamp = document?["date"] as! Timestamp
                let date = timestamp.dateValue
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
                let dateString = formatter.string(from: date())
                self.dateLabel.text = dateString
            }
        }
        
        
        //コメント者の名前を表示
        self.nameLabel.text = "from " + ((Auth.auth().currentUser?.displayName ?? nil)!)
        
    }//ここでviewWillAppear終了
    
    
    
    
    
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
        let commentRef = Firestore.firestore().collection(Const.PostPath).document(postId)/*.collection("comments").document()*/
        let commentName = Auth.auth().currentUser?.displayName
        
        let commentDic = [/*"postID":postId!,*/ "commentName": commentName!,"commentText":commentTextField.text!,/*"commentdate":FieldValue.serverTimestamp() */] as [String : Any]
        
        commentRef.updateData(commentDic)
        //commentTextField.text = ""
        //tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
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
