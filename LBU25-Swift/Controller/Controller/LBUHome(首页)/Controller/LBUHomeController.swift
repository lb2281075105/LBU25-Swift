//
//  LBUHomeController.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/11.
//  Copyright © 2019 刘博. All rights reserved.
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
                                                            action: #selector(searchButtonClick))
    }
    
    @objc private func searchButtonClick() {
        navigationController?.pushViewController(LBUSearchController(), animated: true)
    }

}
