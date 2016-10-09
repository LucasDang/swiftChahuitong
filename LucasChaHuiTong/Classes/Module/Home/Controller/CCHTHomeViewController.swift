//
//  CCHTHomeViewController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class CCHTHomeViewController: UIViewController {
    
    let homeCellIdentifier = "VCHTHomeCellIdentifier"
    var homeModel: MCHTHomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人中心"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "设置", style:UIBarButtonItemStyle.Plain, target: self, action: #selector(setAction))
        
        prepareUI()
        if LOGIN_KEY != nil {
            //如果有登陆才请求用户信息
            pullDownRefresh()
        }
    }

    /**
     设置
     */
    func setAction(){
        
        
    }

    private func prepareUI() {
        self.view.addSubview(myTableView)
        
    }
    
    lazy var myTableView:UITableView =  {
        let  myTableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) , style:UITableViewStyle.Plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .None
        myTableView.rowHeight = 100 + 150 + (SCREEN_WIDTH/3.0)*28/25*2
        myTableView.registerNib(UINib.init(nibName: "VCHTHomeCell", bundle: nil), forCellReuseIdentifier: self.homeCellIdentifier)
        
        return myTableView
    }()

    /**
     初始化数据 + 下拉刷新
     */
    @objc private func pullDownRefresh() {
        MCHTHomeModel.getUserInfo { (success, homeModel) in
           
                self.homeModel = homeModel
                self.myTableView.reloadData()

        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension CCHTHomeViewController: UITableViewDelegate,UITableViewDataSource,VCHTHomeCellDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.homeCellIdentifier) as! VCHTHomeCell
        cell.homeCellDelegate = self
        cell.btn_login.setTitle("登陆/注册", forState: UIControlState.Normal)
        if  self.homeModel?.member_name != nil{
            cell.usererHeadImage?.kf_setImageWithURL(NSURL(string:(self.homeModel?.member_avatar)!))
            cell.btn_login.titleLabel?.numberOfLines = 0
            cell.btn_login.setTitle("账号：" + (self.homeModel?.member_name)! + "\n" + "积分：" + (self.homeModel?.member_points)!, forState: UIControlState.Normal)
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    
    func homeCellActions(cell: UITableViewCell, didSelectedBtnWithTag btnTag: Int) {
        print(btnTag)
    }
    
    
}


