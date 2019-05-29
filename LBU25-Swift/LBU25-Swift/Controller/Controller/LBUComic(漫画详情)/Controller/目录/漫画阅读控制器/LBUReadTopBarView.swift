//
//  LBUReadTopBarView.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/29.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUReadTopBarView: UIView {

    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "nav_back_black"), for: .normal)
        return backButton
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.left.centerY.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
        }
    }
}
