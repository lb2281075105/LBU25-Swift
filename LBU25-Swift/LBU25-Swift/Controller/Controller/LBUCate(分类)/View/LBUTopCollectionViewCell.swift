//
//  LBUTopCollectionViewCell.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/12.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUTopCollectionViewCell: LBUBaseCollectionViewCell {
    private lazy var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    
    override func setupLayout() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    
    var model: LBUTopModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover)
        }
    }
}
