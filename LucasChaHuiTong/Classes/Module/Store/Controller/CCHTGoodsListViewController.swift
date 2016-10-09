//
//  CCHTGoodsListViewController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/22.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class CCHTGoodsListViewController: UIViewController {
    
    let goodsListCellIdentidier = "goodsListCellIdentidier"
    
    var goodsListArray:[MCHTGoodsListSingleModel]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        prepareUI()
        pullDownRefresh()
    }
    
    /**
     准备UI
     */
    private func prepareUI() {
        self.view.addSubview(myTableView)
        
    }
    
    
    
    
    lazy var myTableView:UITableView =  {
        let  myTableView = UITableView(frame: CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40) , style:UITableViewStyle.Plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .None
        myTableView.rowHeight = 128
        myTableView.registerNib(UINib.init(nibName: "VCHTGoodsListCell", bundle: nil), forCellReuseIdentifier: self.goodsListCellIdentidier)
        
        return myTableView
    }()
    
    /**
     初始化数据 + 下拉刷新
     */
    @objc private func pullDownRefresh() {
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
        MCHTGoodsListModel.goodsList("", order: "", page: "8", curPage: "1", gc_id: "", keyword: "", commend: "0") { (goodsListModel) in
            
            self.goodsListArray = goodsListModel?.list
            
            self.myTableView.reloadData()
        }
        
        
    }
    
    /**
     上拉加载
     */
    private func pullUpMoreData() {
        
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension CCHTGoodsListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goodsListArray?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.goodsListCellIdentidier) as! VCHTGoodsListCell
        cell.model = self.goodsListArray![indexPath.row]
        return cell
    }
    
}
