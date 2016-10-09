//
//  CCHTStoreViewController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit
import SDCycleScrollView
import MJRefresh

class CCHTStoreViewController: UIViewController, UITextFieldDelegate,SDCycleScrollViewDelegate{
    var view_top:UIView?
    var txt_top:UITextField?
    var btn_shopCart:UIButton?
    var myTab:UITableView?
    
    ///首页model
    var storeModel:MCHTStoreModel?
    
    ///顶部轮播图
    var topScrollView: SDCycleScrollView?
    var adds: [MCHTStoreAdd]?
    
    ///猜你喜欢model
    var guess_list:[MCHTStoreGuessYouLike]?
    
    //当前页码
    var page: Int = 0
    
    let guessYouLikeIdentifier = "guessYouLikeIdentifier"
    let storeCellIdentifier = "storeCellIdentifier"
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBarHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        pullDownRefresh()
       /*
        myTableView.mj_header = setupHeaderRefresh(self, action: #selector(pullDownRefresh))
        myTableView.mj_footer = setupFooterRefresh(self, action: #selector(pullUpMoreData))
        myTableView.mj_header.beginRefreshing()
 */
    }
    
    /**
     创建导航视图
     */
    private func setUpTopNavView() {
        view_top = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        view_top?.backgroundColor = COLOR_NAV
        view.addSubview(view_top!)

        txt_top = UITextField(frame: CGRect(x: 15, y: 26, width: SCREEN_WIDTH-15-18-25, height: 29))
        txt_top?.borderStyle = UITextBorderStyle.RoundedRect
        txt_top?.placeholder = "搜索商品，品牌"
        txt_top?.delegate = self
        txt_top?.font = UIFont.boldSystemFontOfSize(12)
        view.addSubview(txt_top!)
        
        btn_shopCart = UIButton(frame: CGRect(x: SCREEN_WIDTH-15-24, y: 27, width: 25, height: 23))
        btn_shopCart!.setBackgroundImage(UIImage(named:"btn_shopCart"), forState: UIControlState.Normal)
        btn_shopCart!.addTarget(self, action: #selector(shopCartAction), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn_shopCart!)
        
    }
    ///点击跳转搜索页
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        let searchVC = CCHTSearchController()
         searchVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchVC, animated: true)
        return false
    }
    ///Mark 点击跳转购物车
   @objc private func shopCartAction() {
        if LOGIN_KEY == nil {
            let LoginVC = CCHTLoginController()
            LoginVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(LoginVC, animated: true)
        }else{
            
            let shopCartVC = CCHTShopCartController()
            shopCartVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(shopCartVC, animated: true)
        }
    }
    
    /**
     准备UI
     */
    private func prepareUI() {
     
        view.addSubview(myTableView)
        setUpTopNavView()
        
    }
    
    /**
     准备顶部轮播
     */
    private func prepareScrollView() {
        
        topScrollView = SDCycleScrollView(frame: CGRect(x:0, y:0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.3), delegate: self, placeholderImage: UIImage(named: "photoview_image_default_white"))
        topScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        topScrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        topScrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleClassic
        topScrollView?.bannerImageViewContentMode = UIViewContentMode.ScaleAspectFill
        
        var images = [String]()
        if adds?.count > 0{
        for add in self.adds! {
            images.append(add.image!)
        }
        }
        
        topScrollView?.imageURLStringsGroup = images
        myTableView.tableHeaderView = topScrollView
        
    }
    
    
    lazy var myTableView: UITableView = {
        let myTableView = UITableView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64),style: UITableViewStyle.Plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .None
        myTableView.registerNib(UINib.init(nibName: "VCHTStoreCell", bundle: nil), forCellReuseIdentifier: self.storeCellIdentifier)
        myTableView.registerClass(VCHTGuessYouLikeCell.self, forCellReuseIdentifier: self.guessYouLikeIdentifier)
        
        return myTableView
    }()
     /**
     初始化数据 + 下拉刷新
     */
    @objc private func pullDownRefresh() {
        page = 1
        MCHTStoreModel.storeMainDatas { (storeModel) in
            self.storeModel = storeModel
            
            self.adds = storeModel?.adv_list
           
            self.guess_list = storeModel?.guess_list
            
            self.prepareScrollView()
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


/// MARK: - UITableViewDataSource, UITableViewDelegate
extension CCHTStoreViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let scrollViewH = 15 + (SCREEN_WIDTH-(15*4))/3.0 + 20 + 20
            return 70 + 48 + SCREEN_WIDTH*312/677.0 + scrollViewH + 56
        }else{
             let height = (SCREEN_WIDTH-10*3)/2.0 + 25 + 20
            
            return CGFloat((guess_list?.count ?? 0)!/2)*(height+10)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(storeCellIdentifier) as! VCHTStoreCell
            cell.storeModel = self.storeModel
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier(guessYouLikeIdentifier) as! VCHTGuessYouLikeCell
            cell.guess_list = self.guess_list
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
    }
    
}

//MARK: - VCHTStoreCellDelegate
/**
 这里将所有的按钮放进一个代理方法里面，根据不同的tag值来区分从上而下，由低到高
 左右按钮从10开始，分别为10，11
 试茶师列表按钮有三个，点击这三个都进入试茶师列表界面，都为20
 然后是试茶师下面的滑动商品，点击进入详情，从30开始递增
 最后是猜你喜欢两个按钮，点击进去商品列表页面，都为40
 **/
extension CCHTStoreViewController: VCHTStoreCellDelegate {
    func storeCellActions(cell: UITableViewCell, didSelectedBtnWithTag btnTag: Int) {
        
        if btnTag == 10 {
            
        }else if btnTag == 11 {
            
        }else if btnTag == 20 {
            let commendVC = CCHTGoodsListViewController()
            commendVC.hidesBottomBarWhenPushed = true
            commendVC.navigationItem.title = "试茶师推荐"
            navigationController?.pushViewController(commendVC, animated: true)
        }else if btnTag == 40 {
            
            
        }else{
            //点击进入商品详情
            let model:MCHTStoreCommend = (self.storeModel?.goods![btnTag-30])!
            let goodsDetailVC =  CCHTGoodsDetailViewController()
            goodsDetailVC.goods_id = model.goods_id
            goodsDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(goodsDetailVC, animated: true)
            
        }
    }
    
}



// MARK : - VCHTGuessItemDelegate
extension CCHTStoreViewController: VCHTGuessCellDelegate {
    //点击单个商品进入详情页
    func guessCell(cell: UITableViewCell, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model:MCHTStoreGuessYouLike = self.guess_list![indexPath.item]
        let goodsDetailVC =  CCHTGoodsDetailViewController()
        goodsDetailVC.goods_id = model.goods_id
        goodsDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(goodsDetailVC, animated: true)
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
