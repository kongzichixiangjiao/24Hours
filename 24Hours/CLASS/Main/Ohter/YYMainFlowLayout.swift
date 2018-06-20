//
//  YYMainFlowLayout.swift
//  24Hours
//
//  Created by 侯佳男 on 2018/6/14.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYMainFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = collectionView!.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
    }
}
