//
//  Utility.swift
//  ShoppingPad
//
//  Purpose : 
//  Class contain functions of reusable codes
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import ReactiveKit
import ReactiveUIKit
import Alamofire
import SystemConfiguration




class Utility : UIViewController ,  MFMessageComposeViewControllerDelegate , PContentListInformerToViewModel

{
    
     var localPathOfImage : NSURL?
    
    var num : Bool = false
    // make imageView round
    func RoundImageView (imageView : UIImageView)
    {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.blackColor().CGColor
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        
    }
    
    
    // send text message from the mobile phone
    func sendTextMessage ()
    {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = ["8652210204"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
            print("message sent")
        }
            
        else
        {
            print("can not send message")
        }
  
    }
    
    // fetch image from server
    func fetchImage(url: NSURL) -> Operation<UIImage, NSError> {
        return Operation { observer in
            print(url)
            
            if (self.isConnectedToNetwork() == true)
            {
                // use almofire to deal with server request
                let request = Alamofire.request(.GET, url).response { request, response, data, error in
                    
                    // if error occurs then abort the operation
                    if let error = error {
                        observer.failure(error)
                    } else {
                        // if doesnt occurs error then convert imageData back to image
                        if(data != nil)
                        {
                            observer.next(UIImage(data : data!)!)
                            observer.success()
                        }
                    }
                }
            }
            else
            {
                // convertt url to
                var urlString : String? = String(url)
                
                // trim //file: characters in the new url
                let newImagePath = String(urlString!).stringByReplacingOccurrencesOfString("file:", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                // trim "-- ///" from image path
                let finalImagePath = String(newImagePath).stringByReplacingOccurrencesOfString( "-- ///", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                // get the imagename from the url
                // create a variable to store imageName with an empty name
                var trimmedImageName = String()
                
                // trim the imageName from imagePath
                if let trimmedNameExist = finalImagePath.componentsSeparatedByString("/").last
                {
                    
                    trimmedImageName = trimmedNameExist
                    print(trimmedImageName)
                }
                
                // get default iOS simulators path
                let filemgr = NSFileManager.defaultManager()
                var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                    .UserDomainMask, true)
                let docsDir = dirPaths[0] as NSString
                
                // append trimmedImagePath with actual file path to get current imagePath
                let imgPath1 = docsDir.stringByAppendingPathComponent(trimmedImageName)
                print("docsDir" , imgPath1)
                
                // trim white spaces from image path
                let trimmedString = imgPath1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                                
                // print final path of an image
                print("path validation" , filemgr.fileExistsAtPath(trimmedString))
                
                print("pathhhhhh" ,  trimmedString)
                // if imagePath exist then get image from the path
                if (filemgr.fileExistsAtPath(trimmedString) == true)
                {
                    print("PathImageSuccess" , trimmedString)
                    
                    observer.next(UIImage (contentsOfFile: trimmedString)!)
                    observer.success()
                }
                    
                    // if image path not exist then return default image
                else
                {
                    observer.next(UIImage (named: "defaultImage.jpg")!)
                    observer.success()
                }
                
            }
            // if response is nil then execute this block
            return BlockDisposable
            {
                //request.cancel()
            }
        }
        
    }
    
    // handle sms screen actions
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // check net connectivity
    func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        
        print("zeroAddress",zeroAddress)
        
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress)
        {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)
        {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    
    // This function dowload image in local path
    func downloadImage(contentInfoObj : ContentInfo)
    {
        // Trimm white Space
        let urlTrim = contentInfoObj.mControllerContentImagePath!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // trime white spaces from url string
        let urlStr : NSString = urlTrim.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        // convert url string to NSURL
        let url = NSURL(string:urlStr as String)
        
        //dowload Image To Local Path
        Alamofire.download(.GET, url!)
            {
                temporaryURL, response in
                
                print("c_ID" ,contentInfoObj.mContentID)
                // local path
                let fileManager = NSFileManager.defaultManager()
                
                print("localPathh" , self.localPathOfImage)
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                print("directoryURL component" , directoryURL)
                
                let pathComponent = String(contentInfoObj.mContentID!)
                
                self.localPathOfImage = directoryURL.URLByAppendingPathComponent(pathComponent)
                
                return directoryURL.URLByAppendingPathComponent(pathComponent)
                
            }.response { _, _, data , error in
                // set default image url
                if let error = error {
                    self.localPathOfImage = NSURL(string: "defaultImage.jpg")
                    
                    // send call back to the controller with local image link
                    ContentListController(contentViewModelListener: self).saveDataInDB(contentInfoObj, imagePath: String(self.localPathOfImage!))
                    
                } else
                {
                    // send call back to the controller with local image link
                    ContentListController(contentViewModelListener: self).saveDataInDB(contentInfoObj, imagePath: String(self.localPathOfImage!))
                }
        }    
    }
   
    // empty observer function used for fullfilling controller object creation
    func updateViewModelContentListInformer()
    {
     
    }
    
}


