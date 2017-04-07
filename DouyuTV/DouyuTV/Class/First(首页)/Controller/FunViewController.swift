//
//  FunViewController.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/4/7.
//  Copyright © 2017年 Young. All rights reserved.
//FunViewController

import UIKit

private let enterCellID = "entertainment"

private let kTopicViewH : CGFloat = 200

class FunViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
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
        
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: enterCellID)
        
        collectionView.register( UINib(nibName: "HeaderReusablleView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        collectionView.autoresizingMask  = [.flexibleWidth,.flexibleHeight]
        
        return collectionView
        }()
    
    var viewModel : FunViewModel = FunViewModel()
    
    lazy var topicView : TopicCollectionView = {
        let topicView = TopicCollectionView.loadViewWithNib()
        
        topicView.frame = CGRect(x: 0, y: -(kTopicViewH), width: kScreenWidth, height: kTopicViewH)
        
        return topicView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面
        setupInterface()
        //fetch data
        fetchDataFromNet()
        
        collectionView.contentInset = UIEdgeInsetsMake(kTopicViewH, 0, 0, 0)
    }
    
}

extension FunViewController{
    func setupInterface() -> () {
        view.addSubview(collectionView)
        collectionView.addSubview(topicView)
    }
    func fetchDataFromNet() -> () {
        viewModel.fetchPhoneGameData {
            self.collectionView.reloadData()
            self.topicView.dataArr = self.viewModel.groupArr
        }
    }
}

extension FunViewController{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.groupArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = viewModel.groupArr[section]
        return group.authors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: enterCellID, for: indexPath) as! VideoCollectionViewCell
        let group = viewModel.groupArr[indexPath.section]
        cell.normalModel = group.authors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as? HeaderReusablleView
        
        headerView?.headerModel = viewModel.groupArr[indexPath.section]
        
        return headerView!
    }
}

