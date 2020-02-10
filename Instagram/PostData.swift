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
    //このクラス内でfirestore にアクセスしようとすると、キャッシュを使えなくなって激重アプリになる？
    //このクラスでは後で呼び出すための型宣言のみを記載しておく
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false

    
    init(document: QueryDocumentSnapshot) {
        //ここでidはSnapShotのIDを使う
        self.id = document.documentID
        
        //postDicという箱にsnapshotのデータを全部入れる
        let postDic = document.data()
        
        //とってきたデータを項目ごとに最初に宣言したnameやcaptionに入れる
        self.name = postDic["name"] as? String
        self.caption = postDic["caption"] as? String
        
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
    }

}
