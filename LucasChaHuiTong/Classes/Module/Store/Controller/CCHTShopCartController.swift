//
//  CCHTShopCartController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class CCHTShopCartController: UIViewController {
    
    /**
     请求数据
     */
    var cartList: [MCHTShopCartSingleModel]?
    var sumPrice:String?
    
    /**
     选中数组,
     */
    var ifSeleArray: [Bool]?
    
    /**
     总金额
     */
    var totalPrice:Float = 0.00
    
    /**
     编辑状态：0代表完成，1代表编辑
     */
    var isEdit:Bool?
    
    /**
     底部三个按钮
     */
    var seleAllBtn:UIButton?
     var settleOrDeleteBtn:UIButton?
     var priceOrCollectBtn:UIButton?
    
    let shopCartCellIdentifier = "VCHTShopCartCellIdentifier"
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "购物车"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style:UIBarButtonItemStyle.Plain, target: self, action: #selector(editAction(_:)))
        isEdit = false
        prepareUI()
    }
    /**
     全选事件
     */
    @objc private func editAction(sender:UIBarButtonItem) {
        isEdit = !isEdit!
        if isEdit == true {
            sender.title = "完成"
            settleOrDeleteBtn!.setTitle("删除", forState: UIControlState.Normal)
            priceOrCollectBtn!.backgroundColor = COLOR_GREY
            priceOrCollectBtn!.setTitleColor(COLOR_JETBlACK, forState: UIControlState.Normal)
            priceOrCollectBtn!.setTitle("收藏", forState: UIControlState.Normal)
        }else{
            sender.title = "编辑"
            settleOrDeleteBtn!.setTitle("结算", forState: UIControlState.Normal)
            priceOrCollectBtn!.backgroundColor = UIColor.whiteColor()
            priceOrCollectBtn!.setTitleColor(COLOR_BASEG, forState: UIControlState.Normal)
            priceOrCollectBtn!.setTitle("合计：", forState: UIControlState.Normal)
        }
        
        
    
    }
    
    /**
     准备UI
     */
   private func prepareUI() {
        setUpBottomView()
        view.addSubview(myTableView)
        pullDownRefresh()
    }
    /**
     创建底部视图
     */
    private func setUpBottomView() {
        let bottomView = UIView(frame: CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50))
        self.view.addSubview(bottomView)
        
        let sepLabel = UILabel(frame: CGRectMake(0, 0, SCREEN_WIDTH, 1))
        sepLabel.backgroundColor = COLOR_SEP
        bottomView.addSubview(sepLabel)
        
        seleAllBtn = UIButton(frame: CGRectMake(20, 16, 18, 18))
        seleAllBtn!.setBackgroundImage(UIImage(named: "btn_chooseCycle.png"), forState: UIControlState.Normal)
        seleAllBtn!.setBackgroundImage(UIImage(named: "btn_seleChooseCycle.png"), forState: UIControlState.Selected)
        seleAllBtn!.addTarget(self, action: #selector(seleAllBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(seleAllBtn!)
        
        let label = UILabel(frame: CGRectMake(45, 15, 30, 20))
        label.text = "全选"
        label.font = UIFont.systemFontOfSize(13)
        bottomView.addSubview(label)
        
        settleOrDeleteBtn = UIButton(frame: CGRectMake(SCREEN_WIDTH/10*7, 1, SCREEN_WIDTH/10*3, 49))
        settleOrDeleteBtn!.backgroundColor = COLOR_BASEG
        settleOrDeleteBtn!.setTitle("结算", forState: UIControlState.Normal)
        settleOrDeleteBtn!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        settleOrDeleteBtn!.titleLabel?.font = UIFont.systemFontOfSize(13)
        settleOrDeleteBtn!.titleLabel?.textAlignment = NSTextAlignment.Center
        settleOrDeleteBtn!.addTarget(self, action: #selector(settleAndDeleteAction), forControlEvents: .TouchUpInside)
        bottomView.addSubview(settleOrDeleteBtn!)
        
        priceOrCollectBtn = UIButton(frame: CGRectMake(SCREEN_WIDTH/10*3, 1, SCREEN_WIDTH/10*4, 49))
        priceOrCollectBtn!.setTitle("合计：0.00", forState: UIControlState.Normal)
        priceOrCollectBtn!.setTitleColor(COLOR_BASEG, forState: .Normal)
        priceOrCollectBtn!.titleLabel?.font = UIFont.systemFontOfSize(13)
        priceOrCollectBtn!.titleLabel?.adjustsFontSizeToFitWidth = true
        priceOrCollectBtn!.titleLabel?.textAlignment = NSTextAlignment.Center
        priceOrCollectBtn!.addTarget(self, action: #selector(collectGoodsAction), forControlEvents: .TouchUpInside)
        bottomView.addSubview(priceOrCollectBtn!)
        
        
    }
    /**
     点击全选事件
     */
    @objc private func seleAllBtnAction(sender: UIButton){
        
        sender.selected = !sender.selected
        var seleList = [Bool]()
    
        totalPrice = 0.00
        for (_,obj) in (self.cartList?.enumerate())! {
            if sender.selected{
                seleList.append(true)
                totalPrice = Float(obj.goods_num!)! * Float(obj.goods_price!)! + totalPrice
            }else{
                seleList.append(false)
                totalPrice = 0.0
            }
        }
        self.ifSeleArray = seleList
        if isEdit == false {
        priceOrCollectBtn!.setTitle("合计："+String(totalPrice), forState: UIControlState.Normal)
        }
        self.myTableView.reloadData()

    }
    
    /**
     收藏事件
     */
    @objc private func collectGoodsAction() {
        if isEdit == true {
            
            var cart_id = ""
            for (index,obj) in (self.cartList?.enumerate())! {
                if self.ifSeleArray![index] == true {
                    cart_id = cart_id + obj.cart_id! + ","
                }
            }
            if cart_id != "" {
            MCHTShopCartModel.cartGoosMoveToFav(cart_id, finished: { (success, tip) in
                if success {
                    self.pullDownRefresh()
                }
            })
            }
            
        }
    }
    
    /**
     结算、删除事件
     */
    @objc private func settleAndDeleteAction() {
        if isEdit == true {
            ///删除
            var cart_id = ""
            for (index,obj) in (self.cartList?.enumerate())! {
                if self.ifSeleArray![index] == true {
                    cart_id = cart_id + obj.cart_id! + ","
                }
            }
            if cart_id != "" {
                MCHTShopCartModel.cartGoodsDel(cart_id, finished: { (success, tip) in
                    if success {
                        self.pullDownRefresh()
                    }
                })
            }
            
        }else {
            ///结算
            
        }
    }
    
    
    /**
     初始化数据 + 下拉刷新
     */
    @objc private func pullDownRefresh() {
        MCHTShopCartModel.cartList { (shopCartModel) in
            self.sumPrice = shopCartModel?.sum
            self.cartList = shopCartModel?.cart_list
            
            var seleList = [Bool]()
            for (_) in (self.cartList?.enumerate())! {
                seleList.append(false)
            }
            self.ifSeleArray = seleList
            self.myTableView.reloadData()
        }
        
    }
    
    
    
    lazy var myTableView:UITableView =  {
        let  myTableView = UITableView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) , style:UITableViewStyle.Plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .None
        myTableView.rowHeight = 108
        myTableView.registerNib(UINib.init(nibName: "VCHTShopCartCell", bundle: nil), forCellReuseIdentifier: self.shopCartCellIdentifier)
        
        return myTableView
    }()
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CCHTShopCartController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartList?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.shopCartCellIdentifier) as! VCHTShopCartCell
        cell.singleCartModel = self.cartList![indexPath.row]
        cell.btn_sele.selected =  self.ifSeleArray![indexPath.row]
        cell.btn_sele.tag = indexPath.row
        cell.btn_sele.addTarget(self, action: #selector(seleSingleGoodsAction(_:)), forControlEvents: .TouchUpInside)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func seleSingleGoodsAction(sender:UIButton) {
        sender.selected = !sender.selected
        self.seleAllBtn?.selected = false
        self.ifSeleArray![sender.tag] = sender.selected
        if isEdit == false {
            totalPrice = 0.00
            for (index,obj) in (self.cartList?.enumerate())! {
                if self.ifSeleArray![index] == true {
                    totalPrice = Float(obj.goods_num!)! * Float(obj.goods_price!)! + totalPrice
                }
            }
            priceOrCollectBtn!.setTitle("合计："+String(totalPrice), forState: UIControlState.Normal)
        }
        
    }
    
}
    
    

