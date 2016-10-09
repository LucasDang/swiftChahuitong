//
//  VCHTGoodsListCell.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/23.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class VCHTGoodsListCell: UITableViewCell {
    @IBOutlet weak var goods_image: UIImageView!
    @IBOutlet weak var goods_name: UILabel!
    @IBOutlet weak var goods_price: UILabel!
    @IBOutlet weak var goods_judge: UILabel!
    @IBOutlet weak var goods_origin: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model: MCHTGoodsListSingleModel? {
        didSet {
            guard let model = model else {
                return
            }
            self.goods_image.kf_setImageWithURL(NSURL(string: model.goods_image_url!))
            self.goods_name.text = model.goods_name
            self.goods_price.text = "￥" + model.goods_price!
            self.goods_judge.text = "综合评价" + model.evaluation_good_star! + "分"
            self.goods_origin.text = "云南"
            
            
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
