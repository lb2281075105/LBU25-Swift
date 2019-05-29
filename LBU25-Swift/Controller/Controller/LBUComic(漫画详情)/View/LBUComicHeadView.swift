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
class LBUComicHeadView: UIView {
    private lazy var bgView: UIImageView = {
        let bgView = UIImageView()
        bgView.isUserInteractionEnabled = true
        bgView.contentMode = .scaleAspectFill
        bgView.blurView.setup(style: .dark, alpha: 1).enable()
        return bgView
    }()
    
    private lazy var coverView: UIImageView = {
        let coverView = UIImageView()
        coverView.contentMode = .scaleAspectFill
        coverView.layer.cornerRadius = 3
        coverView.layer.borderWidth = 1
        coverView.layer.borderColor = UIColor.white.cgColor
        return coverView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        return nameLabel
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.textColor = UIColor.white
        authorLabel.font = UIFont.systemFont(ofSize: 13)
        return authorLabel
    }()
    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.textColor = UIColor.white
        totalLabel.font = UIFont.systemFont(ofSize: 13)
        return totalLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 40, height: 20)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: LBUComicHeadCollectionCell.self)
        return collectionView
    }()
    
    private var themes: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0))
            make.width.equalTo(90)
            make.height.equalTo(120)
        }
        
        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(coverView.snp.right).offset(20)
            make.right.greaterThanOrEqualToSuperview().offset(-20)
            make.top.equalTo(coverView)
            make.height.equalTo(20)
        }
        
        bgView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.left.height.equalTo(nameLabel)
            make.right.greaterThanOrEqualToSuperview().offset(-20)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        bgView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.left.height.equalTo(authorLabel)
            make.right.greaterThanOrEqualToSuperview().offset(-20)
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
        }
        
        bgView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(totalLabel)
            make.height.equalTo(30)
            make.right.greaterThanOrEqualToSuperview().offset(-20)
            make.bottom.equalTo(coverView)
        }
    }
    
    var detailStatic: LBUComicStaticModel? {
        didSet {
            guard let detailStatic = detailStatic else { return }
            bgView.kf.setImage(urlString: detailStatic.cover, placeholder: UIImage(named: "normal_placeholder_v"))
            coverView.kf.setImage(urlString: detailStatic.cover, placeholder: UIImage(named: "normal_placeholder_v"))
            nameLabel.text = detailStatic.name
            authorLabel.text = detailStatic.author?.name
            themes = detailStatic.theme_ids ?? []
            collectionView.reloadData()
        }
    }
    
    var detailRealtime: LBUComicRealtimeModel? {
        didSet {
            guard let detailRealtime = detailRealtime else { return }
            let text = NSMutableAttributedString(string: "点击 收藏")
            
            text.insert(NSAttributedString(string: " \(detailRealtime.click_total ?? "0") ",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]), at: 2)
            
            text.append(NSAttributedString(string: " \(detailRealtime.favorite_total ?? "0") ",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]))
            totalLabel.attributedText = text
        }
    }
}

extension LBUComicHeadView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: LBUComicHeadCollectionCell.self)
        cell.titleLabel.text = themes?[indexPath.item]
        return cell
    }
}
