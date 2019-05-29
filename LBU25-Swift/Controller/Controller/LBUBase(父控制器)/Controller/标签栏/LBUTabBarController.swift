//
//  LBUTabBarController.swift
//  LBU25-Swift
//
//  Created by liubo on 2019/5/11.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

class LBUTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        
        
        setupLayout()
    }
    func setupLayout() {
        // 1.首页
        let onePageVC = LBUHomeController(titles: ["推荐",
                                                     "VIP",
                                                     "订阅",
                                                     "排行"],
                                            vcs: [LBUHomeCommentController(),
                                                  LBUHomeVIPController(),
                                                  LBUHomeSubscibeController(),
                                                  LBUHomeRankController()],
                                            pageStyle: .navgationBarSegment)
        addChildController(onePageVC,
                               title: "首页",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home_S"))
        
        
        // 2.分类
        let classVC = LBUCateController()
        addChildController(classVC,
                               title: "分类",
                               image: UIImage(named: "tab_class"),
                               selectedImage: UIImage(named: "tab_class_S"))
        
        
        // 3.书架
        let bookVC = LBUBookController(titles: ["收藏",
                                                  "书单",
                                                  "下载"],
                                         vcs: [LBUBookCollectionController(),
                                               LBUBookDocumentController(),
                                               LBUBookDownloadController()],
                                         pageStyle: .navgationBarSegment)
        addChildController(bookVC,
                               title: "书架",
                               image: UIImage(named: "tab_book"),
                               selectedImage: UIImage(named: "tab_book_S"))
        
        
        // 4.我的
        let mineVC = LBUMineController()
        addChildController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "tab_mine_S"))
    }
    
    func addChildController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(LBUNaviController(rootViewController: childController))
    }
    
}
extension LBUTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
