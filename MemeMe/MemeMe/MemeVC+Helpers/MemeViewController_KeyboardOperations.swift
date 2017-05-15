//
//  MemeViewController_KeyboardOperations.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/16/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

extension MemeViewController {
    
    func subscribetToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromnotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Keyboard Notification handlers
    
    func keyboardWillShow(_ notification : Notification) {
        if view.frame.origin.y >= 0 {
            view.frame.origin.y -= getVerticalOffset(notification)
        }
    }
    
    func keyboardWillHide(_ notification : Notification) {
        if view.frame.origin.y < 0 {
            view.frame.origin.y += getVerticalOffset(notification)
        }
    }
    
    // MARK: Helper Methods
    
    // get offset to display the shadowed textfield over the keyboard
    func getVerticalOffset(_ notification : Notification) -> CGFloat {
        let keyboardHeight = getKeyboardHeight(notification)
        if let activeField = activeTexteField() {
            let textFieldBaseHeight = view.bounds.height - (activeField.frame.origin.y + activeField.frame.size.height)
            
            if textFieldBaseHeight < keyboardHeight {
                return keyboardHeight - textFieldBaseHeight
            }
        }
        return 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
