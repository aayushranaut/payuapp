//
//  PortfolioViewController.swift
//  PayU
//
//  Created by Aayush Ranaut on 5/10/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var portfolioList: [AnyObject] = []
    var portfolioProfitList: [Float] = []
    var tradeId: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Alamofire.request(.GET, "http://10.100.86.148/payuapi/public/api/v1/portfolio/Bill%20Gates")
            .responseJSON { (_, _, data, _) in
                
                var json = JSON(data!)
                
                println(json["data"])
                
                self.tradeId.removeAll(keepCapacity: false)
                self.portfolioProfitList.removeAll(keepCapacity: false)
                
                for (key: String, subJson: JSON) in json["data"] {
                    self.portfolioList.append(subJson["name"].stringValue)
                    self.portfolioProfitList.append(subJson["profit"].floatValue)
                    self.tradeId.append(subJson["id"].intValue)
                }
                
                
                println(self.portfolioList)
                self.tableView.reloadData()
        }
        
        var lpgr: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
        lpgr.minimumPressDuration = 1.0
        self.view.addGestureRecognizer(lpgr)
    }
    
    func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let longPress = gestureRecognizer as UILongPressGestureRecognizer
        
        let state = longPress.state
        
        var locationInView = longPress.locationInView(tableView)
        
        var indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        if !(indexPath != nil) {
            println("Out of bounds")
        } else if longPress.state == UIGestureRecognizerState.Began {
            var alert = UIAlertController(title: "Sell", message: "Sell shares", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Yup!", style: UIAlertActionStyle.Default, handler: { action in
                switch action.style{
                case .Default:
                    var url: String = "http://10.100.86.148/payuapi/public/api/v1/stock/sell/Bill%20Gates/" +  String(self.tradeId[indexPath!.row]);
                    println(url)
                    Alamofire.request(.GET, url)
                        .responseJSON { (_, _, data, _) in
                            
                            self.portfolioList.removeAtIndex(indexPath!.row)
                            self.tradeId.removeAtIndex(indexPath!.row);
                            self.portfolioProfitList.removeAtIndex(indexPath!.row)
                            
                            println(self.portfolioList)
                            self.tableView.reloadData()
                    }
                    
                case .Cancel:
                    println("cancel")
                    
                case .Destructive:
                    println("destructive")
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
                switch action.style{
                case .Default:
                    println("default")
                    
                case .Cancel:
                    println("cancel")
                    
                case .Destructive:
                    println("destructive")
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CustomPortfolioTableViewCell") as! CustomPortfolioTableViewCell
        
        cell.stockLabel.text = portfolioList[indexPath.row] as? String
        cell.stockProfit.text = String(stringInterpolationSegment: portfolioProfitList[indexPath.row])
        
        if(portfolioProfitList[indexPath.row] < 0)
        {
            cell.stockProfit.textColor = UIColor.redColor()
        } else
        {
            cell.stockProfit.textColor = UIColor(red: 64.0/255.0, green: 155.0/255.0, blue: 45.0/255.5, alpha: 1.0)
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioList.count
    }

    
}
