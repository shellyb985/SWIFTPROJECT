//
//  Controller.swift
//  IPL
//  
//  Created by BridgeIt on 01/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class Controller : ControllerUpdaterProtocol {
 
    var mTeamDetailList = NSMutableArray()  //to store all team list and details
    var mPlayerDetailList = NSMutableArray() //to store all player list and details
    
    var viewmodelProtocol : ViewModelUpdater!
    
    var firebaseObj : FirebaseDatabase!
    var alamofireRequestObj : AlamofireRequest!
    var localDatabaseObj : LocalDataBase!
    
    init(pViewModelUpdater:ViewModelUpdater)
     {
        viewmodelProtocol = pViewModelUpdater
        self.mFetchDataFromFireBase()
//        self.mFetchDataFromAlamoFire()
//        self.mFetchDataFromLocalDataBase()
    }
    
    //Method to fetch data from FIREBASE
    func mFetchDataFromFireBase() {
        //Create object of Firebase Database
        firebaseObj = FirebaseDatabase()
        //call to fetch team details form Firebase
        firebaseObj.mFetchTeamDetails(self)
        //call to fetch player details from Firebase
        firebaseObj.mFetchPlayerDetails(self)
    }
    
    //Method to fetch data from Alamofire
    func mFetchDataFromAlamoFire() {
        //Create object of AlamofireRequest Class
        alamofireRequestObj = AlamofireRequest()
        //call to fetch team details form Firebase
        alamofireRequestObj.mFetchTeamDetails(self)
        //call to fetch player details from Firebase
        alamofireRequestObj.mFetchPlayerDetails(self)
    }
    
    //Method to fetch data from Local Database
    func mFetchDataFromLocalDataBase() {
        //Create object of LocalDataBase class
        localDatabaseObj = LocalDataBase()
        //call to fetch team details from local DB
        localDatabaseObj.mFetchTeamDetails(self)
        //call to fetch player details from local DB
        localDatabaseObj.mFetchPlayerDetails(self)
    }
    
    //Method to update team list
    func updataTeamList(teamList : NSMutableArray)
    {
        mTeamDetailList = teamList
        viewmodelProtocol.updateTeamList(teamList)
        viewmodelProtocol.updateViewController()
    }
    
    //Method to update player list
    func updatePlayerList(playerList : NSMutableArray ) {
        mPlayerDetailList = playerList
        viewmodelProtocol.updatePlayerList(playerList)
    }
    
 }//End of class
