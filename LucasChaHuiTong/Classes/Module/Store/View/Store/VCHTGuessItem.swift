//
//  VCHTGuessItem.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/13.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class VCHTGuessItem: UICollectionViewCell {
    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodPrice: UILabel!
    @IBOutlet weak var goodOrigin: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var guessGood: MCHTStoreGuessYouLike? {
        didSet {
            guard guessGood != nil else {
                return
            }
            self.goodImage.kf_setImageWithURL(NSURL(string:(guessGood?.goods_image_url!)!))
            self.goodName.text = guessGood?.goods_name
            self.goodPrice.text = "￥" + (guessGood?.goods_price)!
            //self.goodOrigin.text = guessGood.goo
        }
    
    }

}