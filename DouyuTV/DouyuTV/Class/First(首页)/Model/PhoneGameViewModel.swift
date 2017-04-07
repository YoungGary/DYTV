//
//  PhoneGameViewModel.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/4/7.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class PhoneGameViewModel: NSObject {
    ////https://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=3e760da75be261a588c74c4830632360&client_sys=ios
    
    lazy var groupArr : [Groups] = [Groups]()
    
    
    func fetchPhoneGameData(_ callback:@escaping ()->()){
        
        let url = "https://capi.douyucdn.cn/api/homeCate/getHotRoom"
        let params = ["identification":"3e760da75be261a588c74c4830632360","client_sys":"ios"]
        NetworkTools.requestDataWithGet(url, params: params) { (response) in
            guard let resultDict = response as? [String : AnyObject] else{return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else{
                return
            }
            for dict in dataArr{
                let group = Groups(dict: dict)
                self.groupArr.append(group)
            }
            callback()
        }
    }
}
