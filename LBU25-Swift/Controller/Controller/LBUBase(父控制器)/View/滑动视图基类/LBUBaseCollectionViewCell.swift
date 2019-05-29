//
//  LBUBaseCollectionViewCell.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/12.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import Reusable
class LBUBaseCollectionViewCell: UICollectionViewCell,Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {}
}
