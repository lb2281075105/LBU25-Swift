//
//  LBUHomeController.swift
//  LBU25
//
//  Created by liubo on 2018/12/26.
//  Copyright © 2018 刘博. All rights reserved.
//

import UIKit

class LBUHomeController: LBUPageController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_search"),
                                                            target: self,
                                                            action: #selector(selectAction))
    }
    
    @objc private func selectAction() {
        navigationController?.pushViewController(USearchViewController(), animated: true)
    }
}
