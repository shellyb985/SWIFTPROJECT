//
//  pContentListListener.swift
//  ShoppingPad
//
//  Created by BridgeLabz on 13/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation

protocol PContentListListener
{
    func updateControllerListModel(JsonContentInfo : NSMutableArray)
    func updateControllerViewModel(JsonContentView : NSMutableArray)
}


