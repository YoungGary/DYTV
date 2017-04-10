//
//  BaseViewController.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/4/10.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit
import ImageIO

class BaseViewController: UIViewController {
    
    var contentView : UIView?
    
    lazy var imageView : UIImageView = { [unowned self] in
       let imageView = UIImageView()
        imageView.center = self.view.center
        imageView.autoresizingMask = [.flexibleBottomMargin,.flexibleTopMargin]
        imageView.bounds = CGRect(x: 0, y: 0, width: 160, height: 180)
        
        guard let path = Bundle.main.path(forResource: "fishWomen.gif", ofType: nil),
            let data = NSData(contentsOfFile: path),
            let imageSource = CGImageSourceCreateWithData(data, nil) else {  print("1"); return UIImageView()}
        
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        for i in 0..<CGImageSourceGetCount(imageSource) {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            i == 0 ? imageView.image = image : ()
            images.append(image)
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary,
                let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary,
                let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        
        imageView.animationImages = images
        imageView.animationDuration = totalDuration
        imageView.animationRepeatCount = LONG_MAX
        return imageView
    }()
    
    lazy var label : UILabel = { [unowned self] in
       let label = UILabel()
        label.text = "数据正在加载中.."
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        
        label.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 120)
        label.autoresizingMask = [.flexibleBottomMargin,.flexibleTopMargin]
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        
        
    }

    

}
extension BaseViewController{
    func setupInterface() -> () {
        
        
        contentView?.isHidden = true
        
        view.addSubview(imageView)
        
        view.addSubview(label)
        
        
        
        imageView.startAnimating()
        
        view.backgroundColor = UIColor.white
        
        
    }
    
    func finishAnimation() -> () {
        imageView.stopAnimating()
        
        imageView.isHidden = true
        
        contentView?.isHidden = false
        
    }
}



















