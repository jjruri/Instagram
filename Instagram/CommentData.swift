//
//  CommentData.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/13.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase
//firestoreからの形をswiftで扱える形に直すのがこのクラス
//firestoreからとってきたdocumentをこのクラスに入れたら
//データを使える形にしてこのクラス自体が返ってくる

class CommentData: NSObject {

    var postID:String!
    var commentID:String
    var commentName:String!
    var commentDate:Date?
    var commentText:String?
    
    init(commentDocument: QueryDocumentSnapshot){
        self.commentID = commentDocument.documentID
        
        let commentDic = commentDocument.data()
        print("commentDIc:\(commentDic)")
        postID = commentDic["postID"] as? String
        commentName = commentDic["name"] as? String
        commentText = commentDic["commentText"] as? String
        
        let timeStamp = commentDic["date"] as? Timestamp
        self.commentDate = timeStamp?.dateValue()
    }
    
}
