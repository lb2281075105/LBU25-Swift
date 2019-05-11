//
//  LBUBaseTableViewCell.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/11.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import Reusable

class LBUBaseTableViewCell: UITableViewCell ,Reusable{

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupUI() {}

}
