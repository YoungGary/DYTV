//
//  CycleView.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/17.
//  Copyright © 2017年 Young. All rights reserved.
//  推荐页的最上方轮播图

import UIKit

let kcycleCellID = "cycle"

class CycleView: UIView , UICollectionViewDataSource ,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer : Timer?
    
    //model
    var modelArr : [CycleModel]?{
        didSet{
            collectionView.reloadData()
            
            pageControl.numberOfPages = modelArr?.count ?? 0
            
        }
    }
    
    class func loadViewWithNib() -> CycleView{
        return (Bundle.main.loadNibNamed("CycleView", owner: nil, options: nil)?.first) as! CycleView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = UIViewAutoresizing()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CycleCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: kcycleCellID)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        //timer
        addTimer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
    }
    
}

extension CycleView{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return( modelArr?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kcycleCellID, for: indexPath) as! CycleCollectionViewCell
        guard let models = modelArr else {
            return cell
        }
        cell.setmodel = models[indexPath.item%(modelArr?.count ?? 1)]
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)%(modelArr?.count ?? 1)
        
    }
}

extension CycleView{
    func addTimer(){
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scroll), userInfo: nil , repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func scroll() -> () {
        let offset = collectionView.contentOffset.x
        let current = offset + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x:current ,y:0) , animated: true)
        pageControl.currentPage = Int(collectionView.contentOffset.x/collectionView.frame.size.width)%(modelArr?.count ?? 1)
    }

}












