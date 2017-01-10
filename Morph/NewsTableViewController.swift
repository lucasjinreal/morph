//
//  NewsTableViewController.swift
//  Morph
//
//  Created by JinTian on 07/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    let picsArray = ["home_1", "home_2", "home_3", "home_4", "home_5"]
    
    let kScreenWidth: CGFloat = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.carouselCollectionView.dataSource = self
        self.carouselCollectionView.delegate = self
        let flowLayout = NewsCarouselCollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenWidth/2 + 30, height: 140)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 2
        self.carouselCollectionView.collectionViewLayout = flowLayout
    
    }
    override func viewDidLayoutSubviews() {
        //让collectionview先滚到中间位置
        self.carouselCollectionView.scrollToItem(at: IndexPath(item: 500, section: 0), at: .centeredHorizontally, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension NewsTableViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.carouselCollectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as UICollectionViewCell
        (cell.viewWithTag(10) as! UIImageView).image = UIImage(named: self.picsArray[indexPath.row%5])
        (cell.viewWithTag(11) as! UILabel).text = "心灵和身体总有一个在路上"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.carouselCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}
