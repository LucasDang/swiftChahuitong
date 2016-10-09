//
//  CCHTRegistController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class CCHTRegistController: UIViewController {

    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var txt_pwd: UITextField!
    @IBOutlet weak var btn_sendNote: UIButton!
    @IBOutlet weak var btn_pwdVasible: UIButton!
    @IBOutlet weak var btn_regist: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false
        navigationItem.title = "注册"
        
        
        
        
    }

    
    
    //短信验证码
    @IBAction func sendNoteAction(sender: UIButton) {
        if self.txt_mobile.text == "" {
            LCProgressHUD.showInfoWithStatus("请填写手机号码")
            return
        }
        MCHTLoginModel.sendMobileCode(self.txt_username.text!, type: "0") { (success, tip) in
            if success {
                //self.didTappedBackButton()
            } else {
                LCProgressHUD.showInfoWithStatus(tip)
            }
        }
        
    }
    //密码是否可见
    @IBAction func pwdIfVasibleAction(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            self.txt_pwd.secureTextEntry = false
        }else{
            self.txt_pwd.secureTextEntry = true
        }
    }
    //注册
    @IBAction func registAction(sender: UIButton) {
        if self.txt_mobile.text == "" && self.txt_pwd.text == "" && self.txt_username.text == ""{
            LCProgressHUD.showInfoWithStatus("请将信息填写完整")
            return
        }
         LCProgressHUD.showWithStatus("注册中")
        MCHTLoginModel.accountRegister(self.txt_mobile.text!, username: self.txt_username.text!, password: self.txt_pwd.text!) { (success, tip) in
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
