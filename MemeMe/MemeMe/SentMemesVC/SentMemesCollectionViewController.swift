//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jubin Benny on 5/21/17.
//  Copyright © 2017 Jubin Benny. All rights reserved.
//

import UIKit

//MARK: CollectionView Cell
class SentMemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

//MARK: CollectionView Controller
class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cellSize = CGSize(width: 100, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateCellSize()
    }
    
    func calculateCellSize() {
        let maxVerticalCells = self.view.bounds.height/100
        let maxHorizontalCells = self.view.bounds.width/100
        let maxCellWidthVertical = self.view.bounds.height/maxVerticalCells
        let maxCellWidthHorizontal = self.view.bounds.width/maxHorizontalCells
        let size = min(maxCellWidthVertical, maxCellWidthHorizontal)
        cellSize = CGSize(width: size, height: size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        flowLayout?.invalidateLayout()
    }
    
    //MARK: CollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    //MARK: CollectionView Datasource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell
        
        let meme = appDelegate.memes[indexPath.row]
        cell.imageView.image = meme.memedImage
        return cell
        
    }
    
    //MARK: CollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = appDelegate.memes[indexPath.row].memedImage
        performSegue(withIdentifier: "showCollectionDetail", sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollectionDetail" {
            let memeImage = sender as! UIImage
            let detailVC = segue.destination as! MemeDetailViewController
            
            detailVC.memeImage = memeImage
        }
    }
}
