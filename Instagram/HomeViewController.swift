//
//  HomeViewController.swift
//  Instagram
//
//  Created by Chase Warren on 6/27/17.
//  Copyright © 2017 Chase Warren. All rights reserved.
//

import UIKit
import Parse

extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "YEAR AGO" :
                "\(year)" + " " + "YEARS AGO"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "MONTH AGO" :
                "\(month)" + " " + "MONTHS AGO"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "DAY AGO" :
                "\(day)" + " " + "DAYS AGO"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "HOUR AGO" :
                "\(hour)" + " " + "HOURS AGO"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "MINUTE AGO" :
                "\(minute)" + " " + "MINUTES AGO"
        } else {
            return "A MOMENT AGO"
        }
        
    }
}

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var homePosts: [PFObject]?
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error: Error?) in })
        NotificationCenter.default.post(name: NSNotification.Name("logoutNotfication"),object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let prepareObject = homePosts?[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.detailObject = prepareObject
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("media")
        query.includeKey("captions")
        query.includeKey("_created_at")
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
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("media")
        query.includeKey("captions")
        query.includeKey("_created_at")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground(block: {(posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.homePosts = posts
                print("Got posts!")
            } else {
                print(error?.localizedDescription ?? "Error fetching posts")
            }
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        })
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! PostCell
        
        cell.profilePicture.layer.cornerRadius = cell.profilePicture.frame.size.width / 2

        let object = homePosts?[indexPath.row]
        let caption = object?["caption"] as? String
        let media = object?["media"] as? PFFile
        if let date = object?.createdAt {
            cell.ageLabel.text = date.getElapsedInterval()
        } else {
            print("Could not get date")
        }
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
