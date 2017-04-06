//
//  ScrollTitleView.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/9.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

protocol ScrollTitleViewDelegate : class{
    func scrollTitleView(_ titleView : ScrollTitleView, index : Int)
}

let kScrollLineHight : CGFloat = 2;
let kNomalColor : (CGFloat,CGFloat,CGFloat) = (0 ,0,0)
let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class ScrollTitleView: UIView {
    
    fileprivate var titles : [String]
    
    fileprivate var currentIndex : Int = 0
    
    weak var delegate : ScrollTitleViewDelegate?
    
    fileprivate lazy var scrollView : UIScrollView={
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    lazy var labels : [UILabel] = [UILabel]()
    
    init(frame: CGRect ,titles :[String]) {
        
        self.titles = titles
        super.init(frame: frame)
        //UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加title
        setupTitleLabels()
        //添加bottomLine
        setupButtomLine()
    }
    //MARK:scrollview中添加label
    fileprivate func setupTitleLabels(){
        
        let labelY : CGFloat = 0
        let labelW = frame.width/CGFloat(titles.count)
        let labelH = 40 - kScrollLineHight
        
        for (index , title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor(r: kNomalColor.0, g: kNomalColor.1, b: kNomalColor.2)
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            //frame
            let labelX = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            
            labels.append(label)
            //label添加手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.didClickLabel(_:)))
            label.addGestureRecognizer(tap)
            
            if label.tag == 0 {
                label.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
            }
        }
    }
    //MARK:scrollview 中添加bottomline和scrollLine
    fileprivate func setupButtomLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: bounds.width, height: 0.5)
        addSubview(bottomLine)
        
        scrollView.addSubview(scrollLine)
        guard let label = labels.first else{return}
        scrollLine.frame = CGRect(x: label.frame.origin.x, y: frame.height - kScrollLineHight, width: label.frame.width, height: kScrollLineHight)
        
    }
    //MARK: click label
    @objc fileprivate func didClickLabel(_ gest:UIGestureRecognizer){
        
        guard let current = gest.view as? UILabel else {
            return
        }
        current.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        let preLabel = labels[currentIndex];
        preLabel.textColor =  UIColor(r: kNomalColor.0, g: kNomalColor.1, b: kNomalColor.2)
        
        currentIndex = current.tag;
        
        //滚动条
        let scrollLineX = CGFloat(current.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.5, animations: { 
            self.scrollLine.frame.origin.x = scrollLineX
        }) 
        
        delegate?.scrollTitleView(self, index: currentIndex)
    }
}

//MARK:public method
extension ScrollTitleView{
    func setTitleWithProgress(_ progress : CGFloat,startIndex : Int,target:Int) -> () {
        let sourceLabel = labels[startIndex]
        let targetLabel = labels[target]
        
        let moveTotalX = targetLabel.frame.origin.x  - sourceLabel.frame.origin.x
        let movex = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + movex
        //处理颜色渐变
        let delta = (kSelectColor.0 - kNomalColor.0,kSelectColor.1 - kNomalColor.1,kSelectColor.1 - kNomalColor.1)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - delta.0 * progress, g: kSelectColor.1 - delta.1 * progress, b: kSelectColor.2 - delta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNomalColor.0 + delta.0 * progress, g: kNomalColor.1 + delta.1 * progress, b: kNomalColor.2 + delta.2 * progress)
        
        //记录最细你的current
        
        currentIndex = target
        
    }
}













