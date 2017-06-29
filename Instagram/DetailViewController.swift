//
//  DetailViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/29/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    var detailObject: PFObject?

    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailCaption: UILabel!
    @IBOutlet weak var detailTime: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let detailObject = detailObject {
            let caption = detailObject["caption"] as? String
            let media = detailObject["media"] as? PFFile
            if let date = detailObject.createdAt {
                self.detailTime.text = date.getElapsedInterval()
            }
            self.detailCaption.text = caption
            media?.getDataInBackground(block: { (backgroundData: Data?, error: Error?) in
                if let backgroundData = backgroundData {
                    self.detailImage.image = UIImage(data: backgroundData)
                }
            })
        }
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
