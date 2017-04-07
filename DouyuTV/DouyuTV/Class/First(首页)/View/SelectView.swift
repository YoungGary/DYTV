//
//  SelectView.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/4/6.
//  Copyright © 2017年 Young. All rights reserved.
// 推荐页中间三个按钮

import UIKit

let collcellID = "SelectcellID"

class SelectView : UIView{
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray : [String] = ["homeNewItem_rankingList_30x30_","homeNewItem_msg_30x30_","homeNewItem_allLive_30x30_"]
    var textArray : [String] = ["排行榜","消息","全部直播"]
    
    //get view from nib
    class func loadViewWithNib() -> SelectView{
        return (Bundle.main.loadNibNamed("SelectView", owner: nil, options: nil)?.first) as! SelectView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        collectionView.dataSource = self
        let nib = UINib(nibName: "SelectCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collcellID)
        
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.minimumInteritemSpacing = (kScreenWidth - 80 * 3)/4
        layout.minimumLineSpacing = 0
        
    }
    
    
}

extension SelectView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collcellID, for: indexPath) as! SelectCollectionViewCell
        cell.back_image.image = UIImage(named: imageArray[indexPath.row])
        cell.label.text = textArray[indexPath.row]
        return cell
    }
    
}







