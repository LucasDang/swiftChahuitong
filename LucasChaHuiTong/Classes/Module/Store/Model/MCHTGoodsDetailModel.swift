//
//  MCHTGoodsDetailModel.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/27.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class MCHTGoodsDetailModel: NSObject {
    ///商品信息
    var goods_info:MCHTGoodsInfoModel?
    
    ///商品图片,返回的是字符串，这里将他直接转换成数组
    var goods_image:[String]?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "goods_info" {
            let data = value as! [String : AnyObject]
            let goods_info = MCHTGoodsInfoModel(dict: data)
            self.goods_info = goods_info
            return
        }else if key == "goods_image" {
            let data = value as! String
            let array = data.componentsSeparatedByString(",")
            self.goods_image = array
            return
        }
    }
}

class MCHTGoodsInfoModel:NSObject {
    ///商品名称
    var goods_name: String?
    ///商品说明
    var goods_jingle: String?
    ///商品价格
    var goods_price: String?
    ///商品市场价
    var goods_marketprice: String?
    ///商品编号
    var goods_id: String?
    ///商品点击数
    var goods_click: Int?
    ///商品评论数
    var goods_commentnum: Int?
    ///商品销量
    var goods_salenum: String?
    ///商品库存
    var goods_storage: Int?
    ///评价等级
    var evaluation_good_star: Int?
    ///评价数
    var evaluation_count: Int?
    ///促销价格
    var goods_promotion_price: String?
    ///最多购买数
    var upper_limit: Int?
    ///规格名称
    var spec_name: String?
    ///商品参数介绍
    var goods_attr: [[String : AnyObject]]?
    ///规格名
    //var spec_value: [[String : AnyObject]]?
    ///是否为虚拟商品 1-是 0-否
    var is_virtual: Bool?
    ///虚拟商品有效期
    var virtual_indate: String?
    ///虚拟商品购买上限
    var virtual_limit: Bool?
    ///是否拥有赠品 1-是 0-否
    var have_gift: Bool?
    ///运费
    var goods_freight: String?
    
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    
    
}


extension MCHTGoodsDetailModel {
    
    /**
     商品详情
     - parameter goods_id: 商品编号
     - parameter finished: 完成回调
     */
    class func goodsDetail(goods_id: String, finished: (success: Bool, goodsDetailModel: MCHTGoodsDetailModel) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "goods_id": goods_id,
            "version":"3.0",
            ]
        
        LCNetworkTools.shareNetworkTool.get(GOODSDETAIL, parameters: parameters) { (success, result, error) in
            
            let dict = result!["data"].dictionaryObject!
            finished (success: true, goodsDetailModel:MCHTGoodsDetailModel(dict: dict))
            
            
        }
    }

    
    
    
    
    
}