//
//  ImagePreviewViewController.swift
//  Morph
//
//  Created by JinTian on 17/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {

    @IBOutlet weak var previewImageCollectionView: UICollectionView!
    var previewImages: [UIImage?] = []
    var selectIndexPath: Int = 0
    
    @IBAction func didTapDone(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func didTapSave(_ sender: AnyObject) {
        //获取当前显示的image的第一张，按道理应该只会显示一张
        let cell = self.previewImageCollectionView.visibleCells as [UICollectionViewCell]
        let index = self.previewImageCollectionView.indexPath(for: cell[0])! as IndexPath
        let image = previewImages[index.row]
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(ImagePreviewViewController.image), nil)
        
    }
    
    @IBOutlet weak var visualView: UIVisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize.height = UIScreen.main.bounds.height
        flowLayout.itemSize.width = UIScreen.main.bounds.width
        flowLayout.scrollDirection = .horizontal
        self.previewImageCollectionView?.collectionViewLayout = flowLayout
        self.previewImageCollectionView?.dataSource = self
        self.previewImageCollectionView?.delegate = self
        self.previewImageCollectionView.backgroundColor = UIColor.clear
        self.previewImageCollectionView?.isPagingEnabled = true
        
        let indexPath = IndexPath(row: self.selectIndexPath, section: 0)
        self.previewImageCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        let blurEffect = UIBlurEffect(style: .light)
        self.visualView.effect = blurEffect
        
    }
    
    func image(_ image: UIImage, didFinishSavingWithError: NSError?,contextInfo: AnyObject)
    {
        if didFinishSavingWithError != nil
        {
            ProgressHUD.showError("保存失败，可能是权限问题")
            return
        }
        
        ProgressHUD.showSuccess("已经保存到本地了噢")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ImagePreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.previewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewCell", for: indexPath) as UICollectionViewCell
        (cell.viewWithTag(109) as! UIImageView).image = self.previewImages[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }

}
