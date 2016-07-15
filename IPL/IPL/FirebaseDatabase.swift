/*
//  FirebaseDatabase.swift
//  IPL
//  purpose
//  1. This class is used to fetch team list and player list from FIREBASE
//
//  Created by BridgeIt on 11/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
*/

import UIKit
import Firebase

class FirebaseDatabase: NSObject {

    
    var fbDatabase = FIRDatabase.database().reference()
    var fbDatabase1 = FIRDatabase.database().reference()
  
    //Method to fetch team details from Firebase Database
    func mFetchTeamDetails (pControllerUpdater : ControllerUpdaterProtocol) {
        fbDatabase = fbDatabase.child("teaminfo")
        fbDatabase.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            pControllerUpdater.updataTeamList(snapshot.value as! NSMutableArray)
        })
    }
    
    //Method to fetch player details from Firebase Database
    func mFetchPlayerDetails (pControllerUpdater : ControllerUpdaterProtocol) {
        fbDatabase1 = fbDatabase1.child("playerinfo")
        fbDatabase1.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            pControllerUpdater.updatePlayerList(snapshot.value as! NSMutableArray)
        })

    }
}
