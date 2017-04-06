//
//  HeaderReusablleView.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/13.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit

class HeaderReusablleView: UICollectionReusableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var iconName: UIImageView!
    
    var headerModel : Groups?{
        didSet{
            guard let model = headerModel else {
                return
            }
            nameLabel.text = model.tag_name
            
            iconName.image = UIImage(named: model.icon) ?? UIImage(named: "home_header_normal_18x18_")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
