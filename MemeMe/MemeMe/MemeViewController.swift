//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/3/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoAlbumButtom: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: Helper Vars
    
    var shouldExitApp = false
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]


    // MARK: Application Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateSources()
        if !shouldExitApp {
            setup(topTextField)
            setup(bottomTextField)
            valideteShareButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribetToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromnotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldExitApp {
            UIAlertController.showAlert(Alerts.NoSource, message: Alerts.NoSourceMessage, view: self) {(UIAlertAction) in
                exit(0);
            }
        }
    }
    
    // MARK: IBActions
    
    @IBAction func showPhotoAlbum(_ sender: Any) {
        if !presentPicker(.photoLibrary){
            // photo album may be empty. Hence, disable it's option
            UIAlertController.showAlert(Alerts.NoAlbum, message: Alerts.NoAlbumMessage, view: self) { (UIAlertAction) in
                self.photoAlbumButtom.isEnabled = false
            }
        }
    }
    
    @IBAction func displayCamera(_ sender: Any) {
        if !presentPicker(.camera) {
            // camera is not available. Hence, disable it's option
            UIAlertController.showAlert(Alerts.NoCamera, message: Alerts.NoCameraMessage, view: self) { (UIAlertAction) in
                self.cameraButton.isEnabled = false
            }
        }
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memeImage = generateMemedimage()
        shareMeme(withImage: memeImage)
    }
    
    @IBAction func resetEditor(_ sender: Any) {
        memeImageView.image = nil
        topTextField.text = kTopFieldText
        bottomTextField.text = kBottomFieldText
    }    
}

