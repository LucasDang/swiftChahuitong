//
//  MCHTGoodsListModel.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/23.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class MCHTGoodsListModel: NSObject {
    var hasmore: Bool?
    var page_total: NSNumber?
    var list: [MCHTGoodsListSingleModel]?
    
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "list" {
            let data = value as! [[String : AnyObject]]
            var list = [MCHTGoodsListSingleModel]()
            for dict in data {
                list.append(MCHTGoodsListSingleModel(dict: dict))
            }
            self.list = list
            return
        }
        return super.setValue(value, forKey: key)
    }
}

class MCHTGoodsListSingleModel: NSObject {
    
    var goods_id: String?
    var goods_name: String?
    var goods_commend: String?
    var goods_price: String?
    var goods_marketprice: String?
    var goods_image: String?
    var goods_salenum: String?
    var evaluation_good_star: String?
    var evaluation_count: String?
    var is_virtual: String?
    var is_presell: String?
    var is_fcode: String?
    var have_gift: String?
    var group_flag: Bool?
    var xianshi_flag: Bool?
    var goods_image_url: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}


extension MCHTGoodsListModel {
    
    /**
     商品列表
     - parameter key: 排序方式 1-销量 2-浏览量 3-价格 空-按最新发布排序
     - parameter order: 排序方式 1-升序 2-降序
     - parameter page: 每页数量
     - parameter curPage: 当前页码
     - parameter gc_id: 分类编号
     - parameter keyword: 搜索关键字 注：gc_id和keyword二选一不能同时出现
     - parameter commend: 是否推荐 0-推荐 1-未推荐
     - parameter finished: 完成回调
     */
    class func goodsList(key: String,order: String,page: String,curPage: String,gc_id: String,keyword: String,commend: String, finished: (goodsListModel: MCHTGoodsListModel?) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "key":key,
            "order" : order,
            "page" : page,
            "curPage" : curPage,
            "gc_id" : gc_id,
            "keyword" : keyword,
            "commend" : commend,
            ]
        
        LCNetworkTools.shareNetworkTool.get(GOODSLIST, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(goodsListModel: nil)
                return
            }
            let dict = result["data"].dictionaryObject!
            finished(goodsListModel: MCHTGoodsListModel(dict: dict))
            
        }
    }

    
    
}