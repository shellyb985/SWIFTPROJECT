//
//  PlayerDetailViewController.swift
//  IPL
//  Purpose
//  1.  This View controller view all details of particular player
//
//  Created by BridgeIt on 06/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import Firebase

class PlayerDetailViewController: UIViewController {
    
    var storageRef:FIRStorageReference! 

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var roleLabel: UILabel!
    
    @IBOutlet weak var batStyle: UILabel!
    
    @IBOutlet weak var bowlStyle: UILabel!
    
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var nationalityLabel: UILabel!
    
    @IBOutlet weak var playerImage: UIImageView!

    var mPlayerPDV = [String : AnyObject]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        storageRef = FIRStorage.storage().reference()

        
        nameLabel.text = mPlayerPDV["player_name"] as! String
        roleLabel.text = mPlayerPDV["player_role"] as! String
        batStyle.text = mPlayerPDV["player_batting_style"] as! String
        bowlStyle.text = mPlayerPDV["player_bowling_style"] as! String
        dobLabel.text = mPlayerPDV["player_dob"] as! String
        nationalityLabel.text = mPlayerPDV["player_nationality"] as! String

        // Create a reference to the file you want to download
        let islandRef = storageRef.child(mPlayerPDV["player_img_url"] as! String)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
               self.playerImage.image = UIImage(data: data!)
                
            }
        }
   

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
