//
//  MemeViewController_Logic.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/15/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

struct Meme {
    let topQuote : String
    let bottomQuote : String
    let originalImage : UIImage
    let memedImage : UIImage
}

extension MemeViewController {
    
    // MARK: Meme VC Helper Methods
    
    func validateSources() {
        photoAlbumButtom.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if !photoAlbumButtom.isEnabled && !cameraButton.isEnabled {
            shouldExitApp = true
        }
    }
    
    func valideteShareButton() {
        if memeImageView.image != nil,
            (topTextField.text != kTopFieldText && topTextField.text != ""),
            (bottomTextField.text != kBottomFieldText && bottomTextField.text != "") {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
    }
    
    
    func setup(_ textField : UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    func hideToolBars(_ shouldHide : Bool) {
        bottomToolbar.isHidden = shouldHide
        navBar.isHidden = shouldHide
    }

    func generateMemedimage() -> UIImage {
        hideToolBars(true)
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideToolBars(false)
        return memedImage
    }

    func shareMeme(withImage : UIImage) {
        
        let activityVC = UIActivityViewController(activityItems: [withImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityType, completed, returnedItems:[Any]?, error: Error?) in
            if (!completed) {
                let errorMessage = error != nil ? error!.localizedDescription : Alerts.ShareFailedmessage
                UIAlertController.showAlert(Alerts.ShareFailed, message: errorMessage, view: self, handler: nil)
                return
            }
            self.save(withImage)
            self.dismiss(animated: true, completion: nil)
        }
        present(activityVC, animated: true, completion: nil)
    }
    
    func save(_ memeImage : UIImage) {
        let meme = Meme(topQuote: topTextField.text!, bottomQuote: bottomTextField.text!, originalImage: memeImageView.image!, memedImage: memeImage)
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
}

