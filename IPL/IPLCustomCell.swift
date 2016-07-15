//
//  IPLCustomCell.swift
//  IPL
//
//  Created by BridgeIt on 01/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class IPLCustomCell: UITableViewCell {

    @IBOutlet weak var TeamNameLabel: UILabel!
    @IBOutlet weak var TeamLogoImageView: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var CaptianNameLabel: UILabel!
    @IBOutlet weak var HomeGroundLabel: UILabel!
    @IBOutlet weak var CoachNameLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
