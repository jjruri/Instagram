//
//  PostData.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/04.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    //firestoreからの形をswiftで扱える形に直すのがこのクラス
    //firestoreからとってきたdocumentをこのクラスに入れたら、データを使える形にしてこのクラス自体が返ってくる
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var commentText: String?
    var commentName: String?
    /*
    var postID:String
    var commentID:String
    var commentName:String!
    var commentDate:Date?
    var commentText:String?
    */
    
    init(document: QueryDocumentSnapshot /*,commentDocument: QueryDocumentSnapshot*/) {
        //ここでidはSnapShotのIDを使う
        self.id = document.documentID
        
        //postDicという箱にsnapshotのデータを全部入れる
        let postDic = document.data()
        
        //とってきたデータを項目ごとに最初に宣言したnameやcaptionに入れる
        self.name = postDic["name"] as? String
        self.caption = postDic["caption"] as? String
        self.commentText = postDic["commentText"] as? String
        self.commentName = postDic["commentName"] as? String
        //firestoreのドキュメントに入ってるdateはtimestamoなので、日付だけ取るには一回変換させる必要がある
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        //likeのUID配列をとってくる オプショナルにするだけだとnilでエラー出ちゃう
        if let likes = postDic["likes"] as? [String]{
            self.likes = likes
        }
        
        //likeされてるかどうかを判定して返してあげる処理
        let myid = Auth.auth().currentUser!.uid
        if self.likes.firstIndex(of: myid) != nil {
            self.isLiked = true
        }
        else {
            self.isLiked = false
        }
        
        
        
        
        /*
        self.commentID = ""
        
        let commentDic = commentDocument.data()
        postID = commentDic["postID"] as! String
        commentName = commentDic["name"] as? String
        commentText = commentDic["commentText"] as? String
        
        let commentTimeStamp = commentDic["date"] as? Timestamp
        self.commentDate = commentTimeStamp?.dateValue()
 */
    }
}
