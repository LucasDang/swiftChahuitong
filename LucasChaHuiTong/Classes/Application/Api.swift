//
//  Api.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import Foundation

let LOGIN_KEY = NSUserDefaults.standardUserDefaults().objectForKey("LoginKey")

/// 基URL
let BASE_URL = "http://api.chahuitong.com?"

///短信验证码
let MOBILECODE = "act=login&op=send_code"

///注册URL
let REGISTER = "act=login&op=register"

///登陆
let LOGIN = "act=login"

///忘记密码
let FORGETPWD = "act=login&op=forget_password"

///商城首页
let STOREMAIN = "act=index"

///购物车列表
let CARTLIST = "act=member_cart&op=cart_list"

///购物车数量增减
let CARTADD = "act=member_cart&op=cart_edit_quantity"

///购物车商品收藏
let CARTMOVETOFAV = "act=member_cart&op=move_favorites"

///购物车商品删除
let CARTDEL = "act=member_cart&op=cart_del"

///商品列表
let GOODSLIST = "act=goods&op=goods_list"

///商品详情
let GOODSDETAIL = "act=goods&op=goods_detail"

///获取用户信息
let MEMBERINDEX = "act=member_index"
