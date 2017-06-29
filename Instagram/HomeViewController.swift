//
//  HomeViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/27/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var homePosts: [PFObject]?
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error: Error?) in })
        NotificationCenter.default.post(name: NSNotification.Name("logoutNotfication"),object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("media")
        query.includeKey("captions")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground(block: { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.homePosts = posts
                print("Got posts!")
            } else {
                print(error?.localizedDescription ?? "Error fetching posts")
            }
            self.tableView.reloadData()
        })

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! PostCell
        
        cell.profilePicture.layer.cornerRadius = cell.profilePicture.frame.size.width / 2

        let object = homePosts?[indexPath.row]
        let caption = object?["caption"] as? String
        let media = object?["media"] as? PFFile
        cell.captionLabel.text = caption
        media?.getDataInBackground(block: { (backgroundData: Data?, error: Error?) in
            if let backgroundData = backgroundData {
                cell.postImage.image = UIImage(data: backgroundData)
            }
        })
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homePosts == nil {
            return 0
        }
        return homePosts!.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
