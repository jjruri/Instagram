//
//  PostViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/01.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func handlePostButton(_ sender: Any) {
        //画像を保存用にjpegに変換する
        let imageData = image.jpegData(compressionQuality: 0.75)
        //保存場所を決める
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        print("ポストレフは\(postRef)")
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
        
        //画像のアップロードする準備
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        //画像をstorageに保存する
        imageRef.putData(imageData!, metadata: metadata){(metadata,error) in
            if let error = error {
                print("エラー：\(error)")
                self.dismiss(animated: true, completion: nil)
            }
        //投稿をfirestoreに保存する
            let name = Auth.auth().currentUser?.displayName
            let postDic = ["name":name!,"caption":self.textField.text!,"date":FieldValue.serverTimestamp()] as [String : Any]
            postRef.setData(postDic)
        }
        
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
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
