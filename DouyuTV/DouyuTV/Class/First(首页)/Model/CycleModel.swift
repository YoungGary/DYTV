//
//  CycleModel.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/17.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var id : Int = 0
    
    var title : String = ""
    
    var pic_url : String = ""
    
    var room : [String : AnyObject]? {
        didSet{
            guard let room = room else {
                return
            }
            let anchor = Anchor(dict: room)
            self.anchor = anchor
        }
    }
    var anchor : Anchor?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}






