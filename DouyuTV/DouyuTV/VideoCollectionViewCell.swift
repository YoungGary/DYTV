//
//  VideoCollectionViewCell.swift
//  DouyuTV
//
//  Created by YOUNG on 2017/3/13.
//  Copyright © 2017年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var online_button: UIButton!
    
    @IBOutlet weak var back_image: UIImageView!
    
    @IBOutlet weak var room_nameLabel: UILabel!
    
    @IBOutlet weak var nickName: UIButton!
    

    var normalModel : Anchor?{
        didSet{
            guard let model = normalModel else {
                return
            }
            online_button.setTitle("\(model.online)", for: UIControlState())
            
            let url = URL(string: model.vertical_src)
            
            guard let urls = url else {
                back_image.image = UIImage(named: "live_cell_default_phone_103x103_")
                return
            }
           
            room_nameLabel.text = model.room_name

            back_image.kf.setImage(with: urls, placeholder: UIImage(named: "live_cell_default_phone_103x103_"))
            
            nickName.setTitle(model.nickname, for: UIControlState())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
