//
//  LBUGuessLikeTVCell.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/29.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
typealias LBUGuessLikeTVCellDidSelectClosure = (_ comic: LBUComicModel) -> Void

class LBUGuessLikeTVCell: LBUBaseTableViewCell {
    
    private var didSelectClosure: LBUGuessLikeTVCellDidSelectClosure?
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = self.contentView.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(cellType: LBUComicCollectionViewCell.self)
        return collectionView
    }()
    
    override func setupUI(){
        let titileLabel = UILabel().then{
            $0.text = "猜你喜欢"
        }
        contentView.addSubview(titileLabel)
        titileLabel.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
            make.height.equalTo(20)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titileLabel.snp.bottom).offset(5)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    var model: LBUGuessLikeModel? {
        didSet {
            self.collectionView.reloadData()
        }
    }
}


extension LBUGuessLikeTVCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.frame.width - 50) / 4)
        let height = collectionView.frame.height - 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: LBUComicCollectionViewCell.self)
        cell.cellStyle = .withTitle
        cell.model = model?.comics?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let comic = model?.comics?[indexPath.row],
            let didSelectClosure = didSelectClosure else { return }
        didSelectClosure(comic)
    }
    
    func didSelectClosure(_ closure: LBUGuessLikeTVCellDidSelectClosure?) {
        didSelectClosure = closure
    }
}
