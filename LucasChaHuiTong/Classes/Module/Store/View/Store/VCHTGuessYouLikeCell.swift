//
//  VCHTGuessYouLikeCell.swift
//  LucasChaHuiTong
//
//  Created by 锡哥 on 16/9/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

import UIKit
import SnapKit

protocol VCHTGuessCellDelegate: NSObjectProtocol {
    func guessCell(cell: UITableViewCell, didSelectItemAtIndexPath indexPath: NSIndexPath)
}


class VCHTGuessYouLikeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryIdentifier = "VCHTGuessItem"
    weak var delegate: VCHTGuessCellDelegate?
    
    
    var guess_list:[MCHTStoreGuessYouLike]! {
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    /**
     准备UI
     */
    private func prepareUI() {
        
        contentView.backgroundColor = COLOR_SEP
        contentView.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    // MARK: - 懒加载
    /// collectionView
    private lazy var collectionView: UICollectionView = {
        let width = (SCREEN_WIDTH-10*3)/2.0
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: width, height: width+25+20)
        
       
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = COLOR_SEP
        collectionView.scrollEnabled = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerNib(UINib(nibName: "VCHTGuessItem", bundle: nil), forCellWithReuseIdentifier: self.categoryIdentifier)
        return collectionView
    }()
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension VCHTGuessYouLikeCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guess_list?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(categoryIdentifier, forIndexPath: indexPath) as! VCHTGuessItem
        item.backgroundColor = UIColor.whiteColor()
        item.guessGood = self.guess_list[indexPath.row]
        return item
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.guessCell(self, didSelectItemAtIndexPath: indexPath)
    }
}
