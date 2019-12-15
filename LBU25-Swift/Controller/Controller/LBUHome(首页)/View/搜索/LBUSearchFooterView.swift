//
//  LBUSearchFooterView.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/30.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUSearchCollectionViewCell: LBUBaseCollectionViewCell {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.darkGray
        return titleLabel
    }()
    override func setupLayout() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.background.cgColor
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)) }
    }
}

typealias LBUSearchTFootDidSelectIndexClosure = (_ index: Int, _ model: LBUSearchItemModel) -> Void

protocol LBUSearchFooterViewDelegate: class {
    func searchFooterView(_ searchTFoot: LBUSearchFooterView, didSelectItemAt index: Int, _ model: LBUSearchItemModel)
}

class LBUSearchFooterView: LBUBaseTableViewHeaderFooterView {
    
    weak var delegate: LBUSearchFooterViewDelegate?
    
    private var didSelectIndexClosure: LBUSearchTFootDidSelectIndexClosure?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UCollectionViewAlignedLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.horizontalAlignment = .left
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: LBUSearchCollectionViewCell.self)
        return collectionView
    }()
    
    var data: [LBUSearchItemModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func setupLayout() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
    
}

extension LBUSearchFooterView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: LBUSearchCollectionViewCell.self)
        cell.layer.cornerRadius = cell.bounds.height * 0.5
        cell.titleLabel.text = data[indexPath.row].name
//        cell.backgroundColor = UIColor.random
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.searchFooterView(self, didSelectItemAt: indexPath.row, data[indexPath.row] )
        
        guard let closure = didSelectIndexClosure else { return }
        closure(indexPath.row, data[indexPath.row])
    }
    
    func didSelectIndexClosure(_ closure: @escaping LBUSearchTFootDidSelectIndexClosure) {
        didSelectIndexClosure = closure
    }
}
