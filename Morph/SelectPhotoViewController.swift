//
//  SelectPhotoViewController.swift
//  Morph
//
//  Created by JinTian on 13/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Photos

class SelectPhotoViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBAction func didTapCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
//    var selectedImages: NSMutableArray = []
    var selectedImages: [UIImage?] = []
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    @IBAction func didTapConfirmButton(_ sender: AnyObject) {
        for i in self.selectedImagesIndex{
            let asset = self.assetsFetchResults[i as! Int]
            self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil, resultHandler: { (image, nfo) in
                DispatchQueue.main.async(execute: {
                    self.selectedImages.append(image)
                    //当添加完毕之后就dismiss
                    if self.selectedImages.count == self.selectedImagesIndex.count{
                        self.postFeedsVC?.selectedImages = self.selectedImages
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            })
        }
        
    }
    var imageManager:PHImageManager!
    var cacheImageManager: PHCachingImageManager!
    var assetsFetchResults: PHFetchResult<PHAsset>!
    //缩略图大小
    var assetGridThumbnailSize:CGSize!
    var selectedImagesIndex: NSMutableArray = []
    var postFeedsVC: PostFeedsViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize.width = (UIScreen.main.bounds.width - 10)/4
        flowLayout.itemSize.height = (UIScreen.main.bounds.width - 10)/4
        self.photoCollectionView.collectionViewLayout = flowLayout
        self.photoCollectionView.backgroundColor = UIColor.clear
        self.photoCollectionView.allowsMultipleSelection = true
        //获取所有图片
        if assetsFetchResults == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
        }
        self.imageManager = PHImageManager()
        self.cacheImageManager = PHCachingImageManager()
        self.resetCachedAssets()
        self.confirmButton.isEnabled = false
    }
    //重置缓存
    func resetCachedAssets(){
        self.cacheImageManager.stopCachingImagesForAllAssets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //根据单元格的尺寸计算我们需要的缩略图大小
        let scale = UIScreen.main.scale
        let cellSize = (self.photoCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        assetGridThumbnailSize = CGSize(width: cellSize.width*scale , height: cellSize.height*scale)
    }
    //更新title的显示
    func updateDisplay(){
        //看选择了多少张
        if self.selectedImagesIndex.count != 0{
            self.confirmButton.isEnabled = true
            self.confirmButton.title = "确定(已选择\(self.selectedImagesIndex.count)张图片)"
            self.navigationController?.navigationBar.topItem?.title = "还可选择\(9 - self.selectedImagesIndex.count)张图片"
        }else{
            self.confirmButton.title = "确定"
            self.confirmButton.isEnabled = false
            self.navigationController?.navigationBar.topItem?.title = "选取图片"
        }
    }

}

extension SelectPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.photoCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as UICollectionViewCell
        let asset = self.assetsFetchResults[indexPath.row] as! PHAsset
        //给collectionview填充的是缩略图，因为这样当图片一多的时候不至于卡顿
        self.cacheImageManager.requestImage(for: asset, targetSize: self.assetGridThumbnailSize, contentMode: PHImageContentMode.aspectFill, options: nil) { (image, nfo) in
            (cell.viewWithTag(105) as! UIImageView).image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //选中动画
        if self.selectedImagesIndex.count < 10{
            let cell = collectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: [], animations: {
                cell?.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            (cell?.viewWithTag(106) as! UIImageView).image = UIImage(named: "icon_check")
            self.selectedImagesIndex.add(indexPath.row)
            self.updateDisplay()
        }else{
            ProgressHUD.showTips("最多选择9张图片哦")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //取消选中动画
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: [], animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        (cell?.viewWithTag(106) as! UIImageView).image = UIImage(named: "icon_uncheck")
        self.selectedImagesIndex.remove(indexPath.row)
        self.updateDisplay()
    }
    
}
