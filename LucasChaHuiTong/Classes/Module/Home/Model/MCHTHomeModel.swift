//
//  MCHTHomeModel.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/27.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class MCHTHomeModel: NSObject {

    var member_name: String?
    var member_avatar: String?
    var member_points: String?
    var available_predeposit: String?
    var member_exppoints: String?
    var member_title: String?
    var order_new_count: String?
    var order_pay_count: String?
    var order_send_count: String?
    var order_eval_count: String?

    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}

extension MCHTHomeModel {
    
    /**
     获取用户信息
     - parameter key: 登陆信息
     - parameter finished: 完成回调
     */
    class func getUserInfo(finished: (success:Bool , homeModel:MCHTHomeModel) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "key":LOGIN_KEY!,
            "version": "3.0"
            ]
        
        LCNetworkTools.shareNetworkTool.post(MEMBERINDEX, parameters: parameters) { (success, result, error) in
            if success {
                
                let dict = result!["data"].dictionaryObject!
                finished(success:true,homeModel: MCHTHomeModel(dict: dict))
            }
            
        }
    }
}