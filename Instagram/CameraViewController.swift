//
//  CameraViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/27/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var imagePreview: UIImageView!

    
    var postCaption: String = ""
    
    @IBAction func onPost(_ sender: Any) {
        postCaption = captionField.text!
        dismiss(animated: true, completion: nil)
        Post.postUserImage(image: imagePreview.image, withCaption: postCaption) { (success: Bool, error: Error?) in
            if success {
                print("Image posted!")
            } else {
                print("Failed to post image")
            }
        }
    }
    
    @IBAction func onPick(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let userImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imagePreview.image = userImage
        
        // let size = CGSize(width: <#T##Int#>, height: <#T##Int#>)
        // let resizedOriginalImage = resize(image: originalImage, newSize: )
        // let resizedEditedImage = resize(image: originalImage, newSize: )
        // Do something with the images (based on your use case)
        
        dismiss(animated: true, completion: nil)
    }
    
//    func resize(image: UIImage, newSize: CGSize) -> UIImage {
//        let resizeImageView = UIImageView(frame: CGRect(0, 0, newSize.width, newSize.height))
//        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
//        resizeImageView.image = image
//        
//        UIGraphicsBeginImageContext(resizeImageView.frame.size)
//        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return newImage!
//    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
