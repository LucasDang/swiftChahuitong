//
//  CHTTabBarViewController.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

class CHTTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addControllers()
        selectedIndex = 0
    }

    private func addControllers() {
        addChildViewController(CCHTStoreViewController(),title:"购茶",imageName:"tab_Store",seleImageName:"tab_SeleStore")
        addChildViewController(CCHTTraceViewController(),title:"动态",imageName:"tab_Trace",seleImageName:"tab_SeleTrace")
        addChildViewController(CCHTFindViewController(),title:"发现",imageName:"tab_Find",seleImageName:"tab_SeleFind")
        addChildViewController(CCHTHomeViewController(),title:"我的",imageName:"tab_Home",seleImageName:"tab_SeleHome")
    }
    private func addChildViewController(childController: UIViewController,title:String,imageName:String,seleImageName:String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        var seleImage:UIImage = UIImage(named:seleImageName)!
        seleImage = seleImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        childController.tabBarItem.selectedImage = seleImage
        childController.tabBarItem.title = title;
        childController.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName:COLOR_BASEG], forState:.Selected)
        
        let nav = UINavigationController()
        nav.addChildViewController(childController)
        addChildViewController(nav)
    }
}
