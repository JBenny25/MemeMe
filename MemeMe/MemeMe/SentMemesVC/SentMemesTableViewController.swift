//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/21/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

//MARK: TableView Cell
class SentMemeTableViewCell : UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeDetailLabel: UILabel!
}

//MARK: TableView Controller
class SentMemesTableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: TableView Datasource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeDetailCell") as! SentMemeTableViewCell
        
        let meme = appDelegate.memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        cell.memeDetailLabel.text = meme.topQuote + " " + meme.bottomQuote
        
        return cell
    }
    
    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = appDelegate.memes[indexPath.row].memedImage
        self.performSegue(withIdentifier: "showTableDetail", sender: image)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTableDetail" {
            let memeImage = sender as! UIImage
            let detailVC = segue.destination as! MemeDetailViewController
            
            detailVC.memeImage = memeImage
        }
    }
}
