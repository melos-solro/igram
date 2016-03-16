//
//  HomeViewController.swift
//  igram
//
//  Created by Melos on 3/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var signoutButtonBar: UIBarButtonItem!
    
    @IBOutlet weak var uiNavBar: UINavigationBar!
    
    @IBAction func onSignOut(sender: AnyObject) {
        
        PFUser.logOut()
        performSegueWithIdentifier("signoutSegue", sender: nil)
        
    }
    
    var posts: [PFObject]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorColor = UIColor.blackColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorInset = UIEdgeInsetsMake(0,-8,0,0)
        
        navigationItem.title = "Igram Feed"
        navigationItem.leftBarButtonItem = signoutButtonBar
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.limit = 20
        print("Querying")
        
        // Do any additional setup after loading the view.
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                print("Posts obtained")
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let posts = posts {
            print(posts.count)
            return posts.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath) as! PostTableViewCell
        
        cell.post = self.posts[indexPath.row]

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
