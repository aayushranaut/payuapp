//
//  ViewController.swift
//  PayU
//
//  Created by Aayush Ranaut on 5/9/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var containerView: UIView!
    
    var stocks:[String] = ["APPL", "GOGL", "FB"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func drawerOpen(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("stockCell", forIndexPath: indexPath) as! CustomStockTableViewCell
        
        cell.nameLabel.text = stocks[indexPath.row]
        
        return cell
    }
}

