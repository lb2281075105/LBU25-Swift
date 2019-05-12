//
//  LBUBaseTableViewHeaderFooterView.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/13.
//  Copyright © 2019 刘博. All rights reserved.
//

import Reusable

class LBUBaseTableViewHeaderFooterView: UITableViewHeaderFooterView, Reusable {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {}
    
}
