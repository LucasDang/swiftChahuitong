//
//  CCHTGoodsDetailViewController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/22.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit
import SDCycleScrollView

class CCHTGoodsDetailViewController: UIViewController ,SDCycleScrollViewDelegate {
    let goodsParametersCellIdentifier = "VCHTGoodsParametersCell"
    let goodsJudgeAndImagesCellIdentifier = "VCHTGoodsJudgeAndImagesCell"
    
    ///顶部轮播图
    var topScrollView: SDCycleScrollView?
    var adds: [MCHTStoreAdd]?
    
    var goods_id:String?
    var detailModel:MCHTGoodsDetailModel?
    var goods_attr:[[String:AnyObject]]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "商品详情"
        prepareUI()
        pullDownRefresh()
        
    }

    /**
     准备UI
     */
    func prepareUI() {
        self.view.addSubview(myTableView)
    }
    
    lazy var myTableView:UITableView =  {
        let  myTableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) , style:UITableViewStyle.Plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .None
        myTableView.rowHeight = 108
        myTableView.registerNib(UINib.init(nibName: self.goodsParametersCellIdentifier, bundle: nil), forCellReuseIdentifier: self.goodsParametersCellIdentifier)
        myTableView.registerNib(UINib.init(nibName: self.goodsJudgeAndImagesCellIdentifier, bundle: nil), forCellReuseIdentifier: self.goodsJudgeAndImagesCellIdentifier)
        
        return myTableView
    }()
    
    /**
     准备顶部轮播
     */
    private func prepareScrollView() {
        
        topScrollView = SDCycleScrollView(frame: CGRect(x:0, y:0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.3), delegate: self, placeholderImage: UIImage(named: "photoview_image_default_white"))
        topScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        topScrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        topScrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleClassic
        topScrollView?.bannerImageViewContentMode = UIViewContentMode.ScaleAspectFill
        
        if self.detailModel?.goods_image != nil {
            topScrollView?.imageURLStringsGroup = self.detailModel?.goods_image
            myTableView.tableHeaderView = topScrollView
        }
        
        
        
    }

    /**
     初始化数据 + 下拉刷新
     */
    @objc private func pullDownRefresh() {
        
        MCHTGoodsDetailModel.goodsDetail(self.goods_id!) { (success, goodsDetailModel) in
            self.detailModel = goodsDetailModel
            self.prepareScrollView()
            self.myTableView.reloadData()
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension CCHTGoodsDetailViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }else {
            return 50
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.goodsParametersCellIdentifier) as! VCHTGoodsParametersCell
            cell.goods_info = self.detailModel?.goods_info
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.goodsJudgeAndImagesCellIdentifier) as! VCHTGoodsJudgeAndImagesCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        
    }
    
}