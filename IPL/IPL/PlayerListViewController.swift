//
//  PlayerListViewController.swift
//  IPL
//  Purpose
//  1.  This view controller display all player list and its detailis of specific team
//
//  Created by BridgeIt on 05/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import Firebase

class PlayerListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var storageRef:FIRStorageReference!
    var mPlayerListPLV : NSMutableArray!
    var mPlayer = [String : AnyObject]()
    var index = 0
    
    
    override func viewDidLoad() {
        storageRef = FIRStorage.storage().reference()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mPlayerListPLV.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PLAYERVIEWCELL", forIndexPath: indexPath) as! PLayerListCellTableViewCell
        
        cell.PlayerNameLabel.text = mPlayerListPLV[indexPath.row]["player_name"] as! String  //mReceivedData.playerList[indexPath.row].name
        cell.roleLabel.text = mPlayerListPLV[indexPath.row]["player_role"] as! String   //mReceivedData.playerList[indexPath.row].role

        
        // Create a reference to the file you want to download
        let islandRef = storageRef.child(mPlayerListPLV[indexPath.row]["player_img_url"] as! String)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
            print("Failed to load image")
            }
            else {
                cell.mImageView.image = UIImage(data: data!)
        
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("SHOWPLAYERDETAIL", sender: mPlayer)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let playerViewDetail : PlayerDetailViewController = segue.destinationViewController as! PlayerDetailViewController
        playerViewDetail.mPlayerPDV = mPlayerListPLV[index] as! [String : AnyObject]
        
    }

}
