//
//  MemeViewController_UITextFieldDelegate.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/16/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

let kTopFieldText = "TOP"
let kBottomFieldText = "BOTTOM"


extension MemeViewController : UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate Implementation
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        valideteShareButton()
        if textField.text == "" {
            textField.text = textField == topTextField ? kTopFieldText : kBottomFieldText
        }
    }
    
    // MARK: Helper Methods
    
    func activeTexteField() -> UITextField? {
        if topTextField.isFirstResponder {
            return topTextField
        }
        if bottomTextField.isFirstResponder {
            return bottomTextField
        }
        return nil
    }
}
