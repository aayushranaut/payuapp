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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let urlAsString = "http://localhost/payuapi/public/api/v1/stock/trending"
//        let url = NSURL(string: urlAsString)
//        let urlRequest = NSURLRequest(URL: url!)
//        
//        let queue = NSOperationQueue()
//        
//        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: { (response: NSURLResponse!,
//            data: NSData!,
//            error: NSError!) in
//        
//            
//            if data.length > 0 && error == nil {
//                let json = NSString(data: data, encoding: NSUTF8StringEncoding)
//                let json2 = self.JSONParseArray(json)
//                println("json = \(json2)")
//            }
//        })
        
        Alamofire.request(.GET, "http://10.100.86.148/payuapi/public/api/v1/stock/trending")
            .responseJSON { (_, _, data, _) in
                
//                if let jsonResult = JSON as? Dictionary<String, Dictionary<String, Dictionary<String,String>>> {
//                    println(jsonResult)
//                }
                
                var json = JSON(data!)
                
                //println(json["data"])
                
                for (key: String, subJson: JSON) in json["data"] {
                    self.stocks.append(subJson["name"].stringValue)
                }
                
                println(self.stocks)
                self.tableView.reloadData()
        }
    }
//
//    func JSONParseArray(jsonString: String) -> [AnyObject] {
//        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
//        if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
//        return array
//        }
//        }
//        return [AnyObject]()
//    }
    



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

