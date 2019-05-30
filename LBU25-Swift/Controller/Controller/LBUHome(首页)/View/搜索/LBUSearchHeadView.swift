//
//  LBUSearchHeadView.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/30.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

typealias LBUSearchTHeadMoreActionClosure = ()->Void

protocol LBUSearchHeadViewDelegate: class {
    func searchHeadView(_ searchTHead: LBUSearchHeadView, moreAction button: UIButton)
}

class LBUSearchHeadView: LBUBaseTableViewHeaderFooterView {
    
    weak var delegate: LBUSearchHeadViewDelegate?
    
    private var moreActionClosure: LBUSearchTHeadMoreActionClosure?
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.gray
        return titleLabel
    }()
    
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.setTitleColor(UIColor.lightGray, for: .normal)
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return moreButton
    }()
    
    @objc private func moreAction(button: UIButton) {
        delegate?.searchHeadView(self, moreAction: button)
        
        guard let closure = moreActionClosure else { return }
        closure()
    }
    
    func moreActionClosure(_ closure: @escaping LBUSearchTHeadMoreActionClosure) {
        moreActionClosure = closure
    }
    
    override func setupLayout() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(200)
        }
        
        contentView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        
        let line = UIView().then { $0.backgroundColor = UIColor.background }
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
}
