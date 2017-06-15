//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Jubin Benny on 6/6/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var memeImage : UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = memeImage
    }
}
