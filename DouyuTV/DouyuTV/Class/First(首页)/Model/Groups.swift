//
//  Groups.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/15.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class Groups: NSObject {
    
    var tag_name : String  = ""
    
    var icon: String = "home_header_normal_18x18_"
    
    var room_list : [[String : AnyObject]]?{
        didSet{
            guard let list = room_list else {
                return
            }
            for dict in list{
                let anthor = Anchor(dict: dict)
                authors.append(anthor)
            }
           
        }
    }
    
    var authors : [Anchor] = [Anchor]()
    
    override init() {
        
    }
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
