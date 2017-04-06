//
//  CycleCollectionViewCell.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/17.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var back_image: UIImageView!
    
    var setmodel : CycleModel?{
        didSet{
            guard let model = setmodel else{
                return
            }
            let url = URL(string: model.pic_url)
            //back_image.sd_setImage(with: url)
            back_image.kf.setImage(with: url, placeholder: UIImage(named:"live_cell_default_phone_103x103_"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
