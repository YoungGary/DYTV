//
//  PhoneGamesModel.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/15.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class PhoneGamesModel: NSObject {
    
    var room_id : String = ""
    
    var room_name : String = ""
    
    var author_city : String = ""
    
    var nickname : String = ""
    
    var online_num : String = ""
    
    var room_src : String  = ""
    
    var vertical_src : String = ""
    
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
