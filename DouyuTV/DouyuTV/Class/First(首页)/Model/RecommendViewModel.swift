//
//  RecommendViewModel.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/15.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    
    lazy var groupArr : [Groups] = [Groups]()
    
    lazy var prettyGroup : Groups = Groups()
    
    lazy var hotGroup : Groups = Groups()
    
    lazy var cycleArr : [CycleModel] = [CycleModel]()
    
//    var prettyArr : [PrettyModel] = [PrettyModel]()
//    
//    var hotArr : [HotModel] = [HotModel]()
//    
//    var mobileArr : [PhoneGamesModel] = [PhoneGamesModel]()
    
    func fetchData(_ callback:@escaping ()->()) {
        //fetch 热门 section=0
        let hotUrl = "https://capi.douyucdn.cn/api/v1/getbigDataRoom"
        
        let hotParams = ["client_sys":"ios"]
        
        let gcdGroup = DispatchGroup()
        gcdGroup.enter()
      
        NetworkTools.requestDataWithPost(hotUrl, params: hotParams) { (results) in
            
            guard let resultDict = results as? [String : AnyObject] else{return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else{
                return
            }
            
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon = "home_header_hot_18x18_"
            
            for dict in dataArr{
                let pretty = Anchor(dict: dict)
                self.hotGroup.authors.append(pretty)
            }
            
            gcdGroup.leave()
           // print("finish--0")
        }

        //fetch 颜值区 section=2
        let prettyUrl = "https://capi.douyucdn.cn/api/v1/getVerticalRoom"
        let prettyParams = ["limit": "4","client_sys":"ios","offset":"0"]
        gcdGroup.enter()
        NetworkTools.requestDataWithGet(prettyUrl, params: prettyParams) { (results) in
            
            guard let resultDict = results as? [String : AnyObject] else{return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else{
                
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon = "home_header_phone_18x18_"
            
            for dict in dataArr{
                let pretty = Anchor(dict: dict)
                self.prettyGroup.authors.append(pretty)
                //print(dict["room_id"])
            }
            gcdGroup.leave()
           // print("finish--1颜值")
        }
        //3-11
        let url = "https://capi.douyucdn.cn/api/v1/getHotCate"
        let timeInterval = Date().timeIntervalSince1970
        let params = ["aid": "ios","client_sys":"ios","time":"\(timeInterval)"]
        
          gcdGroup.enter()
        NetworkTools.requestDataWithPost(url, params: params) { (results) in
            guard let resultDict = results as? [String : AnyObject] else{return}
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else{
                return
            }
            for dict in dataArr{
                let group = Groups(dict: dict)
                self.groupArr.append(group)
            }
            gcdGroup.leave()
            //print("finish(2-11)=====")
        }
        
        
        gcdGroup.notify(queue: DispatchQueue.main) {
            //hot-pretty - other
            self.groupArr.insert(self.prettyGroup, at: 0)
            self.groupArr.insert(self.hotGroup, at: 0)
            callback()
        }
    }
    
    func fetchCycleData(_ callback:@escaping ()->()){
        //capi.douyucdn.cn/api/v1/slide/6?version=2.452&client_sys=ios
        NetworkTools.requestDataWithGet("https://capi.douyucdn.cn/api/v1/slide/6", params: ["version":"2.452","client_sys":"ios"]) { (results) in
            guard let resultDict = results as? [String : AnyObject] else{
                print("resultdict error")
                return
            }
            guard let resultArr = resultDict["data"] as? [[String:AnyObject]] else{
                print("resultarr error")
                return
            }
            for dict in resultArr{
                let cycle = CycleModel(dict: dict)
                self.cycleArr.append(cycle)
               
            }
            //print("qingqiu完成后数组的个数\(self.cycleArr.count)")
            callback()
        }
        
    }

}









