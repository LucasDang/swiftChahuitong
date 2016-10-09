//
//  VCHTGoodsParametersCell.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/27.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class VCHTGoodsParametersCell: UITableViewCell {

    @IBOutlet weak var goods_name: UILabel!
    @IBOutlet weak var promotion_price: UILabel!
    @IBOutlet weak var goods_marketprice: UILabel!
    
    @IBOutlet weak var goods_attr: UIView!
    @IBOutlet weak var goods_origin: UILabel!
    @IBOutlet weak var goods_salenum: UILabel!
    
    var goods_info: MCHTGoodsInfoModel? {
        didSet {
            guard let goods_info = goods_info else {
                return
            }
            self.goods_name.text = goods_info.goods_name
            self.promotion_price.text = "￥" + (goods_info.goods_promotion_price)!
            self.goods_marketprice.text = "￥" + (goods_info.goods_marketprice)!
            self.goods_origin.text = ""
            self.goods_salenum.text = "快递：" + goods_info.goods_freight! + "    月销量："  +  goods_info.goods_salenum!
            
        }
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
