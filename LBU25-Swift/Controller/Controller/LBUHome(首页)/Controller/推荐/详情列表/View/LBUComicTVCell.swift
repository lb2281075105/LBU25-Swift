//
//  LBUComicTVCell.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/29.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUComicTVCell: LBUBaseTableViewCell {
    var spinnerName: String?
    
    private  lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        return iconView
    }()
    
    private  lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor.gray
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        return subTitleLabel
    }()
    
    private lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.gray
        descLabel.numberOfLines = 3
        descLabel.font = UIFont.systemFont(ofSize: 14)
        return descLabel
    }()
    
    private lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = UIColor.orange
        tagLabel.font = UIFont.systemFont(ofSize: 14)
        return tagLabel
    }()
    
    private lazy var orderView: UIImageView = {
        let orderView = UIImageView()
        orderView.contentMode = .scaleAspectFit
        return orderView
    }()
    
    override func setupUI() {
        separatorInset = .zero
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
            make.width.equalTo(100)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
            make.top.equalTo(iconView)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(60)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.bottom.equalTo(iconView.snp.bottom)
            make.height.width.equalTo(30)
            make.right.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalTo(orderView.snp.left).offset(-10)
            make.height.equalTo(20)
            make.bottom.equalTo(iconView.snp.bottom)
        }
    }
    
    var model: LBUComicModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover, placeholder: UIImage(named: "normal_placeholder_v"))
            
            titleLabel.text = model.name
            subTitleLabel.text = "\(model.tags?.joined(separator: " ") ?? "") | \(model.author ?? "")"
            descLabel.text = model.description
            
            if spinnerName == "更新时间" {
                let comicDate = Date().timeIntervalSince(Date(timeIntervalSince1970: TimeInterval(model.conTag)))
                var tagString = ""
                if comicDate < 60 {
                    tagString = "\(Int(comicDate))秒前"
                } else if comicDate < 3600 {
                    tagString = "\(Int(comicDate / 60))分前"
                } else if comicDate < 86400 {
                    tagString = "\(Int(comicDate / 3600))小时前"
                } else if comicDate < 31536000{
                    tagString = "\(Int(comicDate / 86400))天前"
                } else {
                    tagString = "\(Int(comicDate / 31536000))年前"
                }
                tagLabel.text = "\(spinnerName!) \(tagString)"
                orderView.isHidden = true
            } else {
                var tagString = ""
                if model.conTag > 100000000 {
                    tagString = String(format: "%.1f亿", Double(model.conTag) / 100000000)
                } else if model.conTag > 10000 {
                    tagString = String(format: "%.1f万", Double(model.conTag) / 10000)
                } else {
                    tagString = "\(model.conTag)"
                }
                if tagString != "0" { tagLabel.text = "\(spinnerName ?? "总点击") \(tagString)" }
                orderView.isHidden = false
            }
        }
    }
    
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else { return }
            if indexPath.row == 0 { orderView.image = UIImage.init(named: "rank_frist") }
            else if indexPath.row == 1 { orderView.image = UIImage.init(named: "rank_second") }
            else if indexPath.row == 2 { orderView.image = UIImage.init(named: "rank_third") }
            else { orderView.image = nil }
        }
    }
    
    
}
