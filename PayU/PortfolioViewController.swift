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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Alamofire.request(.GET, "http://10.100.86.148/payuapi/public/api/v1/portfolio/Bill%20Gates")
            .responseJSON { (_, _, data, _) in
                
                var json = JSON(data!)
                
                println(json["data"])
                
                self.portfolioProfitList.removeAll(keepCapacity: false)
                
                for (key: String, subJson: JSON) in json["data"] {
                    self.portfolioList.append(subJson["name"].stringValue)
                    self.portfolioProfitList.append(subJson["profit"].floatValue)
                }
                
                
                println(self.portfolioList)
                self.tableView.reloadData()
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
            cell.stockProfit.textColor = UIColor.greenColor()
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioList.count
    }

}
