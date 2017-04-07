//
//  TopicCollectionView.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/4/7.
//  Copyright © 2017年 Young. All rights reserved.
//  游戏页面中的上方的游戏collectionView

import UIKit
import Kingfisher

private let topicCell = "topic"

class TopicCollectionView: UIView {
    
    var dataArr : [Groups] = [Groups](){
                    didSet{
                        dataArr.removeFirst()
        
                        if dataArr.count > 15 {
                            dataArr.removeLast(dataArr.count - 15)
                            let more = Groups()
                            more.tag_name = "更多"
                            dataArr.append(more)
                        }else{
                            
                        }
                        collectionView.reloadData()
                    }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    class func loadViewWithNib() -> TopicCollectionView{
        return (Bundle.main.loadNibNamed("TopicCollectionView", owner: nil, options: nil)?.first) as! TopicCollectionView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = UIViewAutoresizing()
        
        flowLayout.itemSize = CGSize(width: kScreenWidth/4, height: 100)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentSize = CGSize(width: kScreenWidth * 2, height: 200)
        let nib = UINib(nibName: "SelectCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: topicCell)
        
        
        
    }
}

extension TopicCollectionView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topicCell, for: indexPath) as! SelectCollectionViewCell
        
        let model = dataArr[indexPath.row]
        //label
        cell.label.text = model.tag_name
        
        cell.label.font = UIFont.systemFont(ofSize: 12)
        //image
        
        let url = URL(string: model.icon_url)
        
        let placeholder = UIImage(named: "home_column_more_49x49_")
        
        
            cell.back_image.kf.setImage(with: url, placeholder: placeholder)
            
            cell.back_image.layer .cornerRadius = cell.back_image.bounds.size.width/2
            cell.back_image.layer.masksToBounds = true
        
        
        
        return cell
    }
}









