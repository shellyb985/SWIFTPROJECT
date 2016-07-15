//
//  NewDataModel.swift
//  IPL
//
//  Created by BridgeIt on 05/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class AlamofireRequest : NSObject {
        
    override init() {
        super.init()
       
       // self.mParseJson(pControllerUpdater:)
    }//end of init method
    
    //Method to fetch team details from url
    func mFetchTeamDetails (pControllerUpdater : ControllerUpdaterProtocol) {
        
        Alamofire.request(.GET, "http://192.168.0.132/ipl2016/team_info_with_folder.json", parameters: ["foo": "bar"])
            .responseJSON { response in
                pControllerUpdater.updataTeamList(response.result.value as! NSMutableArray)
        }
    }
    
    //Method to fetch player details from url
    func mFetchPlayerDetails (pControllerUpdater : ControllerUpdaterProtocol) {
        Alamofire.request(.GET, "http://192.168.0.132/ipl2016/playerlist.json", parameters: ["foo": "bar"])
            .responseJSON { response in
                pControllerUpdater.updatePlayerList(response.result.value as! NSMutableArray)
        }
    }
    
}//end of class
