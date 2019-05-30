//
//  LBUHomeVIPController.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/11.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUHomeVIPController: LBUBaseController {

    // () 就是实例化相当于OC中的init
    private var vipList = [LBUComicListModel]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UCollectionViewSectionBackgroundLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(cellType: LBUComicCollectionViewCell.self)
        collectionView.register(supplementaryViewType: LBUComicCollectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: LBUComicCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        collectionView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        collectionView.uFoot = URefreshTipKissFooter(with: "VIP用户专享\nVIP用户可以免费阅读全部漫画哦~")
        collectionView.uempty = UEmptyView { [weak self] in self?.setupLoadData() }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 加载数据
        setupLoadData()
    }
    
    private func setupLoadData() {
        ApiLoadingProvider.request(LBUApi.vipList, model: LBUVipListModel.self) { (returnData) in
            
            self.collectionView.uHead.endRefreshing()
            self.collectionView.uempty?.allowShow = true
            
            self.vipList = returnData?.newVipList ?? []
            self.collectionView.reloadData()
        }
    }
    
    override func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in make.edges.equalTo(self.view.usnp.edges) }
    }
}

extension LBUHomeVIPController: UCollectionViewSectionBackgroundLayoutDelegateLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vipList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let comicList = vipList[section]
        return comicList.comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: LBUComicCollectionHeaderView.self)
            let comicList = vipList[indexPath.section]
            head.iconView.kf.setImage(urlString: comicList.titleIconUrl)
            head.titleLabel.text = comicList.itemTitle
            head.moreButton.isHidden = !comicList.canMore
            head.moreActionClosure { [weak self] in
                let vc = LBUComicListController(argCon: comicList.argCon, argName: comicList.argName, argValue: comicList.argValue)
                vc.title = comicList.itemTitle
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return head
        } else {
            let foot = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: LBUComicCollectionFooterView.self)
            return foot
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let comicList = vipList[section]
        return comicList.itemTitle?.count ?? 0 > 0 ? CGSize(width: screenWidth, height: 44) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return vipList.count - 1 != section ? CGSize(width: screenWidth, height: 10) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: LBUComicCollectionViewCell.self)
        cell.cellStyle = .withTitle
        let comicList = vipList[indexPath.section]
        cell.model = comicList.comics?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 10.0) / 3.0)
        return CGSize(width: width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let comicList = vipList[indexPath.section]
        guard let model = comicList.comics?[indexPath.row] else { return }
        let vc = LBUComicController(comicid: model.comicId)
        navigationController?.pushViewController(vc, animated: true)
    }
}

