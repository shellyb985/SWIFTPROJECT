//
//  ViewModelUpdater.swift
//  IPL
//
//  Created by BridgeIt on 09/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

protocol ViewModelUpdater
{
    func updateTeamList (teamList : NSMutableArray)
    func updatePlayerList (playerList : NSMutableArray)
    func updateViewController()
}