//
//  MainTabbarController.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/7.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs("First")
        addChildVCs("Live")
        addChildVCs("Focus")
        addChildVCs("Discover")
        addChildVCs("Mine")
    }
    
    func addChildVCs(name : String) -> () {
         let vc =  UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        addChildViewController(vc)
    }
    
    

   
}
