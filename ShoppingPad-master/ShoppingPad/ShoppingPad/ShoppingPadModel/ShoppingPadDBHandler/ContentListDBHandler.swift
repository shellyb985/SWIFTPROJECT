//
//  ContentListDBHandler.swift
//  ShoppingPad
//
//  Purpose:
//  1)This is DBHandler of MVVM design pattern
//  Manages all the data needed for the contentList class in Local DB
//  Refference - Controller
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class ContentListDBHandler {
    
    var mDatabasePath : String
    
    // create database
    init()
    {
        

        // create default database path
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as NSString
        mDatabasePath = docsDir.stringByAppendingPathComponent(
            "ContentDB.sqlite")
        
        // if database path not exist create new database
        if !filemgr.fileExistsAtPath(mDatabasePath as String)
        {
            // create database
            let DB = FMDatabase(path: mDatabasePath as String)
            print("path ", DB)
            
            // if some error occurs pront error message
            if DB == nil
            {
                print("Error: \(DB.lastErrorMessage())")
                
            }
        }
    }
    
    // save the data into the database
    func saveData(createTableQuery : String , insertContentInfoQuery : String)
    {
        let contentDB = FMDatabase(path : mDatabasePath as String)
        print("database Path" , mDatabasePath)
        
        // Check whether database is open or not
        if contentDB.open()
        {
            // execute create table query
            let result = contentDB.executeUpdate(createTableQuery, withArgumentsInArray: nil)
            
            // check whether query executed succesfully or not
            if !result
            {
                print("Error: \(contentDB.lastErrorMessage())")
            }
            
            // insert query
            let insertContentQuery = insertContentInfoQuery
            
            let resultContent = contentDB.executeUpdate(insertContentQuery, withArgumentsInArray: nil)
            
            // check whether query executed succesfully or not
            if !resultContent
            {
                print("Error: \(contentDB.lastErrorMessage())")
            }
                
            else
            {
               print("executed insert")
                
            }
        
        }
            
        
        else
        {
            print("Error: \(contentDB.lastErrorMessage())")
        }
        
    }
    
    // save contentList info data in the table 
    func saveContentListInfoData(contentID : Int , contentTitle : String , contentImagePath : String , contentLink : String , contentType : String , contentCreatedTime : String , contentDescription : String , contentModifiedAt : String ,contentSyncDateTime : String , contentTitleName : String , contentURL : String , contentZipPath : String)
    {
        // write a query to check whether table exist or not and if not then create a table
        let createTableQuery : String = "CREATE TABLE IF NOT EXISTS CONTENTLISTINFO (content_id INTEGER PRIMARY KEY , display_name TEXT, imagesLink TEXT , contentLink TEXT , contentType TEXT , created_at TEXT , decription TEXT , modified_at TEXT , syncDateTime TEXT , title TEXT , url TEXT , zip TEXT)"
        
        // write a query to insert content info data in database
        let insertDataQuery : String = "INSERT INTO CONTENTLISTINFO (content_id ,display_name,imagesLink , contentLink ,  contentType , created_at , decription , modified_at , syncDateTime , title , url , zip) VALUES('\(contentID)','\((contentTitle))','\((contentImagePath))' , '\((contentLink))' , '\((contentType))' , '\((contentCreatedTime))' , '\((contentDescription))' , '\((contentModifiedAt))' , '\((contentSyncDateTime))' , '\((contentTitleName))' , '\((contentURL))' , '\((contentZipPath))')"
        
        // save the database in local database
        self.saveData(createTableQuery, insertContentInfoQuery: insertDataQuery)
        

    }
    
    func saveContentListViewData(contentID : Int , contentAction : String , contentLastSenn : String , contentTotalViews : Int , contentTotalParticipants : Int , displayProfile : String , emailId : String , firstName : String , lastName : String , lastViewDateTime : String , userAdminID : Int , userContentID : Int , userID : Int)
    {
        
        // write a query to create a table
        let createTableQuery : String = "CREATE TABLE IF NOT EXISTS CONTENTLISTVIEWS (contentId INTEGER PRIMARY KEY , action TEXT, lastViewedDateTime TEXT , numberOfViews INTEGER , numberofparticipant INTEGER , displayProfile TEXT , email TEXT , firstName TEXT , lastName TEXT  , userAdminId INTEGER , userContentId INTEGER , userId INTEGER)"
        
        // write a query to insert content info data in database
        let insertDataQuery : String = "INSERT INTO CONTENTLISTVIEWS (contentId ,action ,lastViewedDateTime, numberOfViews ,numberofparticipant , displayProfile , email , firstName , lastName  , userAdminId , userContentId , userId ) VALUES(\(contentID),'\((contentAction))','\((contentLastSenn))' , \(contentTotalViews) , \(contentTotalParticipants) , '\((displayProfile))' , '\((emailId))' , '\((firstName))' , '\((lastName))'  , \(userAdminID) , \(userContentID) , \(userID))"
        
        // save the data in local database
        self.saveData(createTableQuery, insertContentInfoQuery: insertDataQuery)
    }
    
    
    // get content info data from local database
    func getContentListInfoDataFromDB(pContentListListenerObj : PContentListListener)
    {
        let contentInfoArray = NSMutableArray()
        print("IN LOCALDB VIEW")
        
        let contentDB = FMDatabase(path : mDatabasePath as String)
        print(mDatabasePath)
        
        if contentDB == nil
        {
            print("Error: \(contentDB.lastErrorMessage())")
        }
        
        if contentDB.open()
        {
            // select query
            let getContentView = "SELECT * FROM CONTENTLISTINFO "
            
            // define resultset
            let contentView = contentDB.executeQuery(getContentView, withArgumentsInArray: nil)
           
            // seperate value form resultset
            while(contentView.next() == true)
            {
                print("Some data macth in VIew")
                
                // conver to NsDictionary and add to Array
                contentInfoArray.addObject(contentView.resultDictionary())
                print("contentViewArray in DB ", contentInfoArray)
                
            }
            
            contentDB.close()
        }
            
        else
        {
            print("Error: \(contentDB.lastErrorMessage())")
        }
        
        pContentListListenerObj.updateControllerListModel(contentInfoArray)
    }
    
    // get content list from database
    func getContentViewDataFromDB(pContentListListenerObj : PContentListListener)
    {
        let contentViewArray = NSMutableArray()
        print("IN LOCALDB VIEW")
            
        let contentDB = FMDatabase(path : mDatabasePath as String)
       
        if contentDB == nil
        {
            print("Error: \(contentDB.lastErrorMessage())")
        }
            
        if contentDB.open()
        {
            
            // select query
            let getContentView = "SELECT * FROM CONTENTLISTVIEWS "
            
            // define resultset
            let contentView = contentDB.executeQuery(getContentView, withArgumentsInArray: nil)
            
            // seperate value form resultset
            while(contentView.next() == true)
            {
                print("Some data macth in VIew")
                
                // conver to NsDictionary and add to Array
                contentViewArray.addObject(contentView.resultDictionary())
                print("contentViewArray in DB ", contentViewArray)
                
            }

            contentDB.close()
        }
                
        else
        {
            print("Error: \(contentDB.lastErrorMessage())")
        }
        
        // pass content view data to the controller
        pContentListListenerObj.updateControllerViewModel(contentViewArray)
    }
    
}