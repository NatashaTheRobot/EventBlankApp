//
//  ViewController+Extensions.swift
//  EventBlank
//
//  Created by Marin Todorov on 7/18/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit
import Social

extension UIViewController {

    static func alert(message: String, buttons: [String] = ["OK"], completion: ((Int)->Void)?) -> UIAlertController {
        return (UIApplication.sharedApplication().windows.first as! UIWindow).rootViewController!.alert(message, buttons: buttons, completion: completion)
    }
    
    func alert(message: String, buttons: [String] = ["OK"], completion: ((Int)->Void)?) -> UIAlertController {
        
        let alertVC = UIAlertController(title: "",
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        for i in 0..<buttons.count {
            let btnAction = UIAlertAction(title: buttons[i], style: UIAlertActionStyle.Default, handler: {_ in
                completion?(i)
            })
            alertVC.addAction(btnAction)
        }
        
        presentViewController(alertVC, animated: true, completion: nil)
        
        return alertVC
    }

    func tweet(message: String, image: UIImage? = nil, urlString: String? = nil, completion: ((Bool)->Void)?) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            println("twitter available")
            
            let composer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            composer.setInitialText(message)
            
            if let image = image {
                composer.addImage(image)
            }
            
            if let urlString = urlString, let url = NSURL(string: urlString) {
                composer.addURL(url)
            }
            
            composer.completionHandler = {result in
                composer.dismissViewControllerAnimated(true, completion: nil)
                completion?(result == SLComposeViewControllerResult.Done)
            }
            
            presentViewController(composer, animated: false, completion: nil)
        }

    }
}
