//
//  ViewController.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/3/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoAlbumButtom: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
//        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialSetup()
    }
    @IBAction func showImagePicker(_ sender: Any) {
        if !presentPicker(.photoLibrary){
            // photo album may be empty. Hence, disable it's option
            photoAlbumButtom.isEnabled = false
        }
    }
    
    @IBAction func displayCamera(_ sender: Any) {
        if !presentPicker(.camera) {
            // camera is not available. Hence, disable it's option
            cameraButton.isEnabled = false
        }
    }
    
    func presentPicker(_ withSource : UIImagePickerControllerSourceType) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(withSource) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = withSource
            present(picker, animated: true, completion: nil)
            return true
        }
        return false
    }
    
    func initialSetup() {
        let albumAvailable = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        let cameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        if !albumAvailable && !cameraAvailable {
            let alert = UIAlertController(title: "No Image Source", message: "No Image Source Available. App will exit now", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                exit(0)
            }))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        photoAlbumButtom.isEnabled = albumAvailable
        cameraButton.isEnabled = cameraAvailable
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] {
            memeImageView.image = (image as! UIImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

