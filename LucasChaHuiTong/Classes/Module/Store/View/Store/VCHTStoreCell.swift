//
//  VCHTStoreCell.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit
import Kingfisher

protocol VCHTStoreCellDelegate: NSObjectProtocol {
    func storeCellActions(cell:UITableViewCell,didSelectedBtnWithTag btnTag: Int)
}

class VCHTStoreCell: UITableViewCell {

    @IBOutlet weak var btn_homeControlLeft: UIButton!
    @IBOutlet weak var btn_homeControlRight: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    
     weak var delegate: VCHTStoreCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var storeModel: MCHTStoreModel? {
        didSet {
            guard let storeModel = storeModel else {
                return
            }
            //后台控制左右模块
            let left : MCHTStoreAdd = storeModel.home3![0]
            let right: MCHTStoreAdd = storeModel.home3![1]
            self.btn_homeControlLeft.kf_setBackgroundImageWithURL(NSURL(string:left.image!), forState: UIControlState.Normal)
            self.btn_homeControlRight.kf_setBackgroundImageWithURL(NSURL(string: right.image!), forState: UIControlState.Normal)
            
           ///试茶师推荐
            let width = (SCREEN_WIDTH-10*4)/3.0
            let scrollViewH = 15 + (SCREEN_WIDTH-(15*4))/3.0 + 20 + 20
           self.scrollview.contentSize = CGSize( width: 10 + (width+10)*CGFloat(storeModel.goods!.count), height: scrollViewH)
            
            for (_,view) in scrollview.subviews.enumerate() {
                view.removeFromSuperview()
            }
            
           for (index,good) in (storeModel.goods?.enumerate())! {
                let  goodImage = UIButton(type: UIButtonType.Custom)
                goodImage.frame = CGRect(x: 10 + (width+10)*CGFloat(index) , y: 10 , width: width, height: width)
                goodImage.tag = index+30
                goodImage.addTarget(self, action: #selector(storeCellActions(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                self.scrollview.addSubview(goodImage)
                goodImage.kf_setBackgroundImageWithURL(NSURL(string: good.goods_image!), forState: UIControlState.Normal)
            
                let goodName = UILabel(frame:CGRect(x: 10 + (width+10)*CGFloat(index) , y: 10 + width , width: width, height: 20))
                goodName.text = good.goods_name
                goodName.textColor = COLOR_JETBlACK
                goodName.font = UIFont.systemFontOfSize(11)
                self.scrollview.addSubview(goodName)
            
                let goodPrice = UILabel(frame:CGRect(x: 10 + (width+10)*CGFloat(index) , y: 10 + width + 20 , width: width, height: 20))
                goodPrice.text =  "￥" + good.goods_promotion_price!
                goodPrice.textColor = COLOR_BASEG
                goodPrice.font = UIFont.systemFontOfSize(11)
                goodPrice.textAlignment = NSTextAlignment.Center
                self.scrollview.addSubview(goodPrice)
            
            }
        
        }
    }
    
    
    
    
    /**
      这里将所有的按钮放进一个代理方法里面，根据不同的tag值来区分从上而下，由低到高
      左右按钮从10开始，分别为10，11
      试茶师列表按钮有三个，点击这三个都进入试茶师列表界面，都为20
      然后是试茶师下面的滑动商品，点击进入详情，从30开始递增
      最后是猜你喜欢两个按钮，点击进去商品列表页面，都为40
     **/
    @IBAction func storeCellActions(sender: UIButton) {
        delegate?.storeCellActions(self,didSelectedBtnWithTag :sender.tag)
    }
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
