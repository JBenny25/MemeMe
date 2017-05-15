//
//  UIAlertController_Custom.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/9/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

struct Alerts {
    // Title
    static let NoSource = "No Image Source"
    static let NoCamera = "Camera Unavailable"
    static let NoAlbum  = "Photo Album Unavailable"
    static let ShareFailed = "Share Failed"
    
    // Message
    static let NoSourceMessage = "No Image Source Available. App will exit now."
    static let NoCameraMessage = "Unable to access Camera. Disabling the option"
    static let NoAlbumMessage  = "Photo Album seems to be empty. Disbaling this option for now."
    static let ShareFailedmessage = "Meme sharing failed. Please try again."
    
    // Action
    static let DismissAction = "Dismiss"
}

extension UIAlertController {
    
    class func showAlert(_ title: String, message: String, view: UIViewController, handler :((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAction, style: .default, handler: handler))
        view.present(alert, animated: true, completion: nil)
    }
}
