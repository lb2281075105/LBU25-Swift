//
//  LBUBaseCollectionReusableView.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/13.
//  Copyright © 2019 刘博. All rights reserved.
//

import Reusable

class LBUBaseCollectionReusableView: UICollectionReusableView,Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {}
}
