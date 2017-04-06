//
//  NetworkTools.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/15.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTools {
    class func requestDataWithGet(_ url : String, params : [String : String]?,callback : @escaping (_ results : AnyObject) ->()){
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error!)
                print("get method error")
                    return
                }
            callback(result as AnyObject)
        }
        //swift:2.x
//        Alamofire.request(.GET, url, parameters: params, encoding: .URL, headers: nil).responseJSON { (response) in
//            guard let result = response.result.value else{
//                print(response.result.error)
//                print("11111111")
//                return
//            }
//            callback(results: result)
//        }
    }
    
    class func requestDataWithPost(_ url : String, params : [String : String]?,callback : @escaping (_ results : AnyObject) ->()){
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error!)
                print("post method error")
                return
            }
            callback(result as AnyObject)
        }
        
    }

}
