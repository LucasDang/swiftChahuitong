//
//  LCNetworkTools.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// 网络请求回调
typealias NetworkFinished = (success: Bool, result: JSON?, error: NSError?) -> ()

class LCNetworkTools: NSObject {
    /// 网络工具类单例
    static let shareNetworkTool = LCNetworkTools()
}
// MARK: - 基础请求方法
extension LCNetworkTools {
    
    /**
     GET请求
     
     - parameter APIString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func get(APIString: String, parameters: [String : AnyObject]?, finished: NetworkFinished) {
        
        print("\(BASE_URL)\(APIString)")
        Alamofire.request(.GET, "\(BASE_URL)\(APIString)", parameters: parameters).responseJSON { (response) -> Void in
            
            if let data = response.data {
                let json = JSON(data: data)
                if json["code"] == 1 {
                finished(success: true, result: json, error: nil)
                }else{
                    print(json)
                    let string:String = json["msg"].stringValue
                    LCProgressHUD.showInfoWithStatus(string)
                }
            } else {
                LCProgressHUD.showInfoWithStatus("您的网络不给力哦")
                //finished(success: false, result: nil, error: response.result.error)
            }
        }
        
    }
    
    /**
     POST请求
     
     - parameter APIString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func post(APIString: String, parameters: [String : AnyObject]?, finished: NetworkFinished) {
        
        print("\(BASE_URL)\(APIString)")
        Alamofire.request(.POST, "\(BASE_URL)\(APIString)", parameters: parameters).responseJSON { (response) -> Void in
            
            if let data = response.data {
                let json = JSON(data: data)

                if json["code"] == 1 {
                    finished(success: true, result: json, error: nil)
                }else{
                    print(json)
                    let string:String = json["msg"].stringValue
                    LCProgressHUD.showInfoWithStatus(string)
                }
            } else {
                LCProgressHUD.showInfoWithStatus("您的网络不给力哦")
                //finished(success: false, result: nil, error: response.result.error)
            }
        }
}
}