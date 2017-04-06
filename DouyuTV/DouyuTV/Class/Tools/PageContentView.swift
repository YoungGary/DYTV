//
//  PageContentView.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/10.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate  : class {
    func PageContentViews(_ contetnView : PageContentView,progress : CGFloat,startIndex : Int, targetindex : Int)
}
class PageContentView: UIView,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    fileprivate var childVCs : [UIViewController]
    
    fileprivate weak var parentVC : UIViewController?
    //记录开始滑动的时候的offset
    fileprivate  var startOffset : CGFloat = 0
    
    weak var delegate : PageContentViewDelegate?
    
    var isForbiddenDelegate : Bool = false
    
    lazy var collectionView : UICollectionView={[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
       let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init(frame: CGRect,childVCs :[UIViewController],parentVC : UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        for vc in childVCs{
            parentVC?.addChildViewController(vc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}
//MARK:delegate dataSource
extension PageContentView{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childvc = childVCs[indexPath.item]
        childvc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childvc.view)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbiddenDelegate = false
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbiddenDelegate {return}
        
        var progress : CGFloat = 0
        var startIndex : Int = 0;
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        if currentOffsetX > startOffset  {//左
            progress = currentOffsetX / kScreenWidth - floor(currentOffsetX/kScreenWidth)
            
            startIndex = Int(currentOffsetX/kScreenWidth)
            
            targetIndex = startIndex + 1
            
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count-1
            }
            
            if currentOffsetX - startOffset == kScreenWidth {
                progress =  1
                targetIndex = startIndex
            }
        }else{//右
            progress  = 1 - (currentOffsetX / kScreenWidth - floor(currentOffsetX/kScreenWidth))
            targetIndex = Int(currentOffsetX/kScreenWidth)
            startIndex = targetIndex + 1
            
            if startIndex >= childVCs.count {
                startIndex = childVCs.count-1
            }
        }
        
        //print("progress:\(progress),start:\(startIndex),target: \(targetIndex)")
        delegate?.PageContentViews(self, progress: progress, startIndex: startIndex, targetindex: targetIndex)
    }
    
}
//MARK:public method
extension PageContentView{
    func setCurrentIndex(_ index:Int){
        
        isForbiddenDelegate = true
        
        let offsetX = CGFloat(index)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX,y: 0), animated: false)
    }
    
    
}









