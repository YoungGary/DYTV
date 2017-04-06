//
//  PrettyCollectionViewCell.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/15.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nickName: UILabel!
    
    @IBOutlet weak var locate_city: UILabel!
    
    @IBOutlet weak var back_image: UIImageView!
    
    @IBOutlet weak var online_button: UIButton!
    
    
    var prettyModel : Anchor?{
        didSet{
            guard let model = prettyModel else {
                return
            }
            nickName.text = model.nickname
            locate_city.text = model.anchor_city
            
            online_button.setTitle("\(model.online)", for: UIControlState())
            
            let url = URL(string: model.vertical_src)
//            let data : NSData = NSData(contentsOfURL: url!)!
//            back_image.image = UIImage(data: data)
           // back_image.sd_setImage(with: url)
            //TODO:这里
            back_image.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
