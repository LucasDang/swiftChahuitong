//
//  MCHTStoreModel.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

///顶部轮播模型和低下后台控制显示模块：这里由于数据返回格式一样，就直接用了同一个
class MCHTStoreAdd:NSObject {
    
    var image: String?
    var data: String?
    var type: String?
    
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}

///试茶师推荐模型
class MCHTStoreCommend:NSObject {
    var goods_id: String?
    var goods_image: String?
    var goods_name: String?
    var goods_promotion_price: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}

///猜你喜欢模型
class MCHTStoreGuessYouLike:NSObject {
    var origin: String?
    var goods_id: String?
    var goods_price: String?
    var goods_image: String?
    var goods_name: String?
    var goods_image_url: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}


class MCHTStoreModel: NSObject {

    ///顶部轮播图数组
    var adv_list: [MCHTStoreAdd]?
    
    ///底下后台控制模块
    var home3:[MCHTStoreAdd]?
    
    ///试茶师推荐
    var goods:[MCHTStoreCommend]?
    
    var guess_list:[MCHTStoreGuessYouLike]?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "adv_list" {
            let data = value as! [[String : AnyObject]]
            var adv_list = [MCHTStoreAdd]()
            for dict in data {
                adv_list.append(MCHTStoreAdd(dict: dict))
            }
            self.adv_list = adv_list
            return
        }else if key == "home3"{
            let data = value as! [[String : AnyObject]]
            var home3 = [MCHTStoreAdd]()
            for dict in data {
                home3.append(MCHTStoreAdd(dict: dict))
            }
            self.home3 = home3
            return
        }else if key == "goods"{
            let data = value as! [[String : AnyObject]]
            var goods = [MCHTStoreCommend]()
            for dict in data {
                goods.append(MCHTStoreCommend(dict: dict))
            }
            self.goods = goods
            return
        }else if key == "guess_list"{
            let data = value as! [[String : AnyObject]]
            var guess_list = [MCHTStoreGuessYouLike]()
            for dict in data {
                guess_list.append(MCHTStoreGuessYouLike(dict: dict))
            }
            self.guess_list = guess_list
            return
        }
        return super.setValue(value, forKey: key)
        }
    
    
    /**
     获取商城首页数据
     - parameter key: 登陆信息
     - parameter finished: 完成回调
     */
    class func storeMainDatas(finished: (storeModel: MCHTStoreModel?) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "key" : LOGIN_KEY ?? "",
            ]
        
        LCNetworkTools.shareNetworkTool.post(STOREMAIN, parameters: parameters) { (success, result, error) in
            //print(result)
            guard let result = result where result["code"] == 1 else {
                finished(storeModel: nil)
                return
            }
           let dict = result["data"].dictionaryObject!
            finished(storeModel: MCHTStoreModel(dict: dict))
            
            
        }
    }

    
}

