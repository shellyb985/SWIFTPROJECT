//
//  ContentListViewModel.swift
//  ShoppingPad
//
//  Purpose :
//  Extract the data needed for the ContentListUI from the local database via Controller class.
//  Referrence - Contrller Class
//  1)This class is viewModel of MVVM design pattern
//  2)It holds the model for the the contentListView
//  3)This class has the ContentListControllerObject to retrieve the necessary models
//  4)This class has attributes like content image , content title ,last view date time etc
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//


// import third party frame work for binding the data
import ReactiveKit
import ReactiveUIKit

struct ContentViewModel
{
    var mContentImagePath : Observable <String> //image icon
    var mContentTitle : Observable <String>     //content title
    var mLastViewTime : Observable <String>     //last seen time
    var mActionPerformed : Observable <String>  //Action performed by the user
    var mTotalViews : Observable <String>          //Total number of views
    var mTotalParticipants : Observable <String>   //Total number of participants
    var mContentID : Observable <Int>
}

class ContentListViewModel : PContentListInformerToViewModel {
    
    // Object of ContentListViewController
    var mConteListControllerObj : ContentListViewController?
    
    // list of contentModels
    var mListOfContents = [ContentViewModel]()
    
    // UnitTest Variable
    var mTestVariable : Bool? = false
    
    //object of ContentListController
    var mContentListControllerObject : ContentListController?
    
    // object of ContentList observer protocol
    var mContentListViewObserver : ContentListViewObserver?
    
    // declare bool variable for insuring two asynch threads populate data controller
    var mCheckBool : Bool = true
    
    init(contentListViewObserver : ContentListViewObserver)
    {
            //check whether project is running in test mode or not
            if (mTestVariable == true)
            {
                print("populate dummy data")
                
                //call populateData method
                self.populateDummyData()
            }
            else {
                mContentListViewObserver = contentListViewObserver
                // init controller object
                mContentListControllerObject = ContentListController(contentViewModelListener: self)
            }
    }
    
    
    //Populate contentInfoList with Data from controller
    func populateContentListData()
    {
        // populate content info data method from controller
        mContentListControllerObject!.PopulateContentInfoData()
        
        // populate content view data from controller
        mContentListControllerObject!.populateContentListDetails()
        
    }
    
    func populateContentListFromController()
    {
        // get all content data from controller
        let contentArray = mContentListControllerObject!.getContentDataArrays(0)
        
        // retrieve contentInfoArray from ContentArray (object)
        var contentInfoArray = contentArray.ContentInfoArray
        
        // retrieve contentViewArray from ContentArray (object)
        var contentViewArray = contentArray.ContentViewArray
        
        // for loop checking giving contentID of contentInfo array
        // where i stands for the index of contentInfoArray
        for var i = 0 ; i <  contentInfoArray.count; ++i
            {
                //for loop giving function of contentViewArray
                for var j = 0 ; j < contentViewArray.count ; ++j
                {
                    // matching Content ID of contentInfoObject & contentViewObject
                    if (contentInfoArray[i].mContentID == contentViewArray[j].mContentID )
                    {
                        // set object of viewModel with the contentInfo & contentView values
                        let setObj = ContentViewModel(mContentImagePath: Observable( contentInfoArray[i].mControllerContentImagePath!), mContentTitle:Observable (contentInfoArray[i].mConrollerContentTitle!), mLastViewTime: Observable(contentViewArray[j].mControllerContentLastSeen!), mActionPerformed: Observable(contentViewArray[j].mControllerContentAction!), mTotalViews: Observable(String(contentViewArray[j].mControllerContentTotalViews!)+"  views"), mTotalParticipants: Observable (String(contentViewArray[j].mControllerContentTotalParticipants!)+" participants"),mContentID: Observable(contentInfoArray[i].mContentID!))
                        
                        // append setObj in the listOfContents array
                        mListOfContents.append(setObj)
                        
                        print(setObj.mContentImagePath)
                        
                    }
                }
            }
    }
    
    // populate dummy data when compiler is in unittestMode
    func populateDummyData()
    {
        // set a temp object to store ContentListObject attributes
        let setObj = ContentViewModel(mContentImagePath:Observable ("imagePath.jpeg"), mContentTitle: Observable("Bat"), mLastViewTime: Observable ("9.23 pm"), mActionPerformed: Observable("opened"), mTotalViews: Observable("23"), mTotalParticipants:Observable("67") , mContentID: Observable(1))
        
        //Add the contentList object to  mListOfContents array
        mListOfContents.append(setObj)
        print(mListOfContents)
    }
    
    // return the object to the view class
    func getContentInfo (position : Int) -> ContentViewModel
    {
        print(mContentListControllerObject)
        return mListOfContents [position]
    }
    
    // return the total count of list of total contents
    func getContentInfoCount() -> Int
    {
        return mListOfContents.count
    }
    
    // call back content list view
    func updateViewModelContentListInformer()
    {
        if (mCheckBool == false)
        {
            self.populateContentListFromController()
        
            // update observer pattern
            mContentListViewObserver!.updateContentListViewModel()
        }
        
        mCheckBool = false
    }

}


    
    


    
   





