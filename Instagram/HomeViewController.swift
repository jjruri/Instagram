//
//  HomeViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/01.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray:[PostData] = []
    var listener: ListenerRegistration!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        //カスタムtableViewCellを受け入れる部分を記載する
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let postRef = Firestore.firestore().collection(Const.PostPath).order(by: "date", descending: true)
        listener = postRef.addSnapshotListener(){(querySnapshot,error) in
            if let error = error {
                print("DEBIG PRINT:投稿読み込みエラー\(error)")
            }
                
            else{
                self.postArray = querySnapshot!.documents.map { document in
                    let postData = PostData(document: document)
                    return postData
                }
            }
            print("DEBUG PRINT:件数取得 \(self.postArray.count)")
            self.tableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell//ここでクラスを書き換えないとPostTableViewCell側で作った各要素の表示のためにデータをはめていくメソッドをたたけない
        cell.setPostData(postArray[indexPath.row])//ここで1セットずつメソッドにpostdataの値を渡して、cellに入れるデータを返してもらう
        
        //
        cell.likeButton.addTarget(self, action: #selector(handleButton(_:forEvent:)), for: .touchUpInside)
        return cell
    }
    
    @objc func handleButton (_ sender:UIButton, forEvent event:UIEvent){
        print("DEBUG PRINT:イイネボタンがタップされた")
        
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        let postData = postArray[indexPath!.row]
        
        //書き込むUIDが必要なので取得しておく
        if let myid = Auth.auth().currentUser{
            print("myid:\(String(describing: myid))")
            //firestoreに書き込むのはいいねする時も外す時も同一処理にしたいので
            //変更内容を入れる箱をつくる
            var updateDetail: FieldValue

            
            if postData.isLiked {
                print("リムーブします")
                updateDetail = FieldValue.arrayRemove([myid])
            }
            else{
                print("追加します")
                updateDetail = FieldValue.arrayUnion([myid])
                print("updateDetail:\(updateDetail)")
                //postRef.setData(["likes": updateDetail ])
            }
            
            //箱に入れた変更内容をfirestoreに送る(likesをupdateDetailの内容でアップデートする
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            
            print("postRef:\(postRef)")
            print("likes:\(postData.likes)")
            postRef.updateData(["likes": updateDetail])
        }
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
