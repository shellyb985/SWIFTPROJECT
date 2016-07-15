//
//  IPLViewController.swift
//  IPL
//  Purpose 
//  1.  This initial view controller
//  2.  Display all team list 
//  Created by BridgeIt on 01/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import Firebase


class IPLViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, ViewControllerProtocol {
    
    
var list : NSMutableArray = ["/IPL/delhi-daredevils/","/IPL/Gujrat-Lions/","/IPL/Kings-XI-Punjab/","/IPL/Kolkata-Knight-Riders/","/IPL/Mumbai-Indians/","/IPL/Rising-Pune-Supergiants","/IPL/Royal-Challengers-Bangalore/","/IPL/Sunrisers-Hyderabad"]
    
    var mViewModelObj : ViewModel!
    var index = 0
    var storageRef:FIRStorageReference!
    var mPlayerList : NSMutableArray!
    
    @IBOutlet weak var tableview: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = FIRStorage.storage().reference()
        self.mViewModelObj = ViewModel(pControllerProtocol: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mViewModelObj.mTeamDetailList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("CUSTOMCELL", forIndexPath: indexPath) as! IPLCustomCell
        cell.TeamLogoImageView.image = UIImage(named: "download.jpeg")
        cell.TeamNameLabel.text = mViewModelObj.mTeamDetailList[indexPath.row]["team_name"] as? String
        cell.OwnerName.text = mViewModelObj.mTeamDetailList[indexPath.row]["team_owner"] as? String
        cell.HomeGroundLabel.text = mViewModelObj.mTeamDetailList[indexPath.row]["team_home_venue"] as? String
        cell.CaptianNameLabel.text = mViewModelObj.mTeamDetailList[indexPath.row]["team_captain"] as? String
        cell.CaptianNameLabel.text = mViewModelObj.mTeamDetailList[indexPath.row]["team_captain"] as? String
        

        // Create a reference to the file you want to download
        let islandRef = storageRef.child(mViewModelObj.mTeamDetailList[indexPath.row]["team_img_url"] as! String)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                print("Failed to load image")
            }
            else {
                cell.TeamLogoImageView.image = UIImage(data: data!)    
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("SHOWPLAYERLIST", sender: mPlayerList)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        mPlayerList = NSMutableArray()
        let playerListView : PlayerListViewController = segue.destinationViewController as! PlayerListViewController
        for i in 0...(mViewModelObj.mPlayerDetailList.count-1) {
            if ((mViewModelObj.mPlayerDetailList[i]["destination_folder_name"] as! String) == (list[index] as! String)) {
                mPlayerList.addObject(mViewModelObj.mPlayerDetailList[i])
            }
        }
        playerListView.mPlayerListPLV = mPlayerList
    }
    
    //Method to update table view
    func updateViewController()
    {
        tableview.reloadData()
    }
}

