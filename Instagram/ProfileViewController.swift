//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/29/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var numberPostsLabel: UILabel!
    var homePosts: [PFObject]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("media")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground(block: { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.homePosts = posts
                self.numberPostsLabel.text = "\(posts.count)"
            } else {
                print(error?.localizedDescription ?? "Error fetching posts")
            }
            self.collectionView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if homePosts == nil {
            return 0
        }
        return homePosts!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Profile Cell", for: indexPath) as! ProfileCell
        
        let object = homePosts?[indexPath.item]
        let media = object?["media"] as? PFFile
        media?.getDataInBackground(block: { (backgroundData: Data?, error: Error?) in
            if let backgroundData = backgroundData {
                cell.postImage.image = UIImage(data: backgroundData)
            }
        })
        
        return cell
    }
}
