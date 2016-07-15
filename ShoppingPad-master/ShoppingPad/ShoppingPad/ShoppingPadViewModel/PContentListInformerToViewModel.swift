//
//  PContentListInformerToViewModel.swift
//  ShoppingPad
//
//  Purpose : 
//  This protocol is implemented by protocol
//  This protocol informs content list view model that now contentList controller contains data.
//
//  Created by BridgeLabz on 13/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation

protocol PContentListInformerToViewModel
{
    // informs content List Data Model that data is now availiable in controller
    func updateViewModelContentListInformer()
}
