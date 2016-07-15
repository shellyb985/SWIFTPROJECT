//
//  fireBaseDB.swift
//  
//
//  Created by BridgeIt on 11/07/16.
//
//

import UIKit

class fireBaseDB: NSObject {
    
    var fbDatabase = FIRDatabase.database().reference()
    var fbHandler : FIRDatabaseHandle!
    var teamList = [NewTeamDetails]()
    
    
    override init() {
        super.init()
        fbDatabase = fbDatabase.child("teaminfo")
        
    }
    
    func parseTeamDetails (pControllerUpdater : ControllerUpdaterProtocol) {
        fbHandler = fbDatabase.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            let TeamArray = snapshot.value as! NSMutableArray
            
            for i in 0...(TeamArray.count-1) {
                var team = NewTeamDetails()
                team.teamName = TeamArray[i]["team_name"] as! String
                team.ownerName = TeamArray[i]["team_owner"] as! String
                
                self.teamList.append(team)
            }
            
        })
        pControllerUpdater.updataTeamList(teamList)
    }

}
