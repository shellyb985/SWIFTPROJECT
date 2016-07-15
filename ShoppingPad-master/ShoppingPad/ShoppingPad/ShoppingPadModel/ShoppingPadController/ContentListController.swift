		//
//  ContentListController.swift
//  ShoppingPad
//  
//  Purpose:
//  1)This is the data controller in MVVM design pattern
//  2)Provides interface of view model to interact with controller. Abstracting Dataase layer , service layer and model layer.
//  3)Interacts with local DB to save contentList Data
//  4)Interacts with rest service handler to get cloud data
//  5)Encapsulating ContentInfo
//
//  Binds to contentListViewModel , DBHandler & RESTHandler. Used to perform Rest services arranging DBHandler Logic & manage contentListViewModel from local databasemodel 
//  Referrence - ViewModel & Model
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

struct ContentInfo
{
    //declaration of content information
    var mContentID : Int?
    var mConrollerContentTitle : String?
    var mControllerContentImagePath : String?
    var mControllerContentLink : String?
    var mModelContentType : String?
    var mModelContentCreatedTime : String?
    var mModelContentDescription : String?
    var mModelContentModifiedAt : String?
    var mModelContentSyncDateTime : String?
    var mModelContentTitleName : String?
    var mModelContentURL : String?
    var mModelContentZipPath : String?
}

struct ContentView
{
    //declaration of Content view realated variable
    var mContentID : Int?
    var mControllerContentAction : String?
    var mControllerContentLastSeen : String?
    var mControllerContentTotalViews : Int?
    var mControllerContentTotalParticipants : Int?
    var mControllerDisplayProfile : String?
    var mControllerEmailID : String?
    var mControllerFirstName : String?
    var mControllerLastName : String?
    var mControllerLastViewdDateTime : String?
    var mControllerUserAdminID : Int?
    var mControllerUserContentID : Int?
    var mControllerUserID : Int?

}

class ContentListController : PContentListListener
{
    // create object of REST Service handler
    var mRestServiceHandlerOfContentList : RestServiceHandler?
    
    // create object of content DBHandler
    var mContentListDBHandlerObj : ContentListDBHandler?
    
    // protocol of view model
    var mContentViewModelListener : PContentListInformerToViewModel?
    
    // create an empty array to store content info data
    var mControllerContentInfoArray = [ContentInfo]()
    
    // create an empty arrat to store content view details data
    var mControllerContentViewsDetailsArray = [ContentView]()
    
    
    init(contentViewModelListener : PContentListInformerToViewModel)
    {
        // Test variable to show the status of the class to the compiler
        let mUnitTestVariale = false
        
        // call the constructor of REST handler
        mRestServiceHandlerOfContentList = RestServiceHandler()
        
        // call the constructor of model
         mContentListDBHandlerObj = ContentListDBHandler()
        
        if (mUnitTestVariale)
        {
            // call ContentInfo data
            self.setDummyContentInfoController()
        
            // call ContentViewData method
            self.setDummyContentViewDetails()
        }
        else
        {
            
            // set ContentViewModelListner protocols object
            mContentViewModelListener = contentViewModelListener
        }
    }
    
    
    // set dummy contentInfo
    func setDummyContentInfoController ()
    {
        let controllerSetContentInfoObj1 = ContentInfo(mContentID: 1, mConrollerContentTitle: "ball", mControllerContentImagePath: "http", mControllerContentLink: "http//", mModelContentType: "image", mModelContentCreatedTime: "9.34 pm", mModelContentDescription: "red color", mModelContentModifiedAt: "7.29 pm", mModelContentSyncDateTime: "4.34 pm ", mModelContentTitleName: "bat", mModelContentURL: "http : // ", mModelContentZipPath: "www.")
        mControllerContentInfoArray.append(controllerSetContentInfoObj1)
    
    }
    
    // set dummy contentViewDetails
    func setDummyContentViewDetails ()
    {
        // set first dummy object
        let controllerSetContentViewDetailsObj1 = ContentView(mContentID: 1, mControllerContentAction: "opened", mControllerContentLastSeen: "3.25 pm", mControllerContentTotalViews: 45, mControllerContentTotalParticipants: 78, mControllerDisplayProfile: "display_name", mControllerEmailID: "riya@gmail.com", mControllerFirstName: "Riya", mControllerLastName: "Shastri", mControllerLastViewdDateTime: "5.45 pm", mControllerUserAdminID: 1, mControllerUserContentID: 0, mControllerUserID: 4)
        
        // add first dummy object
        mControllerContentViewsDetailsArray.append(controllerSetContentViewDetailsObj1)
    
    }
    
    
    //  populate model & get model object from controller
    func PopulateContentInfoData()
    {
        // check if internet connection is availiable or not
        if Utility().isConnectedToNetwork() == true
        {
            print("Internet connection OK")
            
            // populate data in the rest
            mRestServiceHandlerOfContentList!.populateContenInfoDta(self)
            
        } else
        {
            print("Internet connection FAILED")
            
            // populate data from local database
            self.updateContentInfoDataFRomLocalDB()
            
        }

    }

    
    // populate controllers data
    func populateContentInfoData(contentInfoJSONArray : NSMutableArray)
    {
        // set & get content info list model object
        for count in contentInfoJSONArray
        {
           let DictObj =  ContentInfoDataListModel(JSONContentInfoElement: count as! NSDictionary)
            
            // set contentList controller's attributes
            let tempObj = ContentInfo(mContentID: DictObj.mModelContentID, mConrollerContentTitle: DictObj.mModelContentTitle, mControllerContentImagePath: DictObj.mModelContentImagePath, mControllerContentLink: DictObj.mModelContentLink, mModelContentType: DictObj.mModelContentType, mModelContentCreatedTime: DictObj.mModelContentCreatedTime, mModelContentDescription: DictObj.mModelContentDescription, mModelContentModifiedAt: DictObj.mModelContentModifiedAt, mModelContentSyncDateTime: DictObj.mModelContentSyncDateTime, mModelContentTitleName: DictObj.mModelContentTitleName, mModelContentURL: DictObj.mModelContentURL, mModelContentZipPath: DictObj.mModelContentZipPath)
            
            
            let utilityObj = Utility()
            if (utilityObj.isConnectedToNetwork() == true )
            {
                // download the image from server
                let utilityObj = Utility()
            
                // call download image from utility
                utilityObj.downloadImage(tempObj)
            }
            
            mControllerContentInfoArray.append(tempObj)
        }
    }
    
    
    func saveDataInDB(contentInfoObj :ContentInfo , imagePath : String)
    {
        // save the Content Info data in database
        mContentListDBHandlerObj!.saveContentListInfoData(contentInfoObj.mContentID!, contentTitle: contentInfoObj.mConrollerContentTitle!, contentImagePath: imagePath , contentLink: contentInfoObj.mControllerContentLink!, contentType: contentInfoObj.mModelContentType!, contentCreatedTime: contentInfoObj.mModelContentCreatedTime!, contentDescription: contentInfoObj.mModelContentDescription!, contentModifiedAt: contentInfoObj.mModelContentModifiedAt!, contentSyncDateTime: contentInfoObj.mModelContentSyncDateTime!, contentTitleName: contentInfoObj.mModelContentTitleName!, contentURL: contentInfoObj.mModelContentURL!, contentZipPath: contentInfoObj.mModelContentZipPath!)

    }
    
    //  populate model & get model object from controller
    func populateContentListDetails ()
    {
        // make rest call for content view details from json
        mRestServiceHandlerOfContentList!.populateViewDetailsData(self)

    }
    
    //  populate model & get model object from controller
    func populateContentListDetails (contentListViewJsonArray : NSMutableArray)
    {
        // set & get content list view details data model object
        for count in contentListViewJsonArray
        {
            let DictObj = ContentViewListDataModel(JSONContentViewElement: count as! NSDictionary)
            
            // set contentList view controller's attributes
            let tempObj = ContentView(mContentID: DictObj.mModelContentID, mControllerContentAction: DictObj.mModelContentAction, mControllerContentLastSeen: DictObj.mModelContentLastSeen, mControllerContentTotalViews: DictObj.mModelContentTotalViews, mControllerContentTotalParticipants: DictObj.mModelContentTotalParticipants, mControllerDisplayProfile: DictObj.mModelDisplayProfile, mControllerEmailID: DictObj.mModelDisplayProfile, mControllerFirstName: DictObj.mModelFirstName, mControllerLastName: DictObj.mModelLastName, mControllerLastViewdDateTime: DictObj.mModelLastViewdDateTime, mControllerUserAdminID: DictObj.mModelUserAdminID, mControllerUserContentID: DictObj.mModelUserContentID, mControllerUserID: DictObj.mModelUserID)
            
            
            
            // save the Content Info data in database
            mContentListDBHandlerObj!.saveContentListViewData(tempObj.mContentID!, contentAction: tempObj.mControllerContentAction!, contentLastSenn: tempObj.mControllerContentLastSeen!, contentTotalViews: tempObj.mControllerContentTotalViews!, contentTotalParticipants: tempObj.mControllerContentTotalParticipants!, displayProfile: tempObj.mControllerDisplayProfile!, emailId: tempObj.mControllerEmailID!, firstName: tempObj.mControllerFirstName!, lastName: tempObj.mControllerLastName!, lastViewDateTime: tempObj.mControllerLastViewdDateTime!, userAdminID: tempObj.mControllerUserAdminID!, userContentID: tempObj.mControllerUserContentID!, userID: tempObj.mControllerUserID!)
            
            // append this contentListInfo array
            mControllerContentViewsDetailsArray.append(tempObj)
        }
    }
    
    // return contentInfo array & contentView array
    func getContentDataArrays (userID : Int) -> (ContentInfoArray : [ContentInfo] , ContentViewArray : [ContentView])
    {
        return (mControllerContentInfoArray , mControllerContentViewsDetailsArray)
    }
    

   
   // implement protocol methods (callback)
    func updateControllerListModel(JsonContentInfo : NSMutableArray)
    {
        // populate content info method
        self.populateContentInfoData(JsonContentInfo)
        mContentViewModelListener!.updateViewModelContentListInformer()
    }
    
    // implement protocol method (call back)
    func updateControllerViewModel(JsonContentView : NSMutableArray)
    {
        // populate content view details method
        self.populateContentListDetails(JsonContentView)
        mContentViewModelListener!.updateViewModelContentListInformer()
    }
    
    // update data from local db when user is in offline mode
    func updateContentInfoDataFRomLocalDB()
    {
        // get content info list data from local database
        mContentListDBHandlerObj!.getContentListInfoDataFromDB(self)
        
        // get content view data from local database
        mContentListDBHandlerObj!.getContentViewDataFromDB(self)
        
    }
}
