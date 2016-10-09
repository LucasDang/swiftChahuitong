//
//  VCHTHomeCell.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/26.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit

protocol VCHTHomeCellDelegate: NSObjectProtocol {
    func homeCellActions(cell:UITableViewCell,didSelectedBtnWithTag btnTag:Int)
}

class VCHTHomeCell: UITableViewCell {
    
    weak var homeCellDelegate:VCHTHomeCellDelegate?
    
    @IBOutlet weak var usererHeadImage: UIImageView!
    @IBOutlet weak var btn_login: UIButton!

    
    
    /**
     这里将所有的按钮放进一个代理方法里面，根据不同的tag值来区分从上而下，由低到高
     登陆信息按钮从10开始，分别为10：进入个人主页，11：登陆 。
     订单按钮有5个，从20开始，分别代表不同的状态
     最后是底部六个按钮，从30开始，从左到右，从上而下
     **/
    
    @IBAction func homeBtnAction(sender: UIButton) {
        homeCellDelegate?.homeCellActions(self, didSelectedBtnWithTag: sender.tag)
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.usererHeadImage.layer.cornerRadius = 25
        self.usererHeadImage.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
