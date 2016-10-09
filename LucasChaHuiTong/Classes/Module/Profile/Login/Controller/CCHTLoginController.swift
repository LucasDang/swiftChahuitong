//
//  CCHTLoginController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class CCHTLoginController: UIViewController {
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_pwd: UITextField!
    
    @IBOutlet weak var btn_regist: UIButton!
    @IBOutlet weak var btn_forgetPwd: UIButton!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_qq: UIButton!
    @IBOutlet weak var btn_sina: UIButton!
    @IBOutlet weak var btn_weixin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.title = "登陆"

    }

    
    ///MARK Action
    @IBAction func pwdVisableAction(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            self.txt_pwd.secureTextEntry = false
        }else{
            self.txt_pwd.secureTextEntry = true
        }
    }
    @IBAction func toRegistVCAction(sender: UIButton) {
        let registVC = CCHTRegistController()
        self.navigationController?.pushViewController(registVC, animated: true)
    }
    @IBAction func toForgetPwdVCAction(sender: UIButton) {
        let forgetPwdVC = CCHTForgetPwdController()
        self.navigationController?.pushViewController(forgetPwdVC, animated: true)
    }
    @IBAction func loginAction(sender: UIButton) {
        if self.txt_username == "" || self.txt_pwd.text == "" {
            LCProgressHUD.showInfoWithStatus("用户名和密码不能为空")
            return
        }
        LCProgressHUD.showWithStatus("正在登陆")
        MCHTLoginModel.accountLogin(self.txt_username.text!, password: self.txt_pwd.text!) { (success, tip) in
            if success {
                LCProgressHUD.dismiss()
                //self.didTappedBackButton()
            } else {
                LCProgressHUD.showInfoWithStatus(tip)
            }
        }
    }
    @IBAction func QQAction(sender: UIButton) {
    }
    @IBAction func SinaAction(sender: UIButton) {
    }
    @IBAction func WeixinAction(sender: UIButton) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
