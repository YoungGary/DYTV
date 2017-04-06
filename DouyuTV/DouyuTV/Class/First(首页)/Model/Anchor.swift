//
//  Anchor.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/15.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class Anchor: NSObject {
    
    var nickname : String = ""
    //image
    var vertical_src : String = ""
    
    var room_src : String  = ""
    
    var game_name : String = ""
    
    var online : Int = 0
    //房间名
    var room_name : String = ""
    
    var room_id : String = ""
    
    var anchor_city : String = ""
    
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
