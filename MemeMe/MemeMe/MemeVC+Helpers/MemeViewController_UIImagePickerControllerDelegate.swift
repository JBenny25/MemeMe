//
//  MemeViewController_UIImagePickerControllerDelegate.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/16/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

extension MemeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: UIImagePickerControllerDelegate Implementation
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] {
            memeImageView.image = (image as! UIImage)
            valideteShareButton()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Picker Selection
    
    func presentPicker(_ source : UIImagePickerControllerSourceType) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = source
            present(picker, animated: true, completion: nil)
            return true
        }
        return false
    }
}
