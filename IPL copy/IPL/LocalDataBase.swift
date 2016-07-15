//
//  LocalDataBase.swift
//  IPL
//  Purpose
//  1.  This i
//  Created by BridgeIt on 05/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class LocalDataBase : NSObject {
    
    var DBPath = String()
    //init method
    override init() {
        print("Local db init method")
        let fileMgr = NSFileManager.defaultManager()
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true)
        DBPath = dirPath[0] + "NewTeamDataBase.db"
        
        if fileMgr.fileExistsAtPath(DBPath){
            
            let DB = FMDatabase(path: DBPath)
            if DB.open() {
                //create table for team
                let sqlStmt = "CREATE TABLE IF NOT EXISTS TEAMTABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT,TEAMNAME TEXT,IMGURL TEXT,COACH TEXT,CAPTIAN TEXT,HOMEVENU TEXT,OWNER TEXT,DESTINATIONFOLDER TEXT)"
                
                if DB.executeStatements(sqlStmt) {
                    print("table created")
                }
                else {
                    print("taable not created")
                }
                //creating table for player
                let sqlPlayerStmt = "CREATE TABLE IF NOT EXISTS PLAYERTABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT,PLAYERNAME TEXT,IMGURL TEXT,ROLE TEXT,BATSTYLE TEXT,BOWLSTYLE TEXT,NATIONALITY TEXT,DOB TEXT,DESTINATIONFOLDER TEXT)"
                //to delete table
/*                if DB.executeUpdate("DELETE FROM NEWPLAYERLIST", withArgumentsInArray: nil) {
                    print("Table deleted")
                }
*/
                if DB.executeStatements(sqlPlayerStmt) {
                    print("Player table created")
                }
                else {
                    print("Player : table not created")
                }
                DB.close()
            }
            else {
                print("Failed to open DB")
            }
        }//end of if
    }//end of init
    
    //insert data into team table
    func mInsertTeamDetails (teamList : NSMutableArray) {
        let DB = FMDatabase(path: DBPath)
        if DB.open() {
            print("DataBase open for inserting")
            
            for i in 0...(teamList.count-1) {
                let teamName = teamList[i]["team_name"]
                let imgUrl = teamList[i]["team_img_url"]
                let coach = teamList[i]["team_coach"]
                let captian = teamList[i]["team_captain"]
                let homeVenu = teamList[i]["team_home_venue"]
                let owner = teamList[i]["team_owner"]
                let destFolder = teamList[i]["destination_folder_name"]
                let sqlQuery = "INSERT INTO TEAMLIST (TEAMNAME,IMGURL,COACH,CAPTIAN,HOMEVENU,OWNER,DESTINATIONFOLDER) VALUES ('\(teamName)','\(imgUrl)','\(coach)','\(captian)','\(homeVenu)','\(owner)','\(destFolder)')"

                if DB.executeUpdate(sqlQuery, withArgumentsInArray: nil) {
                }
                else {
                    print("failed to insert data in to table")
                }
            }
            DB.close()
        }
        else {
            print("Failed to open database for inserting")
        }
    }//end of insert method
    
    //method to insert player details
    func mInsertPlayerDetails(playerList : NSMutableArray) {
        for i in 0...(playerList.count-1) {
            let playerName = playerList[i]["player_name"]
            let imgUrl = playerList[i]["player_img_url"]
            let role = playerList[i]["player_role"]
            let batStyle = playerList[i]["player_batting_style"]
            let bowlStyle = playerList[i]["player_bowling_style"]
            let nationality = playerList[i]["player_nationality"]
            let dob = playerList[i]["player_dob"]
            let destFolder = playerList[i]["destination_folder_name"]
            let sqlQuery = "INSERT INTO PLAYERLISTNEW (PLAYERNAME,IMGURL,ROLE,BATSTYLE,BOWLSTYLE,NATIONALITY,DOB,DESTINATIONFOLDER) VALUES ('\(playerName)','\(imgUrl)','\(role)','\(batStyle)','\(bowlStyle)','\(nationality)','\(dob)','\(destFolder)')"
            
            let DB = FMDatabase(path: DBPath)
            if DB.open() {
                print("Player : database opened for inserting")
                if DB.executeUpdate(sqlQuery, withArgumentsInArray: nil) {
                    print("Player : data inserted into table")
                }
                else {
                    print("Player : failed to insert data: '\(DB.lastError())'")
                }
            }
            DB.close()
        }
    }
   
    //Method to fetch team details
    func mFetchTeamDetails(pControllerUpdater : ControllerUpdaterProtocol) ->NSMutableArray {
        let DB = FMDatabase(path: DBPath)
        var teamList = NSMutableArray()
        if(DB.open()){
            print("Reading team list details")
            let sqlQuery = "SELECT * FROM TEAMTABLE"
            let result = DB.executeQuery(sqlQuery, withArgumentsInArray: nil)
            //(TEAMNAME,IMGURL,COACH,CAPTIAN,HOMEVENU,OWNER,DESTINATIONFOLDER)
            while result.next() {
                var team = [String : String]()
                team = [
                    "team_name" : result.stringForColumn("TEAMNAME"),
                    "team_img_url" : result.stringForColumn("IMGURL"),
                    "team_coach" : result.stringForColumn("COACH"),
                    "team_captain" : result.stringForColumn("CAPTIAN"),
                    "team_home_venue" : result.stringForColumn("HOMEVENU"),
                    "team_owner" : result.stringForColumn("OWNER"),
                    "destination_folder_name" : result.stringForColumn("DESTINATIONFOLDER")
                ]
                teamList.addObject(team)
            }
            pControllerUpdater.updatePlayerList(teamList)
         DB.close()
        }
        else{
            print("Failed to open database")
        }
        return teamList
    }
    
    //Method to fetch player details
    func mFetchPlayerDetails(pControllerUpdater : ControllerUpdaterProtocol
        ) -> NSMutableArray{
        let DB = FMDatabase(path: DBPath)
        var playerList = NSMutableArray()
        if(DB.open()){
            print("Reading team list details")
            let sqlQuery = "SELECT * FROM PLAYERTABLE"
            let result = DB.executeQuery(sqlQuery, withArgumentsInArray: nil)
           //(ID INTEGER PRIMARY KEY AUTOINCREMENT,PLAYERNAME TEXT,IMGURL TEXT,ROLE TEXT,BATSTYLE TEXT,BOWLSTYLE TEXT,NATIONALITY TEXT,DOB TEXT,DESTINATIONFOLDER TEXT)
            while result.next() {
                var player = [String : String]()
                player = [
                    "player_name" : result.stringForColumn("PLAYERNAME"),
                    "player_img_url" : result.stringForColumn("IMGURL"),
                    "player_role" : result.stringForColumn("ROLE"),
                    "player_batting_style" : result.stringForColumn("BATSTYLE"),
                    "player_bowling_style" : result.stringForColumn("BOWLSTYLE"),
                    "player_nationality" : result.stringForColumn("NATIONALITY"),
                    "player_dob" : result.stringForColumn("DOB"),
                    "destination_folder_name" : result.stringForColumn("DESTINATIONFOLDER")
                ]
                playerList.addObject(player)
            }
            pControllerUpdater.updatePlayerList(playerList)
            DB.close()
        }
        else{
            print("Failed to open database")
        }
        return playerList
    }
    
}//end of class



