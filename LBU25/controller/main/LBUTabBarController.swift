//
//  LBUTabBarController.swift
//  LBU25
//
//  Created by liubo on 2018/10/10.
//  Copyright © 2018年 刘博. All rights reserved.
//

import UIKit

class LBUTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        
        /// 首页
        let onePageVC = LBUHomeController(titles: ["推荐",
                                                     "VIP",
                                                     "订阅",
                                                     "排行"],
                                            vcs: [LBUReCommendController(),
                                                  LBUVIPController(),
                                                  LBUSubscibeController(),
                                                  LBURankController()],
                                            pageStyle: .navgationBarSegment)
        addChildViewController(onePageVC,
                               title: "首页",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home_S"))
        
        
        /// 分类
        let classVC = LBUClassifyController()
        addChildViewController(classVC,
                               title: "分类",
                               image: UIImage(named: "tab_class"),
                               selectedImage: UIImage(named: "tab_class_S"))
        
        
        /// 书架
        let bookVC = LBUBookController(titles: ["收藏",
                                                  "书单",
                                                  "下载"],
                                         vcs: [LBUCollectionController(),
                                               LBUBookDanController(),
                                               LBUDownloadController()],
                                         pageStyle: .navgationBarSegment)
        addChildViewController(bookVC,
                               title: "书架",
                               image: UIImage(named: "tab_book"),
                               selectedImage: UIImage(named: "tab_book_S"))
        
        
        /// 我的
        let mineVC = LBUMineController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "tab_mine_S"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(LBUNavController(rootViewController: childController))
    }
    
}

extension LBUTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
