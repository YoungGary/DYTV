//
//  UIBarButtonItem+Extemsion.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/9.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    convenience init( imageName : String , HLImage : String = "",size : CGSize = CGSize.zero) {
        let button = UIButton()
        button.setImage(UIImage(named:imageName), for: UIControlState())
        if HLImage != ""{
            button.setImage(UIImage(named:HLImage), for: .highlighted)
        }
        if size != CGSize.zero{
             button.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            button.sizeToFit()
        }
       
        
        self.init(customView:button)
    }
}
