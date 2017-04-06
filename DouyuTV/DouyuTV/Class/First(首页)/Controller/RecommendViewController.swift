//
//  RecommendViewController.swift
//  DouyuTV
//  首页推荐控制器
//  Created by YOUNG on 2017/3/13.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

let itemMargin : CGFloat = 10

let itemWidth : CGFloat = (kScreenWidth - 3 * itemMargin)/2

let itemHeight : CGFloat = itemWidth * 0.75

let prettyHeight :CGFloat = itemWidth / 0.75

let cellID = "cellID"

let headerID = "headerID"

let prettyID = "prettyID"

//cycle
let kCycleViewY = kScreenWidth * 3/8

class RecommendViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: 50)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.white
        
          collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        
        collectionView.register(UINib(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: prettyID)
        
        collectionView.register( UINib(nibName: "HeaderReusablleView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        collectionView.autoresizingMask  = [.flexibleWidth,.flexibleHeight]
        
    
        return collectionView
    }()
    
    var viewModel : RecommendViewModel = RecommendViewModel()
    
    lazy var cycleView : CycleView = {
        let cycleView = CycleView.loadViewWithNib()
        
        cycleView.frame = CGRect(x: 0, y: -kCycleViewY, width: kScreenWidth, height: kCycleViewY)
        
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面
        setupInterface()
        //fetch data
        fetchDataFromNet()
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewY, 0, 0, 0)
    }

   

}

extension RecommendViewController{
    
    func setupInterface() -> () {
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
    }
    func fetchDataFromNet(){
        viewModel.fetchData { 
            self.collectionView.reloadData()
        }
        viewModel.fetchCycleData {
        self.cycleView.modelArr = self.viewModel.cycleArr
        }
    }
    
}
//MARK:UICollectionViewDataSource and delegate
extension RecommendViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.groupArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = viewModel.groupArr[section]
        return group.authors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = viewModel.groupArr[indexPath.section]
        
        if group.tag_name == "颜值" {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: prettyID, for: indexPath) as! PrettyCollectionViewCell
            cell.prettyModel = group.authors[indexPath.row]
            
            return cell
        }
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VideoCollectionViewCell
        
        cell.normalModel = group.authors[indexPath.row]
        
        return cell
        

}
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as? HeaderReusablleView
        
        headerView?.headerModel = viewModel.groupArr[indexPath.section]
        
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let group = viewModel.groupArr[indexPath.section]
        
        if group.tag_name == "颜值" {
            return CGSize(width: itemWidth, height: prettyHeight)
            
        }else{
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
}

















