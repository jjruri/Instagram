//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/12.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //カスタムビューセルに値を入れていく処理
    func setCommentViewCell(_ commentData: CommentData){
        self.commentName.text = commentData.commentName
        self.commentText.text = commentData.commentText
        
        if let date = commentData.commentDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let dateString = formatter.string(from: date)
            self.commentDate.text = dateString
        }
        
    }
}
