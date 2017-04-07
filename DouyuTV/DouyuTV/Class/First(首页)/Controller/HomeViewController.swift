//
//  HomeViewController.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/8.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,ScrollTitleViewDelegate ,PageContentViewDelegate{
    
    lazy var titleView : ScrollTitleView = { [weak self] in
        let titles : [String] = ["推荐","手游","娱乐","游戏","趣玩"];
        let frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 40)
        let titleView = ScrollTitleView(frame: frame, titles: titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView : PageContentView = {[weak self] in
        let frame = CGRect(x: 0, y: 64+kTitleViewHeight, width: kScreenWidth , height: kScreenHeight - 64 - kTitleViewHeight-44)
        
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(PhoneGameViewController())
        childVCs.append(EnterTainMentViewController())
        childVCs.append(GameViewController())
        childVCs.append(FunViewController())
        
        let contentView = PageContentView(frame: frame, childVCs: childVCs, parentVC: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    
}

extension HomeViewController{
    //MARK:set up UI
    fileprivate func setupUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNaviBar()
        
        view.addSubview(titleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.cyan
        
    }
    //MARK:naviBarItems
    fileprivate func setupNaviBar(){
        //设置bar背景色
        navigationController?.navigationBar .setBackgroundImage(UIImage(named: "Img_orange_"), for: UIBarMetrics.default)
        //设置左边item
        let button = UIButton()
        button.setImage(UIImage(named: "logo_66x26_"), for: UIControlState())
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        //设置右边items
        let size = CGSize(width: 40, height: 40)
        let history  = UIBarButtonItem(imageName: "image_my_history", HLImage: "Image_my_history_click", size: size)
         let scan  = UIBarButtonItem(imageName: "scanIcon_20x20_", HLImage: "scanIconHL_20x20_", size: size)
         let search  = UIBarButtonItem(imageName: "searchBtnIcon_20x20_", HLImage: "searchBtnIconHL_20x20_", size: size)
        navigationItem.rightBarButtonItems = [history,scan,search];
    }
    
}

extension HomeViewController{
    func scrollTitleView(_ titleView: ScrollTitleView, index: Int) {
        pageContentView.setCurrentIndex(index)
    }
    
    func PageContentViews(_ contetnView: PageContentView, progress: CGFloat, startIndex: Int, targetindex: Int) {
        titleView.setTitleWithProgress(progress, startIndex: startIndex, target: targetindex)
    }
    
}








