//
//  CCHTForgetPwdController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/7.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class CCHTForgetPwdController: UIViewController {

    @IBOutlet weak var txt_mobileCode: UITextField!
    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var txt_newPwd: UITextField!
    @IBOutlet weak var txt_repeatPwd: UITextField!
    
    @IBOutlet weak var btn_sendCode: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "忘记密码"
    

    }

   
    

    @IBAction func sendCodeAction(sender: UIButton) {
        if self.txt_mobile.text == "" {
            LCProgressHUD.showInfoWithStatus("请填写手机号码")
            return
        }
        MCHTLoginModel.sendMobileCode(self.txt_mobile.text!, type: "1") { (success, tip) in
            if success {
                //self.didTappedBackButton()
            } else {
                LCProgressHUD.showInfoWithStatus(tip)
            }
        }
    }
    
    @IBAction func pwdVisableAction(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            self.txt_newPwd.secureTextEntry = false
        }else{
            self.txt_newPwd.secureTextEntry = true
        }
    }
    @IBAction func repeatPwdVisableAction(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            self.txt_repeatPwd.secureTextEntry = false
        }else{
            self.txt_repeatPwd.secureTextEntry = true
        }
    }
    
    @IBAction func changePwdAction(sender: UIButton) {
        if self.txt_mobile.text == "" || self.txt_mobileCode.text == "" || self.txt_newPwd.text == "" || self.txt_repeatPwd.text == "" {
             LCProgressHUD.showInfoWithStatus("请全部填写完整")
            return
        }
        if self.txt_newPwd.text != self.txt_repeatPwd.text {
            LCProgressHUD.showInfoWithStatus("两次密码不一致")
            return
        }
        
        LCProgressHUD.showWithStatus("正在重置")
        MCHTLoginModel.accountForgetPwd(self.txt_mobileCode.text!, mobile: self.txt_mobile.text!, new_pwd: self.txt_newPwd.text!) { (success, tip) in
             if success {
                LCProgressHUD.dismiss()
                //self.didTappedBackButton()
            } else {
                LCProgressHUD.showInfoWithStatus(tip)
            }
        }
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
