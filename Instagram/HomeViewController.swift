//
//  HomeViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/27/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error: Error?) in
            // PFUser.currentUser() will now be nil
        })
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
