//
//  CustomViewCell.swift
//  ShoppingPad
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {
    
    
    //TableViewcell atributes
    @IBOutlet weak var mContentCellImageView: UIImageView!      // content image
    
    @IBOutlet weak var mContentCellTitleLabel: UILabel!         // content title
    
    @IBOutlet weak var mContentCellViewAction: UILabel!         // content action
    
    @IBOutlet weak var mContentCellLastSeen: UILabel!           // content last seen

    @IBOutlet weak var mContentCellTotalViews: UILabel!         // content total views
    
    @IBOutlet weak var mContentCellTotalParticipants: UILabel!  // total participants of 
    
    //create object of view
    var mContentListViewControllerObj = ContentListViewController()
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
