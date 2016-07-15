//
//  ContentListModel.swift
//  ShoppingPad
//
//  Purpose :
//  1)This is  ContentListModel of MVVM design pattern
//  Model contains contentList  data which is downloaded from backend
//  Referrence - Controller class
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

// Declare Content info list data model
class ContentInfoDataListModel
{
    var mModelContentID = Int()
    var mModelContentTitle = String()
    var mModelContentImagePath = String()
    var mModelContentLink = String()
    var mModelContentType = String()
    var mModelContentCreatedTime = String()
    var mModelContentDescription = String()
    var mModelContentModifiedAt = String()
    var mModelContentSyncDateTime = String()
    var mModelContentTitleName = String()
    var mModelContentURL = String()
    var mModelContentZipPath = String()
    
    // populate content list info data model from json dictionary
    init(JSONContentInfoElement : NSDictionary)
    {
        // set content list info model
        mModelContentID = Int(JSONContentInfoElement.objectForKey("content_id") as! NSNumber)
        mModelContentImagePath = (JSONContentInfoElement.objectForKey("imagesLink")! as! String)
        mModelContentTitle = (JSONContentInfoElement.objectForKey("display_name")! as! String)
        mModelContentLink = (JSONContentInfoElement.objectForKey("zip")! as! String)
        mModelContentType = (JSONContentInfoElement.objectForKey("contentType") as! String)
        mModelContentCreatedTime = (JSONContentInfoElement.objectForKey("created_at") as! String)
        mModelContentDescription = (JSONContentInfoElement.objectForKey("decription") as! String)
        mModelContentModifiedAt = (JSONContentInfoElement.objectForKey("modified_at") as! String)
        mModelContentSyncDateTime = (JSONContentInfoElement.objectForKey("syncDateTime") as! String)
        mModelContentTitleName = "Default Title"
        //mModelContentTitleName = (JSONContentInfoElement.objectForKey("title") as! String)
        mModelContentURL = (JSONContentInfoElement.objectForKey("url") as! String)
        mModelContentZipPath = (JSONContentInfoElement.objectForKey("zip") as! String)
    }
}

// Declare content list view details data model
class ContentViewListDataModel
{
    // declare all content list view model attributes
    var mModelContentID = Int()
    var mModelContentAction = String()
    var mModelContentLastSeen = String()
    var mModelContentTotalViews = Int()
    var mModelContentTotalParticipants = Int()
    var mModelDisplayProfile = String()
    var mModelEmailID = String()
    var mModelFirstName = String()
    var mModelLastName = String()
    var mModelLastViewdDateTime = String()
    var mModelUserAdminID = Int()
    var mModelUserContentID = Int()
    var mModelUserID = Int()
    // set all the contentInfo Model Data
    init(JSONContentViewElement : NSDictionary)
    {
        // set contents view details data model
        mModelContentID = Int(JSONContentViewElement.objectForKey("contentId") as! NSNumber)
        mModelContentAction = JSONContentViewElement.objectForKey("action") as! String
        mModelContentLastSeen = JSONContentViewElement.objectForKey("lastViewedDateTime") as! String
        mModelContentTotalParticipants = Int(JSONContentViewElement.objectForKey("numberOfViews") as! NSNumber)
        mModelContentTotalViews = Int(JSONContentViewElement.objectForKey("numberofparticipant") as! NSNumber)
        mModelDisplayProfile = JSONContentViewElement.objectForKey("displayProfile") as! String
        mModelEmailID = JSONContentViewElement.objectForKey("email") as! String
        mModelFirstName = JSONContentViewElement.objectForKey("firstName") as! String
        mModelLastName = JSONContentViewElement.objectForKey("lastName") as! String
        mModelLastViewdDateTime = JSONContentViewElement.objectForKey("lastViewedDateTime") as! String
        mModelUserAdminID = Int(JSONContentViewElement.objectForKey("userAdminId") as! NSNumber)
        mModelUserContentID = Int(JSONContentViewElement.objectForKey("userContentId") as! NSNumber)
        mModelUserID = Int(JSONContentViewElement.objectForKey("userId") as! NSNumber)

        
    }
}

