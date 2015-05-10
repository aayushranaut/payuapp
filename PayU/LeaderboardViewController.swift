//
//  LeaderboardViewController.swift
//  PayU
//
//  Created by Aayush Ranaut on 5/10/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var portfolioList: [AnyObject] = []
    var portfolioProfitList: [Float] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Alamofire.request(.GET, "http://10.100.86.148/payuapi/public/api/v1/leaderboard/net")
            .responseJSON { (_, _, data, _) in
                
                var json = JSON(data!)
                
                println(json["data"])
                
                self.portfolioProfitList.removeAll(keepCapacity: false)
                
                for (key: String, subJson: JSON) in json["data"] {
                    self.portfolioList.append(subJson["username"].stringValue)
                    self.portfolioProfitList.append(subJson["net_worth"].floatValue)
                }
                
                
                println(self.portfolioList)
                self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CustomLeaderboardTableViewCell", forIndexPath: indexPath) as! CustomLeaderboardTableViewCell
        
        cell.name.text = portfolioList[indexPath.row] as? String
        cell.money.text = String(stringInterpolationSegment: portfolioProfitList[indexPath.row])

        cell.money.textColor = UIColor.greenColor()

        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioList.count
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
