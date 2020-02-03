//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by 佐藤淳哉 on 2020/02/01.
//  Copyright © 2020 Junya.Satou. All rights reserved.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate,CLImageEditorDelegate {
    
    //ライブラリを起動させる
    @IBAction func handleLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController,animated: true,completion: nil)
        }
    }
    //カメラを起動させる
    @IBAction func handleCameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController,animated: true,completion: nil)
        }
    }
    
    //ライブラリでもカメラでも画像が確定した時に呼んでるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil{
            let image = info[.originalImage] as! UIImage
            
            print("DEBUG PRINT:image=\(image)")
            let editor = CLImageEditor(image : image)!
            editor.delegate = self
            picker.present(editor, animated: true,completion: nil)
        }
    }
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post")
        postViewController.image = image!
        editor.present(postViewController,animated: true,completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
