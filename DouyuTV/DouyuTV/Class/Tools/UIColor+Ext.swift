//
//  UIColor+Ext.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/10.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init( r: CGFloat,g:CGFloat,b:CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}
