//
//  CameraViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/27/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func onPick(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            // let size = CGSize(width: <#T##Int#>, height: <#T##Int#>)
            // let resizedOriginalImage = resize(image: originalImage, newSize: )
            // let resizedEditedImage = resize(image: originalImage, newSize: )
            // Do something with the images (based on your use case)
            
            dismiss(animated: true, completion: nil)
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
