//
//  MCHTLoginModel.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class MCHTLoginModel: NSObject {

    

}

// MARK: - 各种网络请求
extension MCHTLoginModel {
    /**
     获取短信验证码
     - parameter mobile: 手机号
     - parameter type: 0-注册 1-忘记密码
     - parameter finished: 完成回调
     */
    class func sendMobileCode(mobile:String,type:String,finished:(success:Bool,tip:String) -> ()) {
        let parameters: [String:AnyObject] = [
        "mobile":mobile,
        "type":type,
        ]
        LCNetworkTools.shareNetworkTool.post(MOBILECODE, parameters: parameters) { (success, result, error) in
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            if result["code"] == 1 {
                finished(success: true, tip: "发送成功")
            } else {
                finished(success: false, tip: result["msg"].stringValue)
            }
        }
        
    }
    
    
    /**
     账号注册
     - parameter code: 短信验证码
     - parameter client: 客户端类型
     - parameter mobile: 手机号码
     - parameter password: 密码
     - parameter finished: 完成回调
     */
    class func accountRegister(code: String, username: String, password: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "mobile" : username,
            "password" : password,
            "client" : "ios",
            "code":code,
        ]
        
        LCNetworkTools.shareNetworkTool.post(REGISTER, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            
            if result["code"] == 1 {
                let key:String = result["data"]["key"].string!
                NSUserDefaults.standardUserDefaults().setObject(key, forKey: "LoginKey")
                finished(success: true, tip: "注册成功")
            } else {
                finished(success: false, tip: result["msg"].stringValue)
            }
            
        }
    }
    
    /**
     账号登陆
     - parameter client: 客户端类型
     - parameter username: 用户名
     - parameter password: 密码
     - parameter finished: 完成回调
     */
    class func accountLogin(username: String, password: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "username" : username,
            "password" : password,
            "client" : "ios",
            ]
        
        LCNetworkTools.shareNetworkTool.post(LOGIN, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            print(result)
            if result["code"] == 1 {
                let key:String = result["data"]["key"].string!
                NSUserDefaults.standardUserDefaults().setObject(key, forKey: "LoginKey")
                finished(success: true, tip: "登陆成功")
            } else {
                finished(success: false, tip: result["msg"].stringValue)
            }
            
        }
    }

    /**
     重置密码
     - parameter code: 短信验证码
     - parameter mobile: 手机号码
     - parameter password: 密码
     - parameter finished: 完成回调
     */
    class func accountForgetPwd(code: String, mobile: String, new_pwd: String, finished: (success: Bool, tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "mobile" : mobile,
            "new_pwd" : new_pwd,
            "code":code,
            ]
        
        LCNetworkTools.shareNetworkTool.post(FORGETPWD, parameters: parameters) { (success, result, error) in
            
            guard let result = result else {
                finished(success: false, tip: "您的网络不给力哦")
                return
            }
            
            if result["code"] == 1{
                finished(success: true, tip: "重置成功")
            } else {
                finished(success: false, tip: result["msg"].stringValue)
            }
            
        }
    }


    
}