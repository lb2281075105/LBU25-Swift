//
//  LBUReadCollectionViewCell.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/29.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit


import Kingfisher


// 设置占位图
extension UIImageView: Placeholder {}

class LBUReadCollectionViewCell: LBUBaseCollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var placeholder: UIImageView = {
        let placeholder = UIImageView(image: UIImage(named: "yaofan"))
        placeholder.contentMode = .center
        return placeholder
    }()
    
    override func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
    
    var model: LBUImageModel? {
        didSet {
            guard let model = model else { return }
            imageView.image = nil
            imageView.kf.setImage(urlString: model.location, placeholder: placeholder)
        }
    }
}
