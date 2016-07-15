//
//  ViewModel.swift
//  IPL
//  Purpose
//  1.  This class is view model for view 
//  2.  This class hold all list and details of team and player
//  Created by BridgeIt on 01/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ViewModel: ViewModelUpdater  {

    var mTeamDetailList = NSMutableArray()
    var mPlayerDetailList = NSMutableArray()
    var mControllerObj : Controller!
    var viewProtocol : ViewControllerProtocol?
    
    init(pControllerProtocol : ViewControllerProtocol ) {
       
        viewProtocol = pControllerProtocol
        mControllerObj = Controller(pViewModelUpdater: self)
        //self.mgetTeamListViewModel()
    }

    //Method return teamDetails at specific index
    func mTeamDetialAtIndex(index : Int) -> [String : AnyObject] {
        return mTeamDetailList[index] as! [String : AnyObject]
    }
    
    //Method return playerDetails at specific index
    func mPlayerDetailAtIndex(index : Int) -> [String : AnyObject] {
        return mPlayerDetailList[index] as! [String : AnyObject]
    }
    
    //Method return Total Number of Team
    func mTotalTeamDetails() -> Int {
        return mTeamDetailList.count
    }
    //Method to return Total Number of Player
    func mTotalPlayerDetails() -> Int {
        return mPlayerDetailList.count
    }
    //Method to update Team list
    func updateTeamList (teamList : NSMutableArray) {
         mTeamDetailList = teamList
    }
    
    //Method to update Player Details
    func updatePlayerList (playerList : NSMutableArray) {
        mPlayerDetailList = playerList
    }
    
    //
    func updateViewController()
    {
        viewProtocol?.updateViewController()
    }
}
