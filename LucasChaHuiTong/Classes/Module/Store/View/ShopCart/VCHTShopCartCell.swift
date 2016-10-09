//
//  VCHTShopCartCell.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/18.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class VCHTShopCartCell: UITableViewCell {

    @IBOutlet weak var goods_image_url: UIImageView!
    
    @IBOutlet weak var goods_name: UILabel!
    @IBOutlet weak var goods_price: UILabel!
    @IBOutlet weak var goods_num: UILabel!
    
    @IBOutlet weak var btn_sele: UIButton!
    
    var cart_id:String?
    var quantity:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.goods_image_url.layer.cornerRadius = 5
        self.goods_image_url.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /**
     1为增加，-1为减少
     */
    
    @IBAction func changeGoodsNumAction(sender: UIButton) {
        if sender.tag == 1 {
            quantity = Int(self.goods_num.text!)! + 1
        }else if sender.tag == -1 {
            quantity = Int(self.goods_num.text!)! - 1
        }
        LCProgressHUD.showWithStatus("更新中")
        MCHTShopCartModel.cartGoosNumAdd(self.cart_id!, quantity:String(self.quantity!) ) { (success, tip) in
            if success {
               LCProgressHUD.dismiss()
                self.singleCartModel!.goods_num = String(self.quantity!)
                self.goods_num.text = String(self.quantity!)
            }
            
        }
        
        
        
    }
    
    
    
    var singleCartModel: MCHTShopCartSingleModel? {
        didSet {
            guard let singleCartModel = singleCartModel else {
                return
            }
            self.cart_id = singleCartModel.cart_id
            self.goods_name.text = singleCartModel.goods_name
            self.goods_image_url.kf_setImageWithURL(NSURL(string:(singleCartModel.goods_image_url!)))
            self.goods_price.text = "￥" +  singleCartModel.goods_price!
            self.goods_num.text = singleCartModel.goods_num
    
        }
    }
}
