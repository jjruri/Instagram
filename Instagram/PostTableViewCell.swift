//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/04.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell {
    
    //PostDataでfirestoreからのデータを使える型に変換したのを元に、データが届いたときに表示できるように要素をつくるためのクラス
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //PostDataの値をセルに送り込むためのfunc
    func setPostData(_ postData: PostData){
        //firevbaseUIで使えるようになったsd_setImageというメソッドを使ってファイルパスから画像をダウンロードしてimageViewに突っ込むまでを一気にやってもらう
        //画像処理
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        //テキスト情報処理
        self.captionLabel.text = "\(postData.name!)|\(postData.caption!)"
        
        //date処理
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        //いいねマークの処理
        if postData.isLiked == true {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        else{
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        //いいね数の表示
        let likecount = postData.likes.count
        self.likeLabel.text = "\(likecount)"
    }
    
    
}
