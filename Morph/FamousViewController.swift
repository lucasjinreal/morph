//
//  FamousViewController.swift
//  Morph
//
//  Created by JinTian on 07/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FamousViewController: UIViewController {

    @IBOutlet weak var showCollectionView: UICollectionView!
    
    let kScreenWidth: CGFloat = UIScreen.main.bounds.width
    let imageArray = ["one_piece_0", "one_piece_1", "one_piece_2", "one_piece_3", "one_piece_4", "one_piece_5", "one_piece_6", "one_piece_7", "one_piece_8"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = FamousShowCollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenWidth * 1 / 2, height: 380)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        self.showCollectionView.collectionViewLayout = flowLayout

        let left: CGFloat = self.showCollectionView!.frame.width / 2 - flowLayout.itemSize.width / 2
        self.showCollectionView.contentInset = UIEdgeInsetsMake(0, left, 0, left)
      
        self.showCollectionView.reloadData()
        self.showCollectionView.setContentOffset(CGPoint(x: -left, y: 0), animated: true)
        self.showCollectionView.dataSource = self
        self.showCollectionView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}

extension FamousViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.showCollectionView.dequeueReusableCell(withReuseIdentifier: "ShowCell", for: indexPath) as UICollectionViewCell
        (cell.viewWithTag(20) as! UIImageView).image = UIImage(named: self.imageArray[indexPath.row])
        (cell.viewWithTag(20) as! UIImageView).layer.cornerRadius = 6
        (cell.viewWithTag(20) as! UIImageView).clipsToBounds = true
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
