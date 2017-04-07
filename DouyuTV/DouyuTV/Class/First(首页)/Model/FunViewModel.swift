//
//  FunViewModel.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/4/7.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class FunViewModel: NSObject {
    lazy var groupArr : [Groups] = [Groups]()

    //https://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=393b245e8046605f6f881d415949494c&client_sys=ios
    func fetchPhoneGameData(_ callback:@escaping ()->()){
        
        let url = "https://capi.douyucdn.cn/api/homeCate/getHotRoom"
        let params = ["identification":"393b245e8046605f6f881d415949494c","client_sys":"ios"]
        NetworkTools.requestDataWithGet(url, params: params) { (response) in
            guard let resultDict = response as? [String : AnyObject] else{return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else{
                return
            }
            for dict in dataArr{
                let group = Groups(dict: dict)
                if group.room_list?.count != 0 {
                    self.groupArr.append(group)
                }else{
                    continue
                }
            }
            
            callback()
        }
    }
}
