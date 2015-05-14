//
//  ViewController.swift
//  PayU
//
//  Created by Aayush Ranaut on 5/9/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var stocks:[String] = []
    var graph: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIGraphicsBeginImageContext(self.view.bounds.size)
        UIImage(named: "547561.png")!.drawInRect(self.view.bounds)
        var blurImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: blurImg.applyExtraLightEffect()!)
        
        Alamofire.request(.GET, "http://10.100.86.148/payuapi/public/api/v1/stock/trending")
            .responseJSON { (_, _, data, _) in
                
                var json = JSON(data!)
                
                //println(json["data"])
                
                for (key: String, subJson: JSON) in json["data"] {
                    self.stocks.append(subJson["name"].stringValue)
                    var list: [Int] = []
                    for i in 0..<subJson["graph"].count {
                        list.append(Int(subJson["graph"][i]["price"].floatValue * 100))
                    }
                    self.graph.append(list)
                }
                
                
                println(self.stocks)
                self.tableView.reloadData()
        }
        
        var time = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    func update()
    {
        Alamofire.request(.GET, "http://10.100.86.148/payuapi/public/api/v1/stock/trending")
            .responseJSON { (_, _, data, _) in
                
                var json = JSON(data!)
                
                //println(json["data"])
                
                self.graph.removeAll(keepCapacity: false)
                self.stocks.removeAll(keepCapacity: false)
                for (key: String, subJson: JSON) in json["data"] {
                    self.stocks.append(subJson["name"].stringValue)
                    var list: [Int] = []
                    for i in 0..<subJson["graph"].count {
                        list.append(Int(subJson["graph"][i]["price"].floatValue * 100))
                    }
                    self.graph.append(list)
                }
                
                
                println(self.stocks)
                self.tableView.reloadData()
        }
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
        cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(self.graph.count)
        println(indexPath.row)
        graphView.graphPoints = self.graph[indexPath.row] as! [Int]
        graphView.setNeedsDisplay()
    }
}

