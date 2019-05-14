//
//  LBUComicHeadCollectionCell.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/14.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUComicHeadCollectionCell: LBUBaseCollectionViewCell {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()
    
    override func setupLayout(){
        layer.cornerRadius = 3
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
