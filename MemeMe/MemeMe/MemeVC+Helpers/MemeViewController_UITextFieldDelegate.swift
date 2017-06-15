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

let kTopTFTag = 100
let kBottomTFTag = 200


extension MemeViewController : UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate Implementation
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = textField.tag == kTopTFTag && !hasValidBottomQuote() ? .next : .done
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == kTopTFTag, !hasValidBottomQuote() {
            bottomTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        valideteShareButton()
        if textField.text == "" {
            textField.text = textField.tag == kTopTFTag ? kTopFieldText : kBottomFieldText
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
    
    func hasValidTopQuote() -> Bool {
        return topTextField.text != kTopFieldText && topTextField.text != ""
    }
    
    func hasValidBottomQuote() -> Bool {
        return bottomTextField.text != kBottomFieldText && bottomTextField.text != ""
    }
    
    func setup(_ textField : UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }

}
