//
//  PLayerListCellTableViewCell.swift
//  IPL
//
//  Created by BridgeIt on 05/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class PLayerListCellTableViewCell: UITableViewCell {
    @IBOutlet weak var roleLabel: UILabel!

    @IBOutlet weak var mImageView: UIImageView!
  
    @IBOutlet weak var PlayerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
