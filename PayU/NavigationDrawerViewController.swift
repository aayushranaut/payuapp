//
//  NavigationDrawerViewController.swift
//  PayU
//
//  Created by Aayush Ranaut on 5/9/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class NavigationDrawerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var menuItems:[String] = ["Portfolio", "Leaderboard"]
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NavCell", forIndexPath: indexPath) as! CustomNavTableViewCell
        
        cell.menuItemLabel.text = menuItems[indexPath.row]
        
        return cell
    }

}
