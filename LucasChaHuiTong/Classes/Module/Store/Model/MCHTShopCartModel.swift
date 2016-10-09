//
//  MCHTShopCartModel.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/20.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class MCHTShopCartModel: NSObject {
    
    var sum: String?
    var cart_list: [MCHTShopCartSingleModel]?
    
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "cart_list" {
            let data = value as! [[String : AnyObject]]
            var cart_list = [MCHTShopCartSingleModel]()
            for dict in data {
                cart_list.append(MCHTShopCartSingleModel(dict: dict))
            }
            self.cart_list = cart_list
            return
        }
        return super.setValue(value, forKey: key)
    }
    
}

class MCHTShopCartSingleModel: NSObject {
    
    var buyer_id: String?
    var store_name: String?
    var goods_price: String?
    var goods_image: String?
    var goods_name: String?
    var goods_image_url: String?
    var goods_num: String?
    var goods_id: String?
    var goods_sum: String?
    var cart_id: String?
    var store_id: String?
    var bl_id: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}

extension MCHTShopCartModel {
    /**
     购物车列表
     - parameter key: 登陆信息
     - parameter finished: 完成回调
     */
    class func cartList(finished: (shopCartModel: MCHTShopCartModel?) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "key":LOGIN_KEY!,
            ]
        
        LCNetworkTools.shareNetworkTool.post(CARTLIST, parameters: parameters) { (success, result, error) in
            guard let result = result else {
                finished(shopCartModel: nil)
                return
            }
            if result["code"] == 1 {
            let dict = result["data"].dictionaryObject!
            finished(shopCartModel: MCHTShopCartModel(dict: dict))
            }else{
                
            }
            
        }
    }

    /**
     购物车商品数量增减
     - parameter key: 登陆信息
     - parameter cart_id: 购物车编号
     - parameter quantity: 购买数量
     - parameter finished: 完成回调
     */
    class func cartGoosNumAdd(cart_id: String, quantity: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "key":LOGIN_KEY!,
            "cart_id" : cart_id,
            "quantity" : quantity,
            ]
        
        LCNetworkTools.shareNetworkTool.post(CARTADD, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            if result["code"] == 1 {
                finished(success: true, tip: "修改成功")
            } else {
                finished(success: false, tip: result["msg"].stringValue)
            }
            
        }
    }

    /**
     购物车商品收藏
     - parameter key: 登陆信息
     - parameter cart_id: 购物车编号，如果是多个用逗号隔开
     - parameter finished: 完成回调
     */
    class func cartGoosMoveToFav(cart_id: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "key":LOGIN_KEY!,
            "cart_id" : cart_id,
            ]
        
        LCNetworkTools.shareNetworkTool.post(CARTMOVETOFAV, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            
            if result["code"] == 1 {
                finished(success: true, tip: "收藏成功")
            } else {
                finished(success: false, tip: result["msg"].stringValue)
            }
            
        }
    }

    
    /**
     购物车商品删除
     - parameter key: 登陆信息
     - parameter cart_id: 购物车编号，如果是多个用逗号隔开
     - parameter finished: 完成回调
     */
    class func cartGoodsDel(cart_id: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "key":LOGIN_KEY!,
            "cart_id" : cart_id,
            ]
        
        LCNetworkTools.shareNetworkTool.post(CARTDEL, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            if result["code"] == 1 {
                finished(success: true, tip: "删除成功")
            } else {
                finished(success: false, tip: result["msg"].stringValue)
            }
            
        }
    }

    
    
    
    
}


